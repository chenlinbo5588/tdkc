<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Shop extends TZ_Admin_Controller {
    public function __construct(){
	parent::__construct();
        $this->assign('sideMenuName','店铺管理');
    }
   
    public function index()
    {
        
        try {
            $this->load->model("Shop_Model");
            $config['total_rows'] = $this->Shop_Model->getCount();
            $config['per_page'] = 2;
            
            /*
            $this->load->library('pagination');
            $config = pagination_config('page');
            $config['base_url'] = url_path('shop','index',array(),true);
            $this->pagination->initialize($config); 
            $this->assign('pagination', $this->pagination->create_links());
             */
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            $pager = pageArrayGenerator($_GET['page'],$config['per_page'],$config['total_rows'],url_path('shop','index',array(),true));
            
            $this->assign('page',$pager);
            //$condition['select'] = 'a,b';
            $condition['pager'] = array(
                'page_size' => $config['per_page'],
                'current_page' => isset($_GET['page']) ? intval($_GET['page']) : 1
            );
            $data = $this->Shop_Model->getList($condition);
            foreach($data as $k => $v){
                $data[$k]['op'] = array(
                    'edit' => '<a href="'.url_path('shop','edit',array('id'=>$v['shop_id']),true).'">编辑</a>&nbsp;'
                );
                
                if($v['is_delete'] == '删除'){
                    $data[$k]['op']['delete'] = '<a href="'.url_path('shop','undelete',array('id'=>$v['shop_id']),true).'">恢复</a>&nbsp;';
                }else{
                    if($v['status'] == '已发布'){
                        $data[$k]['op']['publish'] = '<a href="'.url_path('shop','unpublish',array('id'=>$v['shop_id']),true).'">取消发布</a>&nbsp;';
                    }else{
                        $data[$k]['op']['publish'] = '<a href="'.url_path('shop','publish',array('id'=>$v['shop_id']),true).'">发布</a>&nbsp;';
                    }
                    
                    $data[$k]['op']['delete'] = '<a class="delete" href="javascript:void(0);" data-href="'.url_path('shop','delete',array('id'=>$v['shop_id']),true).'">删除</a>&nbsp;';
                }
            }
            
            $this->assign('list',$data);
        }catch(Exception $e){
            
        }
        
        $this->setMainPage('shop_list');
        $this->displayAdmin();
        
    }
    
    public function _setStatus($key,$value){
        
        $this->load->model("Shop_Model");
        $where = "shop_id = " . $_GET['id'];
        $data[$key] = $value;
        if($value == '删除'){
            $data['status'] = '未发布';//自动变成未发布
        }
        
        $data['updatetime'] = date("Y-m-d H:i:s");

        $string = $this->db->update_string($this->Shop_Model->_tableName, $data,$where);
        $this->db->query($string);
    }
    
    public function delete(){
        $this->_setStatus('is_delete','删除');
        redirect(url_path('shop','index'));
    }
    public function undelete(){
        $this->_setStatus('is_delete','正常');
        redirect(url_path('shop','index'));
    }
    
    public function unpublish(){
        $this->_setStatus('status','未发布');
        redirect(url_path('shop','index'));
    }
    
    public function publish(){
        $this->_setStatus('status','已发布');
        redirect(url_path('shop','index'));
    }
    
    
    public function deleteShopImg(){
        
        $code = 200;
        $body = array(
          'delete_status' => "failed"
        );
        
        try{
            $this->load->model("Shop_Model");
            
            $condition['where'] = array('shop_id ' => intval($_POST['id']) );
            
            $shop = $this->Shop_Model->getList($condition);
            
            if(!empty($shop[0])){
                $shop[0]['images'] = json_decode($shop[0]['images'],true);
            }
            
            foreach($shop[0]['images'] as $k => $v){
                if($v['aid'] == $_POST['file_id']){
                    @unlink(realpath(dirname(APPPATH)).'/img/Files/'.$v['path']);
                    unset($shop[0]['images'][$k]);
                }
            }
            $where = "shop_id = " . $_POST['id'];
            $data['images'] = json_encode($shop[0]['images']);
            
            $string = $this->db->update_string($this->Shop_Model->_tableName, $data,$where);
            $this->db->query($string);
            
            $code = 200;
            $body['delete_status'] = "delete success";
        }catch(Exception $e){
            $code = 500;
        }
        
        $this->sendFormatJson($code,$body);
    }
    
    
    public function add(){
        
        $this->assign('action','add');
        
        $this->setMainPage('shop_add');
        $this->displayAdmin();
    }
    
    
    public function _getShopInfo($shopId){
        
        try{
            $this->load->model("Shop_Model");
            
            $condition['where'] = array('shop_id ' => $shopId );
            
            $shop = $this->Shop_Model->getList($condition);
            
            if(!empty($shop[0])){
                $shop[0]['images'] = json_decode($shop[0]['images'],true);
            }
            
            //print_r($shop[0]);
            $this->assign("shopInfo",$shop[0]);
            
        }catch(Exception $e){
            //
        }
    }
    
    public function edit(){
        
        $this->_getShopInfo(intval($_GET['id']));
        
        $this->assign('action','edit');
        $this->setMainPage('shop_add');
        $this->displayAdmin();
    }
    
    public function save(){
        
        $message = array();
        $message['feedback'] = '';
        $message['className'] = 'danger';
        
        try {
            $this->load->model('Shop_Model');
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
            
            if(!isset($_POST['shop_id'])){
                $_POST['status'] = '新增';
                $_POST['createtime'] = $now;
                
                $flag = $this->Shop_Model->add($_POST);
                $action = "创建";
            }else{
                $action = "修改";
                $flag = $this->Shop_Model->update($_POST);
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
        
        if($action == '修改'){
            $this->assign('action','edit');
            $this->_getShopInfo(intval($_POST['shop_id']));
        }
        
        $this->assign('message',$message);
        $this->setMainPage('shop_add');
        $this->displayAdmin();
    }
    
}
