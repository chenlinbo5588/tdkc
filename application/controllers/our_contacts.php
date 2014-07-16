<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Our_Contacts extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Model');
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
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('contacts','index')
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array(
                'id != ' => 1,
                'status' => '正常'
            );
            
            $condition['order'] = 'createtime ASC';
            
            if(!empty($_GET['mobile'])){
                $condition['like']['mobile'] = $_GET['mobile'];
            }
            
            if(!empty($_GET['tel'])){
                $condition['like']['tel'] = $_GET['tel'];
            }
            
            if(!empty($_GET['virtual_no'])){
                $condition['like']['virtual_no'] = $_GET['virtual_no'];
            }
            
            $data = $this->User_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}

