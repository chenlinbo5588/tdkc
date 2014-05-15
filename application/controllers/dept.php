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
                $data = array();
                
                foreach($childs as $key => $val){
                    $ids[] = $val['id'];
                }
                $this->Dept_Model->fake_delete(array('id' => $ids));
                $this->load->model('User_Model');
                
                $users = $this->User_Model->getList(array('select' => 'id', 'where_in' => array('dept_id' => $ids)));
                
                if($users){
                    foreach($users['data'] as $user ){
                        $data[] = array(
                            'id' => $user['id'],
                            'dept_id' => $dept['pid']
                        );
                    }
                    $this->User_Model->batchUpdate($data,'id');
                }
                
                $this->sendFormatJson('success',array('operation' => 'delete', 'id' => implode(',',$ids) , 'text' => '删除成功'));
            }else{
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '找不到记录,删除失败'));
            }
            
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        
        $selfid = (int)gpc('id', "GP",0);
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            $this->form_validation->set_rules('pid', '上级部门', 'required|integer');
            if($this->form_validation->run()){
                
                /**
                 * 设置上级菜单 不能为 当前菜单的 的下级菜单
                 */
                $childs  = $this->Dept_Model->getDeptListByTree($_POST['id']);
                
                $keys = array_keys($childs);
                if(in_array($_POST['pid'],$keys )){
                    //防止循环引用
                    $this->assign("feedback", "failed");
                    $this->assign('feedMessage',"修改失败,不能将当前部门的下级部门设置未其上级设置");
                }else{
                    if($_POST['id'] == $_POST['pid'] || $_POST['id'] == 1){
                        unset($_POST['pid']);
                    }
                    
                    // add
                    $_POST['updator'] = $this->_userProfile['name'];
                    $this->Dept_Model->update($_POST);
                    //print_r($dept);
                    $this->assign("feedback", "success");
                    $this->assign('feedMessage',"修改成功");
                }
                
                $dept = $this->Dept_Model->getById(array('where' => array('id' => $_POST['id'])));
                
            }else{
                $dept = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $dept = $this->Dept_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->Dept_Model->clearDeptTree();
        $data = $this->Dept_Model->getDeptListByTree();
        
        $this->Dept_Model->saveTree($data);
        $this->Dept_Model->clearDeptTree();
        //$self = $data[$dept['id']];
        
        if(!$childs){
            $childs = $this->Dept_Model->getDeptListByTree($dept['id']);
        }
        
        $ids = array_keys($childs);
        $ids[] = $dept['id'];
        
        $employs = $this->User_Model->getList(array(
           'where_in' => array(
               array('key' => 'dept_id ','value' => $ids )
             )
        ));
        $this->assign('gobackUrl',$gobackUrl);
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
            $gobackUrl = $_POST['gobackUrl'];
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
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('data',$data);
        $this->display();
		
	}
}

