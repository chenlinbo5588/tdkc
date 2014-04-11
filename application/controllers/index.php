<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Index extends TZ_Admin_Controller {
    public function __construct(){
        parent::__construct();
        
        $this->assign('cssFiles',array('site'));
    }
    
    public function index()
    {
        /*
        try {
            $this->load->model("Image_Model");
            $condition['where'] = array('name ' => 'home_page');
            $row = $this->Image_Model->getList($condition);
            
            if(!empty($row[0])){
                $images = json_decode($row[0]['online_images'],true);
                
                if(!empty($images)){
                    $this->assign('data',$images);
                }
            }
            
        }catch(Exception $e){
            //
        }*/
        
        $this->assign('top_menu','首页');
        $this->display();
    }
    
}
