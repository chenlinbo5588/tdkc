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
        
        $data = array();
        
        if($condition['select']){
            $this->db->select($condition['select']);
        }
        
        if($condition['like']){
            $this->db->like($condition['like']);
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
        
        $data['data'] = $query->result_array();
        /**
         * 先获得数据 
         */
        if($condition['pager']){
            if($condition['where']){
                $this->db->where($condition['where']);
            }

            $config['total_rows'] = $this->db->count_all_results($this->_tableName);
            $pager = pageArrayGenerator($_GET['page'],$condition['pager']['page_size'],$config['total_rows'],$condition['pager']['query_param']);
            $data['pager'] = $pager;
        }
        return $data;

    }
}