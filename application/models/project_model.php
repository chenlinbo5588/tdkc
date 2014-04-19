<?php


class Project_Model extends TZ_Model {
    
    public $_tableName = 'tb_project';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'project_type' => $param['project_type'],
            'year' => $param['year'],
            'month' => $param['month'],
            'region_code' => strtoupper($param['code']),
            'region_name' => $param['region_name'],
            'name' => $param['name'],
            'type' => $param['type'],
            'village' => $param['village'],
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'manager' => $param['manager'],
            'manager_mobile' => $param['manager_mobile'],
            'manager_tel' => $param['manager_tel'],
            'address' => $param['address'],
            'displayorder' => $param['displayorder'],
            'creator' => $param['creator'],
            'updator' => $param['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        return $this->db->insert($this->_tableName, $data);
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
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'project_type' => $param['project_type'],
            'year' => $param['year'],
            'month' => $param['month'],
            'region_code' => strtoupper($param['code']),
            'region_name' => $param['region_name'],
            'name' => $param['name'],
            'type' => $param['type'],
            'village' => $param['village'],
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'manager' => $param['manager'],
            'manager_mobile' => $param['manager_mobile'],
            'manager_tel' => $param['manager_tel'],
            'address' => $param['address'],
            'displayorder' => $param['displayorder'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
}