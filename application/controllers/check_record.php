<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Check_Record extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        
        $this->load->model('Check_Record_Model');
        $this->load->helper('number');
        
    }
    
    public function index(){
        $this->assign('action','index');
        $evaluate = $this->_getEvaluate();
        $this->assign('evaluate',$evaluate);
        $this->_getPageData(array( 'status !=' => '已删除'));
		$this->display();
	}
    
    
    
    private function _getJdConfig(){
        return array(
           'kzd' => array(
               'title' => '控制点',
               'kzd_jd',
               'kzd_num',
               'kzd_avg',
               'kzd_overflow',
           ),
           'sbd' => array(
               'title' => '碎部点',
               'sbd_jd',
               'sbd_num',
               'sbd_avg',
               'sbd_overflow',
           ),
          'bc' => array(
              'title' => '边长',
               'bc_jd',
               'bc_num',
               'bc_avg',
               'bc_overflow',
           ),
           'jzd' => array(
               'title' => '界址点',
               'jzd_jd',
               'jzd_num',
               'jzd_avg',
               'jzd_overflow',
           ),
         );
       
    }
    
    private function _addRules(){
        
        $this->form_validation->set_rules('name', '项目名称', 'trim|required|max_length[150]|htmlspecialchars');
        $this->form_validation->set_rules('type[]', '项目类型', 'required');
        $this->form_validation->set_rules('method[]', '检查方法', 'required' );
        
        
        $jdList = $this->_getJdConfig();
        
        foreach($jdList as $v){
            $this->form_validation->set_rules($v[0], $v['title'].'精度（限差）', 'required|numeric');
            $this->form_validation->set_rules($v[1], $v['title'].'实测点数', 'required|is_natural');
            $this->form_validation->set_rules($v[2], $v['title'].'误差均值', 'required|numeric');
            $this->form_validation->set_rules($v[3], $v['title'].'超限点个数', 'required|is_natural');
        }
        
        $this->form_validation->set_rules('pm', '作业组负责人', 'trim|required|callback_checkname');
        $this->form_validation->set_rules('evaluate', '精度评定', 'required');
        $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
        $this->form_validation->set_rules('checkor', '检查者', 'trim|required|htmlspecialchars');
        $this->form_validation->set_rules('remark', '检查评语', 'trim|required|htmlspecialchars');
        
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
    
    private function _formatProjectNo($year,$masterSerial,$prefix = 'WJ'){
        
        if($masterSerial < 1000){
            $masterSerial = str_pad($masterSerial, 3,'0', STR_PAD_LEFT);
        }
        
        return $year."-{$prefix}".$masterSerial;
    }
    
    
    private function _op($year,$action = 'add'){
        
        if($action == 'add'){
            $master_serial = $this->Check_Record_Model->getCount(array(
                'where' => array(
                    'year' => $year
                )
            ));
            
            $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
            $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['master_serial']);
        }

        if(!empty($_POST['file_id'])){
            $_POST['files'] = implode(',',$_POST['file_id']);
        }else{
           $_POST['files'] = ''; 
        }
        
        if($action == 'add'){
            $insertid = $this->Check_Record_Model->add($_POST);
            return $insertid;
        }else{
            $rows = $this->Check_Record_Model->update($_POST);
            return $rows;
        }
        
    }
    
    /**
     *  基本信息
     */
    public function add(){
        
        $this->_initPageData();
        $this->assign('action','add');
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            for($i = 0 ; $i < 1; $i++){
                if(!$this->form_validation->run()){
                    
                    $info = $_POST;
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                    break;
                }
                
                //发送给
                $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                
                
                $_POST['year'] = date("Y");
                $_POST['creator'] = $this->_userProfile['name'];
                $_POST['sendor_id'] = $sendorInfo['id'];
                $_POST['sendor'] = $sendorInfo['name'];

                $insertid = $this->_op($_POST['year'],'add');
                
                $info = $this->Check_Record_Model->queryById($insertid);
                
                if($sendorInfo['id'] != $this->_userProfile['id']){
                    $this->_addPm($info,$sendorInfo,3);
                }
                
                $d = $this->_addProjectFault($info,$_POST,2,0);
                
                $message = '保存成功';
                $feed = 'success';
                $this->assign('feed',$feed);
                //$this->sendFormatJson('success', array('text' => '创建成功'));
            }
            
            $this->assign('message',$message);
        }
        
        
        $this->_getSendorList(array(
            "( ch_fs = 'y' OR ch_cs = 'y') " => null
        ));
        
        $this->_getWjProjectFault($info);
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
    }
    
    
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->_addRules();
            $gobackUrl = $_POST['gobackUrl'];
            $info = $this->Check_Record_Model->getById(array('where' => array('id' => $_POST['id'])));
            
            for($i = 0; $i < 1; $i++){
                if(!$this->form_validation->run()){
                    
                    if(!is_array($_POST['type'])){
                        $_POST['type'] = array();
                    }
                    if(!is_array($_POST['method'])){
                        $_POST['method'] = array();
                    }
                    
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                    $info = $_POST;
                    break;
                }
                
                if($this->_userProfile['id'] != 1){
                    if(!in_array($this->_userProfile['name'], array($info['creator'],$info['sendor']))){
                        $message = '您不能保存';
                        break;
                    }
                }
                
                $sendorInfo = array();
                //变化了
                if($info['sendor_id'] != $_POST['sendor']){
                    $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                    $_POST['sendor_id'] = $sendorInfo['id'];
                    $_POST['sendor'] = $sendorInfo['name'];
                }else{
                    $_POST['sendor_id'] = $info['sendor_id'];
                    $_POST['sendor'] = $info['sendor'];
                }
                
                $_POST['updator'] = $this->_userProfile['name'];
                $affectRow = $this->_op($info['year'],'edit');
                if($affectRow < 0){
                    $message = '保存失败';
                    break;
                }
                
                $this->_cleanFile($info['files'],$_POST['file_id']);
                $message = '保存成功';
                $info = $this->Check_Record_Model->getById(array('where' => array('id' => $info['id'])));
                
                if($sendorInfo){
                    $this->_addPm($info,$sendorInfo,3);
                }
                
                $d = $this->_addProjectFault($info,$_POST,2,0);
                $info['type'] = explode('|',$info['type']);
                $info['method'] = explode('|',$info['method']);
            }
            
            $this->assign('message',$message);
            
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Check_Record_Model->getById(array('where' => array('id' => $_GET['id'])));
            $info['type'] = explode('|',$info['type']);
            $info['method'] = explode('|',$info['method']);
        }
        
        $this->_initPageData();
        if($info['files']){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        $this->_getSendorList(array(
            "( ch_fs = 'y' OR ch_cs = 'y') " => null
        ));
        
        $this->_getWjProjectFault($info);
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display('add');
    }
    
    
    public function delete(){
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $info = $this->Check_Record_Model->queryById($_POST['id']);
            
            if($info){
                
                $this->Check_Record_Model->delete(array('id' => $_POST['id']));
                //删除文件
                if($info['files']){
                    $files = $this->_getFiles($info['files']);
                    $this->_deleteFile($files);
                }
                
                $this->sendFormatJson('success',array('operation' => 'delete', 'id' => $_POST['id'] , 'text' => '删除成功'));
            }else{
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '找不到记录,删除失败'));
            }
            
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    /**
     * 获取缺陷列表
     * @param type $info 
     */
    private function _getWjProjectFault($info){
        $this->load->model('Fault_Model');
        $sysFaultList = $this->Fault_Model->getList(array(
            'where' => array(
                'score >' => 0,
                'type' => 7 // 只取外业检查
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
        
        
        $this->load->model('Project_Fault_Model');
        
        //初审错误
        $userFaultList = $this->Project_Fault_Model->getList(array(
            'where' => array(
                'project_type' => 2,
                'type' => 0,
                'project_id' => $info['id'],
                'status' => 0
            )
        ));
        /*
        //复审错误
        $userFaultList[] = $this->Project_Fault_Model->getList(array(
                'where' => array(
                    'project_type' => 0,
                    'type' => 1,
                    'project_id' => $info['id'],
                    'status' => 0
                )
            ));
        */
        
        $csFault = array();
        foreach($userFaultList['data'] as $f){
            $csFault[$f['fault_code']] = $f;
        }
        
        $this->assign('userFaultList0',$csFault);
        //$this->assign('userFaultList1',$userFaultList[1]['data']);
    }
    
    private function _getEvaluate(){
        return array(
            '优',
            '良',
            '合格',
            '不合格'
        );
    }
    private function _initPageData(){
       
        $projectTypeList = array(
            '地形、地籍',
            '放样',
            '竣工',
            '房产',
            '其他'
        );
        
        $checkMethod = array(
            '图面巡视',
            '采点检查',
            '量边检查',
            '其它检查'
        );
        
        $jdList = $this->_getJdConfig();
        
        $evaluate = $this->_getEvaluate();
        //print_r($jdList);
        $this->assign('projectTypeList',$projectTypeList);
        $this->assign('checkMethod',$checkMethod);
        $this->assign('jdList',$jdList);
        $this->assign('evaluate',$evaluate);
        
    }
    
    
    private function _getPageData($status = array( 'status !=' => '已删除')){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "createtime DESC";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('taizhang','index')
            );
            
            if(!empty($_GET['project_no'])){
                $condition['like']['project_no'] = trim($_GET['project_no']);
            }
            
            if(!empty($_GET['name'])){
                $condition['like']['name'] = trim($_GET['name']);
            }
            
            if(!empty($_GET['status'])){
                $status = array_merge(array('status' => $_GET['status']),$status);
            }
            
            $condition['where'] = $status;
            
            if(!empty($_GET['id'])){
                $condition['where']['id'] = $_GET['id'];
            }
            
        
            if(!empty($_GET['status'])){
                $condition['where']['status'] = $_GET['status'];
            }
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            
            if(!empty($_GET['pm'])){
                $condition['where']['pm'] = trim($_GET['pm']);
            }
            
            if(is_array($_GET['evaluate'])){
                $condition['where_in'][] = array('key' => 'evaluate' , 'value' => $_GET['evaluate']);
            }
            
            if(!empty($_GET['sendor'])){
                $condition['where']['sendor'] = trim($_GET['sendor']);
            }
            
            $data = $this->Check_Record_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
}
