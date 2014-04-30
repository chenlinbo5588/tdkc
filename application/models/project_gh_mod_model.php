<?php


class Project_Gh_Mod_Model extends TZ_Model {
    
    public $_tableName = 'tb_project_gh_mod';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'project_id' => $param['project_id'],
            'user_id' => $param['user_id'],
            'type' => $param['type'],
            'action' => $param['action'],
            'creator' => $param['creator'],
            'createtime' => $now,
            'content' => $param['content'],
            'user_data' => $param['user_data'],
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
}