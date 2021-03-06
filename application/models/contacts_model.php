<?php


class Contacts_Model extends TZ_Model {
    
    public $_tableName = 'tb_contacts';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($info){
        $now = time();
        
        $data = array(
            'id' => NULL,
            'company_name' => $info['company_name'],
            'name' => $info['name'],
            'type' => $info['type'],
            'mobile' => $info['mobile'],
            'tel' => $info['tel'],
            'virtual_no' => $info['virtual_no'],
            'fax' => $info['fax'],
            'address' => $info['address'],
            'creator' => $info['creator'],
            'updator' => $info['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
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
            'id' => $param['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
    public function update($info){
        
        $data = array(
            'company_name' => $info['company_name'],
            'name' => $info['name'],
            'mobile' => $info['mobile'],
            'tel' => $info['tel'],
            'virtual_no' => $info['virtual_no'],
            'fax' => $info['fax'],
            'address' => $info['address'],
            'updator' => $info['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $info['id']
        );
        
        $this->db->update($this->_tableName, $data, $where);
        return $this->db->affected_rows();
    }
    
    
}