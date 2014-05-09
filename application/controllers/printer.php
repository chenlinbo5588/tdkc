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
        $this->load->helper('number');
        $info = $this->Project_Model->queryById($id);
        $this->assign('info',$info);
        
        
        $dateInfo['year'] = to_chinese_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = to_chinese_number(date("n",$info['createtime']),'O');
        $dateInfo['day'] = to_chinese_number(date("j",$info['createtime']),'O');
        
        
        $this->assign('dateInfo',$dateInfo);
        
        
        /**
         * 计算有多少村 
         */
        
        /*
        $this->load->model('Project_Mj_Model');
        $mjList = $this->Project_Mj_Model->getList(array(
            'where' => array(
                'type' => 0,
                'project_id' => $info['id']
            )
        ));
        */
        /**
         * 首先计算 录入的面积地 类是否已经 超出了 默认表格的地类数量 ,
         * 如果超过 先查找 那个超过了
         * 如果那个土地大类超过了，则查看于自己属于同一个大类的，是否是空闲的,如果空闲者利用 将其替换掉
         * 如果与自己属于同一个大类的满了，再查看其他大类是否 有空闲，如果有则借一行，
         * 
         * 土地大类至少有一行
         */
        
        /*
        $dl = array();
        
        $tableDl = array(
        );
        
        
        
        if($mjList['data']){
            foreach($mjList['data'] as $v){
                $dl[] = $v['code2'];
            }
        }
        
        $dl = array_unique($dl);
        if(count($dl)){
            
        }
        */
        /*
        $this->load->model('Land_Category_Model');
        $sysLandCategory = $this->Land_Category_Model->getList(array(
            'where' => array(
                'pid' => 0
            ),
            'order' => 'cate_id ASC ,code ASC' 
        ));
        
        
        $this->assign('sysLandCategory',$sysLandCategory['data']);
         * 
         */
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