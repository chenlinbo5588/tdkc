<?php


class Menu_Model extends TZ_Model {
    
    public $_tableName = 'tb_menu';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function getAllMenu(){
        
        
    }
    
    /**
     * 获得用户
     */
    public function getUserByAccount($account){
        $sql = "SELECT * FROM ".$this->_tableName ." WHERE account = ?"; 
        $query = $this->db->query($sql, array($account));
        $row = $query->result_array();
        return $row;
    }
}