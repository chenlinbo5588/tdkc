<?php


class Device_Model extends TZ_Model {
    
    public $_tableName = 'tb_device';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'name' => $param['name'],
            'type' => $param['type'],
            'buy_time' => $param['buy_time'],
            'pay_amout' => $param['pay_amout'],
            'user' => $param['user'],
            'check_sdate' => $param['check_sdate'],
            'check_edate' => $param['check_edate'],
            'is_off' => $param['is_off'],
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
            'name' => $param['name'],
            'type' => $param['type'],
            'buy_time' => $param['buy_time'],
            'pay_amout' => $param['pay_amout'],
            'user' => $param['user'],
            'check_sdate' => $param['check_sdate'],
            'check_edate' => $param['check_edate'],
            'is_off' => $param['is_off'],
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