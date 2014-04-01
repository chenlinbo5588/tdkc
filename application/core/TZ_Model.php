<?php


/**
 * 自定义Model  
 */

class TZ_Model extends CI_Model {
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function getCount(){
        return $this->db->count_all_results($this->_tableName);
    }
    
    
    public function getList($condition = array()){
        
        if($condition['select']){
            $this->db->select($condition['select']);
        }else{
            $this->db->select('*');
        }
        
        if($condition['where']){
            $this->db->where($condition['where']);
        }
        
        if($condition['order']){
            $this->db->order_by($condition['order']);
        }else{
            $this->db->order_by("updatetime desc");
        }
        
        if($condition['pager']){
            $query = $this->db->get($this->_tableName,$condition['pager']['page_size'],($condition['pager']['current_page'] - 1) * $condition['pager']['page_size']);
        }else{
            $query = $this->db->get($this->_tableName);
        }
        
        return $query->result_array();

    }
}