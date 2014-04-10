<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Menu extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Menu_Model');
    }
    
	public function index()
	{
        $data = $this->Menu_Model->getListByTree(0,'----');
        $this->assign('data',$data);
		$this->display();
	}
    
    public function auth(){
        
        
        $data = $this->Menu_Model->getListByTree();
        $this->assign('data',$data);
        $this->display();
    }
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $dept = $this->Menu_Model->getById(array('where' => array('id' => $_POST['id'],'status' => '正常')));
            
            if($dept){
                
                /**
                 * 判断权限 
                 */
                $childs = $this->Menu_Model->getListByTree($dept['id']);
                
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
            $this->form_validation->set_rules('url', '权限名称', 'required|callback_custom_url|is_unique_not_self['.$this->Menu_Model->_tableName.".url.id.".$_POST['id']."]");
            if($this->form_validation->run()){
                
                /**
                 * 上级不能是自己 
                 */
                if($_POST['id'] == $_POST['pid'] || $_POST['id'] == 1){
                    unset($_POST['pid']);
                }
                
                /**
                 * 设置上级菜单 不能为 当前菜单的 的下级菜单
                 */
                $childs  = $this->Menu_Model->getListByTree($_POST['id']);
                
                $keys = array_keys($childs);
                if(in_array($_POST['pid'],$keys )){
                    //防止循环引用
                    $this->assign("feedback", "failed");
                    $this->assign('feedMessage',"修改失败,不能将当前菜单的上级设置未其下级菜单");
                }else{
                    // add
                    $_POST['updator'] = $this->_userProfile['name'];
                    $this->Menu_Model->update($_POST);
                    $this->assign("feedback", "success");
                    $this->assign('feedMessage',"修改成功");
                }
                
                $menu = $this->Menu_Model->getById(array('where' => array('id' => $_POST['id'])));
                
            }else{
                $menu = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $menu = $this->Menu_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->Menu_Model->clearMenuTree();
        $data = $this->Menu_Model->getListByTree();
        $this->assign('menu',$menu);
        $this->assign('data',$data);
        $this->display('add');
    }
    
    /**
     *
     * @param type $str
     * @return boolean 
     */
    public function custom_url($str){
        
        if (!preg_match('/^c=[a-zA-Z_]{1,20}&m=[a-zA-Z_]{1,20}$/',$str,$matchs))
        {
            $this->form_validation->set_message('custom_url', '%s 字段输入不正确');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
        
        
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('name', '菜单名称', 'required|min_length[2]|max_length[50]');
        
        $this->form_validation->set_rules('pid', '上级菜单', 'required|is_natural');
    }

    public function add()
	{
        
        $data = $this->Menu_Model->getListByTree();
        
        if($this->isPostRequest()){
            $this->assign('menu',$_POST);
            
            $this->_addRules();
            $this->form_validation->set_rules('url', '权限名称', 'required|callback_custom_url|is_unique['.$this->Menu_Model->_tableName.".url]");
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                
                if(empty($_POST['pid'])){
                    $_POST['pid'] = 0;
                }
                
                $insertid = $this->Menu_Model->add($_POST);
                
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

