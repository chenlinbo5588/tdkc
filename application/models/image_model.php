<?php



class Image_Model extends TZ_Model {
    
    public $_tableName = 'image';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        
        $data = array(
            'id' => NULL,
            'name' => $param['name'],
            'createtime' => $param['createtime'],
            'updatetime' => $param['updatetime'],
            'images' => json_encode(array()),
            'online_images' => json_encode(array())
        );
        
        if(!empty($param['images'])){
            $data['images'] = json_encode($param['images']);
        }
        
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
            'updatetime' => $param['updatetime'],
            'images' => json_encode(array())
        );
        
        if(!empty($param['images'])){
            $data['images'] = json_encode($param['images']);
        }
        
        if(!empty($param['online_images'])){
            $data['online_images'] = json_encode($param['online_images']);
        }
        
        $this->db->where('name', $param['name']);
        return $this->db->update($this->_tableName, $data);
        
        
        
    }
}