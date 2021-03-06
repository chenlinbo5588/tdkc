<?php


class User_Salary_Model extends TZ_Model {
    
    public $_tableName = 'tb_user_salary';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($info){
        $now = time();
        
        $data = array(
            'id' => NULL,
            'user_id' => $info['user_id'],
            'salary' => $info['salary'],
            'reason' => $info['reason'],
            'creator' => $info['creator'],
            'updator' => $info['creator'],
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
    public function delete($param){
        
    }
    
    public function fake_delete($param){
        
        $where = array(
            'id' => $param['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
    public function update($info){
        
        $data = array(
            'name' => $info['name'],
            'address' => $info['address'],
            'updator' => $info['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $info['id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
}