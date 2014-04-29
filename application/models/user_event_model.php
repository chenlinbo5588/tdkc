<?php


class User_Event_Model extends TZ_Model {
    
    public $_tableName = 'tb_user_event';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        
        $now = time();
        
        $data = array(
            'id' => NULL,
            'project_id' => $param['project_id'],
            'user_id' => $param['user_id'],
            'title' => $param['title'],
            'url' => $param['url'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
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
            'isnew' => $user['isnew'],
            'updator' => $user['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $user['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}