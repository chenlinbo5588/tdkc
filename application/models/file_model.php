<?php


class File_Model extends TZ_Model {
    
    public $_tableName = 'tb_files';
    
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
    
    
    
    /**
     * really delete
     * @param type $user 
     */
    public function delete($param){
        
    }
    
    
    public function fake_delete_file($param){
        $where = array(
            'id' => $param['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        return $this->db->update($this->_tableName, $data, $where);
        
    }
    
    
    public function fake_delete($param){
        
        $where = array(
            'id' => $param['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'name' => $param['name'],
            
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $user['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}