<?php


class User_Event_Model extends TZ_Model {
    
    public $_tableName = 'tb_user_event';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($user){
        
        $now = time();
        
        if(!$user['psw']){
            $user['psw'] = md5(config_item('encryption_key').'#123456!');
        }
        
        $data = array(
            'id' => NULL,
            'name' => $user['name'],
            'account' => $user['account'],
            'id_card' => $user['id_card'],
            'email' => $user['email'],
            'gh' => $user['gh'],
            'psw' => $user['psw'],
            'sex' => $user['sex'],
            'mobile' => $user['mobile'],
            'tel' => $user['tel'],
            'virtual_no' => $user['virtual_no'],
            'dept_id' => $user['dept_id'],
            'role_id' => $user['role_id'],
            'school_name' => $user['school_name'],
            'major' => $user['major'],
            'graduation_date' => $user['graduation_date'],
            'job_title' => $user['job_title'],
            'current_job' => $user['current_job'],
            'enter_date' => $user['enter_date'],
            'creator' => $user['creator'],
            'updator' => $user['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        return $this->db->insert($this->_tableName, $data);
        
    }
    
    /**
     * really delete
     * @param type $user 
     */
    public function delete($user){
        
    }
    
    public function fake_delete($user){
        
        $where = array(
            'id' => $user['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($user){
        $data = array(
            'name' => $user['name'],
            'account' => $user['account'],
            'id_card' => $user['id_card'],
            'email' => $user['email'],
            'gh' => $user['gh'],
            'sex' => $user['sex'],
            'mobile' => $user['mobile'],
            'tel' => $user['tel'],
            'virtual_no' => $user['virtual_no'],
            'dept_id' => $user['dept_id'],
            'role_id' => $user['role_id'],
            'school_name' => $user['school_name'],
            'major' => $user['major'],
            'graduation_date' => $user['graduation_date'],
            'job_title' => $user['job_title'],
            'current_job' => $user['current_job'],
            'enter_date' => $user['enter_date'],
            'updator' => $user['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $user['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}