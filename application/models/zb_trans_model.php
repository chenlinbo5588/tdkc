<?php


class Zb_Trans_Model extends TZ_Model {
    
    public $_tableName = 'tb_zb_trans';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'batch_id' => $param['batch_id'],
            'fid' => $param['fid'],
            'dkbh' => $param['dkbh'],
            'x' => $param['x'] ,
            'y' => $param['y'] ,
            'hash' => $param['hash'],
            'mj' => $param['mj'],
            'xmmc' => $param['xmmc'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
    
}