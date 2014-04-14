<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_File extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('File_Model');
    }
    
    
	public function index()
	{
        $this->load->helper('url');
        $pid = empty($_GET['pid']) ? 0 : intval($_GET['pid']);
        
        $condition = array();
        $condition['where'] = array(
            'pid' => $pid
        );
        
        $this->load->helper('number');
        
        $data = $this->File_Model->getList($condition);
        $this->assign('data',$data);
		$this->display();
	}
    
    public function addfolder(){
        
        if($this->isPostRequest() && !empty($_POST['folder_name'])){
            
            
        }
        
        $this->display();
    }
    
    
}

