<?php


class News_Model extends TZ_Model {
    
    public $_tableName = 'tb_news';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'title' => $param['title'],
            'content' => $param['content'],
            'creator' => $param['creator'],
            'updator' => $param['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
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
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
    public function update($schedule){
        $data = array(
            'title' => $schedule['title'],
            'content' => $schedule['content'],
            'updator' => $schedule['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $schedule['id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
}