<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Taizhang extends TZ_Admin_Controller {
    
    public $projectTypeList = null;
    
    
    public function __construct(){
        parent::__construct();
        
        $this->projectTypeList = getTaizhangList();
        $this->load->model('Region_Model');
        $this->load->model('Project_Nature_Model');
        $this->load->model('Taizhang_Model');
        
        $this->load->helper('number');
    }
    
    
    
    
	public function index()
	{
        
        $this->assign('action','index');
        
        $this->_initData();
        
        
        if('delete' == $_GET['inc_del']){
            $this->_getPageData(array( 'status !=' => ''));
        }else{
            $this->_getPageData(array( 'status !=' => '已删除'));
        }
        
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
            
            $now = time();
            if('收费' == $_POST['submit']){
                if(!empty($_POST['complete_time'])){
                    $this->form_validation->set_rules('complete_time', '项目完成时间', 'valid_date');
                }else{
                    $_POST['complete_time'] = 0;
                }

                if(!empty($_POST['get_doc'])){
                    $this->form_validation->set_rules('get_doc', '成果资料领取', 'is_natural|less_than[2]');
                }else{
                    $_POST['get_doc'] = 0;
                }

                if(!empty($_POST['get_doctime'])){
                    $this->form_validation->set_rules('get_doctime', '成果资料领取时间', 'valid_date');
                }else{
                    $_POST['get_doctime'] = 0;
                }

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
                //$this->form_validation->set_rules('ys_amount', '应收金额', 'required|numeric');
                $this->form_validation->set_rules('ss_amount', '实收金额', 'required|numeric');


                //$this->form_validation->set_rules('is_owed', '欠费情况', 'required|is_natural|less_than[2]');
                //$this->form_validation->set_rules('is_gov', '是否政府挂账', 'required|is_natural|less_than[2]');
                if(!empty($_POST['fee_type'])){
                    $this->form_validation->set_rules('fee_type', '收费情况', 'is_natural|less_than[6]');
                }else{
                    $_POST['fee_type'] = 0;
                }

                if(!empty($_POST['remark'])){
                    $this->form_validation->set_rules('remark', '备注', 'max_length[500]');
                }else{
                    $_POST['remark'] = '';
                }

                if($this->form_validation->run()){
                    $data = array(
                        'complete_time' => $_POST['complete_time'],
                        'get_doc' => $_POST['get_doc'],
                        'get_doctime' => $_POST['get_doctime'],
                        'get_owner' => $_POST['get_owner'],
                        'owner_tel' => $_POST['owner_tel'],
                        'kh_amount' => $_POST['kh_amount'],
                        'ys_amount' => 0,
                        'ss_amount' => $_POST['ss_amount'],
                        //'is_owed' => $_POST['is_owed'],
                        //'is_gov' => $_POST['is_gov'],
                        'collect_date' => date("Y-m-d"),
                        'fee_type' => $_POST['fee_type'],
                        'remark' => $_POST['remark'],
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id']));
                    if($return){
                        $this->sendFormatJson('success', array('text' => $_POST['submit'].'成功'));
                    }else{
                        $this->sendFormatJson('failed', array('text' => $_POST['submit'].'失败'));
                    }
                }else{
                    $message = strip_tags(validation_errors());
                    $this->sendFormatJson('failed', array('text' => $message));
                }
            }elseif('受理' == $_POST['submit']){
                $data = array(
                    'can_revocation' => 0,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now
                );
                $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'],'status' => '已通过复审','can_revocation' => 1));
                if($return){
                    $this->sendFormatJson('success', array('text' => $_POST['submit'].'成功'));
                }else{
                    $this->sendFormatJson('failed', array('text' => $_POST['submit'].'失败'));
                }
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
    
    private function _initData(){
        $this->assign('projectTypeList',$this->projectTypeList);
        
        /**
         * 区域 
         */
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => date("Y")),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        /**
         * 项目性质 
         */
        $natureList = $this->Project_Nature_Model->getList(array('where' => array('status' => '正常'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('natureList',$natureList['data']);
        
        $this->assign('hasFeeAuth',$this->checkAuth("taizhang+fee"));
    }
    
    
    public function recyclebin(){
        $this->assign('action','recyclebin');
        $this->_initData();
        
        $this->_getPageData(array('status' => '已删除'));
		$this->display('index');
        
    }
    
    public function dating(){
        $this->assign('action','dating');
        $this->_initData();
        
        if('delete' == $_GET['inc_del']){
            $this->_getPageData(array( 'status !=' => ''));
        }else{
            $this->_getPageData(array( 'status !=' => '已删除'));
        }
        
		$this->display();
    }
    
    /**
     * 重新启用 
     */
    public function restore(){
        if($this->isPostRequest() && !empty($_POST['restore_id'])){
            $message = array();
            $reload = 0;
            
            $successCnt = 0;
            $failedCnt = 0;
            
            foreach($_POST['restore_id'] as $val){
                $updateData = array(
                        'status' => '新增',
                        'zc_time' => 0,
                        'cs_time' => 0,
                        'fs_time' => 0,
                        'zc_name' => '',
                        'cs_name' => '',
                        'fs_name' => '',
                        'zc_yj' => '',
                        'cs_yj' => '',
                        'fs_yj' => '',
                        'zc_remark' => '',
                        'cs_remark' => '',
                        'fs_remark' => '',
                        'sendor_id' => $this->_userProfile['id'],
                        'sendor' => $this->_userProfile['name'],
                        'creator' => $this->_userProfile['name'],
                        'updatetime' => time(), 
                        'updator' => $this->_userProfile['name']
                    );
                //谁重新启用的 就归谁
                /*
                $info = $this->Taizhang_Model->queryById($val);
                $sendorInfo = $this->User_Model->getFirst(array(
                    'where' => array(
                        'name' => $info['creator']
                    )
                ));
                
                if($sendorInfo){
                    $updateData['sendor_id'] = $sendorInfo['id'];
                    $updateData['sendor'] = $sendorInfo['name'];
                }
                */
                
                $flag = $this->Taizhang_Model->updateByWhere(
                    $updateData,
                    array(
                        'id' => $val,
                        'status' => '已删除'
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
                $message[] = '<p class="success">'.$successCnt.'个记录重新启用成功</p>';
            }
            
            if($failedCnt){
                $message[] = '<p class="failed">'.$failedCnt.'个记录重新启用失败</p>';
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
        
        //$projectTypeList = $this->Project_Type_Model->getList(array('order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$this->projectTypeList);
        
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
            
            $categroy = array();
            
            if(!empty($_GET['category'])){
                $condition['where_in'][] = array('key' => 'category' , 'value' => $_GET['category']);
                
                foreach($_GET['category'] as $cate){
                    $categroy[$cate] = true;
                }
            }
            
            $this->assign('category',$categroy);
        
            if(!empty($_GET['status'])){
                $condition['where']['status'] = $_GET['status'];
            }
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            if(!empty($_GET['region_name'])){
                $condition['where']['region_name'] = trim($_GET['region_name']);
            }
            
            if(!empty($_GET['pm'])){
                $condition['where']['pm'] = trim($_GET['pm']);
            }
            
            if(!empty($_GET['creator'])){
                $condition['where']['creator'] = trim($_GET['creator']);
            }
            
            if(!empty($_GET['nature'])){
                $condition['where']['nature'] = trim($_GET['nature']);
            }
            
            if(is_array($_GET['fee_type'])){
                $feeValue = array();
                $feeGet = array();
                foreach($_GET['fee_type'] as $fv){
                    $feeValue[] = substr($fv,1);
                    $feeGet[$fv] = 1;
                }
                
                $this->assign('feeGet',$feeGet);
                if($feeValue){
                    $condition['where_in'][] = array('key' => 'fee_type' , 'value' => $feeValue);
                }
            }
            
            if(is_array($_GET['get_doc'])){
                $docValue = array();
                $docGet = array();
                foreach($_GET['get_doc'] as $fv){
                    $docValue[] = substr($fv,1);
                    $docGet[$fv] = 1;
                }
                
                $this->assign('docGet',$docGet);
                if($docValue){
                    $condition['where_in'][] = array('key' => 'get_doc' , 'value' => $docValue);
                }
            }
            
            if(!empty($_GET['sendor'])){
                $condition['where']['sendor'] = trim($_GET['sendor']);
            }
            
            if(!empty($_GET['remark'])){
                $condition['like']['remark'] = trim($_GET['remark']);
            }
            
            $data = $this->Taizhang_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
