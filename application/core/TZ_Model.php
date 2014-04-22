<?php


/**
 * 自定义Model  
 */

class TZ_Model extends CI_Model {
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function sumByCondition($condition){
        
        $this->db->select_sum($condition['field']);
        $this->db->where($condition['where']);
        $query =  $this->db->get($this->_tableName);
        
        $data = $query->result_array();
        return $data;
    }
    
    public function getCount($condition = array()){
        if($condition['where']){
            $this->db->where($condition['where']);
        }
        
        return $this->db->count_all_results($this->_tableName);
    }
    
    public function queryById($id,$key = 'id'){
        $query = $this->db->get_where($this->_tableName,array($key => $id));
        $data = $query->result_array();
        if($data[0]){
            return $data[0];
        }else{
            return false;
        }
    }
    
    public function getById($condition){
        if($condition['where']){
            
            if($condition['select']){
                $this->db->select($condition['select']);
            }
            
            $this->db->where($condition['where']);
            $query = $this->db->get($this->_tableName);
            $data = $query->result_array();
            
            if($data[0]){
                return $data[0];
            }
        }
        
        return false;
    }
    
    public function deleteByWhere($where){
        return $this->db->delete($this->_tableName,$where);
    }
    
    public function updateByWhere($data,$where){
        return $this->db->update($this->_tableName,$data,$where);
    }
    
    public function batchInsert($data){
        return $this->db->insert_batch($this->_tableName, $data); 
    }
    
    public function batchUpdate($data,$key = 'id'){
        return $this->db->update_batch($this->_tableName, $data,$key); 
    }
    
    public function getMaxByWhere($field,$where = array()){
        if($where){
            $this->db->where($where);
        }
        
        $this->db->select_max($field);
        $query = $this->db->get($this->_tableName);
        
        $data = $query->result_array();
        
        return $data[0][$field];
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
        
        if($condition['where_in']){
            foreach($condition['where_in'] as $val){
                $this->db->where_in($val['key'],$val['value']);
            }
        }
        
        if($condition['where_not_in']){
            foreach($condition['where_not_in'] as $val){
                $this->db->where_not_in($val['key'],$val['value']);
            }
        }
        
        if($condition['order']){
            $this->db->order_by($condition['order']);
        }else{
            $this->db->order_by("createtime DESC");
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
            if($condition['like']){
                $this->db->like($condition['like']);
            }
            
            $config['total_rows'] = $this->db->count_all_results($this->_tableName);
            $pager = pageArrayGenerator($_GET['page'],$condition['pager']['page_size'],$config['total_rows'],$condition['pager']['query_param']);
            $data['pager'] = $pager;
        }
        return $data;

    }
}