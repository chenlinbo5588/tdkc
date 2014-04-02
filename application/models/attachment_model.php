<?php


/**
 * 用户模型 
 */
class Attachment_Model extends TZ_Model {
    
    public $_tableName = 'tb_attachment';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($data){
        
        $string = $this->db->insert_string($this->_tableName, $data);
        $query = $this->db->query($string);
        
        if($this->db->affected_rows()){
            return $this->db->insert_id();
        }else{
            return false;
        }
    }
    
}