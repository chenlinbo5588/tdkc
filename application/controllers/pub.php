<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Pub extends TZ_Controller {
    public function __construct(){
        parent::__construct();
        $this->load->model('News_Model');
        $this->load->model('Announce_Model');
    }
    
    
    public function index(){
        
        
    }
    
    /**
     * 新闻详情
     */
    public function detail(){
        
        $id = (int)gpc("id","GP",0);
        $info = $this->News_Model->queryById($id);
        
        if(!$info){
            die("信息找不到");
        }
        $this->assign('info',$info);
        $this->display();
    }
    
    /**
     * 公告详情 
     */
    public function andetail(){
        
        $id = (int)gpc("id","GP",0);
        $info = $this->Announce_Model->queryById($id);
        
        if(!$info){
            die("信息找不到");
        }
        $this->assign('info',$info);
        $this->display('detail');
    }
    
    
    public function anlist(){
        try {
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('pub','anlist')
            );
           
            $condition['where'] = array();
            $condition['where']['status'] = '正常';
            $condition['where']['type'] = 0;
            
            $data = $this->Announce_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
        $this->display();
        
    }
    
    public function newslist(){
        try {
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('pub','newslist')
            );
           
            $condition['where'] = array();
            $condition['where']['status'] = '正常';
            $condition['where']['is_publish'] = 1;
            
            $data = $this->News_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
        $this->display();
    }
    
    
    public function instlist(){
        try {
            
            $this->load->model('Inst_Model');
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('pub','instlist')
            );
           
            $condition['where'] = array();
            $condition['where']['status'] = '正常';
            
            $data = $this->Inst_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
        $this->display();
    }
}