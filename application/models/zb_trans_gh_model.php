<?php


class Zb_Trans_Gh_Model extends TZ_Model {
    
    public $_tableName = 'tb_zb_trans_gh';
    
    public function __construct(){
        parent::__construct();
    }
    
    public function add($param){
        $now = time();
        $data = array(
            'batch_id' => $param['batch_id'],
            'fid' => $param['fid'],
            'region_code' => $param['region_code'],
            'viliage' => $param['viliage'],
            'purpose_code' => $param['purpose_code'],
            'xmmc' => $param['xmmc'],
            'mj' => $param['mj'],
            'dkbh' => $param['dkbh'],
            'x' => $param['x'] ,
            'y' => $param['y'] ,
            'hash' => $param['hash'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        $this->db->insert($this->_tableName, $data);
        return $this->db->insert_id();
    }
    
}