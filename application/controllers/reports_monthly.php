<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 台账 项目统计报表
 */
class reports_monthly extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Taizhang_Model');
    }
    
    private function _report_monthly(){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $cd = array(
            'where' => array(
                'createtime >= ' => strtotime($_POST['sdate']),
                'createtime < ' => strtotime($_POST['edate']) + 86400
             ),
            'where_in' => array(
                array(
                    'key' => 'status','value' => array('已通过复审','已收费')
                )
            ),
            'order' => 'createtime ASC , category ASC , region_code ASC'
        );
        
        if($_POST['pm']){
            if(strpos($_POST['pm'],',') !== false){
                
                $pmlist = explode(',',$_POST['pm']);
                $pms = array();
                foreach($pmlist as $pm){
                    if(trim($pm) != ''){
                        $pms[] = $pm;
                    }
                }
                
                if($pms){
                    $cd['where_in'][] = array(
                        'key' => 'pm',
                        'value' => $pms
                    );
                }
            }else{
                $cd['where']['pm'] = $_POST['pm'];
            }
        }
        
        if($_POST['region_name']){
            $cd['where_in'][] = array(
                'key' => 'region_name',
                'value' => $_POST['region_name']
            );
        }
        
        $projectList = $this->Taizhang_Model->getList($cd);
        
        
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
        
        $objPHPExcel->setActiveSheetIndex(0);
        $objPHPExcel->getActiveSheet()->setCellValue('A1', $_POST['sdate'].'至'.$_POST['edate'].'项目统计');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:L1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '勘测流水号');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '项目名称');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '项目类型');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '项目主要完成人');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '质量等级');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '权重');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '缺陷扣分×处');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '项目个数');
        $objPHPExcel->getActiveSheet()->setCellValue('J2', '优秀率');
        $objPHPExcel->getActiveSheet()->setCellValue('K2', '总权重');
        $objPHPExcel->getActiveSheet()->setCellValue('L2', '质量之星');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(17);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(12);
        
        
        $workerProjectList = array();
        $workerList = array();
        
        foreach($projectList['data'] as $p){
            $workerProjectList[$p['pm']]['list'][] = $p;
            $workerList[] = $p['pm'];
        }
        
        $workerList = array_unique($workerList);
        
        $i = 0;
        $row_start = 3;
        
        $max_quality = 0;
        $star_worker = 0;
        $star_worker_row = 0;
        
        $counter = 0;
        
        foreach($workerList as $worker){
            $projectCount = count($workerProjectList[$worker]['list']);
            $current_start = $i + $row_start;
            $current_end = $current_start + $projectCount - 1;
            
            $levelRate = array(
                '优秀' => 0,
                '良好' => 0,
                '合格' => 0
            );
            $totalWeight = 0;
            
            foreach($workerProjectList[$worker]['list'] as $p){
                if($p['total_fault'] == 0){
                    $levelText = '优秀';
                }elseif($p['total_fault'] == 1){
                    $levelText = '良好';
                }else{
                    $levelText = '合格';
                }
                
                $levelRate[$levelText]++;
                $totalWeight += $p['weight'];
                
                $current_row = $i + $row_start;

                $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,$i + 1);
                $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['project_no']);
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['name']);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['ptype_name']);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['pm']);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $levelText);
                $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['weight']);
                $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, "{$p['fault_cnt1']}+{$p['fault_cnt2']}={$p['total_fault']}");
                $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, $projectCount);
                
                $i++;
            }
            
            $excellent_rate = $levelRate['优秀']/$projectCount;
            
            if($excellent_rate >  $max_quality){
                $max_quality = $excellent_rate;
                $star_worker = $worker;
                $star_worker_row = $current_start;
            }
            
            $objPHPExcel->getActiveSheet()->setCellValue('J'.$current_start, ($excellent_rate * 100).'%');
            $objPHPExcel->getActiveSheet()->setCellValue('K'.$current_start, $totalWeight);
            $objPHPExcel->getActiveSheet()->setCellValue('L'.$current_start, "");
            $objPHPExcel->getActiveSheet()->mergeCells('I'.$current_start.':I'.$current_end);
            $objPHPExcel->getActiveSheet()->mergeCells('J'.$current_start.':J'.$current_end);
            $objPHPExcel->getActiveSheet()->mergeCells('K'.$current_start.':K'.$current_end);
            $objPHPExcel->getActiveSheet()->mergeCells('L'.$current_start.':L'.$current_end);
         
            
            if($counter % 2 == 0){
                $fillColor = 'FFCCFFCC';
            
                $objPHPExcel->getActiveSheet()->getStyle('E'.$current_start.':E'.$current_end)->applyFromArray(
                        array(
                            'fill' => array(
                                'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                                'startcolor' => array(
                                    'argb' => $fillColor
                                ),
                                'endcolor'   => array(
                                    'argb' => $fillColor
                                )
                            )
                        )
                );
            }
            
            $counter++;
        }
        
        //质量之星设置
        $objPHPExcel->getActiveSheet()->setCellValue('L'.$star_worker_row, '质量之星★');
        $objPHPExcel->getActiveSheet()->getStyle('L'.$star_worker_row)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:L1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );

        $objPHPExcel->getActiveSheet()->getStyle('A2:L2')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 12
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:L'.(count($projectList['data']) + 2))->applyFromArray(
                array(
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
        
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'项目统计报表.xls');
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
        
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => date("Y") , 'name !=' => '其他'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        if($this->isPostRequest()){
            $this->form_validation->set_rules('sdate', '登记开始日期', 'required|valid_date');
            $this->form_validation->set_rules('edate', '登记结束日期', 'required|valid_date');
            
            if($this->form_validation->run()){
                $this->_report_monthly();
            }else{
                $this->display();
            }
        }else{
            $this->display();
        }
    }
    
    
}
