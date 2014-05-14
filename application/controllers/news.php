<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class News extends TZ_Controller {
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
}