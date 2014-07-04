<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Device extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Device_Model');
    }
    
	public function index()
	{
        $this->_getPageData();
		$this->display();
	}
    
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->Device_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            $this->form_validation->set_rules('name', '名称', 'required|min_length[2]|max_length[30]|callback_checkname[edit-'.$_POST['id'].']');
            
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['displayorder'] = empty($_POST['displayorder']) ? 0 : intval($_POST['displayorder']);
                $this->Device_Model->update($_POST);
                $info = $this->Device_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Device_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('add');
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('name', '设备名称', 'required|min_length[1]|max_length[100]');
        
        
        if(!empty($_POST['type'])){
            $this->form_validation->set_rules('type', '设备型号', 'min_length[1]|max_length[100]');
        }else{
            $_POST['type'] = '';
        }
        if(!empty($_POST['buy_time'])){
            $this->form_validation->set_rules('buy_time', '购买日期', 'valid_date');
        }else{
            $_POST['buy_time'] = '';
        }
        
        if(!empty($_POST['pay_amout'])){
            $this->form_validation->set_rules('pay_amout', '购买价格', 'is_numeric');
        }else{
            $_POST['pay_amout'] = 0;
        }
        
        if(!empty($_POST['user'])){
            $this->form_validation->set_rules('user', '使用者', 'max_length[30]');
        }else{
            $_POST['user'] = '';
        }
        
        if(!empty($_POST['check_sdate'])){
            $this->form_validation->set_rules('check_sdate', '质检有效期开始', 'valid_date');
        }else{
            $_POST['check_sdate'] = '';
        }
        if(!empty($_POST['check_edate'])){
            $this->form_validation->set_rules('check_edate', '质检有效期结束', 'valid_date');
        }else{
            $_POST['check_edate'] = '';
        }
        
        $this->form_validation->set_rules('is_off', '是否报废', 'required|is_natural|less_than[2]');
        
        if(!empty($_POST['displayorder'])){
            $this->form_validation->set_rules('displayorder', '排序', 'integer');
        }
    }
    
    public function add()
	{
        $this->assign('info',$_POST);
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                $_POST['displayorder'] = empty($_POST['displayorder']) ? 0 : intval($_POST['displayorder']);
                $insertid = $this->Device_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
		
	}
    
    
    public function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('project_type','index',array('name' => $_GET['name']))
            );
            
            
            $condition['where']['status'] = '正常';
            
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            $data = $this->Device_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
}

