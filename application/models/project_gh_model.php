<?php


class Project_Gh_Model extends TZ_Model {
    
    public $_tableName = 'tb_project_gh';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'year' => $param['year'],
            'month' => $param['month'],
            'region_code' => strtoupper($param['region_code']),
            'region_name' => $param['region_name'],
            'name' => $param['name'],
            'type_id' => $param['type_id'],
            'type' => $param['type'],
            'village' => $param['village'],
            'union_name' => $param['union_name'],
            'source' => $param['source'],
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'manager' => $param['manager'],
            'manager_mobile' => $param['manager_mobile'],
            'manager_tel' => $param['manager_tel'],
            'address' => $param['address'],
            'descripton' => $param['descripton'],
            'displayorder' => $param['displayorder'],
            'sendor_id' => $param['user_id'],
            'sendor' => $param['creator'],
            'user_id' => $param['user_id'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        if($param['start_date']){
            $data['start_date'] = $param['start_date'];
        }
        
        if($param['end_date']){
            $data['end_date'] = $param['end_date'];
        }
        
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
            'status' => '已删除',
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
    public function update($param){
        $data = array(
            'month' => $param['month'],
            'region_code' => strtoupper($param['region_code']),
            'region_name' => $param['region_name'],
            'name' => $param['name'],
            'type_id' => $param['type_id'],
            'type' => $param['type'],
            'village' => $param['village'],
            'union_name' => $param['union_name'],
            'source' => $param['source'],
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'manager' => $param['manager'],
            'manager_mobile' => $param['manager_mobile'],
            'manager_tel' => $param['manager_tel'],
            'address' => $param['address'],
            'descripton' => $param['descripton'],
            'displayorder' => $param['displayorder'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        if($param['end_date']){
            $data['end_date'] = $param['end_date'];
        }
        
        $where = array(
            'id' => $param['id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
}