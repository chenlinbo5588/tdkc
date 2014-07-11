<?php


class Taizhang_Model extends TZ_Model {
    
    public $_tableName = 'tb_taizhang';
    
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
            'nature' => $param['nature'],
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'address' => $param['address'],
            'pm' => $param['pm'],
            'descripton' => $param['descripton'],
            'total_area' => $param['total_area'],
            'churan_area' => $param['churan_area'],
            'fee_type' => $param['fee_type'],
            'has_doc' => $param['has_doc'],
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
            'master_serial' => $param['master_serial'],
            'region_serial' => $param['region_serial'],
            'name' => $param['name'],
            'nature' => $param['nature'],
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'address' => $param['address'],
            'descripton' => $param['descripton'],
            'pm' => $param['pm'],
            'descripton' => $param['descripton'],
            'total_area' => $param['total_area'],
            'churan_area' => $param['churan_area'],
            'fee_type' => $param['fee_type'],
            'has_doc' => $param['has_doc'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
}