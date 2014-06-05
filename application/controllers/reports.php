<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 报表数据
 */
class reports extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        
    }
    
    public function index(){
        $this->display();
    }
    
    
}
