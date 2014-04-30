<?php

/**
 *
 * 自定义 后台管理控制 控制器 
 */
class TZ_Admin_Controller extends TZ_Controller {
    
    public $_userProfile = null;
    public $_userMenu = array();
    public $_userAuth = array();
    
    public function __construct(){
        parent::__construct();
        
        $session = $this->session->userdata['profile'];
        
        //file_put_contents("session.txt",print_r($session,true));
        if(!$session){
            redirect(url_path('login'),'javascript:top');
        }
        
        $this->load->model('User_Model');
        
        //$this->load->library('encrypt');
        
        //$user = $this->User_Model->getUserByAccount($session['account']);
        /*
        if($user[0]['psw'] != $this->encrypt->decode($session['psw'])){
            redirect(url_path('login'),'javascript:top');
        }
        */
        $this->load->model('User_Menu_Model');
        $this->load->model('Role_Menu_Model');
        
        $userMenu = $this->User_Menu_Model->getList(array(
            'field' => 'id,url,auth_key',
            'where' => array('user_id' => $session['id'],'status' => 0)
        ));
        
        
        $roleMenu = $this->Role_Menu_Model->getList(array(
            'field' => 'id,url,auth_key',
            'where_in' => array(
                array(
                    'key' => 'role_id',
                    'value' => array($session['role_id'],$session['share_role_id'])
                )
             )
        ));
        
        if($userMenu['data']){
            foreach($userMenu['data'] as $value){
                $this->_usermMenu[$value['id']] = $value;
                $this->_userAuth[] = $value['auth_key'];
            }
        }
        
        $this->_userProfile = $session;
        $this->assign('userProfile',$session);
    }
    
    
}