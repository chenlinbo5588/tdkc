<?php


class In_Model extends TZ_Model {
    
    public $_tableName = 'tb_in';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'receive_time' => $param['receive_time'],
            'title' => $param['title'],
            'file_code' => $param['file_code'],
            'sendor' => $param['sendor'],
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
    
    
    public function update($param){
        $data = array(
            'receive_time' => $param['receive_time'],
            'title' => $param['title'],
            'file_code' => $param['file_code'],
            'sendor' => $param['sendor'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
}