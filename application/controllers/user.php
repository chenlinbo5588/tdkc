<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Model');
    }
    
	public function index()
	{
        $this->_getPageData();
		$this->display();
	}
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            if($_POST['id'] == 1){
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '超级管理不能删除'));
            }
            
            $this->User_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    /*
    public function editunique($str,$field){
        print_r($field);
        
        list($table, $field)=explode('.', $field);
        $count = $this->User_Model->getCount(array(
            'where' => array(
                    $field => $str
                )
            )
        );
        
        if ($count > 1)
        {
            $this->form_validation->set_message('editunique', '%s 字段输入不正确');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    */
    
    
    public function edit(){
        $this->assign('action','edit');
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            //$this->form_validation->set_rules('account', '账号', 'required|min_length[3]|max_length[15]|alpha_dash|callback_editunique['.$this->User_Model->_tableName.'.account]');
            //$this->form_validation->set_rules('gh', '工号', 'required|numeric|callback_editunique['.$this->User_Model->_tableName.'.gh]');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['enter_date'] = empty($_POST['enter_date']) ? time() : strtotime($_POST['enter_date']);
                
                $this->User_Model->update($_POST);
                
                $user = $this->User_Model->getById(array('where' => array('user_id' => $_POST['id'])));
                
                $user['enter_date'] = date("Y-m-d",$user['enter_date']);
                $user['graduation_date'] = date("Y-m-d",$user['graduation_date']);
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $user = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $user = $this->User_Model->getById(array('where' => array('user_id' => $_GET['id'])));
            $user['enter_date'] = date("Y-m-d",$user['enter_date']);
            $user['graduation_date'] = date("Y-m-d",$user['graduation_date']);
        }
        
        $this->assign('user',$user);
        $this->display('add');
    }
    
    private function _addRules(){
        
        $this->form_validation->set_error_delimiters('<span class="'.config_item('validation_error').'">', '</span>');
        $this->form_validation->set_rules('name', '姓名', 'required|min_length[1]|max_length[20]');
        //$this->form_validation->set_rules('name', '姓名', 'required|min_length[1]|max_length[20]');
        
        if(!empty($_POST['psw'])){
            $this->form_validation->set_rules('psw', '密码', 'required|min_length[6]|max_length[12]|matches[psw2]');
            $this->form_validation->set_rules('psw2', '密码确认', 'required|min_length[6]|max_length[12]');
        }

        if(!empty($_POST['id_card'])){
            //$this->form_validation->set_rules('id_card', '身份证号码', 'callback_id_check');
        }

        if(!empty($_POST['email'])){
            $this->form_validation->set_rules('email', '邮箱', 'required|valid_email');
        }

        $this->form_validation->set_rules('mobile', '手机号码', 'required|exact_length[11]|numeric');
        $this->form_validation->set_rules('enter_date', '入院时间', 'required');
    }


    public function add()
	{
        if($this->isPostRequest()){
            $this->assign('user',$_POST);
            
            
            $this->form_validation->set_rules('account', '账号', 'required|min_length[3]|max_length[15]|alpha_dash|is_unique['.$this->User_Model->_tableName.'.account]');
            $this->form_validation->set_rules('gh', '工号', 'required|numeric|is_unique['.$this->User_Model->_tableName.'.gh]' );
            
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['enter_date'] = empty($_POST['enter_date']) ? time() : strtotime($_POST['enter_date']);
                $_POST['graduation_date'] = empty($_POST['graduation_date']) ? time() : strtotime($_POST['graduation_date']);
                
                $userid = $this->User_Model->add($_POST);
                
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
     * for test 
     * @param type $str
     * @return boolean 
     */
    public function id_check($str)
    {
        if ($str != 'test')
        {
            $this->form_validation->set_message('id_check', '%s 字段输入不正确');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
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
                'query_param' => url_path('user','index',array('name' => $_GET['name']))
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            if($_GET['inc_del'] != '是'){
                $condition['where'] = array(
                    'status = ' => '正常'  
                );
            }
            
            $data = $this->User_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
