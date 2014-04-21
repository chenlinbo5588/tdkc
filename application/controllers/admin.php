<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Admin extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
    }
   
    public function index()
    {
        $this->display();
    }
    
    /**
     * 这三个函数需要权限检查 
     */
    public function top(){
        
        $this->display();
    }
    public function main(){
        $this->display();
    }
    
    public function menu(){
        $this->display();
    }
    
    public function change_password()
    {
        if($this->isPostRequest()){
            $this->form_validation->set_rules('old_psw', '原密码', 'required|min_length[6]|max_length[10]');
            $this->form_validation->set_rules('new_psw', '新密码', 'required|min_length[6]|max_length[10]|matches[new_psw2]');
            $this->form_validation->set_rules('new_psw2', '新密码确认', 'required|min_length[6]|max_length[10]');
            
            if($this->form_validation->run()){
                $session = $this->session->all_userdata();
                $query = $this->db->get($this->User_Model->_tableName,array(
                    'account' => $session['profile']['account']
                ));
                $user = $query->result_array();

                /**
                * 验证原密码 
                */
                if($user && md5(config_item('encryption_key').$_POST['old_psw']) == $user[0]['psw']){

                    /**
                    * 更新数据库 
                    */
                    $this->db->set('updatetime','now()',false);
                    $this->db->where(array(
                        'account' => $session['profile']['account']
                    ));
                    $this->db->set('psw',md5(config_item('encryption_key').$_POST['new_psw']));
                    $this->db->update($this->User_Model->_tableName);

                    $this->load->library('encrypt');
                    $user[0]['psw'] = $_POST['new_psw'];
                    $user[0]['psw'] = $this->encrypt->encode($user[0]['psw']);
                    $profile['profile'] = $user[0];

                    $this->session->set_userdata($profile);
                    $this->assign("feedback", "success");
                    $this->assign('feedMessage',"修改成功");
                }else{
                    $this->assign("feedback", "failed");
                    $this->assign('feedMessage',"原密码错误");
                }
            }else{
                $this->assign("feedback", "failed");
            }
        }
        
        $this->display();
    }
}
