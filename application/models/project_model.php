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
            'project_no' => $param['project_no'],
            'year' => $param['year'],
            'month' => $param['month'],
            'region_code' => strtoupper($param['region_code']),
            'region_name' => $param['region_name'],
            'master_serial' => $param['master_serial'],
            'region_serial' => $param['region_serial'],
            'name' => $param['name'],
            'input_type' => $param['input_type'],
            'type_id' => $param['type_id'],
            'type' => $param['type'],
            'type_name' => $param['type_name'],
            'cate_name' => $param['cate_name'],
            'weight' => $param['weight'],
            'score' => $param['weight'],
            'nature' => $param['nature'],
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
            'has_doc' => $param['has_doc'],
            'displayorder' => $param['displayorder'],
            'pm_id' => $param['pm_id'],
            'pm' => $param['pm'],
            'sendor_id' => $param['sendor_id'],
            'sendor' => $param['sendor'],
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
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'region_code' => strtoupper($param['region_code']),
            'region_name' => $param['region_name'],
            'name' => $param['name'],
            'type_id' => $param['type_id'],
            'type' => $param['type'],
            'type_name' => $param['type_name'],
            'cate_name' => $param['cate_name'],
            'weight' => $param['weight'],
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
            'has_doc' => $param['has_doc'],
            'displayorder' => $param['displayorder'],
            'pm_id' => $param['pm_id'],
            'pm' => $param['pm'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        if($param['sendor']){
            $data['sendor'] = $param['sendor'];
            $data['sendor_id'] = $param['sendor_id'];
        }
        
        if($param['end_date']){
            $data['end_date'] = $param['end_date'];
        }
        
        if($param['pm_id']){
            $data['pm_id'] = $param['pm_id'];
        }
        if($param['pm']){
            $data['pm'] = $param['pm'];
        }
        
        
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
}