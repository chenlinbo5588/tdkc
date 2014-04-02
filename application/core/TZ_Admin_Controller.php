<?php

/**
 *
 * 自定义 后台管理控制 控制器 
 */
class TZ_Admin_Controller extends TZ_Controller {
    
    public $_userProfile = null;
    public $_userMenu = array();
    
    public function __construct(){
        parent::__construct();
        
        /*
         * 登录检查
         */
        
        //检查用户和密码
        $session = $this->session->userdata['profile'];
        if(!$session){
            redirect(url_path('login'));
        }
        
        $this->load->model('User_Model','');
        $this->load->library('encrypt');
        
        $user = $this->User_Model->getUserByAccount($session['account']);
        
        if($user[0]['psw'] != $this->encrypt->decode($session['psw'])){
            redirect(url_path('login'));
        }
        
        $this->_userProfile = $session;
        $this->assign('userProfile',$session);
    }
    
}