<?php

/**
 *
 * 自定义 后台管理控制 控制器 
 */
class TZ_Admin_Controller extends TZ_Controller {
    
    public $_userProfile = null;
    public $_userMenu = array();
    public static $_userAuth = array();
    
    public function __construct(){
        parent::__construct();
        
        $session = $this->session->userdata['profile'];
        
        //file_put_contents("session.txt",print_r($session,true));
        if(!$session){
            redirect(url_path('login'),'javascript:top');
        }
        $this->load->model('User_Model');
        $this->load->model('User_Menu_Model');
        $this->load->model('Role_Menu_Model');
        
        $this->_init_user_menu($session);
        
        $this->_userProfile = $session;
        
        /*
        file_put_contents("1.txt",print_r(self::$_userAuth,true));
        
        echo config_item('controller_trigger').'='.$this->tplDir .'&'.config_item('function_trigger').'='.$this->tplName;
        echo "<br/>";
        echo md5('c=project&m=index');
        print_r(self::$_userAuth);
         * *
         */
        
       
        //file_put_conetnts("1.txt",md5(config_item('controller_trigger').'='.$this->tplDir .'&'.config_item('function_trigger').'='.$this->tplName),FILE_APPEND);
        
        if($this->_userProfile['id'] != 1 && !in_array(md5(config_item('controller_trigger').'='.$this->tplDir .'&'.config_item('function_trigger').'='.$this->tplName), self::$_userAuth)){
            if($this->isAjax){
                $this->sendFormatJson('error',array('id' => 0, 'text' => '您没有足够的访问权限，请联系管理员'));
            }else{
                $this->display('noprivilage','common');
            }
        }
        
        $this->_init_user_event($session);
        
        $this->assign('userProfile',$session);
    }
    
    private function _init_user_menu($session){
        
        
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
                self::$_userAuth[] = $value['auth_key'];
            }
        }
        
        if($roleMenu['data']){
            foreach($roleMenu['data'] as $value){
                self::$_userAuth[] = $value['auth_key'];
            }
        }
        
        self::$_userAuth = array_unique(self::$_userAuth );
        
    }
    
    
    private function _init_user_event($session){
        
        $this->load->model('User_Event_Model');
        
        
        $eventCount = $this->User_Event_Model->getCount(array(
           'where' => array(
               'user_id' => $session['id'],
               'isnew' => 1
           ) 
        ));
        
        $this->assign('eventCount',$eventCount);
        
    }
    
}