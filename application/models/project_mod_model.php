<?php


class Project_Mod_Model extends TZ_Model {
    
    public $_tableName = 'tb_project_mod';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'project_id' => $param['project_id'],
            'user_id' => $param['user_id'],
            'action' => $param['action'],
            'content' => $param['content'],
            'creator' => $param['creator'],
            'createtime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
}