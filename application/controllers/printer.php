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
     * 宗地勘测定界成果报告 
     */
    public function zddj(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        $this->assign('info',$info);
        
        
        
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
        
        $type = $_GET['type'];
        
        
        $this->load->helper('number');
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到记录');
        }
        
        $this->assign('info',$info);
 
        $dateInfo['year'] = to_chinese_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = to_chinese_number(date("n",$info['createtime']),'O');
        $dateInfo['day'] = to_chinese_number(date("j",$info['createtime']),'O');
        
        $this->assign('dateInfo',$dateInfo);
        
        $this->load->model('Land_Category_Model');
        $sysLandCategory = $this->Land_Category_Model->getList(array(
            'where' => array(
                'pid !=' => 0
            ),
            'order' => 'cate_id ASC ,code ASC' 
        ));
        
        $dlList = array();
        foreach($sysLandCategory['data'] as $v){
            $dlList[$v['cate_id']][] = $v;
        }
        
        $this->load->model('Project_Area_Model');
        $mj = $this->Project_Area_Model->getList(array(
            'where' => array(
                'type' => 0,
                'project_id' => $info['id']
            ),
            'order' => 'createtime DESC',
            'limit' => 1
        ));

        if($mj['data'][0]){
            $this->assign('mjb',$mj['data'][0]);
        }
        $this->assign('dlList',$dlList );
        $this->display();
    }
    
    public function check(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        
        $this->load->model('Project_Fault_Model');
        
        //初审错误
        $csFault = $this->Project_Fault_Model->getList(array(
            'where' => array(
                'project_type' => 0,
                'type' => 0,
                'project_id' => $info['id'],
                'status' => 0
            )
        ));
        //复审错误
        $fsFault = $this->Project_Fault_Model->getList(array(
            'where' => array(
                'project_type' => 0,
                'type' => 1,
                'project_id' => $info['id'],
                'status' => 0
            )
        ));
        
        $this->assign('csFault',$csFault['data']);
        $this->assign('fsFault',$fsFault['data']);
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