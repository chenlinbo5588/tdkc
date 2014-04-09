<?php


class User_Model extends TZ_Model {
    
    public $_tableName = 'tb_user';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    /**
     * 获得用户
     */
    public function getUserByAccount($account,$field = '*'){
        $sql = "SELECT {$field} FROM ".$this->_tableName ." WHERE account = ?"; 
        $query = $this->db->query($sql, array($account));
        $row = $query->result_array();
        return $row;
    }
    
    
    public function add($user){
        
        $now = time();
        
        if(!$user['psw']){
            $user['psw'] = md5(config_item('encryption_key').'#123456!');
        }
        
        $data = array(
            'user_id' => NULL,
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
            'user_id' => $user['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($user){
        $data = array(
            'name' => $user['name'],
            'id_card' => $user['id_card'],
            'email' => $user['email'],
            'sex' => $user['sex'],
            'mobile' => $user['mobile'],
            'tel' => $user['tel'],
            'virtual_no' => $user['virtual_no'],
            'dept_id' => $user['dept_id'],
            'school_name' => $user['school_name'],
            'major' => $user['major'],
            'graduation_date' => $user['graduation_date'],
            'job_title' => $user['job_title'],
            'current_job' => $user['current_job'],
            'enter_date' => $user['enter_date'],
            'updator' => $user['updator'],
            'updatetime' => time()
        );
        
        if(!$user['psw']){
            $data['psw'] = md5(config_item('encryption_key').$user['psw']);
        }
        
        $where = array(
            'user_id' => $user['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}