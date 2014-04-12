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
            
            $condition['order'] = "createtime desc";
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
        $this->form_validation->set_rules('name', '名称', 'required|min_length[3]|max_length[100]|htmlspecialchars');
        $this->form_validation->set_rules('type', '类型', 'required|numeric');
        $this->form_validation->set_rules('mobile', '手机号码', 'required|numeric|exact_length[11]');
        $this->form_validation->set_rules('tel', '固定电话', 'required|numeric_dash|min_length[5]|max_length[20]');
        $this->form_validation->set_rules('fax', '传真', 'required|numeric_dash|min_length[3]|max_length[15]');
        $this->form_validation->set_rules('address', '地址', 'required|min_length[3]|max_length[150]|htmlspecialchars');
    }
    
    public function add()
	{
        
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                
                $insertid = $this->Contacts_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    
    
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '通讯录编号', 'required|is_natural_no_zero');
            
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
            $info = $this->Contacts_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
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
            $this->sendFormatJson('success',array('id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
}

