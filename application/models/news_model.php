<?php



class News_Model extends TZ_Model {
    
    public $_tableName = 'news';
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($param){
        
        $data = array(
            'news_id' => NULL,
            'title' => $param['title'],
            'title' => $param['title2'],
            'cover_img' => $param['cover_img'],
            'content' => $param['content'],
            'status' => $param['status'],
            'createtime' => $param['createtime'],
            'updatetime' => $param['updatetime']
        );
        
        $string = $this->db->insert_string($this->_tableName, $data);
        $this->db->query($string);
        
        if($this->db->affected_rows()){
            return $this->db->insert_id();
        }else{
            return false;
        }
    }
    
    public function update($param){
        
        $data = array(
            'title' => $param['title'],
            'title2' => $param['title2'],
            'cover_img' => $param['cover_img'],
            'content' => $param['content'],
            'updatetime' => $param['updatetime']
        );
        
        $where = "news_id = " . $param['news_id'];
        $string = $this->db->update_string($this->_tableName, $data,$where);
        $this->db->query($string);
        
        if($this->db->affected_rows()){
            return true;
        }else{
            return false;
        }
    }
}