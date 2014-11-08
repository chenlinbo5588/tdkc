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
            'category' => $param['category'],
            'project_no' => $param['project_no'],
            'year' => $param['year'],
            'month' => $param['month'],
            'region_code' => strtoupper($param['region_code']),
            'region_name' => $param['region_name'],
            'master_serial' => $param['master_serial'],
            'region_serial' => $param['region_serial'],
            'ptype_id' => $param['ptype_id'],
            'ptype_name' => $param['ptype_name'],
            'pcate_name' => $param['pcate_name'],
            'weight' => $param['weight'],
            'name' => $param['name'],
            'nature' => isset($param['nature']) ? $param['nature'] : '',
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'address' => $param['address'],
            'pm' => $param['pm'],
            'descripton' => $param['descripton'],
            'total_area' => $param['total_area'],
            'churan_area' => $param['churan_area'],
            'sendor_id' => $param['sendor_id'],
            'sendor' => $param['sendor'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        if(!empty($param['files'])){
            $data['files'] = $param['files'];
        }
        
        if(!empty($param['complete_time'])){
            $data['complete_time'] = $param['complete_time'];
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
    
    
    public function update($param,$whereExtra = array()){
        $data = array(
            'region_code' => strtoupper($param['region_code']),
            'region_name' => $param['region_name'],
            'ptype_id' => $param['ptype_id'],
            'ptype_name' => $param['ptype_name'],
            'pcate_name' => $param['pcate_name'],
            'weight' => $param['weight'],
            'name' => $param['name'],
            'nature' => isset($param['nature']) ? $param['nature'] : '',
            'contacter' => $param['contacter'],
            'contacter_mobile' => $param['contacter_mobile'],
            'contacter_tel' => $param['contacter_tel'],
            'address' => $param['address'],
            'pm' => $param['pm'],
            'descripton' => $param['descripton'],
            'total_area' => isset($param['total_area']) ? $param['total_area'] : 0 ,
            'churan_area' => isset($param['churan_area']) ? $param['churan_area'] : 0,
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        if($param['project_no']){
            $data['project_no'] = $param['project_no'];
        }
        
        if(!empty($param['files'])){
            $data['files'] = $param['files'];
        }else{
            $data['files'] = '';
        }
        
         if(!empty($param['complete_time'])){
            $data['complete_time'] = $param['complete_time'];
        }
        
        $where = array_merge(array(
            'id' => $param['id']
        ),$whereExtra);
        
        $this->db->update($this->_tableName, $data,$where);
        
        return $this->db->affected_rows();
    }
    
}