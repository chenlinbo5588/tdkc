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
        /**
         * 获得消息数量 
         */
        $this->load->model('Pm_Model');
        $msgCount = $this->Pm_Model->getCount(array(
           'where' => array(
               'user_id' => $this->_userProfile['id'],
               'isnew' => 1
           )
        ));
        
        $this->load->model('Announce_Model');
        $notice = $this->Announce_Model->getList(array(
            'where' => array(
                'type' => 1
            ),
            'limit' => 1
        ));
        
        $this->assign('notice',$notice['data'][0]);
        $this->assign('messageCount',$msgCount);
        $this->display();
    }
    public function main(){
        $this->load->model('Inst_Model');
        $zhiduList = $this->Inst_Model->getList(array(
           'where' => array(
               'status' => '正常'
           ) 
        ));
        
        $this->assign('zhiduList',$zhiduList['data']);
        
        $this->load->model('News_Model');
        $newsList = $this->News_Model->getList(array(
           'where' => array(
               'is_publish' => 1,
               'status' => '正常'
           ),
           
          'limmit' => 10
        ));
        
        $this->assign('newsList',$newsList['data']);
        
        $this->load->model('Announce_Model');
        $announceList = $this->Announce_Model->getList(array(
           'where' => array(
               'type' => 0,
               'status' => '正常'
           ),
          'limmit' => 10
        ));
        
        $this->assign('announceList',$announceList['data']);
        
        $this->load->model('Pm_Model');
        $msgCount = $this->Pm_Model->getCount(array(
           'where' => array(
               'user_id' => $this->_userProfile['id'],
               'isnew' => 1
           )
        ));
        
        $this->assign('messageCount',$msgCount);
        
        $this->load->model('User_Event_Model');
        $eventCount = $this->User_Event_Model->getCount(array(
           'where' => array(
               'user_id' => $this->_userProfile['id'],
               'isnew' => 1
           )
        ));
        $this->assign('eventCount',$eventCount);
        
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
                
                $this->load->model('User_Model');
                $user = $this->User_Model->queryById($session['profile']['id']);
                /**
                * 验证原密码 
                */
                if($user && md5(config_item('encryption_key').$_POST['old_psw']) == $user['psw']){

                    /**
                    * 更新数据库 
                    */
                    $this->db->set('updatetime',time());
                    $this->db->where(array(
                        'id' => $user['id']
                    ));
                    $this->db->set('psw',md5(config_item('encryption_key').$_POST['new_psw']));
                    $this->db->update($this->User_Model->_tableName);

                    $this->load->library('encrypt');
                    unset($user['psw']);
                    
                    $profile['profile'] = $user;

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
