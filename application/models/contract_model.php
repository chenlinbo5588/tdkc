<?php


class Contract_Model extends TZ_Model {
    
    public $_tableName = 'tb_contract';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'title' => $param['title'],
            'sign_time' => $param['sign_time'],
            'amount' => $param['amount'],
            'linkman' => $param['linkman'],
            'is_comp' => $param['is_comp'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        if($data['file_id']){
            $data['file_id'] = $param['file_id'];
            $data['file_name'] = $param['file_name'];
        }
        
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
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'title' => $param['title'],
            'sign_time' => $param['sign_time'],
            'amount' => $param['amount'],
            'linkman' => $param['linkman'],
            'is_comp' => $param['is_comp'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        if($param['file_id']){
            $data['file_id'] = $param['file_id'];
            $data['file_name'] = $param['file_name'];
        }
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}