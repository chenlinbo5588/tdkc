<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Login extends TZ_Controller {
    public function __construct(){
	parent::__construct();
	
    }
    
    public function index()
    {
        /*
        $session = $this->session->all_userdata();
        
        if($session['profile']['remember-me']){
            $this->assign('remember_account',$session['profile']['account']);
        }
        */
        $this->setSEO('登录');
        $this->assign('cssFiles',array('bootstrap','login'));
        $this->display();
    }
    
    
    public function submit()
    {
        $loginSuccess = false;
        
        $this->load->model('User_Model','');
        $errorMsg = array();
        
        
        if(empty($_POST['username']) || empty($_POST['password'])){
            $errorMsg['message'] = "请输入账号和密码";
        }else{
            $user = $this->User_Model->getUserByAccount($_POST['username']);
            
            if($user && md5(config_item('encryption_key').$_POST['password']) == $user[0]['psw']){
                
                /*
                if($_POST['remember-me'] == 'remember-me'){
                    $user[0]['remember-me'] = true;
                }
                */
                
                $this->load->library('encrypt');
                $user[0]['psw'] = $this->encrypt->encode($user[0]['psw']);
                $profile['profile'] = $user[0];
                
                $this->session->set_userdata($profile);
                
                $loginSuccess = true;
            }else{
                $errorMsg['message'] = "账号或者密码错误";
            }
        }
        $this->assign('errorMsg',$errorMsg);
        
        if($loginSuccess){
            redirect(url_path('admin','index','',false));
        }else{
            $this->setSEO('登录');
            $this->assign('cssFiles',array('bootstrap','login'));
            $this->display();
        }
    }
    
}
