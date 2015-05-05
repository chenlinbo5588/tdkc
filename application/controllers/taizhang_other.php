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
        
        $this->form_validation->set_rules('pm', '作业组负责人', 'trim|required|callback_checkPm');
        
        if(!empty($_POST['descripton'])){
            $this->form_validation->set_rules('descripton', '备注', 'trim|max_length[300]|htmlspecialchars');
        }else{
            $_POST['descripton'] = isset($_POST['descripton'])  == true ? trim($_POST['descripton']) : '';
        }
        
        if(!empty($_POST['file_id'])){
            $this->form_validation->set_rules('file_id[]', '图件文档', 'required|is_natural_no_zero');
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
        $project_id = (int)gpc('project_id','GP',0);
        $taizhang_id = (int)gpc('taizhang_id','GP',0);
        $source_del = (string)gpc('source_del','GP','');
        
        
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
            
                        
            $project_id = (int)gpc('project_id','GP',0);
            $taizhang_id = (int)gpc('taizhang_id','GP',0);
            
            /**
             * 自动填充信息 
             */
            $autoFillInfo = array();
            
            if($project_id){
                $autoFillInfo = $this->_fetchProjectInfo($project_id);
            }else if($taizhang_id){
                $autoFillInfo = $this->_fetchTaizhangInfo($taizhang_id);
            }
            
            if($autoFillInfo){
                $this->assign('info',$autoFillInfo);
            }
        }
        
        if($project_id){
            $this->assign('project_id',$project_id);
        }
        
        if($taizhang_id){
            $this->assign('taizhang_id',$taizhang_id);
        }
        
        if($source_del){
            $this->assign('source_del',$source_del);
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
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => $addYear ),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        
        $projectTypeList = $this->Project_Type_Model->getList(array(
           'where_in' => array(
               array('key' => 'cate_name','value' => array('土地'))
           ),
           'order' => 'type ASC, createtime ASC'
        ));
        
        $this->assign('projectTypeList',$projectTypeList['data']);
       
        /**
         * 项目性质 
         */
        $natureList = $this->Project_Nature_Model->getList(array('where' => array('status' => '正常','type' => TAIZHANG_OTHER),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('natureList',$natureList['data']);
    }
    
    /**
     * 
     */
    public function check(){
        parent::check();
    }
    
    
    /**
     * 初审
     */
    public function first_sh(){
        parent::first_sh();
    }
    
    /**
     * 复审
     */
    public function second_sh(){
        parent::second_sh();
    }
    
}
