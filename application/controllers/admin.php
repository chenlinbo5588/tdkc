<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Admin extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
    }
   
    public function index()
    {
        $this->display();
    }
    
    public function change_password()
    {
        
        $this->display();
    }
    
    
    public function save_password()
    {
        $message = array();
        $message['feedback'] = '';
        $message['className'] = 'danger';
        
        try {
            
            while(1){
                $this->load->model('User_Model');

                if(strlen($_POST['new_psw']) < 6 || strlen($_POST['new_psw2']) < 6){
                    $message['feedback'] = '新密码长度必须大于6个字符';
                    break;
                }
                
                if($_POST['new_psw'] != $_POST['new_psw2']){
                    $message['feedback'] = '两次密码不一致';
                    break;
                }
                
                $session = $this->session->all_userdata();
                $query = $this->db->get($this->User_Model->_tableName,array(
                    'account' => $session['profile']['account']
                ));
                $user = $query->result_array();

                /**
                * 验证原密码 
                */
                if($user && md5(config_item('encryption_key').$_POST['old_psw']) == $user[0]['password']){
                   
                    /**
                     * 更新数据库 
                     */
                    $this->db->set('updatetime','now()',false);
                    $this->db->where(array(
                        'account' => $session['profile']['account']
                    ));
                    $this->db->set('password',md5(config_item('encryption_key').$_POST['new_psw']));
                    $this->db->update($this->User_Model->_tableName);
                    
                    /**
                     *  
                     */
                    $this->load->library('encrypt');
                    $user[0]['password'] = $_POST['new_psw'];
                    $user[0]['password'] = $this->encrypt->encode($user[0]['password']);
                    $profile['profile'] = $user[0];

                    $this->session->set_userdata($profile);
                    $message['feedback'] = '修改成功,3秒后自动退出,请重新登录';
                    $message['className'] = 'success';
                    $message['location'] = url_path('login','index',array(),true);
                    break;
                }else{
                    $message['feedback'] = "原密码错误";
                    break;
                }
            }
        }catch(Exception $e){
            $message['feedback'] = '系统错误,请重新尝试('.$e->getCode().')';
        }
        
        $this->assign('message',$message);
        $this->display('change_password');
        
    }
    
}
