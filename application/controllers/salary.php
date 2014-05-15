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
        $user_id = gpc('user_id','GP',0);
        
        $salaryTypeList = $this->Salary_Type_Model->getList(array(
           'where' => array(
               'status' => '正常'
           ),
           'order' => 'createtime ASC , displayorder DESC'
        ));
        
        $this->assign('salaryTypeList',$salaryTypeList['data']);
        
        /**
         * 获得用户信息 
         */
        $user = $this->User_Model->queryById($user_id);
        $this->assign('user',$user);
        
        if($this->isPostRequest() && !empty($_POST['user_id'])){
            
            $gobackUrl = $_POST['gobackUrl'];
            
            $d = array();
            foreach($salaryTypeList['data'] as $type){
                if(isset($_POST['salary_'.$type['id']])){
                    $this->form_validation->set_rules('salary_'.$type['id'], $type['name'], 'required|is_numeric');
                }
                
                $d[$type['name']] = !empty($_POST['salary_'.$type['id']]) ? $_POST['salary_'.$type['id']]: 0;
            }
            
            if($this->form_validation->run()){
                
                $this->User_Salary_Model->updateByWhere(array(
                    'status' => 1,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => time()
                ),array(
                    'user_id' => $user_id,
                    'status' => 0
                ));
                
                $_POST['salary'] = json_encode($d);
                $_POST['creator'] = $this->_userProfile['name'];
                
                $this->User_Salary_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"调整成功");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"调整失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('userSalary',$this->_getCurrentSalary($user_id));
        $this->assign('user',$user);
        $this->assign('userSalaryHistory',$this->_getUserSalaryHistory($user_id));
        $this->display();
    }
    
    
    
    private function _getCurrentSalary($user_id){
        $userSalary = $this->User_Salary_Model->getList(array(
            'where' => array(
                'user_id' => $user_id,
                'status' => 0
            )
        ));
        
        if($userSalary['data'][0]){
            $userSalary['data'][0]['salary'] = json_decode($userSalary['data'][0]['salary'],true);
            
           return $userSalary['data'][0];
        }else{
            return false;
        }
        
    }
    
    private function _getUserSalaryHistory($user_id){
        $userSalary = $this->User_Salary_Model->getList(array(
            'where' => array(
                'user_id' => $user_id
            )
        ));
        
        $d = array();
        
        foreach($userSalary['data'] as $k =>  $v){
            $tmp = json_decode($v['salary'],true);
            $tmp2 = array();
            foreach($tmp as $tk => $tv){
               $tmp2[] = "<label class=\"salary_ht\"><span>{$tk}</span><strong>{$tv}</strong></label>";
            }
            $v['salary_text'] = implode('',$tmp2);
            $d[] = $v;
        }
        
        return $d;
        
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
