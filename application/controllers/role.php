<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Role extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Role_Model');
    }
    
	public function index()
	{
        $this->_getPageData();
		$this->display();
	}
    
    public function auth(){
        $this->load->model('Menu_Model');
        $data = $this->Menu_Model->getListByTree();
        
        if(!empty($_GET['id'])){
            $info = $this->Role_Model->getById(array('where' => array('id' => intval($_GET['id']))));
        }
        
        $this->load->model('Role_Menu_Model');
        
        $roleMenu = $this->Role_Menu_Model->getList(array(
            'field' => 'auth_key',
            'where' => array('role_id' => $_GET['id'],'status' => 0)
        ));
        
        $existsAuth = array();
        if($roleMenu['data']){
            foreach($roleMenu['data'] as $value){
                $existsAuth[] = $value['auth_key'];
            }
        }
        
        $this->assign('existsAuth',$existsAuth);
        $this->assign('actionUrl',url_path('role','auth'));
        if($this->isPostRequest() && !empty($_POST['id'])){
            $info = $this->Role_Model->getById(array('where' => array('id' => intval($_POST['id']))));
            
            if($info['type'] == 1 && $this->_userProfile['id'] != 1){
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,系统角色权限只能由超级管理员修改");
            }else{
                $this->form_validation->set_rules('auth_key[]', '权限ID', 'exact_length[32]|alpha_numeric');

                if($this->form_validation->run()){
                    
                    $updateCount = $this->Role_Menu_Model->updateByWhere(
                            array('status' => 1,'updator' => $this->_userProfile['name'],'updatetime' => time()),
                            array('role_id' => $_POST['id'])
                            );

                    if(!empty($_POST['auth_key'])){
                        $this->load->model('Menu_Model');
                        /**
                        * 必须是系统内部的已经存在的
                        */
                        $menuList = $this->Menu_Model->getList(array(
                            'where_in' => array(
                                array(
                                    'key'=> 'auth_key' ,
                                    'value' => array_values($_POST['auth_key'])
                                )
                            )
                        ));

                        $newmenu = array();
                        $now = time();
                        foreach($menuList['data'] as $value){
                            $newmenu[] = array(
                                'role_id' => $_POST['id'],
                                'auth_key' => $value['auth_key'],
                                'creator' => $this->_userProfile['name'],
                                'updator' => $this->_userProfile['name'],
                                'createtime' => $now,
                                'updatetime' => $now,
                            );
                        }

                        if($newmenu){
                            $this->Role_Menu_Model->batchInsert($newmenu);
                        }
                    }

                    $this->assign("feedback", "success");
                    $this->assign('feedMessage',"修改成功");
                }else{
                    $this->assign("feedback", "failed");
                    $this->assign('feedMessage',"修改失败");
                }
            }
            
            $this->assign('redirectUrl',url_path('role','auth','id='.$_POST['id']));
        }
        
        $this->assign('info',$info);
        $this->assign('data',$data);
        $this->display('auth','menu');
    }
    
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            
            $role = $this->Role_Model->getById(array('where' => array('id' => $_POST['id'])));
            
            if($role['type'] == 1){
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '系统角色不能删除'));
            }
            
            $this->load->model('User_Model');
            $usedCount = $this->User_Model->getCount(array('where' => array('role_id' => $_POST['id'],'status' => '正常')));
            
            if($usedCount){
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '角色正在使用，不能删除'));
            }
            
            $this->Role_Model->fake_delete($_POST);
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
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                if(empty($_POST['type'])){
                    $_POST['type'] = 2;
                }else{
                    if(!in_array($_POST['type'],array(1,2))){
                        $_POST['type'] = 2;
                    }
                }
                
                $this->Role_Model->update($_POST);
                $role = $this->Role_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $role = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $role = $this->Role_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('role',$role);
        $this->display('add');
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('name', '角色名称', 'required|min_length[2]|max_length[10]');
        $this->form_validation->set_rules('type', '角色类型', 'required|is_natural|less_than[3]');
    }

    public function add()
	{
        if($this->isPostRequest()){
            $this->assign('role',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                
                if(empty($_POST['type'])){
                    $_POST['type'] = 2;
                }else{
                    if(!in_array($_POST['type'],array(1,2))){
                        $_POST['type'] = 2;
                    }
                }
                
                $insertid = $this->Role_Model->add($_POST);
                
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
            
            $data = $this->Role_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
}

