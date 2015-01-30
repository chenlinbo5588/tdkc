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
                case 1:
                    $url = url_path('project_gh','index','name='.urlencode($info['name']).'&id='.$info['id']);
                    break;
                case 2:
                    $url = url_path('taizhang','index','name='.urlencode($info['name']).'&id='.$info['id']);
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
            $prepath = config_item('filestore_dir');

            $cleanFiles = $this->_getFiles($needCleanFile);
            foreach($cleanFiles as $file){
                $file_realpath = $prepath.$file['file_store_path'].$file['file_md5'].$file['file_extension'];
                @unlink($file_realpath);
            }
        }
        
    }
    
    /**
     * 获取缺陷列表
     * @param type $info 
     */
    protected function _getProjectFault($info){
        
        if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
            
            $this->load->model('Fault_Model');
            $sysFaultList = $this->Fault_Model->getList(array(
                'where' => array(
                    'score >' => 0
                ),
                'order' => 'type ASC,code ASC'
            ));
            
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
        
        $this->assign('userFaultList0',$userFaultList[0]['data']);
        $this->assign('userFaultList1',$userFaultList[1]['data']);
    }
    
    
    protected function _addProjectFault($info,$param,$project_type = 0){
        $data = array();
        
        if(!empty($param['fault'])){
            if($info['status'] == '已提交初审'){
                $fault_step = 0;
            }else{
                $fault_step = 1;
            }

            $this->load->model('Project_Fault_Model');
            
            
            $this->Project_Fault_Model->deleteByWhere(array(
                'project_type' => $project_type,
                'project_id' => $info['id'],
                'type' => $fault_step
            ));
            
            if($project_type == 0){
                $this->load->model('Fault_Model');
                
                $sysFaultList = $this->Fault_Model->getList(array(
                    'where_in' => array(
                        array('key' => 'code','value' => $_POST['fault'])
                    )
                ));
                
            }else{
                $this->load->model('Gh_Fault_Model');
                $sysFaultList = $this->Gh_Fault_Model->getList(array(
                    'where_in' => array(
                        array('key' => 'code','value' => $_POST['fault'])
                    )
                ));
            }
            

            $insertData = array();

            foreach($sysFaultList['data'] as $fkey => $fvalue){
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

            if($fault_step == 0){
                $data['fault_cnt1'] = count($_POST['fault']);
                $data['total_fault'] = $data['fault_cnt1'] + $info['fault_cnt2'];
            }else if($fault_step == 1){
                $data['fault_cnt2'] = count($_POST['fault']);
                $data['total_fault'] = $data['fault_cnt2'] + $info['fault_cnt1'];
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
    
}