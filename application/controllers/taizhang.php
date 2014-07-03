<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 测绘项目台账管理 
 */
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
        $this->_initPageData(date("Y"));
        $this->_getPageData();
		$this->display();
	}
    
    
    
    private function _addRules(){
        
        //$this->form_validation->set_rules('year', '年份', 'required|integer');
        $this->form_validation->set_rules('master_serial', '总编号', 'required|numeric');
        $this->form_validation->set_rules('region_serial', '分编号', 'required|numeric');
        $this->form_validation->set_rules('name', '单位名称', 'trim|required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '登记地址', 'trim|required|min_length[2]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('region_code', '区域', 'required|alpha');
        $this->form_validation->set_rules('total_area', '总面积', 'required|numeric');
        $this->form_validation->set_rules('churan_area', '出让面积', 'required|numeric');
        
        $this->form_validation->set_rules('nature', '用途', 'required' );
        
        $this->form_validation->set_rules('contacter', '联系人名称', 'trim|required|max_length[15]|htmlspecialchars');
        $this->form_validation->set_rules('contacter_mobile', '联系人手机', 'trim|numeric|min_length[4]|max_length[15]');
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
    
    private function _formatProjectNo($year,$regionCode,$masterSerial,$regionSerial,$prefix = 'A'){
        
        if($masterSerial < 1000){
            $masterSerial = str_pad($masterSerial, 4,'0', STR_PAD_LEFT);
        }

        if($regionSerial < 1000){
            $regionSerial = str_pad($regionSerial, 3,'0', STR_PAD_LEFT);
        }
        
        return $prefix.$year."-".$masterSerial."-".strtoupper($regionCode).$regionSerial;
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
    
    
    public function add()
	{
        $this->assign('action','add');
        if($this->isPostRequest()){
            
            $this->_addRules();
            if($this->form_validation->run()){
                $_POST['year'] = date("Y");
                $_POST['month'] = date("m");
                $_POST['contacter_tel'] = '';
                
                $_POST['project_no'] = $this->_formatProjectNo($_POST['year'], $_POST['region_code'], $_POST['master_serial'], $_POST['region_serial']);
                $this->_add($_POST['year']);
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
    
    
    private function _add($year){
         // add
        $_POST['user_id'] = $this->_userProfile['id'];
        $_POST['creator'] = $this->_userProfile['name'];
        
        /*
        $master_serial = $this->Taizhang_Model->getMaxByWhere('master_serial',array(
            'year' => $year
        ));

        $region_serial = $this->Taizhang_Model->getMaxByWhere('region_serial',array(
            'year' => $year,
            'region_code' => $_POST['region_code']
        ));

        $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
            
        $totalOffset = config_item('total_offset');
        if(!empty($totalOffset)){
            $_POST['master_serial'] += (int)$totalOffset[date("Y")];
        }

        $_POST['region_serial'] = $region_serial ? $region_serial + 1 : 1;

        $regionOffset = config_item('region_offset_'.date("Y"));

        if(!empty($regionOffset)){
            $_POST['region_serial'] += (int)$regionOffset[$_POST['region_code']];
        }

        $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['region_code'],$_POST['master_serial'],$_POST['region_serial']);
        */
        
        
        $regionName = $this->Region_Model->getList(array(
                'select' => 'name',
                'where' => array(
                    'year' => $year,
                    'code' => $_POST['region_code'],
                    'status' => '正常'
                )
        ));
        
        if($regionName['data'][0]['name']){
            $_POST['region_name'] = $regionName['data'][0]['name'];
        }else{
            $_POST['region_name'] = '';
        }
        
        
        $insertid = $this->Taizhang_Model->add($_POST);
        
        return $insertid;
        
    }
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->_addRules();
            if($this->form_validation->run()){
                $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_POST['id'])));
                $_POST['updator'] = $this->_userProfile['name'];
                
                if($info['region_code'] != strtoupper($_POST['region_code'])){
                    $regionName = $this->Region_Model->getList(array(
                        'select' => 'name',
                        'where' => array(
                            'year' => $info['year'],
                            'code' => $_POST['region_code'],
                            'status' => '正常'
                        )
                    ));

                    if($regionName['data'][0]['name']){
                        $_POST['region_name'] = $regionName['data'][0]['name'];
                    }else{
                        $_POST['region_name'] = '';
                    }
                }else{
                    $_POST['region_name'] = $info['region_name'];
                }
                
                $_POST['project_no'] = $this->_formatProjectNo($info['year'], $_POST['region_code'], $_POST['master_serial'], $_POST['region_serial']);
                
                $this->Taizhang_Model->update($_POST);
                $this->sendFormatJson('success', array('text' => '修改成功'));
            }else{
                $message = strip_tags(validation_errors());
                $this->sendFormatJson('failed', array('text' => $message));
            }
        }else{
            $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_GET['id'])));
            $this->_initPageData($info['year']);
            
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
