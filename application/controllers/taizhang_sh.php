<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');



//散活
class Taizhang_Sh extends TZ_Admin_Controller {
    
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
        $this->form_validation->set_rules('nature', '用途', 'trim|required|max_length[20]|htmlspecialchars' );
        
        if(!empty($_POST['contacter'])){
            $this->form_validation->set_rules('contacter', '联系人名称', 'trim|required|max_length[15]|htmlspecialchars');
        }else{
            $_POST['contacter'] = '';
        }
        
        if(!empty($_POST['contacter_mobile'])){
            $this->form_validation->set_rules('contacter_mobile', '联系人号码', 'trim|numeric|min_length[4]|max_length[15]');
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
    
    private function _formatProjectNo($year,$masterSerial,$prefix = ''){
        
        if($masterSerial < 1000){
            $masterSerial = str_pad($masterSerial, 3,'0', STR_PAD_LEFT);
        }
        
        return $prefix.$year.$masterSerial;
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
                    $_POST['year'] = date("Y");
                    $_POST['month'] = date("m");
                    $_POST['category'] = TAIZHANG_SH;
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
            
            $this->_fetchProjectInfo(TAIZHANG_SH);
            
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
            /**
            $master_serial = $this->Taizhang_Model->getCount(array(
                'where' => array(
                    'year' => $year,
                    'category' => TAIZHANG_SH
                )
            ));
            
            $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
            $_POST['region_serial'] = 0;
            $offset = config_item('offset_'.$year);
            if(!empty($offset)){
                $_POST['master_serial'] += (int)$offset['FG_TOTAL'];
            }
            
            $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['master_serial']);
             
             */
            $_POST['master_serial'] = 0;
            $_POST['region_serial'] = 0;
            $_POST['project_no'] = '';
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
            $rows = $this->Taizhang_Model->update($_POST);
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
                
                $this->_cleanFile($info['files'],$_POST['file_id']);
                
                
                $message = '操作成功';
                
                $info = $this->Taizhang_Model->getById(array('where' => array('id' => $info['id'])));
                //$this->sendFormatJson('success', array('text' => '修改成功'));
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
           'order' => 'createtime ASC'
        ));
        
        $this->assign('projectTypeList',$projectTypeList['data']);
        
    }
    
}
