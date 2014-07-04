<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Contacts extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Contacts_Model');
    }
    
    
	
	public function index()
	{
        
        $this->_getPageData();
        
		$this->display();
	}
    
    private function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('contacts','index')
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array();
            
            if(!empty($_GET['mobile'])){
                $condition['like']['mobile'] = $_GET['mobile'];
            }
            
            if(!empty($_GET['tel'])){
                $condition['like']['tel'] = $_GET['tel'];
            }
            
            if($_GET['type'] !== ''){
                $condition['where']['type'] = $_GET['type'];
            }
            
            if($_GET['inc_del'] != '是'){
                $condition['where']['status'] = '正常';
            }
            
            
            $data = $this->Contacts_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addRules(){
        
        
        $this->form_validation->set_rules('type', '类型', 'required|is_natural|less_than[2]');
        
        if($_POST['type'] == 1){
            $this->form_validation->set_rules('company_name', '单位名称', 'required|min_length[1]|max_length[100]|htmlspecialchars');
        }
        
        $this->form_validation->set_rules('name', '名称', 'required|min_length[1]|max_length[100]|htmlspecialchars');
        if(!empty($_POST['mobile'])){
            $this->form_validation->set_rules('mobile', '手机号码', 'trim|valid_mobile');
        }
        
        //$this->form_validation->set_rules('tel', '固定电话', 'valid_telephone');
        $this->form_validation->set_rules('tel', '固定电话', 'numeric_dash|min_length[6]|max_length[15]');
        $this->form_validation->set_rules('virtual_no', '虚拟号码', 'numeric_dash|max_length[10]');
        $this->form_validation->set_rules('fax', '传真', 'numeric_dash|min_length[6]|max_length[15]');
        $this->form_validation->set_rules('address', '地址', 'max_length[150]|htmlspecialchars');
    }
    
    public function add()
	{
        
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                
                if($_POST['type'] == 0){
                    $_POST['company_name'] = OUR_COMPANY_NAME;
                }
                
                $insertid = $this->Contacts_Model->add($_POST);
                
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
    
    
    
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '通讯录编号', 'required|is_natural_no_zero');
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                $this->Contacts_Model->update($_POST);
                $info = $this->Contacts_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Contacts_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('add');
    }
    
    /**
     * 删除日程 
     */
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->Contacts_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete', 'id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
}

