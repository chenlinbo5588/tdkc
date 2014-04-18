<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class project_ch extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Model');
    }
    
	public function index()
	{
        
        $this->_getPageData();
		$this->display();
	}
    
    
    public function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "createtime desc";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('user','index',array('name' => $_GET['name']))
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array();
            
            if(!empty($_GET['gh'])){
                $condition['where']['gh'] = $_GET['gh'];
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
