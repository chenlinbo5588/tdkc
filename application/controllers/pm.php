<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pm extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Pm_Model');
    }
    
    
	
	public function index()
	{
        $this->_getPageData();
        
		$this->display();
	}
    
    private function _getPageData(){
        try {
            
            $action = gpc("action","GP","send");
            $action = strtolower($action);
            
            if(!in_array($action,array('send','receive','trash'))){
                $action = 'send';
            }
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('pm','index')
            );
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
            }
            
            $condition['where'] = array();
            
            switch($action){
                case 'send':
                    $condition['where']['user_id'] = $this->_userProfile['id'];
                    break;
                case 'receive':
                    $condition['where']['to_user_id'] = $this->_userProfile['id'];
                    break;
                case 'trash':
                    $condition['where']['user_id'] = $this->_userProfile['id'];
                    $condition['where']['status'] = '已删除';
                    break;
                default:
                    break;
            }
            
            
            $data = $this->Pm_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('title', '标题', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('to_user_id', '收件人', 'trim|required||is_natural_no_zero');
        $this->form_validation->set_rules('to_user_name', '收件人', 'trim|required');
        $this->form_validation->set_rules('content', '内容', 'required|min_length[3]|htmlspecialchars');
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
                
                $insertid = $this->Pm_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    
    /**
     * 修改 
     */
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '工作编号', 'required|is_natural_no_zero');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                
                $this->Pm_Model->update($_POST);
                $info = $this->Pm_Model->getById(array('where' => array('id' => $_POST['id'],'user_id' => $this->_userProfile['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $info = $this->Pm_Model->getById(array('where' => array('id' => $_GET['id'],'user_id' => $this->_userProfile['id'])));
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
            
            $_POST['user_id'] = $this->_userProfile['id'];
            
            $this->Pm_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
}

