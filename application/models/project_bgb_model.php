<?php


class Project_Bgb_Model extends TZ_Model {
    
    public $_tableName = 'tb_project_bgb';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'type' => $param['type'],
            'project_id' => $param['project_id'],
            'content' => !empty($param['bgb']) ? $param['bgb'] : '' ,
            'creator' => $param['creator'],
            'updator' => $param['creator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
    
}