<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Image extends TZ_Admin_Controller {
    public function __construct(){
	parent::__construct();
        $this->assign('sideMenuName','轮播图片管理');
    }
   
    public function index()
    {
        try {
            $this->load->model("News_Model");
            
            $data = $this->_getRowByName('home_page');
            
            ///print_r($data);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            
        }
        
        $this->setMainPage('image');
        $this->displayAdmin();
    }
    
    private function _getRowByName($name)
    {
        $this->load->model("Image_Model");
        $condition['where'] = array('name ' => $name );
        $row = $this->Image_Model->getList($condition);
        
        if(!empty($row[0])){
            $row[0]['images'] = json_decode($row[0]['images'],true);
            return $row[0];
        }else{
            return false;
        }
        
    }
    
    public function publish(){
        $code = 500;
        $body = array(
          'publish' => "failed"
        );
        
        try{
            $this->load->model("Image_Model");
            $where = array(
                'name' =>  $_POST['name']
            );
            
            $this->db->set('updatetime', date('Y-m-d H:i:s'));
            $this->db->set('online_images', 'images',false);
            
            $this->db->where($where);
            $this->db->update($this->Image_Model->_tableName);
            
            $code = 200;
            $body['publish'] = "success";
        }catch(Exception $e){
            $code = 500;
        }
        
        $this->sendFormatJson($code,$body);
        
    }
    
    public function deleteImg(){
        
        $code = 500;
        $body = array(
          'delete_status' => "failed"
        );
        
        try{
            $this->load->model("Image_Model");
            
            $condition['where'] = array('name ' => $_POST['name'] );
            
            $row = $this->Image_Model->getList($condition);
            
            if(!empty($row[0])){
                $row[0]['images'] = json_decode($row[0]['images'],true);
            }
            
            $deleteFiles = array();
            $path = realpath(dirname(APPPATH));
            
            foreach($row[0]['images'] as $k => $v){
                if($v['aid'] == $_POST['file_id']){
                    $deleteFiles[] = '/img/Files/'.$v['path'];
                    unset($row[0]['images'][$k]);
                }
            }
            $where = array(
                'name' =>  $_POST['name']
            );
            
            $data['images'] = json_encode($shop[0]['images']);
            
            $flag = $this->Image_Model->update($data);
            
            if($flag) {
                foreach($deleteFiles as $val){
                    @unlink($path.$val);
                }
            }
            
            $code = 200;
            $body['delete_status'] = "delete success";
        }catch(Exception $e){
            $code = 500;
        }
        
        $this->sendFormatJson($code,$body);
    }
    
    
    
    public function save(){
        
        $message = array();
        $message['feedback'] = '';
        $message['className'] = 'danger';
        
        try {
            $this->load->model('Image_Model');
            $this->load->model('Attachment_Model');
            
            if($_POST['file_id']){
                $condition['where'] = "aid IN (".implode(',',array_values($_POST['file_id'])) .')';
                $data = $this->Attachment_Model->getList($condition);
            }
            
            $_POST['images'] = array();
            if($data){
                foreach($data as $key => $val){
                    $_POST['images'][] = array(
                            'aid' => $val['aid'],
                            'path' => $val['path_name']
                        );
                }
            }
            
            $now = date("Y-m-d H:i:s");
            $_POST['updatetime'] = $now;
            
            if(!isset($_POST['name'])){
                $_POST['createtime'] = $now;
                
                $flag = $this->Image_Model->add($_POST);
                $action = "创建";
            }else{
                $action = "修改";
                $flag = $this->Image_Model->update($_POST);
            }
            
            if($flag){
                $message['feedback'] = $action.'成功';
                $message['className'] = 'success';
            }else{
                $message['feedback'] = $action.'失败,请重新尝试';
            }
            
        }catch(Exception $e){
            $message['feedback'] = '系统错误,请重新尝试('.$e->getCode().')';
        }
        
        $this->assign('data',$this->_getRowByName($_POST['name']));
        $this->assign('message',$message);
        $this->setMainPage('image');
        $this->displayAdmin();
    }
    
   
    
}
