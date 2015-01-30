<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 产值报表
 */
class reports_chanzhi extends TZ_Admin_Controller {
    public $projectTypeList = null;
    
    private $_feeTypeName = array(
        0 => '未收费',
        1 => '挂账',
        2 => '票开款收',
        3 => '票开款未收',
        4 => '票未开款收',
        5 => '暂挂账'
    );
    
    public function __construct(){
        parent::__construct();
        
        $this->projectTypeList = getTaizhangList();
        $this->load->model('Region_Model');
        $this->load->model('Taizhang_Model');
        $this->load->model('Project_Nature_Model');
    }
    
    private function _writeDataHeader($objPHPExcel, $row = 1 , $feeName = ''){
        $objPHPExcel->getActiveSheet()->setCellValue('A'.$row, '编号');
        $objPHPExcel->getActiveSheet()->setCellValue('B'.$row, '台账类型');
        $objPHPExcel->getActiveSheet()->setCellValue('C'.$row, '项目类型');
        $objPHPExcel->getActiveSheet()->setCellValue('D'.$row, '宗地名称');
        $objPHPExcel->getActiveSheet()->setCellValue('E'.$row, '性质');
        $objPHPExcel->getActiveSheet()->setCellValue('F'.$row, '完成日期');
        $objPHPExcel->getActiveSheet()->setCellValue('G'.$row, '土地坐落');
        $objPHPExcel->getActiveSheet()->setCellValue('H'.$row, '面积');
        $objPHPExcel->getActiveSheet()->setCellValue('I'.$row, '领取时间');
        $objPHPExcel->getActiveSheet()->setCellValue('J'.$row, $feeName ? $feeName : '收费类型');
        $objPHPExcel->getActiveSheet()->setCellValue('K'.$row, '考核金额');
        $objPHPExcel->getActiveSheet()->setCellValue('L'.$row, '实收金额');
        $objPHPExcel->getActiveSheet()->setCellValue('M'.$row, '备注');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(20);
        
        
        $objPHPExcel->getActiveSheet()->getStyle('A'.$row .':M'.$row)->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 10
                    ),

                    'fill' => array(
                        'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                        'startcolor' => array(
                            'argb' => 'FFC0C0C0'
                        ),
                        'endcolor'   => array(
                            'argb' => 'FFC0C0C0'
                        )
                    )
                )
        );
    }
    
    
    private function _writeDetailBlock($objPHPExcel ,$feeName, $list , $row_start = 2){
        
        $i = 0;
        $subtotal_row = 1;
        $this->_writeDataHeader($objPHPExcel,$row_start , $feeName);
        $row_start++;
        
        if(!empty($list)){
            foreach($list as $p){
                $current_row = $i + $row_start;

                $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row, $p['project_no']);
                $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row, $p['category']);
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['ptype_name']);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['name']);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['nature']);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['complete_time']);
                $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['address']);
                $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, $p['total_area']);
                $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, $p['get_doctime']);
                $objPHPExcel->getActiveSheet()->setCellValue('J'.$current_row, $this->_feeTypeName[$p['fee_type']]);
                $objPHPExcel->getActiveSheet()->setCellValue('K'.$current_row, $p['kh_amount']);
                $objPHPExcel->getActiveSheet()->setCellValue('L'.$current_row, $p['ss_amount']);
                $objPHPExcel->getActiveSheet()->setCellValue('M'.$current_row, $p['remark']);

                if('已删除' == $p['status']){
                    $objPHPExcel->getActiveSheet()->getStyle('A'.$current_row.':M'.$current_row)->applyFromArray(
                            array(
                                'fill' => array(
                                    'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                                    'startcolor' => array(
                                        'argb' => 'FFFF0000'
                                    ),
                                    'endcolor'   => array(
                                        'argb' => 'FFFF0000'
                                    )
                                )
                            )
                    );
                }

                $i++;
            }
            
        }else{
            $current_row = $i + $row_start;
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row, '无数据');
            $objPHPExcel->getActiveSheet()->getStyle('A'.$current_row)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);;
            
            //$objPHPExcel->getActiveSheet()->mergeCells('A'.$current_row.':N'.$current_row);
        }
        
        $current_row++;
        
        $subtotal_row = $current_row;
        
        $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row, '小计');
        
        $objPHPExcel->getActiveSheet()->setCellValue('K'.$current_row, '=SUM(K'.$row_start.':K'.($current_row -1).')');
        $objPHPExcel->getActiveSheet()->setCellValue('L'.$current_row, '=SUM(L'.$row_start.':L'.($current_row -1).')');
        $objPHPExcel->getActiveSheet()->getStyle('K'.$current_row)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
        $objPHPExcel->getActiveSheet()->getStyle('L'.$current_row)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            
        $objPHPExcel->getActiveSheet()->getStyle('A'.($row_start - 1) .':M'.($row_start  +  (count($list) == 0 ? 1 : count($list)) ))->applyFromArray(
                array(
                    'font'    => array(
                        'size'     => 10
                    ),
                    'alignment' => array(
                        'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    ),
                    'borders' => array(
                        'allborders' => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN,
                            'color' => array('argb' => 'FF000000')
                        )
                    )
                )
        );
        
        return $subtotal_row;
    }
    
    
    private function _writeWorkSheet($objPHPExcel , $list){
        
        $feeTypeDataList = array(
            0 => array(),
            1 => array(),
            2 => array(),
            3 => array(),
            4 => array(),
            5 => array(),
        );
        
        
        foreach($list['data'] as $row){
            if(!isset($feeTypeDataList[$row['fee_type']])){
                $feeTypeDataList[$row['fee_type']] = array();
                $feeTypeDataList[$row['fee_type']][] = $row;
            }else{
                $feeTypeDataList[$row['fee_type']][] = $row;
            }
        }
        
        $jumper = array();
        $tempCount = 1;
        foreach($feeTypeDataList as $fk => $feeList){
            $jumper[$fk] = $tempCount;
            $tempCount += count($feeList) == 0 ?  4 : count($feeList) + 3;
        }
        
        $subtotal_rows = array();
        foreach($feeTypeDataList as $fk => $feeList){
            $subtotal_rows[] = $this->_writeDetailBlock($objPHPExcel , $this->_feeTypeName[$fk], $feeList , $jumper[$fk]);
        }
        
        if($subtotal_rows){
            
            $total_row = $subtotal_rows[count($subtotal_rows) - 1] + 2;
            
            $cells = array(
                'kh' => array(),
                'ss' => array()
            );
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$total_row, '合计');
            
            //=SUM(E3,F7)
            foreach($subtotal_rows as $subrow){
                $cells['kh'][] = "K{$subrow}";
                $cells['ss'][] = "L{$subrow}";
            }
            
            $objPHPExcel->getActiveSheet()->setCellValue('K'.$total_row, '=SUM('.implode(',',$cells['kh']).')');
            $objPHPExcel->getActiveSheet()->setCellValue('L'.$total_row, '=SUM('.implode(',',$cells['ss']).')');
            
            $objPHPExcel->getActiveSheet()->getStyle('K'.$total_row)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            $objPHPExcel->getActiveSheet()->getStyle('L'.$total_row)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
        }
    }
    
    
    private function _report(){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        //file_put_contents("debug.txt",print_r($_POST,true));
        
        $cd = array(
            'where' => array(
                'createtime >= ' => strtotime($_POST['sdate']),
                'createtime < ' => strtotime($_POST['edate']) + 86400
             ),
            'order' => 'fee_type ASC , createtime ASC'
        );
        
        $pmCondition = array(
            'select' => 'pm',
            'where' => $cd['where'],
            'group_by' => 'pm',
            'order' => 'pm ASC'
        );
        
        if($_POST['status']){
            $cd['where_in'][] = array('key' => 'status','value' => $_POST['status']);
        }else{
            $cd['where']['status'] = 'XXXX';
        }
        
        
        if($_POST['category']){
            //$cd['where']['category'] = $_POST['category'];
            $cd['where_in'][] = array('key' => 'category','value' => $_POST['category']);
        }else{
            $cd['where']['category'] = 'XXXX';
        }
        
        
        if($_POST['pm']){
            if(strpos($_POST['pm'],'，') !== false){
                $pmlist = explode('，',$_POST['pm']);
                $pms = array();
                foreach($pmlist as $pm){
                    if(trim($pm) != ''){
                        $pms[] = $pm;
                    }
                }
                
                if($pms){
                    $pmCondition['where_in'][] = array(
                        'key' => 'pm',
                        'value' => $pms
                    );
                }
            }else{
                $pmCondition['where']['pm'] = $_POST['pm'];
            }
        }
        
        
        if($_POST['nature']){
            if(strpos($_POST['nature'],'，') !== false){
                
                $naturelist = explode('，',$_POST['nature']);
                $natures = array();
                foreach($naturelist as $nature){
                    if(trim($nature) != ''){
                        $natures[] = $nature;
                    }
                }
                
                if($natures){
                    $cd['where_not_in'][] = array(
                        'key' => 'nature',
                        'value' => $natures
                    );
                }
            }else{
                $cd['where']['nature !='] = $_POST['nature'];
            }
        }
        
        if($_POST['region_name']){
            $cd['where_in'][] = array(
                'key' => 'region_name',
                'value' => $_POST['region_name']
            );
        }
        
        
        
        $cacheMethod = PHPExcel_CachedObjectStorageFactory::cache_to_discISAM; 
        $cacheSettings = array( 'dir'  => ROOT_DIR.'/temp' );
        PHPExcel_Settings::setLocale('zh_CN');
        PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);
        
        $objPHPExcel = new PHPExcel();
        
        /*
        $objPHPExcel->getProperties()->setCreator("OA")
							 ->setLastModifiedBy("OA")
							 ->setTitle("Office 2007 XLSX Test Document")
							 ->setSubject("Office 2007 XLSX Test Document")
							 ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
							 ->setKeywords("office 2007 openxml php")
							 ->setCategory("Test result file");
        */
        
        
    
        $pmLists = $this->Taizhang_Model->getList($pmCondition);
        
        if(!empty($pmLists['data'])){
            foreach($pmLists['data'] as $pmk => $current_pm){
                if($pmk > 0){
                    $myWorkSheet = new PHPExcel_Worksheet($objPHPExcel,$current_pm['pm']); 
                    $objPHPExcel->addSheet($myWorkSheet);
                    $objPHPExcel->setActiveSheetIndex($pmk);
                }else{
                    $objPHPExcel->setActiveSheetIndex($pmk);
                    $objPHPExcel->getActiveSheet()->setTitle($current_pm['pm']);
                }
                
                $cd['where']['pm'] = $current_pm['pm'];
                
                $tempList = $this->Taizhang_Model->getList($cd);
                $this->_writeWorkSheet($objPHPExcel,$tempList);
            }
        }
        
        $objPHPExcel->setActiveSheetIndex(0);
        
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'产值统计报表.xls');
        $objWriter->save(ROOT_DIR.'/temp/'.$filename);
        $objPHPExcel->disconnectWorksheets(); 
        unset($objPHPExcel,$objWriter); 
        force_download($filename,  file_get_contents(ROOT_DIR.'/temp/'.$filename));
        
    }
    
    /**
     * 导出 
     */
    public function index(){
        $this->load->helper('download');
        
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => date("Y")),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        $this->assign('projectTypeList',$this->projectTypeList);
        
        if($this->isPostRequest()){
            $this->form_validation->set_rules('sdate', '登记开始日期', 'required|valid_date');
            $this->form_validation->set_rules('edate', '登记结束日期', 'required|valid_date');
            
            if($this->form_validation->run()){
                $this->_report();
            }else{
                $this->display();
            }
        }else{
            $this->display();
        }
    }
    
    
}
