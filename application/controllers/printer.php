<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Printer extends TZ_Controller {

    public function __construct(){
        parent::__construct();
        $this->load->model('Project_Model');
    }
    
    
	public function index()
	{
		die(0);
	}
    
    
    /**
     * 界址表
     */
    public function jzb(){
        
       $id = (int)gpc('id','GP',0);
       
       if(!$id){
           die('参数错误');
       }
       
        $this->load->model('Project_Jz_Model');
        $jzList = $this->Project_Jz_Model->getList(array(
            'where' => array(
                'project_id' => $id
            ),
            'order' => 'direction ASC'
        ));

        
        $info = $this->Project_Model->queryById($id);
        $totalPage = ceil(count($jzList['data'])/10); //总页数
        if($totalPage > 1){
            $pageAr = range(1,$totalPage);
        }else{
            $pageAr = array(1);
        }
        $this->assign('pageAr',$pageAr);
        $this->assign('jzAr',range(0,9));
        $this->assign('info',$info);
        
        $data = array();
       
        foreach($pageAr as $p){
            $data[$p] = array();
            for($i = 0; $i < 10; $i++){
                if(isset($jzList['data'][$i + ($p - 1) * 10])){
                    $data[$p][] = $jzList['data'][$i + ($p - 1) * 10];
                }
            }
        }
        
        if(count($data[$p]) < 10){
            $padTr = range(1 , 10 - count($data[$p]));
            $this->assign('padTr',$padTr);
        }
        $this->load->helper('number');
        $dateInfo['year'] = to_chinese_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = to_chinese_number(date("n",$info['createtime']),'O');
        $dateInfo['day'] = to_chinese_number(date("j",$info['createtime']),'O');
        $this->assign('dateInfo',$dateInfo);
        $this->assign('jzList',$data);
       
        $this->display();
    }
    
    /**
     * 土地面积分类表 
     */
    public function mjb(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        $this->assign('info',$info);
        
        $this->display();
    }
    
    public function check(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        $this->assign('info',$info);
        $this->display();
    }
    
    /**
     * 缺陷列表
     */
    public function fault(){
        
       $id = (int)gpc('id','GP',0);
       
       if(!$id){
           die('参数错误');
       }
       
       $this->display();
    }
    
}

/* End of file printer.php */
/* Location: ./application/controllers/printer.php */