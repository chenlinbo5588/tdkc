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

        $field_sepchar = $_POST['field_sepchar'];

        if(!$field_sepchar){
            $field_sepchar = "\t";
        }
        
        $totalLine = 0;
        
        if($_POST['orgdata']){
            $ar = explode("\n",$_POST['orgdata']);
            if(is_array($ar)){
                foreach($ar as $k => $line){
                    if(trim($line) != ""){
                        $info = explode($field_sepchar,$line);
                        
                        $d = array(
                            'batch_id' => $batch_id
                        );
                        
                        $d['fid'] = empty($info[$_POST['field_fid']  - 1]) ? 0 : $info[$_POST['field_fid'] - 1] ;
                        $d['dkbh'] = empty($info[$_POST['field_dkbh'] - 1]) ? 0 : $info[$_POST['field_dkbh'] - 1] ;
                        $d['x'] = empty($info[$_POST['field_x'] - 1]) ? '' : $info[$_POST['field_x'] - 1] ;
                        $d['y'] = empty($info[$_POST['field_y'] - 1]) ? '' : $info[$_POST['field_y'] - 1] ;
                        $d['mj'] = empty($info[$_POST['field_mj'] - 1]) ? 0 : $info[$_POST['field_mj'] - 1] ;
                        
                        if($d['x'] && $d['y']){
                            $d['hash'] = md5($d['x'].$d['y']);
                        }else{
                            $d['hash'] = md5(uniqid());
                        }
                        
                        $d['xmmc'] = empty($info[$_POST['field_xmmc'] - 1]) ? '' : $info[$_POST['field_xmmc'] - 1] ;
                        if(substr($d['xmmc'],0,1) == '@'){
                            $d['xmmc'] = substr($d['xmmc'],1);
                        }
                        
                        $d['xmmc'] = str_replace(array("\n","\r","\r\n"),"",$d['xmmc']);
                        
                        //print_r($d);
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
        $x_pre = empty($_GET['x_pre']) ? '' : $_GET['x_pre'];
        $y_pre = empty($_GET['y_pre']) ? '' : $_GET['y_pre'];
        
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
            $warning = array();
            
            foreach($dks as $dk ){
                /**
                 * 首先看是否有镂空 
                 */
                $sql = "SELECT COUNT(*) num, hash  FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} GROUP BY hash HAVING num >= 2 ORDER BY fid ASC ";
                $lkQuery = $this->db->query($sql);
                $lkResult = $lkQuery->result_array();
                
                $lkBlocks = array();
                $lkAbnormalBlocks = array();
                
                foreach($lkResult as $lv ){
                    if(2 == $lv['num']){
                        //正常的闭合圈
                        $lkBlocks[$lv['hash']] = $lv;
                    }else{
                        //不正常 ， 一个重复出现2次以上 , 需要人工处理
                        $lkAbnormalBlocks[$lv['hash']] = $lv;
                    }
                }
                
                if($lkAbnormalBlocks){
                    $dbAbnormalPoints = $this->Zb_Trans_Model->getList(array(
                        'where' => array(
                            'batch_id' => $batch_id,
                            'dkbh' => $dk
                        ),
                        'where_in' => array(
                            array(
                                'key' => 'hash' , 'value' => array_keys($lkAbnormalBlocks)
                            )
                        ),
                        'order' => 'fid ASC'
                    ));
                    
                    foreach($dbAbnormalPoints['data'] as $abnormalPoint){
                        $warning[] = "异常提示:地块编号为{$dk} 坐标({$abnormalPoint['x']},{$abnormalPoint['y']}) 点号={$abnormalPoint['fid']} 出现 ".$lkAbnormalBlocks[$abnormalPoint['hash']]['num'] ."次重复， 请检查图形坐标 ，与该点号关联的输出已被忽略 ";
                    }
                }
                
                $lkHash = array_keys($lkBlocks);
                
                if(count($lkHash) >= 2){
                    //有镂空
                    $query = $this->db->query("SELECT COUNT(*) AS NUM FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} ORDER BY fid ASC ");
                    $dkPoints = $query->result_array();
                    
                    //取一条就足够数据标题行内容填充了
                    $dkQuery = $this->db->query("SELECT * FROM {$this->Zb_Trans_Model->_tableName} WHERE batch_id = '$batch_id' AND dkbh = {$dk} ORDER BY fid ASC LIMIT 1");
                    $dkInfo = $dkQuery->result_array();
                    
                    $djMj = sprintf("%.4f",$dkInfo[0]['mj'] / 10000);
                    
                    $txt[] = $dkPoints[0]['NUM'].",{$djMj},1,{$dkInfo[0]['xmmc']}{$dk},面,,土地整理项目,,@";
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
                                
                                $point['y'] = $y_pre . sprintf("%.{$point_jd}f",$point['y']);
                                $point['x'] = $x_pre . sprintf("%.{$point_jd}f",$point['x']);
                                
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
                                
                                $point['y'] = $y_pre . sprintf("%.{$point_jd}f",$point['y']);
                                $point['x'] = $x_pre . sprintf("%.{$point_jd}f",$point['x']);
                                
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
                    $txt[] = count($dkPoints).",{$dkMj},1,{$dkPoints[0]['xmmc']}{$dk},面,,土地整理项目,,@";
                    for($i = 0 ; $i < count($dkPoints); $i++){
                        $point = $dkPoints[$i];
                        
                        $point['y'] = $y_pre . sprintf("%.{$point_jd}f",$point['y']);
                        $point['x'] = $x_pre . sprintf("%.{$point_jd}f",$point['x']);
                        
                        
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
        $this->assign('warning',$warning);
        $this->assign('message',$message);
        $this->display();
        
    }
    
    
}

/* End of file printer.php */
/* Location: ./application/controllers/printer.php */