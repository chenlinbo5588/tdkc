<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_schedule extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Schedule_Model');
    }
    
    
	
	public function index()
	{
        
        /**
         * 获得日程数据 
         */
        $condition['order'] = "sdate ASC";
        
        if(!empty($_GET['title'])){
            $condition['like'] = array('title' => $_GET['title']);
        }

        $condition['where'] = array(
            'user_id' => $this->_userProfile['id'],
            'status' => '正常'
        );

        $genMonth = date("m");
        $genYear = date("Y");
        
        if(!empty($_GET['sdate']) && empty($_GET['edate'])){
            $condition['where']['sdate <='] = strtotime($_GET['sdate']);
        }
        
        if(empty($_GET['sdate']) && !empty($_GET['edate'])){
            $condition['where']['edate <='] = strtotime($_GET['edate']);
        }
        
        if(!empty($_GET['sdate']) && !empty($_GET['edate'])){
            $condition['where']['sdate <='] = strtotime($_GET['sdate']);
            $condition['where']['edate >='] = strtotime($_GET['edate']);
        }
        

        $data = $this->User_Schedule_Model->getList($condition);
        $prefs = array (
               'show_next_prev' => true,
               'next_prev_url'   => url_path('my_schedule'),
               'start_day'    => 'monday',
               'month_type'   => 'long',
               'day_type'     => 'long'
        );
        
        $this->load->library('calendar',$prefs);
        $this->load->helper('date');
        
        
        if(!empty($_GET['year'])){
            $genYear = $_GET['year'];
            $genMonth = $_GET['month'];
        }
        
        if($data['data']){
            foreach($data['data'] as $key => $value){
                $value['edit_url'] = url_path('my_schedule','edit','id='.$value['id']);
                $value['delete_url'] = url_path('my_schedule','delete','id='.$value['id']);
                
                $data['data'][$key] = $value;
            }
        }
       
        $calender = $this->calendar->generate($genYear,$genMonth,$data['data']);
        $this->assign('calender',$calender);
		$this->display();
	}
    
    
    private function _addRules(){
        $this->form_validation->set_rules('title', '标题', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('content', '内容', 'required|min_length[3]|htmlspecialchars');
        $this->form_validation->set_rules('sdate', '开始日期', 'required|valid_date[yyyy-mm-dd]');
        $this->form_validation->set_rules('edate', '结束日期', 'required|valid_date[yyyy-mm-dd]');
    }
    
    public function add()
	{
        
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                $_POST['sdate'] = empty($_POST['sdate']) ? time() : strtotime($_POST['sdate']);
                $_POST['edate'] = empty($_POST['edate']) ? time() : strtotime($_POST['edate']);
                
                $insertid = $this->User_Schedule_Model->add($_POST);
                
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
     * 修改日程 
     */
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '日程编号', 'required|is_natural_no_zero');
            
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                $_POST['sdate'] = strtotime($_POST['sdate']);
                $_POST['edate'] = strtotime($_POST['edate']);
                
                $this->User_Schedule_Model->update($_POST);
                $info = $this->User_Schedule_Model->getById(array('where' => array('id' => $_POST['id'],'user_id' => $this->_userProfile['id'])));
                
                
                $info['sdate'] = date("Y-m-d",$info['sdate'] );
                $info['edate'] = date("Y-m-d",$info['edate'] );
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            
            $info = $this->User_Schedule_Model->getById(array('where' => array('id' => $_GET['id'],'user_id' => $this->_userProfile['id'])));
            $info['sdate'] = date("Y-m-d",$info['sdate'] );
            $info['edate'] = date("Y-m-d",$info['edate'] );
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('add');
    }
    
    /**
     * 删除日程 
     */
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $_POST['user_id'] = $this->_userProfile['id'];
            
            $this->User_Schedule_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'),$_SERVER['HTTP_REFERER']);
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
}

