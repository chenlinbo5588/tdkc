<?php


class Project_Type_Model extends TZ_Model {
    
    public $_tableName = 'tb_project_type';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'type' => $param['type'],
            'cate_name' => $param['cate_name'],
            'name' => $param['name'],
            'weight' => $param['weight'],
            'displayorder' => $param['displayorder'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
    
    public function delete($param){
        return $this->db->delete($this->_tableName,array('id' => $param['id']));
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
            'type' => $param['type'],
            'name' => $param['name'],
            'cate_name' => $param['cate_name'],
            'name' => $param['name'],
            'weight' => $param['weight'],
            'displayorder' => $param['displayorder'],
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