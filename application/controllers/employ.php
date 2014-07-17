<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Employ extends TZ_Admin_Controller {
    
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
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        
        $this->load->model('Dept_Model');
        $data = $this->Dept_Model->getDeptListByTree();
        $this->assign('deptList',$data);
        
        $this->load->model('Role_Model');
        $roleList = $this->Role_Model->getList(array('where' => array('status' => '正常','type' => 2)));
        
        $this->assign('roleList',$roleList['data']);
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->form_validation->set_rules('account', '账号', 'required|min_length[3]|max_length[15]|alpha_dash|is_unique_not_self['.$this->User_Model->_tableName.'.account.id.'.$_POST['id'].'.status.正常]');
            $this->form_validation->set_rules('gh', '工号', 'required|numeric|is_unique_not_self['.$this->User_Model->_tableName.'.gh.id.'.$_POST['id'].'.status.正常]');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['enter_date'] = empty($_POST['enter_date']) ? time() : strtotime($_POST['enter_date']);
                $_POST['graduation_date'] = empty($_POST['graduation_date']) ? time() : strtotime($_POST['graduation_date']);
                $_POST['title_time'] = empty($_POST['title_time']) ? time() : strtotime($_POST['title_time']);
                
                $this->User_Model->update($_POST);
                
                $user = $this->User_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                
                $user['enter_date'] = date("Y-m-d",$user['enter_date']);
                $user['graduation_date'] = date("Y-m-d",$user['graduation_date']);
                $user['title_time'] = date("Y-m-d",$user['title_time']);
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                
                $user = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            
            $user = $this->User_Model->getById(array('where' => array('id' => $_GET['id'])));
            $user['enter_date'] = date("Y-m-d",$user['enter_date']);
            $user['graduation_date'] = date("Y-m-d",$user['graduation_date']);
            $user['title_time'] = date("Y-m-d",$user['title_time']);
        }
        
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('user',$user);
        $this->display('add');
    }
    
    private function _addRules(){
        
        $this->form_validation->set_rules('name', '姓名', 'required|min_length[1]|max_length[20]|htmlspecialchars');
        
        if(!empty($_POST['psw'])){
            $this->form_validation->set_rules('psw', '密码', 'required|min_length[6]|max_length[10]|matches[psw2]');
            $this->form_validation->set_rules('psw2', '密码确认', 'required|min_length[6]|max_length[10]');
        }

        if(!empty($_POST['id_card'])){
            //$this->form_validation->set_rules('id_card', '身份证号码', 'callback_id_check');
        }
        
        if(!empty($_POST['huji'])){
            $this->form_validation->set_rules('huji', '户籍所在地', 'max_length[30]');
        }
        
        if(!empty($_POST['email'])){
            $this->form_validation->set_rules('email', '邮箱', 'required|valid_email|max_length[40]');
        }
        
        if(!empty($_POST['graduation_date'])){
            $this->form_validation->set_rules('graduation_date', '毕业时间', 'required|valid_date[yyyy-mm-dd]');
        }

        if(!empty($_POST['job_title'])){
            $this->form_validation->set_rules('job_title', '职称名称', 'max_length[30]');
        }
        
        if(!empty($_POST['title_time'])){
            $this->form_validation->set_rules('title_time', '职称评定时间', 'required|valid_date[yyyy-mm-dd]');
        }
        
        $this->form_validation->set_rules('mobile', '手机号码', 'required|valid_mobile');
        $this->form_validation->set_rules('contract_year', '合同年限', 'required|is_natural_no_zero');
        
        
        $this->form_validation->set_rules('enter_date', '入院时间', 'required|valid_date[yyyy-mm-dd]');
        $this->form_validation->set_rules('dept_id', '归属部门', 'required|integer|greater_than[0]');
    }


    public function add()
	{
        $this->load->model('Dept_Model');
        $data = $this->Dept_Model->getDeptListByTree();
        $this->assign('deptList',$data);
        
        $this->load->model('Role_Model');
        $roleList = $this->Role_Model->getList(array('where' => array('status' => '正常','type' => 2)));
        
        $this->assign('roleList',$roleList['data']);
        
        if($this->isPostRequest()){
            $this->assign('user',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            
            $this->form_validation->set_rules('account', '账号', 'required|min_length[3]|max_length[15]|alpha_dash|is_unique_by_status['.$this->User_Model->_tableName.'.account.status.正常]');
            $this->form_validation->set_rules('gh', '工号', 'required|numeric|is_unique_by_status['.$this->User_Model->_tableName.'.gh.status.正常]' );
            
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['enter_date'] = empty($_POST['enter_date']) ? time() : strtotime($_POST['enter_date']);
                $_POST['graduation_date'] = empty($_POST['graduation_date']) ? time() : strtotime($_POST['graduation_date']);
                $_POST['title_time'] = empty($_POST['title_time']) ? time() : strtotime($_POST['title_time']);
                
                $userid = $this->User_Model->add($_POST);
                
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
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('user','index',array('name' => $_GET['name']))
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array(
                'id !=' => 1,
            );
            
            $condition['order'] = 'createtime ASC';
            
            if(!empty($_GET['gh'])){
                $condition['where']['gh'] = $_GET['gh'];
            }
            
            if(!empty($_GET['job_title'])){
                $condition['like']['job_title'] = $_GET['job_title'] ;
            }
            
            if(!empty($_GET['age_s'])){
                $condition['where']['age >='] = $_GET['age_s'];
            }
            
            if(!empty($_GET['age_e'])){
                $condition['where']['age <='] = $_GET['age_e'];
            }
            
            if($_GET['inc_del'] != '是'){
                $condition['where']['status'] = '正常';
            }
            
            $data = $this->User_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
