<?php



class Shop_Model extends TZ_Model {
    
    public $_tableName = 'shop';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        
        $data = array(
            'shop_id' => NULL,
            'shop_name' => $param['shop_name'],
            'address' => $param['address'],
            'manager' => $param['manager'],
            'mobile' => $param['mobile'],
            'tel' => $param['tel'],
            'status' => $param['status'],
            'createtime' => $param['createtime'],
            'updatetime' => $param['updatetime'],
            'images' => json_encode(array())
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
            'shop_name' => $param['shop_name'],
            'address' => $param['address'],
            'manager' => $param['manager'],
            'mobile' => $param['mobile'],
            'tel' => $param['tel'],
            'updatetime' => $param['updatetime'],
            'images' => json_encode(array())
        );
        
        if(!empty($param['images'])){
            $data['images'] = json_encode($param['images']);
        }
        
        $where = "shop_id = " . $param['shop_id'];
        $string = $this->db->update_string($this->_tableName, $data,$where);
        $this->db->query($string);
        
        if($this->db->affected_rows()){
            return true;
        }else{
            return false;
        }
    }
}