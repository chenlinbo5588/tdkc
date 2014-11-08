<?php


class Out_Model extends TZ_Model {
    
    public $_tableName = 'tb_out';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'send_time' => $param['send_time'],
            'title' => $param['title'],
            'file_code' => $param['file_code'],
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
            'send_time' => $param['send_time'],
            'title' => $param['title'],
            'file_code' => $param['file_code'],
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