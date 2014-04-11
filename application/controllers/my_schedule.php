<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_schedule extends TZ_Admin_Controller {

	
	public function index()
	{
        $prefs = array (
               'show_next_prev'  => TRUE,
               'next_prev_url'   => url_path('my_shedule'),
               'start_day'    => 'monday',
               'month_type'   => 'long',
               'day_type'     => 'long'
        );
        
        $this->load->library('calendar',$prefs);
        
        //$this->calendar->add();
        
        $data = array(
               3  => 'http://example.com/news/article/2006/03/',
               7  => 'http://example.com/news/article/2006/07/',
               13 => 'http://example.com/news/article/2006/13/',
               26 => 'http://example.com/news/article/2006/26/'
             );
        $calender = $this->calendar->generate(date("Y"),date("m"),$data);
        $this->assign('calender',$calender);
        $this->_getPageData();
		$this->display();
	}
    
    private function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $this->load->model('User_Event_Model');
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "createtime desc";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('my_event','index')
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array();
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']);
            }
            
            if(!empty($_GET['status'])){
                $condition['where']['status'] = $_GET['status'];
            }
            
            $data = $this->User_Event_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
}

