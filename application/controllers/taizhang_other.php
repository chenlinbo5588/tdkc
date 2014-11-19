<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Taizhang_Other extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Nature_Model');
        $this->load->model('Taizhang_Model');
        $this->load->model('Project_Type_Model');
        
        $this->load->helper('number');
        
    }
    
    private function _addRules(){
        
        //$this->form_validation->set_rules('year', '年份', 'required|integer');
        //自动生成
        //$this->form_validation->set_rules('master_serial', '总编号', 'required|numeric');
        //$this->form_validation->set_rules('region_serial', '分编号', 'required|numeric');
        $this->form_validation->set_rules('region_name', '区域', 'required');
        $this->form_validation->set_rules('name', '单位名称', 'trim|required|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '土地坐落', 'trim|required|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('nature', '用途', 'required' );
        
        if(!empty($_POST['contacter'])){
            $this->form_validation->set_rules('contacter', '联系人名称', 'trim|required|max_length[15]|htmlspecialchars');
        }else{
            $_POST['contacter'] = '';
        }
        
        if(!empty($_POST['contacter_mobile'])){
            $this->form_validation->set_rules('contacter_mobile', '联系人手机', 'trim|numeric|min_length[4]|max_length[15]');
        }else{
            $_POST['contacter_mobile'] = '';
        }
        
        if(!empty($_POST['contacter_tel'])){
            $this->form_validation->set_rules('contacter_tel', '联系人座机', 'trim|numeric|min_length[4]|max_length[15]');
        }else{
            $_POST['contacter_tel'] = '';
        }
        
        $this->form_validation->set_rules('pm', '作业组负责人', 'trim|required|callback_checkname');
        
        if(!empty($_POST['descripton'])){
            $this->form_validation->set_rules('descripton', '备注', 'trim|max_length[300]|htmlspecialchars');
        }else{
            $_POST['descripton'] = isset($_POST['descripton'])  == true ? trim($_POST['descripton']) : '';
        }
        
        if(!empty($_POST['file_id'])){
            $this->form_validation->set_rules('file_id[]', '图件文档', 'required|is_natural_no_zero');
        }
        
    }
    
    
    public function checkname($name){
        
        $this->load->model('User_Model');
        $count = $this->User_Model->getCount(array('where' => array('name' => $name)));
        
        if($count){
            return true;
        }else{
            $this->form_validation->set_message('checkname', '%s 字段参数不正确，没有这个人员');
            return FALSE;
        }
    }
    
    private function _formatProjectNo($year,$masterSerial,$nature){
        
        $prefix = '';
        switch($nature){
            case '土方':
                $prefix = 'TF';
                break;
            case '山塘':
                $prefix = 'ST';
                break;
            case '地形':
                $prefix = 'DX';
                break;
            case '评估':
                $prefix = 'PG';
                break;
            case '控制':
                $prefix = 'KZ';
                break;
            default:
                break;
        }
        
        if($masterSerial < 1000){
            $masterSerial = str_pad($masterSerial, 3,'0', STR_PAD_LEFT);
        }

        return $prefix.$year."-".$masterSerial;
    }
    
    
    
    /**
     *  基本信息
     */
    public function add(){
        
        $year = date("Y");
        
        $this->assign('action','add');
        $this->_initPageData($year);
        
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            if($this->form_validation->run()){
                $message = '';
                for($i = 0 ; $i < 1; $i++){
                    
                    if('保存' == $_POST['submit']){
                        $dupTips = $this->_getDupList(TAIZHANG_OTHER, $_POST['name']);
                        if($dupTips){
                            $info = $_POST;
                            $this->assign('saveText','确认');
                            $this->assign('dupTips','<p>名称'.$_POST['name'].'已入'.TAIZHANG_OTHER.'台账，点击<span class=\"notice\">确定</span>继续保存，</p><p>原台账号信息:</p>'.  implode('', $dupTips));
                            break;
                        }
                    }
                    
                    $_POST['year'] = date("Y");
                    $_POST['month'] = date("m");
                    $_POST['category'] = TAIZHANG_OTHER;
                    $_POST['user_id'] = $this->_userProfile['id'];
                    $_POST['creator'] = $this->_userProfile['name'];
                    $_POST['total_area'] = 0;
                    $_POST['churan_area'] = 0;
                    $_POST['sendor_id'] = $_POST['user_id'] ;
                    $_POST['sendor'] = $_POST['creator'];

                    $insertid = $this->_op($_POST['year'],'add');
                    $info = $this->Taizhang_Model->queryById($insertid);

                    $message = '操作成功';
                    $feed = 'success';
                    $this->assign('feed',$feed);
                    //$this->sendFormatJson('success', array('text' => '创建成功'));
                }
            }else{
                $info = $_POST;
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                //$message = strip_tags(validation_errors());
            }
            
            if($info['file_id']){
                $this->assign('files',$this->_getFiles($info['file_id']));
            }
            
            $this->assign('info',$info);
            $this->assign('message',$message);
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            
                        
            $this->_fetchProjectInfo(TAIZHANG_OTHER);
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->_getStep($info);
        $this->display();
    }
    
    
    private function _op($year,$action = 'add'){
         // add
        

        $region_code = $this->Region_Model->getList(array(
            'select' => 'code',
            'where' => array(
                'year' => $year,
                'name' => $_POST['region_name'],
                'status' => '正常'
            )
        ));

        if($region_code['data'][0]['code']){
            $_POST['region_code'] = $region_code['data'][0]['code'];
        }else{
            $_POST['region_code'] = '';
        }
        
        if($action == 'add'){
            $master_serial = $this->Taizhang_Model->getCount(array(
                'where' => array(
                    'year' => $year,
                    'category' => TAIZHANG_OTHER,
                    'nature' => $_POST['nature']
                )
            ));
            
            $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
            $_POST['region_serial'] = 0;
            $offset = config_item('offset_'.$year);
            if(!empty($offset)){
                $_POST['master_serial'] += (int)$offset['OTHER'][$_POST['nature']];
            }

            $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['master_serial'],$_POST['nature']);
        }
        
        $project_type = $this->Project_Type_Model->queryById($_POST['type_id']);
        
        $_POST['ptype_id'] = $project_type['id'];
        $_POST['ptype_name'] = $project_type['name'];
        $_POST['pcate_name'] = $project_type['cate_name'];
        $_POST['weight'] = $project_type['weight'];
        
        if(!empty($_POST['file_id'])){
            $_POST['files'] = implode(',',$_POST['file_id']);
        }
        
        if($action == 'add'){
            $insertid = $this->Taizhang_Model->add($_POST);
            return $insertid;
        }else{
            if($this->_userProfile['id'] != 1){
                $rows = $this->Taizhang_Model->update($_POST,array('creator' => $this->_userProfile['name']));
            }else{
                $rows = $this->Taizhang_Model->update($_POST);
            }
            
            return $rows;
        }
        
    }
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->_addRules();
            $gobackUrl = $_POST['gobackUrl'];
            $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_POST['id'])));
            
            if($this->form_validation->run()){
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['id'] = $info['id'];
                $_POST['total_area'] = 0;
                $_POST['churan_area'] = 0;
                
                $affectRow = $this->_op($info['year'],'edit');
                
                if($affectRow){
                    $this->_cleanFile($info['files'],$_POST['file_id']);
                    $message = '保存成功';

                    $info = $this->Taizhang_Model->getById(array('where' => array('id' => $info['id'])));
                    //$this->sendFormatJson('success', array('text' => '修改成功'));
                }else{
                    $message = '保存失败,只能由'.$info['creator'].'保存';
                }
                
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                //$this->sendFormatJson('failed', array('text' => $message));
            }
            
            $this->assign('message',$message);
            
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->_initPageData($info['year']);
        if($info['files']){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        $this->_getStep($info);
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display('add');
    }
    
    private function _initPageData($addYear){
        
        /**
         * 区域 
         */
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => $addYear , 'name !=' => '其他'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        
        $projectTypeList = $this->Project_Type_Model->getList(array(
           'where_in' => array(
               array('key' => 'cate_name','value' => array('土地'))
           ),
           'order' => 'createtime ASC'
        ));
        
        $this->assign('projectTypeList',$projectTypeList['data']);
       
        
    }
    
    /**
     * 
     */
    public function check(){
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
        
        $this->_getStep($info);
        $this->_getProjectFault($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display();
    }
    
    
    /**
     * 初审
     */
    public function first_sh(){
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
                    $d = $this->_addProjectFault($info,$_POST,0);
                    
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
                        $now = time();
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
        
        $this->_getProjectFault($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display();
    }
    
    /**
     * 初审
     */
    public function second_sh(){
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
                    $d = $this->_addProjectFault($info,$_POST,0);
                    
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
                        $now = time();
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
        
        $this->_getProjectFault($info);
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
    }
    
}
