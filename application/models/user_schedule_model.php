<?php


class User_Schedule_Model extends TZ_Model {
    
    public $_tableName = 'tb_user_schedule';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($schedule){
        $now = time();
        
        $data = array(
            'id' => NULL,
            'user_id' => $schedule['user_id'],
            'sdate' => $schedule['sdate'],
            'edate' => $schedule['edate'],
            'title' => $schedule['title'],
            'content' => $schedule['content'],
            'creator' => $schedule['creator'],
            'updator' => $schedule['updator'],
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
            'id' => $param['id'],
            'user_id' => $param['user_id']
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
            'sdate' => $schedule['sdate'],
            'edate' => $schedule['edate'],
            'content' => $schedule['content'],
            'updator' => $schedule['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $schedule['id'],
            'user_id' => $schedule['user_id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
}