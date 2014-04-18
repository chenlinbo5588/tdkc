<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class project extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
    }
    
    /**
     * 默认测量项目 
     */
	public function index()
	{
		$this->display();
	}
    
    /**
     * 规划 
     */
    public function guihua(){
        
        $this->display();
        
    }
    
}
