<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Taizhang extends TZ_Admin_Controller {
    
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
        $this->_getPageData();
		$this->display();
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
                    'status' => '已收费',
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
                    $this->_addPm($info, array('id' => $info['sendor_id']), 2);
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
        $this->display();
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
    
    /**
     * 统计 
     */
    public function statistics(){
        
        $projectTypeList = array(
            '土地勘测' => '土地勘测',
            '房产项目' => '房产项目',
            '放线竣工' => '放线竣工',
            '违法用地勘测' => '违法用地勘测',
            '土方山塘地形评估控制' => '土方山塘地形评估控制',
            '个人建房' => '个人建房'
        );
        
        //$projectTypeList = $this->Project_Type_Model->getList(array('order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$projectTypeList);
        
        $condition = array();
        
        $this->load->model('Taizhang_Model');
        
        $fields = array('COUNT(*) AS cnt', 'year' ,'month','category' ,'region_name','pm','nature');
        
        if(!empty($_GET['sdate'])){
            $condition['where']['createtime >='] = strtotime($_GET['sdate']);
        }else{
            $condition['where']['createtime >='] = strtotime(date("Y-m-d"));
        }

        if(!empty($_GET['edate'])){
            $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
        }else{
            $condition['where']['createtime <='] = strtotime(date("Y-m-d")) + 86400;
        }
        
        $condition['group_by'] = array('year','month');
        
        if(!empty($_GET['region_name'])){
            $condition['where']['region_name'] = $_GET['region_name'];
        }else{
            array_push($condition['group_by'],'region_name');
        }
        
        if(!empty($_GET['pm'])){
            $condition['where']['pm'] = $_GET['pm'];
        }else{
            array_push($condition['group_by'],'pm');
        }
        
        if(!empty($_GET['category'])){
            $condition['where']['category'] = $_GET['category'];
        }else{
            array_push($condition['group_by'],'category');
        }
        
        array_push($condition['group_by'],'nature');
        
        $condition['select'] = implode(',',$fields);
        $data = $this->Taizhang_Model->getList($condition);
        
        $this->assign('data',$data);
        $this->display();
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
                'status !=' => '已删除'
            );
            
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
            
            $data = $this->Taizhang_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
