<?php


class Role_Menu_Model extends TZ_Model {
    
    public $_tableName = 'tb_role_menu';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($user){
        
        $now = time();
        $data = array(
            'role_id' => $param['id'],
            'auth_key' => $user['auth_key'],
            'creator' => $user['creator'],
            'updator' => $user['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        return $this->db->insert($this->_tableName, $data);
        
    }
    
    public function update(){
        
        
    }
    
    
    /**
     * really delete
     * @param type $user 
     */
    public function delete($condition = array()){
        
        if(!$condition['where']){
            return false;
        }
        
        $this->db->where($condition['where']);
        $this->db->delete($this->_tableName);
        
        return $this->db->affected_rows();
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
    
    
    
    
}