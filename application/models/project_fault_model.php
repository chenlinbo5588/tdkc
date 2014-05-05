<?php


class Project_Fault_Model extends TZ_Model {
    
    public $_tableName = 'tb_project_fault';
    
    public function __construct(){
        parent::__construct();
    }
    
    /*
    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'type' => $param['type'],
            'project_id' => $param['project_id'],
            'fault_code' => $param['fault_code'],
            'fault_name' => $param['fault_name'],
            'remark' => $param['remark'],
            'score' => $param['score'],
            'content' => $param['content'],
            'creator' => $param['creator'],
            'updator' => $param['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
     * 
     */
    
}