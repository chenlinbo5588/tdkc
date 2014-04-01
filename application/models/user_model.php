<?php


class User_Model extends TZ_Model {
    
    public $_tableName = 'user';
    
    public function __construct(){
        parent::__construct();
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