<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dept extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Dept_Model');
    }
    
	public function index()
	{
        $this->_getPageData();
		$this->display();
	}
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            /**
             * @todo 如果部门下面有员工 ,不能被删除 
             */
            $this->Dept_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $this->Dept_Model->update($_POST);
                $role = $this->Dept_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $role = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $role = $this->Dept_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->assign('role',$role);
        $this->display('add');
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('name', '角色名称', 'required|min_length[2]|max_length[10]');
    }

    public function add()
	{
        if($this->isPostRequest()){
            $this->assign('role',$_POST);
            
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                
                $insertid = $this->Dept_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    
    public function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "updatetime desc";
            $condition['pager'] = array(
                'page_size' => 2,
                'current_page' => $_GET['page'],
                'query_param' => url_path('role','index',array('name' => $_GET['name']))
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            if($_GET['inc_del'] != '是'){
                $condition['where'] = array(
                    'status = ' => '正常'  
                );
            }
            
            $data = $this->Dept_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
}

