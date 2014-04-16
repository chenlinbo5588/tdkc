<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Share_File extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('File_Model');
    }
    
    
	public function index()
	{
        $pid = (int)gpc('pid','GP',0);
        $this->_getList($pid);
		$this->display();
	}
    
    public function _getList($pid = 0){
        
        $this->load->helper('url');
        $this->load->helper('number');
        
        if($pid){
            
            $currentFolder = $this->File_Model->getById(array(
                'select' => 'id,pid,status,in_share',
                'where' => array('id' => $pid,'status' => 0)
            ));
            //do update first
            if($currentFolder['in_share']){
                $this->db->query("UPDATE {$this->File_Model->_tableName} SET in_share = 1 WHERE pid = {$pid} AND in_share = 0 LIMIT 500");
            }else{
                // 可能被执行到， 基本不会被执行到这个逻辑
                $this->db->query("UPDATE {$this->File_Model->_tableName} SET in_share = 0 WHERE pid = {$pid} AND in_share = 1 LIMIT 500");
            }
        }
        
        $condition = array();
        //$condition['select'] = 'id,pid,file_name,status,is_dir,file_size,createtime';
        $condition['where'] = array(
            'pid' => $pid,
            'status' => 0,
            'in_share' => 1
        );
        
        
        $data = $this->File_Model->getList($condition);
        
        
        $sumCondition['field'] = 'file_size';
        $sumCondition['where'] = $condition['where'];
        
        $sizeInfo = $this->File_Model->sumByCondition($sumCondition);
        $parents = $this->File_Model->getParents($pid);
        $parents = array_reverse($parents);
        //print_r($parents);
        $this->assign('parents',$parents);
        $this->assign('sizeInfo',$sizeInfo[0]);
        $this->assign('pid',$pid);
        $this->assign('data',$data);
        
    }
    
    public function download(){
        $fid = (int)gpc('id','GP',0);
        $file = $this->File_Model->getById(array(
            'where' => array('id' => $fid),
            'in_share' => 1,
            'is_dir' => 0,
            'status' => 0
        ));
        
        if(!$file){
            redirect(url_path('share_file'),'javascript');
        }else{
            
            $this->load->helper('download');
            $file_realpath = config_item('filestore_dir').$file['file_store_path'].$file['file_md5'].$file['file_extension'];
            if(file_exists($file_realpath)){
                $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_downs = file_downs + 1 WHERE id = {$file['id']}");
                force_download($file['file_real_name'],  file_get_contents($file_realpath));
            }else{
                redirect(url_path('share_file'),'javascript');
            }
        }
    }
    
}

