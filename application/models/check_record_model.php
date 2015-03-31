<?php


class Check_Record_Model extends TZ_Model {
    
    public $_tableName = 'tb_check_record';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'year' => $param['year'],
            'master_serial' => $param['master_serial'],
            'project_no' => $param['project_no'],
            'name' => $param['name'],
            'type' => implode('|',$param['type']),
            'method' => implode('|',$param['method']),
            'pm' => $param['pm'],
            'checkor' => $param['checkor'],
            'evaluate' => $param['evaluate'],
            'remark' => $param['remark'],
            'sendor_id' => $param['sendor_id'],
            'sendor' => $param['sendor'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        foreach(array('kzd','sbd','bc','jzd') as $v){
            
            $key1 = $v.'_jd';
            $key2 = $v.'_num';
            $key3 = $v.'_avg';
            $key4 = $v.'_overflow';
            
            $data[$key1] = $param[$key1];
            $data[$key2] = $param[$key2];
            $data[$key3] = $param[$key3];
            $data[$key4] = $param[$key4];
        }
        
        
        if(!empty($param['files'])){
            $data['files'] = $param['files'];
        }
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
    
    public function delete($param){
        $where = array(
            'id' => intval($param['id'])
        );
        
        $this->db->delete($this->_tableName,$where);
        return $this->db->affected_rows();
    }
    
    public function fake_delete($param){
        
        $where = array(
            'id' => intval($param['id'])
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
        $now = time();
        
        $data = array(
            'name' => $param['name'],
            'type' => implode('|',$param['type']),
            'method' => implode('|',$param['method']),
            'pm' => $param['pm'],
            'checkor' => $param['checkor'],
            'evaluate' => $param['evaluate'],
            'remark' => $param['remark'],
            'sendor_id' => $param['sendor_id'],
            'sendor' => $param['sendor'],
            'updator' => $param['updator'],
            'updatetime' => $now
        );
        
        foreach(array('kzd','sbd','bc','jzd') as $v){
            
            $key1 = $v.'_jd';
            $key2 = $v.'_num';
            $key3 = $v.'_avg';
            $key4 = $v.'_overflow';
            
            $data[$key1] = $param[$key1];
            $data[$key2] = $param[$key2];
            $data[$key3] = $param[$key3];
            $data[$key4] = $param[$key4];
        }
        
        if(!empty($param['files'])){
            $data['files'] = $param['files'];
        }else{
            $data['files'] = '';
        }
        
        $where = array_merge(array(
            'id' => $param['id']
        ),$whereExtra);
        
        $this->db->update($this->_tableName, $data,$where);
        
        return $this->db->affected_rows();
    }
    
}