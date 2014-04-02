<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Logout extends TZ_Controller {
    public function __construct(){
	parent::__construct();
	
    }
    
    public function index()
    {
        $this->session->sess_destroy();
        
        $this->setSEO('登录');
        $this->assign('cssFiles',array('bootstrap.min','login'));
        $this->display('index','login');
    }
    
}
