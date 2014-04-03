<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Logout extends TZ_Controller {
    public function __construct(){
	parent::__construct();
	
    }
    
    public function index()
    {
        $this->session->sess_destroy();
        redirect(url_path('login'));
    }
    
}
