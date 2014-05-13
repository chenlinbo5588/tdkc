<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Notice extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Announce_Model');
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
                'query_param' => url_path('notice','index')
            );
            
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
            }
            
            $condition['where'] = array();
            $condition['where']['status'] = '正常';
            $condition['where']['type'] = 1;
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            
            $data = $this->Announce_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('title', '标题', 'required|min_length[3]|max_length[200]|htmlspecialchars');
    }
    
    public function add()
	{
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['content'] = '';
                $_POST['type'] = 1;
                $insertid = $this->Announce_Model->add($_POST);
                
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
     * 
     */
    public function detail(){
        
        $id = (int)gpc("id","GP",0);
        $pm = $this->Announce_Model->queryById($id);
        
        if(!$pm){
            die("信息找不到");
        }
        $this->assign('info',$pm);
        $this->display();
    }
    
    
    /**
     * 修改 
     */
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '公告编号', 'required|is_natural_no_zero');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['content'] = '';
                $this->Announce_Model->update($_POST);
                $info = $this->Announce_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $info = $this->Announce_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->assign('info',$info);
        $this->display('add');
    }
    
    /**
     * 删除 
     */
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->Announce_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
}

