<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Taizhang_Other extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Nature_Model');
        $this->load->model('Taizhang_Model');
        
        $this->load->helper('number');
    }
    
    
    
    
	public function index()
	{
        
        $this->assign('action','index');
        //$this->_initPageData(date("Y"));
        $this->_getPageData();
		$this->display();
	}
    
    
    
    private function _addRules(){
        
        //$this->form_validation->set_rules('year', '年份', 'required|integer');
        $this->form_validation->set_rules('master_serial', '编号', 'required|numeric');
        $this->form_validation->set_rules('name', '项目名称', 'trim|required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '土地坐落', 'trim|required|min_length[2]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('pm', '作业组负责人', 'trim|required|callback_checkname');
        $this->form_validation->set_rules('fee_type', '收费情况', 'required|integer|greater_than[0]|less_than[5]');
        $this->form_validation->set_rules('has_doc', '成果资料', 'required|integer|less_than[2]');
        
        if(!empty($_POST['descripton'])){
            $this->form_validation->set_rules('descripton', '备注', 'trim|max_length[300]|htmlspecialchars');
        }else{
            $_POST['descripton'] = isset($_POST['descripton'])  == true ? trim($_POST['descripton']) : '';
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
                $prefix = 'DS';
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
            $masterSerial = str_pad($masterSerial, 4,'0', STR_PAD_LEFT);
        }

        return $prefix.$year."-".$masterSerial;
    }
    
    
    
    /**
     * 删除 
     */
    public function delete(){
        if($this->isPostRequest() && !empty($_POST['delete_id'])){
            $message = array();
            $reload = 0;
            
            $successCnt = 0;
            $failedCnt = 0;
            
            foreach($_POST['delete_id'] as $val){
                $flag = $this->Taizhang_Model->updateByWhere(
                    array(
                        'status' => '已删除',
                        'updatetime' => time(), 
                        'updator' => $this->_userProfile['name']
                    ),
                    array(
                        'id' => $val
                    )
                );
                
                if($flag){
                    $successCnt++;
                }else{
                    $failedCnt++;
                }
            }
            
            if($successCnt){
                $reload = 1;
            }
            
            if($successCnt){
                $message[] = '<p class="success">'.$successCnt.'个记录被删除成功</p>';
            }
            
            if($failedCnt){
                $message[] = '<p class="failed">'.$failedCnt.'个记录被删除失败</p>';
            }
            $this->assign('reload',$reload);
            $this->assign('message','<div class="pd20">'.implode('',$message).'</div>');
            $this->display('showmessage','common');
            
        }else{
            $this->assign('message','删除失败参数错误');
            $this->display('showmessage','common');
        }
    }
    
    public function fee(){
        
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Taizhang_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->form_validation->set_rules('complete_time', '项目完成时间', 'required|valid_date');
            $this->form_validation->set_rules('get_doc', '成果资料领取', 'required|is_natural|less_than[2]');
            $this->form_validation->set_rules('get_doctime', '成果资料领取时间', 'required|valid_date');
            
            if(!empty($_POST['get_owner'])){
                $this->form_validation->set_rules('get_owner', '成果资料领取人', 'max_length[20]');
            }else{
                $_POST['get_owner'] = '';
            }
            
            if(!empty($_POST['owner_tel'])){
                $this->form_validation->set_rules('owner_tel', '成果资料领取人联系号码', 'numeric_dash|max_length[20]');
            }else{
                $_POST['owner_tel'] = '';
            }
            
            $this->form_validation->set_rules('kh_amount', '考核金额', 'required|numeric');
            $this->form_validation->set_rules('ys_amount', '应收金额', 'required|numeric');
            $this->form_validation->set_rules('ss_amount', '实收金额', 'required|numeric');
            $this->form_validation->set_rules('is_owed', '欠费情况', 'required|is_natural|less_than[2]');
            $this->form_validation->set_rules('is_gov', '是否政府挂账', 'required|is_natural|less_than[2]');
            $this->form_validation->set_rules('fee_type', '收费情况', 'required|is_natural|less_than[5]');
            
            if(!empty($_POST['remark'])){
                $this->form_validation->set_rules('remark', '备注', 'max_length[500]');
            }else{
                $_POST['remark'] = '';
            }
            
            if($this->form_validation->run()){
                $now = time();
                $data = array(
                    'complete_time' => $_POST['complete_time'],
                    'get_doc' => $_POST['get_doc'],
                    'get_doctime' => $_POST['get_doctime'],
                    'get_owner' => $_POST['get_owner'],
                    'owner_tel' => $_POST['owner_tel'],
                    'kh_amount' => $_POST['kh_amount'],
                    'ys_amount' => $_POST['ys_amount'],
                    'ss_amount' => $_POST['ss_amount'],
                    'is_owed' => $_POST['is_owed'],
                    'is_gov' => $_POST['is_gov'],
                    'collect_date' => date("Y-m-d"),
                    'fee_type' => $_POST['fee_type'],
                    'remark' => $_POST['remark'],
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now
                );
                $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id']));
                if($return){
                    $this->sendFormatJson('success', array('text' => '保存成功'));
                }else{
                    $this->sendFormatJson('failed', array('text' => '保存失败'));
                }
            }else{
                $message = strip_tags(validation_errors());
                $this->sendFormatJson('failed', array('text' => $message));
            }
            
        }else{
            $this->assign('info',$info);
            $this->display();
        }
    }
    
    public function add()
	{
        $this->assign('action','add');
        if($this->isPostRequest()){
            
            $this->_addRules();
            if($this->form_validation->run()){
                $_POST['year'] = date("Y");
                $_POST['month'] = date("m");
                $_POST['contacter_tel'] = '';
                $_POST['category'] = '其他登记';
                
                $_POST['region_code'] = '';
                $_POST['region_name'] = '';
                $_POST['region_serial'] = 0;
                $_POST['contacter'] = '';
                $_POST['contacter_mobile'] = '';
                $_POST['total_area'] = 0;
                $_POST['churan_area'] = 0;
                $_POST['user_id'] = $this->_userProfile['id'];
                $_POST['creator'] = $this->_userProfile['name'];
                
                $_POST['project_no'] = $this->_formatProjectNo($_POST['year'], $_POST['master_serial'],$_POST['nature']);
                $insertid = $this->Taizhang_Model->add($_POST);
                
                $this->sendFormatJson('success', array('text' => '创建成功'));
            }else{
                //$message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $message = strip_tags(validation_errors());
                $this->sendFormatJson('failed', array('text' => $message));
            }
        }else{
            $this->sendFormatJson('failed', array('text' => '参数错误'));
        }
		
	}
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->_addRules();
            if($this->form_validation->run()){
                $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $_POST['contacter_tel'] = '';
                $_POST['region_code'] = '';
                $_POST['region_name'] = '';
                $_POST['region_serial'] = 0;
                $_POST['contacter'] = '';
                $_POST['contacter_mobile'] = '';
                $_POST['total_area'] = 0;
                $_POST['churan_area'] = 0;
                $_POST['updator'] = $this->_userProfile['name'];
                
                $_POST['project_no'] = $this->_formatProjectNo($info['year'], $_POST['master_serial'],$_POST['nature']);
                
                $this->Taizhang_Model->update($_POST);
                $this->sendFormatJson('success', array('text' => '修改成功'));
            }else{
                $message = strip_tags(validation_errors());
                $this->sendFormatJson('failed', array('text' => $message));
            }
        }else{
            $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_GET['id'])));
            //$this->_initPageData($info['year']);
            
            $this->assign('info',$info);
            $this->display('edit');
        }
        
    }
    
    private function _initPageData($addYear){
        
        /**
         * 区域 
         */
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => $addYear),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        /**
         * 项目性质 
         */
        $natureList = $this->Project_Nature_Model->getList(array('where' => array('status' => '正常','type' => '测绘项目'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('natureList',$natureList['data']);
        
        //$this->assign('yearList',yearList());
        //$this->assign('monthList',range(1,12));
        
    }
    
    
    private function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "createtime DESC";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('project_ch','index')
            );
            
            if(!empty($_GET['project_no'])){
                $condition['like']['project_no'] = $_GET['project_no'];
            }
            
            if(!empty($_GET['name'])){
                $condition['like']['name'] = $_GET['name'];
            }
            
            $condition['where'] = array(
                'category' => '其他登记',
                'status !=' => '已删除'
            );
            
            if(!empty($_GET['status'])){
                $condition['where']['status'] = $_GET['status'];
            }
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            $data = $this->Taizhang_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
