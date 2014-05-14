<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Inout extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('In_Model');
        $this->load->model('Out_Model');
    }
    
    
	
	public function index()
	{
        $this->assign('action','receive');
        $this->_getPageData('receive');
		$this->display('receive');
	}
    
    public function receive(){
        $this->assign('action','receive');
        $this->_getPageData('receive');
		$this->display();
    }
    
    
    public function send(){
        $this->assign('action','send');
        $this->_getPageData('send');
		$this->display();
    }
    
    private function _getPageData($action = 'index'){
        try {
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('inout','index')
            );
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
            }
            
            $condition['where'] = array();
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            $condition['where']['status'] = '正常';
            
            switch($action){
                //默认是收文
                case 'receive':
                    $data = $this->In_Model->getList($condition);
                    break;
                case 'send':
                    $data = $this->Out_Model->getList($condition);
                    break;
                default:
                    break;
            }
            
            $this->assign('action',$action);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addInRules(){
        $this->form_validation->set_rules('sendor', '发文单位', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('title', '主题', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('file_code', '文件文号', 'required|max_length[50]|htmlspecialchars');
        $this->form_validation->set_rules('receive_time', '收文时间', 'required|valid_date');
    }
    
    
    private function _addOutRules(){
        $this->form_validation->set_rules('title', '主题', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('file_code', '文件文号', 'required|max_length[50]|htmlspecialchars');
        $this->form_validation->set_rules('send_time', '发文时间', 'required|valid_date');
        
    }
    
    public function addin()
	{
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            
            $this->_addInRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                
                $insertid = $this->In_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    
    public function addout()
	{
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            
            $this->_addOutRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                
                $insertid = $this->Out_Model->add($_POST);
                
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
    public function editin(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '收文ID', 'required|is_natural_no_zero');
            
            $this->_addInRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                $this->In_Model->update($_POST);
                $info = $this->In_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $info = $this->In_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->assign('info',$info);
        $this->display('addin');
    }
    
    
    /**
     * 修改 
     */
    public function editout(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '发文ID', 'required|is_natural_no_zero');
            
            $this->_addOutRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                $this->Out_Model->update($_POST);
                $info = $this->Out_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $info = $this->Out_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->assign('info',$info);
        $this->display('addout');
    }
    
    /**
     * 删除 收文
     */
    public function deletein()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->In_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
}

