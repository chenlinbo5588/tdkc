<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Printer extends TZ_Controller {

    public function __construct(){
        parent::__construct();
        $this->load->model('Taizhang_Model');
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

        
        $info = $this->Taizhang_Model->queryById($id);
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
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        $this->assign('dateInfo',$dateInfo);
        $this->assign('jzList',$data);
       
        $this->display();
    }
    
    /**
     * 勘测定界
     */
    public function kcdj(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $info = $this->Taizhang_Model->queryById($id);
        $this->assign('info',$info);
        $this->load->helper('number');
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        $this->assign('dateInfo',$dateInfo);
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
        
        $info = $this->Taizhang_Model->queryById($id);
        if($info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征'){
            $info['total_area'] = number_format($info['total_area'],0,".","");
            //$info['total_area'] = sprintf("%f",$info['total_area']);
        }else{
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        $this->assign('info',$info);
        
        $this->load->helper('number');
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        $this->assign('dateInfo',$dateInfo);
        
        
        $this->load->model('Project_Zddj_Model');
        $zddj = $this->Project_Zddj_Model->getList(array(
            'where' => array(
                'type' => 0,
                'project_id' => $info['id']
            ),
            'order' => 'createtime DESC',
            'limit' => 1
        ));

        if($zddj['data'][0]){
            $this->assign('zddj',$zddj['data'][0]);
        }
        
        $this->display();
    }
    
    
    /**
     * 违法用地勘测定界成果报告 
     */
    public function wfzddj(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $info = $this->Taizhang_Model->queryById($id);
        $this->assign('info',$info);
        $this->load->helper('number');
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        $this->assign('dateInfo',$dateInfo);
        $this->display();
    }
    
    
     /**
     * 界址表
     */
    public function fastjzb(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $type = $_GET['type'];
        
        
        $this->load->helper('number');
        $info = $this->Taizhang_Model->queryById($id);
        
        if(!$info){
            die('找不到记录');
        }
        
        $this->assign('info',$info);
 
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        
        $this->assign('dateInfo',$dateInfo);
        
        
        $this->load->model('Project_Jzb_Model');
        $jzb = $this->Project_Jzb_Model->getList(array(
            'where' => array(
                'type' => 0,
                'project_id' => $info['id']
            ),
            'order' => 'createtime DESC',
            'limit' => 1
        ));

        if($jzb['data'][0]){
            $this->assign('jzb',$jzb['data'][0]);
        }
        
        $this->display();
    }
    
    
    /**
     * 变更表
     */
    public function bgb(){
        $id = (int)gpc('id','GP',0);
       
        if(!$id){
            die('参数错误');
        }
        
        $type = $_GET['type'];
        
        
        $this->load->helper('number');
        $info = $this->Taizhang_Model->queryById($id);
        
        if(!$info){
            die('找不到记录');
        }
        
        $this->assign('info',$info);
 
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        
        $this->assign('dateInfo',$dateInfo);
        
        $this->load->model('Project_Bgb_Model');
        $bgb = $this->Project_Bgb_Model->getList(array(
            'where' => array(
                'type' => 0,
                'project_id' => $info['id']
            ),
            'order' => 'createtime DESC',
            'limit' => 1
        ));

        if($bgb['data'][0]){
            $this->assign('bgb',$bgb['data'][0]);
        }
        
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
        $info = $this->Taizhang_Model->queryById($id);
        
        if(!$info){
            die('找不到记录');
        }
        
        $info['project_no'] = $this->_makeClear($info['region_code'] ,$info['project_no'] );
        
        $this->assign('info',$info);
 
        $dateInfo['year'] = year_number(date("Y",$info['createtime']),'O');
        $dateInfo['month'] = month_day_number(date("n",$info['createtime']));
        $dateInfo['day'] = month_day_number(date("j",$info['createtime']));
        
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
        
        $info = $this->Taizhang_Model->queryById($id);
        
        
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
        
        $checkTitle = '';
        
        if(TAIZHANG_WF == $info['category']){
            $checkTitle = '违法用地';
        }else if(TAIZHANG_HOUSE == $info['category']){
            $checkTitle = '房产项目';
        }else{
            switch($info['nature']){
                case '新征预审':
                case '供地':
                case '供地预审':
                case '放线':
                case '竣工':
                    $checkTitle = $info['nature'];
                    break;
                default:
                    break;
            }
            
        }
        
        $this->assign('checkTitle',$checkTitle);
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
    
    /**
     * 处理 大写的 O 与 数字 0 相似的问题
     */
    private function _makeClear($regionCode , $projectNo){
        
        if(strtolower($regionCode) == 'o'){
            $nos = explode('-',$projectNo);
            $nos[0] = $nos[0] ? strtoupper($nos[0]) : '';
            $nos[1] = $nos[1] ? strtoupper($nos[1]) : '';
            
            if($nos[2]){
                $nos[2] = strtolower(substr($nos[2],0,1)) . substr($nos[2],1);
            }
            
            $projectNo = implode('-',$nos);
        }else{
            $projectNo = strtoupper($projectNo);
        }
        
        return $projectNo;
    }
    
    public function covertd(){
       $id = (int)gpc('id','GP',0);
       
       if(!$id){
           die('参数错误');
       }
       
       $info = $this->Taizhang_Model->queryById($id);
       if(!$info){
            die('找不到记录');
        }
        $this->load->helper('number');
        
        $dt = time();
        if($info['fs_time']){
            $dt = $info['fs_time'];
        }
        
        $info['project_no'] = $this->_makeClear($info['region_code'] ,$info['project_no'] );
        
        $changeDate = false;
        
        $this->load->model('Project_Area_Model');
        $mj = $this->Project_Area_Model->getList(array(
            'where' => array(
                'type' => 0,
                'project_id' => $info['id']
            ),
            'order' => 'createtime DESC',
            'limit' => 1
        ));

        //print_r($mj['data'][0]['content']);
        if(!empty($mj['data'][0]['content'])){
            $matchCount = preg_match("/<div\s*?class=\"center\s*?mjb_lk\"\>(.*?)<\/div\>/is",$mj['data'][0]['content'],$match);
            //print_r($match);
            if($matchCount > 0){
                $matchCount = 0;
                $matchCount = preg_match("/<span.*?>\s*(.*?)\s*?年\s*?(.*?)\s*?月\s*?(.*?)\s*?日/im",  $match[1],$match2);
                //print_r($match2);
                
                if($matchCount){
                    $dateInfo['year'] = $match2[1];
                    $dateInfo['month'] = $match2[2];
                    $dateInfo['day'] = $match2[3];
                    
                    $changeDate = true;
                }
            }
            
            
            $matchCount = 0;
            $matchCount = preg_match("/<thead>.*>单位名称<\/td>.*?>(.*?)<.*主送部门/is",$mj['data'][0]['content'],$match3);
            //print_r($match3);
            if($matchCount > 0){
                $info['name'] = strlen(trim($match3[1])) > 0 ? $match3[1] : $info['name'];
            }
            
            //性质参照面积表填写的为准
            $matchCount = 0;
            $matchCount = preg_match("/<span class=\"nature\">性质:(.*?)<\/span>/is",$mj['data'][0]['content'],$match4);
            //print_r($match4);
            $natureText = trim(strip_tags($match4[1]));
            if($matchCount > 0 && $natureText){
                $info['nature'] = $natureText;
            }
        }
        
        if(!$changeDate){
            $dateInfo['year'] = year_number(date("Y",$dt),'O');
            $dateInfo['month'] = month_day_number(date("n",$dt));
            $dateInfo['day'] = month_day_number(date("j",$dt));
        }
        
        $this->assign('dateInfo',$dateInfo);
        
       $this->assign('info', $info);
       
       $this->display();
       
    }
}

/* End of file printer.php */
/* Location: ./application/controllers/printer.php */