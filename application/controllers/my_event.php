<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_event extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('User_Event_Model');
    }
    
    
	public function index()
	{
        
        $this->_getPageData();
        
		$this->display();
	}
    
    private function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "createtime desc";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('my_event','index')
            );
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
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

