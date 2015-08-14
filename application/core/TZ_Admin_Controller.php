<?php

/**
 *
 * 自定义 后台管理控制 控制器 
 */
class TZ_Admin_Controller extends TZ_Controller {
    
    public $_userProfile = null;
    public $_userMenu = array();
    public static $_userAuth = array();
    
    public function __construct(){
        parent::__construct();
        
        $session = $this->session->userdata['profile'];
        
        //file_put_contents("session.txt",print_r($session,true));
        if(!$session){
            redirect(url_path('login'),'javascript:top');
        }
        $this->load->model('User_Model');
        $this->load->model('User_Menu_Model');
        $this->load->model('Role_Menu_Model');
        
        $this->_init_user_menu($session);
        
        $this->_userProfile = $session;
        
        /*
        file_put_contents("1.txt",print_r(self::$_userAuth,true));
        
        echo config_item('controller_trigger').'='.$this->tplDir .'&'.config_item('function_trigger').'='.$this->tplName;
        echo "<br/>";
        echo md5('c=project&m=index');
        print_r(self::$_userAuth);
         * *
         */
        
       
        //file_put_conetnts("1.txt",md5(config_item('controller_trigger').'='.$this->tplDir .'&'.config_item('function_trigger').'='.$this->tplName),FILE_APPEND);
        
        if($this->_userProfile['id'] != 1 && !in_array(md5(config_item('controller_trigger').'='.$this->tplDir .'&'.config_item('function_trigger').'='.$this->tplName), self::$_userAuth)){
            if($this->isAjax){
                $this->sendFormatJson('error',array('id' => 0, 'text' => '您没有足够的访问权限，请联系管理员'));
            }else{
                $this->display('noprivilage','common');
            }
        }
        
        $this->_init_user_event($session);
        
        $this->assign('userProfile',$session);
    }
    
    private function _init_user_menu($session){
        
        
        $userMenu = $this->User_Menu_Model->getList(array(
            'field' => 'id,url,auth_key',
            'where' => array('user_id' => $session['id'],'status' => 0)
        ));
        
        $roleMenu = $this->Role_Menu_Model->getList(array(
            'field' => 'id,url,auth_key',
            'where_in' => array(
                array(
                    'key' => 'role_id',
                    'value' => array($session['role_id'],$session['share_role_id'])
                )
             )
        ));
        
        if($userMenu['data']){
            foreach($userMenu['data'] as $value){
                $this->_usermMenu[$value['id']] = $value;
                self::$_userAuth[] = $value['auth_key'];
            }
        }
        
        if($roleMenu['data']){
            foreach($roleMenu['data'] as $value){
                self::$_userAuth[] = $value['auth_key'];
            }
        }
        
        self::$_userAuth = array_unique(self::$_userAuth );
        
    }
    
    
    private function _init_user_event($session){
        
        $this->load->model('User_Event_Model');
        
        
        $eventCount = $this->User_Event_Model->getCount(array(
           'where' => array(
               'user_id' => $session['id'],
               'status' => '未处理'
           ) 
        ));
        
        $this->assign('eventCount',$eventCount);
        
    }
    
    public function getAuthList(){
        if(self::$_userAuth){
            return self::$_userAuth;
        }else{
            return array();
        }
    }
    
    public function checkRedoWorflowPrivilege($val){

        if(!$this->checkAuth('taizhang+redo_workflow')){
            $this->form_validation->set_message('checkRedoWorflowPrivilege', '无重新审核权限');
            return false;
        }else{
            return true;
        }
    }
    
    public function checkPm($name){
        $this->load->model('User_Model');
        $user = $this->User_Model->queryById($name,'name');
        
        if($user){
            if(!$user['is_pm']){
                $this->form_validation->set_message('checkPm', '%s 字段参数不正确，你输入的人员不是组长');
                return false;
            }
            
            return true;
        }else{
            $this->form_validation->set_message('checkPm', '%s 字段参数不正确，没有这个人员');
            return FALSE;
        }
    }
    
    /**
     * 检查权限
     * @param type $authKey
     * @return boolean 
     */
    public function checkAuth($authKey){
        
        if(strpos($authKey,'+') !== false){
            $url = config_item('controller_trigger').'='.substr($authKey,0,strpos($authKey,'+')).'&'.config_item('function_trigger').'='.substr($authKey,strpos($authKey,'+') + 1);
        }else{
            $url = config_item('controller_trigger').'='.$authKey.'&'.config_item('function_trigger').'=index';
        }
        
        if($this->_userProfile['id'] != 1){
            if(in_array(md5($url),$this->getAuthList())){
                return true;
            }else{
                return false;
            }
        }else{
            return true;
        }
    }

    public function getUserProfile(){
        return $this->_userProfile;
    }
    
    protected function _fillFeeInfo($dest_id , $source_id){
        $this->load->model('Taizhang_Model');
        $data = $this->Taizhang_Model->getById(array(
            'select' => "fee_type,complete_time,get_doc,get_doctime,get_owner,owner_tel,kh_amount,ys_amount,ss_amount,is_owed,is_gov,collect_date,remark,project_id,files",
            'where' => array(
                'id' => $source_id
            )
        ));
        
        if($data){
            $this->db->update($this->Taizhang_Model->_tableName, $data, array('id' => $dest_id));
        }
    }
    
    protected function _getFiles($param){
        
        if(is_string($param)){
            $param = explode(',',$param);
        }
        
        $this->load->model('Attachment_Model');
        $hasFiles = $this->Attachment_Model->getList(array(
            'where_in' => array(
                array('key' => 'id', 'value' => $param)
            )
        ));
        
        return $hasFiles['data'];
        
    }
    
    
    
    protected function _getStep($info){
        $status = array(
           // '新增' , '发送' ,'布置', '实施','完成','提交初审','通过初审',  '提交复审', '通过复审', '项目提交','收费','归档'
            '新增' , '提交初审','通过初审',  '提交复审', '通过复审'
        );
        
        $names = array(
            '新增' => 'creator',
            '提交初审' => 'zc_name',
            '通过初审' => 'cs_name',
            '提交复审' => 'cs_name',
            '通过复审' => 'fs_name'
        );
        
        $statusKey = array_keys($status);
        $currentKey = 0;
        
        //print_r($statusKey);
        foreach($statusKey as $v){
            if($status[$v] == str_replace('已','',$info['status'])){
                $currentKey = $v + 1;
            }
        }

        $statusHtml = array();
        foreach($status as $k => $v){
            if($info[$names[$v]]){
                $v = $v.'('.$info[$names[$v]].')';
            }
            
            if($k < $currentKey){
                $statusHtml[] = '<span class="status statusover">'.$v."</span>";
                
            }elseif($k == $currentKey){
                $statusHtml[] = '<span class="status current">'.$v."</span>";
            }else{
                $statusHtml[] = '<span class="status">'.$v."</span>";
            }
        }
        
        $this->assign('statusHtml',$statusHtml);
    }
    
    
    /**
     * 添加待办记录
     * 
     * @param type $info
     * @param type $sendorInfo
     * @param type $project_type 0=测绘 1=规划 2=台账 3=检查记录
     */
    protected function _addPm($info,$sendorInfo,$project_type){
        
        //file_put_contents('debug.txt',print_r($info,true));
        //file_put_contents('debug.txt',print_r($sendorInfo,true),FILE_APPEND);
        //file_put_contents('debug.txt',$project_type,FILE_APPEND);
        $this->User_Event_Model->updateByWhere(array(
            'isnew' => 0,
            'status' => '已处理',
            'updator' => $this->_userProfile['name'],
            'updatetime' => time()
        ),array('user_id' => $this->_userProfile['id'],'project_type' => $project_type, 'project_id' => $info['id']));
        
        $this->User_Event_Model->deleteByWhere(array(
            'user_id' => empty($sendorInfo['id']) != true ? $sendorInfo['id'] : 0,
            'project_type' => $project_type,
            'project_id' => $info['id']
        ));
        
        //if($sendorInfo['id'] != $this->_userProfile['id']){
            $url = '';
            switch($project_type){
                case 0:
                    $url = url_path('project_ch','index','name='.urlencode($info['name']).'&id='.$info['id']);
                    break;
                case 2:
                    $url = url_path('taizhang','index','name='.urlencode($info['name']).'&id='.$info['id']);
                    break;
                case 3:
                    $url = url_path('check_record','index','name='.urlencode($info['name']).'&id='.$info['id']);
                    break;
                case 1:
                    //规划项目比较少， 放到最后减少判断
                    $url = url_path('project_gh','index','name='.urlencode($info['name']).'&id='.$info['id']);
                    break;
                default:
                    break;
            }
            
            $this->User_Event_Model->add(array(
                'project_type' => $project_type,
                'project_id' => $info['id'],
                'user_id' => empty($sendorInfo['id']) != true ? $sendorInfo['id'] : 1,
                'title' => cut($info['name'],100),
                'url' => $url,
                'creator' => $this->_userProfile['name']
            ));
        //}
        
    }
    
    
    
    protected function _getSendorList($where = array()){
        if(!$this->User_Sendor_Model){
            $this->load->model('User_Sendor_Model');
        }
        
        $where = array_merge(array('user_id' => $this->_userProfile['id']),$where);
        $userSendorList = $this->User_Sendor_Model->getList(array(
            'where' => $where,
            'order' => 'createtime ASC ,displayorder DESC'
        ));
        $this->assign('userSendorList',$userSendorList['data']);
    }
    
    /**
     * 删除文件操作
     * @param type $files 
     */
    protected function _deleteFile($files){
        $prepath = config_item('filestore_dir');
        foreach($files as $file){
            $file_realpath = $prepath.$file['file_store_path'].$file['file_md5'].$file['file_extension'];
            @unlink($file_realpath);
        }
    }
    
    /**
     * 将新提交的文件中，在原来的文件列表中不存在的部分 ，从文件系统删除
     * @param type $current_files  当前拥有的文件
     * @param type $file_ids       本次提交的文件
     */
    protected function _cleanFile($current_files , $file_ids){
        $needCleanFile = array();
        
        if(!empty($current_files)){
            $currentFiles = explode(',',$current_files);
        }else{
            $currentFiles = array();
        }
        
        if(!empty($file_ids)){
            if($currentFiles){
                foreach($currentFiles as $file){
                    if(!in_array($file,$file_ids)){
                        $needCleanFile[] = $file;
                    }
                }
            }
        }else{
            if(!empty($current_files)){
                $needCleanFile = explode(',',$current_files);
            }
        }
        
        ///file_put_contents("debug.txt", print_r($needCleanFile,true));
        
        if($needCleanFile){
            $cleanFiles = $this->_getFiles($needCleanFile);
            $this->_deleteFile($cleanFiles);
        }
    }
    
    /**
     * 获取缺陷列表
     * @param type $info 
     */
    protected function _getProjectFault($info){
        
        if($info['status'] == '已提交初审' || $info['status'] == '已提交复审' || $info['status'] == '已通过复审'){
            
            $where = array(
                'score >' => 0,
                'type !=' => 7 , // 剔除外业检查
                'type != ' => 8  // attation the key diff ,there one more black
            );
            
            $this->load->model('Fault_Model');
            if($info['status'] == '已通过复审'){
                unset($where['type != ']); // 初复试 质检 错误对照表 
                
                $sysFaultList = $this->Fault_Model->getList(array(
                    'where' => $where,
                    'or_where' => array('type' => 9),
                    'order' => 'type ASC,code ASC'
                ));
                
            }else{
                $sysFaultList = $this->Fault_Model->getList(array(
                    'where' => $where,
                    'order' => 'type ASC,code ASC'
                ));
            }
            
            $tmpFaultList = array();
            foreach($sysFaultList['data'] as $v){
                if(!isset($tmpFaultList[$v['type']])){
                    $tmpFaultList[$v['type']] = array(
                        'title' => $v['typename'],
                        'list' => array()
                    );
                    $tmpFaultList[$v['type']]['list'][] = $v;
                }else{
                    $tmpFaultList[$v['type']]['list'][] = $v;
                }
            }
            
            $this->assign('sysFaultList',$tmpFaultList);
        }
        
        
        $this->load->model('Project_Fault_Model');
        
        $userFaultList = array();
        //初审错误
        $userFaultList[] = $this->Project_Fault_Model->getList(array(
            'where' => array(
                'project_type' => 0,
                'type' => 0,
                'project_id' => $info['id'],
                'status' => 0
            )
        ));
        
        //复审错误
        $userFaultList[] = $this->Project_Fault_Model->getList(array(
                'where' => array(
                    'project_type' => 0,
                    'type' => 1,
                    'project_id' => $info['id'],
                    'status' => 0
                )
            ));
        
        
        //针对复审的缺陷
        $userFaultList[] = $this->Project_Fault_Model->getList(array(
                'where' => array(
                    'project_type' => 0,
                    'type' => 2,
                    'project_id' => $info['id'],
                    'status' => 0
                )
            ));
        
        
        $this->assign('userFaultList0',$userFaultList[0]['data']);
        $this->assign('userFaultList1',$userFaultList[1]['data']);
        $this->assign('userFaultList2',$userFaultList[2]['data']);
    }
    
    
    protected function _addProjectFault($info,$param,$project_type = 0 , $fault_step = 0){
        $data = array();
        
        if(!empty($param['fault'])){
            
            $this->load->model('Project_Fault_Model');
            
            
            $this->Project_Fault_Model->deleteByWhere(array(
                'project_type' => $project_type,
                'project_id' => $info['id'],
                'type' => $fault_step
            ));
            
            //0 = 测绘项目 1 = 规划项目  2 = 外业检查项目
            if($project_type == 0 || $project_type == 2){
                $this->load->model('Fault_Model');
                
                $sysFaultList = $this->Fault_Model->getList(array(
                    'where_in' => array(
                        array('key' => 'code','value' => $param['fault'])
                    )
                ));
                
            }else{
                $this->load->model('Gh_Fault_Model');
                $sysFaultList = $this->Gh_Fault_Model->getList(array(
                    'where_in' => array(
                        array('key' => 'code','value' => $param['fault'])
                    )
                ));
            }
            
            $zeroScoreFault = array();
            $insertData = array();

            foreach($sysFaultList['data'] as $fvalue){
                if($fvalue['score'] < 0.01){
                    $zeroScoreFault[] = $fvalue['code'];
                }
                
                $insertTime = time();
                $insertData[] = array(
                    'project_type' => $project_type,
                    'project_id' => $info['id'],
                    'type' => $fault_step,
                    'fault_code' => $fvalue['code'],
                    'fault_name' => $fvalue['name'],
                    'remark' => !empty($param[strtoupper($fvalue['code']).'_remark']) ? $param[strtoupper($fvalue['code']).'_remark'] : '',
                    'score' => (double)$fvalue['score'],
                    'creator' => $this->_userProfile['name'],
                    'updator' => $this->_userProfile['name'],
                    'createtime' => $insertTime,
                    'updatetime' => $insertTime
                );
            }

            //扣分为0 的 不计错误次数
            $decreseFaultCount = 0;
            foreach($param['fault'] as $fv){
                if(in_array($fv,$zeroScoreFault)){
                    $decreseFaultCount++;
                }
            }
            
            if($fault_step == 0){
                $data['fault_cnt1'] = count($param['fault']) - $decreseFaultCount;
                $data['total_fault'] = $data['fault_cnt1'] + $info['fault_cnt2'];
            }else if($fault_step == 1){
                $data['fault_cnt2'] = count($param['fault']) - $decreseFaultCount;
                $data['total_fault'] = $data['fault_cnt2'] + $info['fault_cnt1'];
            }else if($fault_step == 2){
                $data['fault_cnt3'] = count($param['fault']) - $decreseFaultCount;
                $data['total_fault'] = $data['fault_cnt3'] + $data['fault_cnt2'] + $info['fault_cnt1'];
            }

            $this->Project_Fault_Model->batchInsert($insertData);
        }
        
        return $data;
        
    }
    
    
    protected function _fetchProjectInfo($project_id){
        $info = array();
        
        if($project_id){
            $this->load->model('Project_Model');
            $info = $this->Project_Model->queryById($project_id);

            if($info){
                unset($info['id'],$info['status'],$info['sendor_id']);
                $info['ptype_id'] = $info['type_id']; 
                
                /**
                $dupTips = $this->_getDupList($category,$projectInfo['name']);
                
                if($dupTips){
                    $this->assign('dupTips','<p>名称 '.$projectInfo['name'].' 已入'.$category.'台账，如需新编台账，注意名称问题</p><p>原台账号信息:</p>'.  implode('', $dupTips));
                }
                 * 
                 */
            }
        }
        
        return $info;
    }
    
    protected function _fetchTaizhangInfo($taizhang_id){
        $info = array();
        
        if($taizhang_id){
            $this->load->model('Taizhang_Model');
            $info = $this->Taizhang_Model->queryById($taizhang_id);

            if($info){
                unset($info['id'],$info['status'],$info['sendor_id']);
                
                /**
                $dupTips = $this->_getDupList($category,$projectInfo['name']);
                
                if($dupTips){
                    $this->assign('dupTips','<p>名称 '.$projectInfo['name'].' 已入'.$category.'台账，如需新编台账，注意名称问题</p><p>原台账号信息:</p>'.  implode('', $dupTips));
                }
                 * 
                 */
            }
        }
        
        return $info;
    }
    
    /**
     * 获得重复的台账名称列表
     * @param type $category
     * @param type $name
     * @return string 
     */
    protected function _getDupList($category, $name){
        $dupTips = array();
        
        if(!$this->Taizhang_Model){
            $this->load->model('Taizhang_Model');
        }
        $history = $this->Taizhang_Model->getList(array(
            'where' => array(
                'category' => $category,
                'name' => $name
            ),
            'order' => 'createtime DESC'
        ));
        
        if($history['data']){
            foreach($history['data'] as $his){
                $dupTips[] = '<p>'.$his['project_no'].'</p>';
            }
        }
        
        return $dupTips;
    }
    
    /**
     * 自查
     */
    protected function check(){
        $id = (int)gpc('id','GP',0);
        
        $info = $this->Taizhang_Model->queryById($id);
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $now = time();
            if('提交初审' ==  $_POST['submit']){
                if(!empty($_POST['zc_yj'])){
                    $this->form_validation->set_rules('zc_yj', '自查意见', 'max_length[300]');
                }else{
                    $_POST['zc_yj'] = '合格';
                }
                if(!empty($_POST['zc_remark'])){
                    $this->form_validation->set_rules('zc_remark', '自查修改和处理意见', 'max_length[300]');
                }else{
                    $_POST['zc_remark'] = '合格';
                }

                $this->form_validation->set_rules('sendor', '发送给初审', 'required|is_natural_no_zero');
            
                if($this->form_validation->run()){
                    $op = '提交初审';
                    $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'zc_time' => $now,
                        'zc_name' => $this->_userProfile['name'],
                        'zc_yj' => $_POST['zc_yj'],
                        'zc_remark' => $_POST['zc_remark'],
                        'can_revocation' => 1
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '新增','sendor_id' => $this->_userProfile['id']));

                    if($return){
                        $message = $_POST['submit'].'成功';
                        $this->_addPm($info,$sendorInfo,2);
                        $info = $this->Taizhang_Model->queryById($info['id']);
                    }else{
                        $message = $_POST['submit'].'失败';
                    }

                    //$this->sendFormatJson('success', array('text' => '修改成功'));
                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                    //$this->sendFormatJson('failed', array('text' => $message));
                }
            }elseif('撤销' == $_POST['submit']){
                $op = '新增';
                $data = array(
                    'sendor_id' => $this->_userProfile['id'],
                    'sendor' => $this->_userProfile['name'],
                    'status' => $op,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now,
                    'zc_name' => '',
                    'can_revocation' => 0
                );
                $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审' , 'can_revocation' => 1 ));

                if($return){
                    $message = $_POST['submit'].'成功';
                    $info = $this->Taizhang_Model->queryById($info['id']);
                }else{
                    $message = $_POST['submit'].'失败';
                }
            }
            
            $this->assign('message',$message);
        }else{
            
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        if($info['files']){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        $this->_getSendorList(array(
            'ch_cs' => 'y'
        ));
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        $this->_getStep($info);
        $this->_getProjectFault($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display();
    }
    
    /**
     * 初审
     */
    protected function first_sh(){
        $id = (int)gpc('id','GP',0);
        
        $info = $this->Taizhang_Model->queryById($id);
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $now = time();
            
            if($_POST['workflow'] == '退回'){
                
                //$this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
                    $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
                }
                if($this->form_validation->run()){
                    $d = $this->_addProjectFault($info,$_POST,0,0);
                    $sendorInfo = $this->User_Model->queryById($info['zc_name'],'name');
                    $data = array(
                        'cs_time' => 0,
                        'cs_name' => '',
                        'cs_yj' => '',
                        'cs_remark' => '',
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'fault_cnt1' => (int)$d['fault_cnt1'],
                        'total_fault' => (int)$d['total_fault'],
                        'status' => '新增',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'can_revocation' => 1
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = $_POST['workflow'].'成功';
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = $_POST['workflow'].'失败';
                    }
                    
                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
                
            }else{
                if('通过并提交复审' ==  $_POST['submit']){
                    if(!empty($_POST['cs_yj'])){
                        $this->form_validation->set_rules('cs_yj', '初审意见', 'max_length[300]');
                    }else{
                        $_POST['cs_yj'] = '按规范要求测量，报告符合要求。';
                    }
                    if(!empty($_POST['cs_remark'])){
                        $this->form_validation->set_rules('cs_remark', '初审修改和处理意见', 'max_length[300]');
                    }else{
                        $_POST['cs_remark'] = '合格';
                    }

                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if($this->form_validation->run()){
                        //$op1 = '通过初审';
                        $op2 = '提交复审';

                        $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                        $data = array(
                            'sendor_id' => $sendorInfo['id'],
                            'sendor' => $sendorInfo['name'],
                            'status' => '已'.$op2,
                            'updator' => $this->_userProfile['name'],
                            'updatetime' => $now,
                            'cs_time' => $now,
                            'cs_name' => $this->_userProfile['name'],
                            'cs_yj' => $_POST['cs_yj'],
                            'cs_remark' => $_POST['cs_remark'],
                            'can_revocation' => 1
                        );
                        $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                        if($return){
                            $this->_addPm($info,$sendorInfo,2);
                            $message = $_POST['submit'].'成功';
                            $info = $this->Taizhang_Model->queryById($info['id']);
                        }else{
                            $message = $_POST['submit'].'失败';
                        }

                    }else{
                        $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                    }
                }elseif('受理' ==  $_POST['submit']){
                    $data = array(
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'can_revocation' => 0
                    );
                    
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审' , 'can_revocation' => 1 ));

                    if($return){
                        $message = $_POST['submit'].'成功';
                        $info = $this->Taizhang_Model->queryById($info['id']);
                    }else{
                        $message = $_POST['submit'].'失败';
                    }
                    
                }elseif('撤销' ==  $_POST['submit']){
                    $op = '已提交初审';
                    $data = array(
                        'sendor_id' => $this->_userProfile['id'],
                        'sendor' => $this->_userProfile['name'],
                        'status' => $op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'cs_name' => ''
                    );
                    
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审' , 'can_revocation' => 1 ));

                    if($return){
                        $message = $_POST['submit'].'成功';
                        $info = $this->Taizhang_Model->queryById($info['id']);
                    }else{
                        $message = $_POST['submit'].'失败';
                    }
                }
            }
            
            $this->assign('message',$message);
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $this->_getStep($info);
        $this->_getSendorList(array(
            'ch_fs' => 'y'
        ));
        if(!empty($info['files'])){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        $this->_getProjectFault($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display();
    }
    
    protected function second_sh(){
        $id = (int)gpc('id','GP',0);
        
        $info = $this->Taizhang_Model->queryById($id);
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $now = time();
            if($_POST['workflow'] == '退回' ){
                
                //$this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
                
                if($this->form_validation->run()){
                    $d = $this->_addProjectFault($info,$_POST,0,1);
                    $sendorInfo = $this->User_Model->queryById($info['cs_name'],'name');
                    
                    $data = array(
                        'fs_time' => 0,
                        'fs_name' => '',
                        'fs_yj' => '',
                        'fs_remark' => '',
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'fault_cnt2' => (int)$d['fault_cnt2'],
                        'total_fault' => (int)$d['total_fault'],
                        'status' => '已提交初审',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'can_revocation' => 1
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = $_POST['workflow'].'成功';
                        
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = $_POST['workflow'].'失败';
                    }
                    
                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
            }else if($_POST['workflow'] == '重新审核'){
                
                $this->form_validation->set_rules('redo_workflow', '重新审核', 'callback_checkRedoWorflowPrivilege');
                $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
                
                if($this->form_validation->run()){
                    $d = $this->_addProjectFault($info,$_POST,0,2);
                    
                    //直接变为新增状态,重新走流程
                    $sendorInfo = $this->User_Model->queryById($info['creator'],'name');
                    
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'fault_cnt3' => (int)$d['fault_cnt3'],
                        'total_fault' => (int)$d['total_fault'],
                        'status' => '新增',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'can_revocation' => 0
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已通过复审'));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = $_POST['workflow'].'成功';
                        
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = $_POST['workflow'].'失败';
                    }
                    
                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
                
            }else{
                if('通过并提交收费' == $_POST['submit']){
                    if(!empty($_POST['fs_yj'])){
                        $this->form_validation->set_rules('fs_yj', '复审意见', 'max_length[300]');
                    }else{
                        $_POST['fs_yj'] = '经查资料齐全，合格。';
                    }
                    if(!empty($_POST['fs_remark'])){
                        $this->form_validation->set_rules('fs_remark', '复审修改和处理意见', 'max_length[300]');
                    }else{
                        $_POST['fs_remark'] = '合格';
                    }

                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if($this->form_validation->run()){
                        $op = '通过复审';

                        $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                        $data = array(
                            'sendor_id' => $sendorInfo['id'],
                            'sendor' => $sendorInfo['name'],
                            'status' => '已'.$op,
                            'updator' => $this->_userProfile['name'],
                            'updatetime' => $now,
                            'fs_time' => $now,
                            'fs_name' => $this->_userProfile['name'],
                            'fs_yj' => $_POST['fs_yj'],
                            'fs_remark' => $_POST['fs_remark'],
                            'can_revocation' => 1
                        );
                        $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                        if($return){
                            $this->_addPm($info,$sendorInfo,2);
                            $message = $_POST['submit'].'成功';
                            $info = $this->Taizhang_Model->queryById($id);
                        }else{
                            $message = $_POST['submit'].'失败';
                        }

                    }else{
                        $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                    }
                }elseif('受理' ==  $_POST['submit']){
                    $data = array(
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'can_revocation' => 0
                    );
                    
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审' , 'can_revocation' => 1 ));

                    if($return){
                        $message = $_POST['submit'].'成功';
                        $info = $this->Taizhang_Model->queryById($info['id']);
                    }else{
                        $message = $_POST['submit'].'失败';
                    }
                    
                }elseif('撤销' ==  $_POST['submit']){
                    $op = '已提交复审';
                    $data = array(
                        'sendor_id' => $this->_userProfile['id'],
                        'sendor' => $this->_userProfile['name'],
                        'status' => $op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'fs_name' => ''
                    );
                    
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已通过复审' , 'can_revocation' => 1 ));

                    if($return){
                        $message = $_POST['submit'].'成功';
                        $info = $this->Taizhang_Model->queryById($info['id']);
                    }else{
                        $message = $_POST['submit'].'失败';
                    }
                }
            }
            
            $this->assign('message',$message);
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $this->_getStep($info);
        $this->_getSendorList(array(
            'ch_fee' => 'y'
        ));
        if(!empty($info['files'])){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        $this->_getProjectFault($info);
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
        
    }
}