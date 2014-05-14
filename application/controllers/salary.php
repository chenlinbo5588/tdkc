<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Salary extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Model');
        $this->load->model('Salary_Type_Model');
        $this->load->model("User_Salary_Model");
    }
    
	public function index()
	{
        
        $this->_getPageData();
		$this->display();
	}
    
    
    /**
     * 
     */
    public function adjust(){
        $this->assign('action','adjust');
        
        $salaryTypeList = $this->Salary_Type_Model->getList(array(
           'where' => array(
               'status' => '正常'
           ),
           'order' => 'displayorder DESC'
        ));
        
        $userSalary = $this->User_Salary_Model->getList(array(
            'where' => array(
                'user_id' => $this->_userProfile['id'],
                'status' => 0
            )
        ));
        
        if($userSalary['data'][0]){
            $this->assign('userSalaryList',json_decode($userSalary['data'][0],true));
        }
        
        $this->assign('salaryTypeList',$salaryTypeList['data']);
        
        $this->_getUserSalaryHistory();
        
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->_addRules();
            if($this->form_validation->run()){
                /*
                $this->User_Model->update($_POST);
                $user = $this->User_Model->getById(array('where' => array('id' => $_POST['id'])));
                */
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                
                $user = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $user = $this->User_Model->getById(array('where' => array('id' => $_GET['id'])));
            $user['enter_date'] = date("Y-m-d",$user['enter_date']);
            $user['graduation_date'] = date("Y-m-d",$user['graduation_date']);
            $user['title_time'] = date("Y-m-d",$user['title_time']);
        }
        
        $this->assign('user',$user);
        $this->display();
    }
    
    
    private function _getUserSalaryHistory(){
        $userSalary = $this->User_Salary_Model->getList(array(
            'where' => array(
                'user_id' => $this->_userProfile['id']
            )
        ));
        
        $this->assign('userSalaryHistory',$userSalary['data']);
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('name', '姓名', 'required|min_length[1]|max_length[20]|htmlspecialchars');
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
                'status' => '正常',
                'id !=' => 1
            );
            
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
            
            
            $data = $this->User_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
