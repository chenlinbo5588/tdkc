<?php


class Consume_Model extends TZ_Model {
    
    public $_tableName = 'tb_consume';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'name' => $param['name'],
            'type' => $param['type'],
            'unit_name' => $param['unit_name'],
            'owner' => $param['owner'],
            'quantity' => $param['quantity'],
            'direction' => $param['direction'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
    
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
            'name' => $param['name'],
            'type' => $param['type'],
            'unit_name' => $param['unit_name'],
            'owner' => $param['owner'],
            'quantity' => $param['quantity'],
            'direction' => $param['direction'],
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