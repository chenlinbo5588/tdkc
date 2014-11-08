<?php


class Pm_Model extends TZ_Model {
    
    public $_tableName = 'tb_pm';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    /**
     * 添加一条消息
     * @param type $param
     * @return type 
     */
    public function addOnePm($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'user_id' => $param['to_user_id'],
            'receivor' => $param['to_user_name'],
            'driection' => 1,
            'isnew' => 1,
            'title' => $param['title'],
            'content' => $param['content'],
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data); 
        return $this->db->insert_id();
    }
    
    
    public function add($param){
        $now = time();
        
        $data = array();
        for($i = 0; $i < 2; $i++){
            $data[] = array(
                'id' => NULL,
                'user_id' => $i == 0 ? $param['user_id'] : $param['to_user_id'],
                'receivor' => $param['to_user_name'],
                'driection' => $i,
                'isnew' => $i,
                'title' => $param['title'],
                'content' => $param['content'],
                'creator' => $param['creator'],
                'updator' => $param['updator'],
                'createtime' => $now,
                'updatetime' => $now
            );
        }
        
       return $this->db->insert_batch($this->_tableName, $data); 
       
    }
    
    /**
     * really delete
     * @param type $user 
     */
    public function delete($param){
        
    }
    
    public function fake_delete($param){
        
        $where = array(
            'id' => $param['id'],
            'user_id' => $param['user_id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
    public function update($param){
        $data = array(
            'title' => $param['title'],
            'content' => $param['content'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id'],
            'user_id' => $param['user_id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
}