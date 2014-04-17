<?php


class Pm_Model extends TZ_Model {
    
    public $_tableName = 'tb_pm';
    
    public function __construct(){
        parent::__construct();
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
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($schedule){
        $data = array(
            'title' => $schedule['title'],
            'content' => $schedule['content'],
            'updator' => $schedule['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $schedule['id'],
            'user_id' => $schedule['user_id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}