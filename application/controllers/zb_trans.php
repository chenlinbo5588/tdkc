<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Zb_Trans extends TZ_Controller {

    public function __construct(){
        parent::__construct();
        $this->load->model('Zb_Trans_Model');
    }
    
    
	public function index()
	{
        $this->Zb_Trans_Model->deleteByWhere(array(
            'createtime <' => time() - 86400  //删除1天前的数据
        ));
        
        $this->display();
	}
    
    
    public function updata()
    {
        $successCount = 0;
        $failedCount = 0;
        $batch_id = date("YmdHis");

        $totalLine = 0;
        
        if($_POST['orgdata']){
            $ar = explode("\n",$_POST['orgdata']);
            
            if(is_array($ar)){
                foreach($ar as $k => $line){
                    
                    if(trim($line) != ""){
                        $info = explode(',',$line);
                        $d = array(
                            'batch_id' => $batch_id,
                            'fid' => $info[0],
                            'dkbh' => $info[1],
                            'x' => $info[3],
                            'y' => $info[2],
                            'hash' => md5($info[3].$info[2]),
                            'mj' => $info[4]
                        );
                        if(strpos($line,'@') !== false){
                            $d['xmmc'] = substr($line,strpos($line,'@') + 1);
                        }else{
                            $d['xmmc'] = '';
                        }
                        
                        $d['xmmc'] = str_replace(array("\n","\r","\r\n"),"",$d['xmmc']);
                        
                        $this->Zb_Trans_Model->add($d);
                        
                        $totalLine++;
                    }
                }
                
                $query = $this->db->query("SELECT COUNT(*) AS NUM FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '{$batch_id}'");
                $rows = $query->result_array();
                
                $successCount = $rows[0]['NUM'];
                $failedCount = $totalLine - $successCount;
            }
        }
        
        $this->assign('rows',array('batch_id' => $batch_id, 'success' => $successCount , 'failed' => $failedCount));
        
        $this->display();
    }
    
    
    public function fx(){
        
        set_time_limit(0);
        $batch_id = empty($_GET['batch_id']) ? '' : $_GET['batch_id'];
        $point_pre = empty($_GET['point_pre']) ? 'J' : $_GET['point_pre'];
        $point_jd  = empty($_GET['point_jd']) ? '3' : $_GET['point_jd'];
        
        // 只能3 到 4 位小数点
        if(!in_array($point_jd,array('3','4'))){
            $point_jd = '3';
        }
        
        /**
         * 首先确定当前批次 有多少个地块
         */
        
        $query = $this->db->query("SELECT dkbh FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '{$batch_id}' GROUP BY dkbh ORDER BY dkbh ASC");
        $result = $query->result_array();
        
        $txt = array();
        $dks = array();
        
        if($result){
            foreach($result as $dk){
                $dks[] = $dk['dkbh'];
            }
            
            unset($result);
            $message = "共找到地块数量=".count($dks);
            
            foreach($dks as $dk ){
                /**
                 * 首先看是否有镂空 
                 */
                $sql = "SELECT COUNT(*) num, hash  FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} GROUP BY hash HAVING num >= 2 ORDER BY fid ASC ";
                $lkQuery = $this->db->query($sql);
                $lkResult = $lkQuery->result_array();
                
                $lkBlocks = array();
                foreach($lkResult as $lv ){
                    $lkBlocks[$lv['hash']] = $lv;
                }
                
                $lkHash = array_keys($lkBlocks);
                
                if(count($lkHash) >= 2){
                    //有镂空
                    $query = $this->db->query("SELECT COUNT(*) AS NUM FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} ORDER BY fid ASC ");
                    $dkPoints = $query->result_array();
                    
                    $dkQuery = $this->db->query("SELECT * FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} ORDER BY fid ASC LIMIT 1");
                    $dkInfo = $dkQuery->result_array();
                    
                    $djMj = sprintf("%.4f",$dkInfo[0]['mj'] / 10000);
                    
                    $txt[] = $dkPoints[0]['NUM'].",{$djMj},{$dkInfo[0]['xmmc']}{$dk},面,,土地整理项目,,@";
                    $dbLkBlocks = $this->Zb_Trans_Model->getList(array(
                        'where' => array(
                            'batch_id' => $batch_id,
                            'dkbh' => $dk
                        ),
                        'where_in' => array(
                            array(
                                'key' => 'hash' , 'value' => $lkHash
                            )
                        ),
                        'order' => 'fid ASC'
                    ));
                    
                    unset($dkPoints);
                    
                    $recordCounter = array();
                    
                    foreach($lkHash as $hk => $hv){
                        $fidSting = 'fid >= '.$dbLkBlocks['data'][$hk*2]['fid'] . ' AND  fid <= '.$dbLkBlocks['data'][$hk*2 + 1]['fid'];
                        $query = $this->db->query("SELECT * FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} AND  {$fidSting} ORDER BY  fid ASC ");
                        $tempPoints = $query->result_array();
                        //echo $fidSting."<br/>";
                        
                        $jump = 0;
                        $jNum = 0;
                        $inc = $hk;
                        $circleNo = $hk + 1;
                        while($inc  > -1 ){
                            $jump += $recordCounter[$inc];
                            $inc--;
                        }
                        //echo $jump .'<br/>';
                        
                        //减去闭合点,这样下一个圈 起始位置和 上一个圈结束位置 接上
                        $recordCounter[$hk] = count($tempPoints)  -1 ;
                        
                        if($hk == 0){
                            for($i = 0 ; $i < count($tempPoints); $i++){
                                $point = $tempPoints[$i];
                                
                                $point['y'] = sprintf("%.{$point_jd}f",$point['y']);
                                $point['x'] = sprintf("%.{$point_jd}f",$point['x']);
                                
                                $jNum = $i + 1;
                                if(($i + 1)  == count($tempPoints)){
                                   $txt[] = "{$point_pre}1,{$circleNo},{$point['y']},{$point['x']}";
                                   
                                }else{
                                    $txt[] = "{$point_pre}{$jNum},{$circleNo},{$point['y']},{$point['x']}";
                                }
                            }
                        }else{
                            for($i = 0 ; $i < count($tempPoints); $i++){
                                $point = $tempPoints[$i];
                                
                                $point['y'] = sprintf("%.{$point_jd}f",$point['y']);
                                $point['x'] = sprintf("%.{$point_jd}f",$point['x']);
                                
                                $jNum = $jump +  $i + 1  ;
                                if(($i + 1)  == count($tempPoints)){
                                    $txt[] = "{$point_pre}".($jump + 1).",{$circleNo},{$point['y']},{$point['x']}";
                                }else{
                                    $txt[] = "{$point_pre}{$jNum},{$circleNo},{$point['y']},{$point['x']}";
                                }
                            }
                        }
                    }
                    
                    //print_r($recordCounter);
                }else{
                    //没有镂空
                    $query = $this->db->query("SELECT * FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} ORDER BY fid ASC ");
                    $dkPoints = $query->result_array();
                    $dkMj = sprintf("%.4f",$dkPoints[0]['mj'] / 10000);
                    $txt[] = count($dkPoints).",{$dkMj},{$dkPoints[0]['xmmc']}{$dk},面,,土地整理项目,,@";
                    for($i = 0 ; $i < count($dkPoints); $i++){
                        $point = $dkPoints[$i];
                        
                        $point['y'] = sprintf("%.{$point_jd}f",$point['y']);
                        $point['x'] = sprintf("%.{$point_jd}f",$point['x']);
                        
                        
                        $jNum = $i + 1;
                        
                        if(($i + 1)  == count($dkPoints)){
                            $txt[] = "{$point_pre}1,1,{$point['y']},{$point['x']}";
                        }else{
                            $txt[] = "{$point_pre}{$jNum},1,{$point['y']},{$point['x']}";
                        }
                    }
                }
            }
            
        }else{
            $message = '没有找到地块';
        }
        
        $this->assign('txt',$txt);
        $this->assign('message',$message);
        $this->display();
        
    }
    
    
}

/* End of file printer.php */
/* Location: ./application/controllers/printer.php */