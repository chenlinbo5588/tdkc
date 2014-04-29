<?php


class Attachment_Model extends TZ_Model {
    
    public $_tableName = 'tb_attachment';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($data){
        
        $string = $this->db->insert_string($this->_tableName, $data);
        $query = $this->db->query($string);
        
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
        );
        
        if($param['is_dir']){
            $where['is_dir'] = $param['is_dir'];
        }
        
        $data = array(
            'status' => '1'
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'file_name' => $param['file_name'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}