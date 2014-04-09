<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dept extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Dept_Model');
    }
    
	public function index()
	{
        $data = $this->Dept_Model->getDeptListByTree();
        
        $this->assign('data',$data);
		$this->display();
	}
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            if($_POST['id'] == 1){
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '该部门不能删除'));
            }else{
                $dept = $this->Dept_Model->getById(array('where' => array('id' => $_POST['id'],'status' => '正常')));
            }
            
            if($dept){
                
                $childs = $this->Dept_Model->getDeptListByTree($dept['id']);
                $ids = array($dept['id']);
                foreach($childs as $key => $val){
                    $ids[] = $val['id'];
                }
                $this->Dept_Model->fake_delete(array('id' => $ids));
                /**
                 * 首先 update user 表 
                 */
                
                
                /**
                 * 再 update dept 表 
                 */
                
                $this->sendFormatJson('success',array('id' => implode(',',$ids) , 'text' => '删除成功'));
            }else{
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '找不到记录,删除失败'));
            }
            
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->_addRules();
            $this->form_validation->set_rules('pid', '上级部门', 'required|integer');
            if($this->form_validation->run()){
                
                if($_POST['id'] == $_POST['pid'] || $_POST['id'] == 1){
                    unset($_POST['pid']);
                }
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $this->Dept_Model->update($_POST);
                $dept = $this->Dept_Model->getById(array('where' => array('id' => $_POST['id'])));
                //print_r($dept);
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $dept = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $dept = $this->Dept_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $data = $this->Dept_Model->getDeptListByTree();
        
        $this->Dept_Model->saveTree($data);
        $this->Dept_Model->clearDeptTree();
        //$self = $data[$dept['id']];
        
        $childs = $this->Dept_Model->getDeptListByTree($dept['id']);
        
        $ids = array($dept['id']);
        foreach($childs as $key => $val){
            $ids[] = $val['id'];
        }
        
        $employs = $this->User_Model->getList(array(
           'where_in' => array(
               array('key' => 'dept_id ','value' => $ids )
             )
        ));
        
        $this->assign('dept',$dept);
        $this->assign('data',$data);
        $this->assign('employs',$employs);
        $this->display('add');
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('name', '部门名称', 'required|min_length[2]|max_length[50]');
    }

    public function add()
	{
        
        $data = $this->Dept_Model->getDeptListByTree();
        
        if($this->isPostRequest()){
            $this->assign('dept',$_POST);
            
            $this->_addRules();
            
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                
                if(empty($_POST['pid'])){
                    $_POST['pid'] = 0;
                }
                
                $insertid = $this->Dept_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        $this->assign('data',$data);
        $this->display();
		
	}
}

