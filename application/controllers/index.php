<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Index extends TZ_Admin_Controller {
    public function __construct(){
        parent::__construct();
    }
    
    public function index()
    {
        redirect(url_path('admin'));
        $this->display();
    }
    
}
