<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 测绘项目管理 
 */
class reports_fault extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Taizhang_Model');
        $this->load->model('Project_Fault_Model');
        $this->load->helper('number');
    }
    
    
    private function _getStepFaultList($param){
        
        $faults = array();
        
        // 0=初审 1=复审 2=质检
        foreach(array(0,1,2) as $value){
            $key = $value + 1;
            $faults[$value] = array();
            
            //先取出台账
            $temp = $this->Taizhang_Model->getList(array(
                'where' => array(
                    "fault_cnt{$key} >"  => 0 ,
                    'createtime >= ' => strtotime($param['sdate']),
                    'createtime < ' => strtotime($param['edate']) + 86400
                ),
                'where_in' => array(
                    array(
                        'key' => 'status','value' => array('已通过复审','已收费')
                    )
                )
            ));


            if($temp['data']){
                foreach($temp['data'] as $p){
                    $faults[$value][$p['id']] = $p;
                }
                
                // 取出台账 审核错误记录
                $f1  = $this->Project_Fault_Model->getList(array(
                    'where' => array(
                        'project_type' => 0,
                        'type' => $value,   //当前循环值
                        'status' => 0
                    ),
                    'where_in' => array(
                        array(
                            'key' => 'project_id', 'value' => array_keys($faults[$value]))
                        )
                    )
                );

                if($f1['data']){
                    foreach($f1['data'] as $v){
                        $faults[$value][$v['project_id']]['fault_list'][] = $v;
                    }
                }
                unset($f1);
            }
            
        }
        
        return $faults;
    }
    
    
    private function _report_faults(){
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $projectList = $this->_getStepFaultList($_POST);
        
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
        $objPHPExcel->getActiveSheet()->setCellValue('A1', $_POST['sdate'].'至'.$_POST['edate'].'质量缺陷扣分项目统计');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:K1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '检查时间');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '勘测流水号');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '项目名称');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '项目类型');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '项目负责人');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '缺陷签字人');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '质量扣分');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '缺陷扣分编号');
        $objPHPExcel->getActiveSheet()->setCellValue('J2', '缺陷内容记载');
        $objPHPExcel->getActiveSheet()->setCellValue('K2', '备注');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(13);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(22);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(30);
        $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(12);
        
        
        $i = 0;
        $j = 0;
        $row_start = 3;
        $jump = $row_start;

        foreach($projectList[0] as $p){
            $j = 0;
            
            $current_row_start = $jump;
            $current_row_end = $current_row_start + $p['fault_cnt1'] - 1;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump,$i + 1 );
            if($p['fault_cnt1'] != 0){
                foreach($p['fault_list'] as $fault){
                    $inner_current_row = $current_row_start + $j; 
                    $objPHPExcel->getActiveSheet()->setCellValue('B'.$inner_current_row,date("Y-m-d",$p['cs_time']));
                    $objPHPExcel->getActiveSheet()->setCellValue('C'.$inner_current_row, $p['project_no']);
                    $objPHPExcel->getActiveSheet()->setCellValue('D'.$inner_current_row, $p['name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('E'.$inner_current_row, $p['ptype_name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('F'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('G'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('H'.$inner_current_row, $fault['score']);
                    $objPHPExcel->getActiveSheet()->setCellValue('I'.$inner_current_row, $fault['fault_code']);
                    $objPHPExcel->getActiveSheet()->setCellValue('J'.$inner_current_row, $fault['remark']);
                    $objPHPExcel->getActiveSheet()->setCellValue('K'.$inner_current_row, '');
                    
                    $j++;
                }
                
                $objPHPExcel->getActiveSheet()->mergeCells('A'.$current_row_start.':A'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('B'.$current_row_start.':B'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('C'.$current_row_start.':C'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('D'.$current_row_start.':D'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('E'.$current_row_start.':E'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('F'.$current_row_start.':F'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('G'.$current_row_start.':G'.$current_row_end);
            }
            
            $jump += $p['fault_cnt1'];
            $i++;
        }
        
        //初审最后一行行号
        $chushen_row_end = $jump - 1 ;
        
        //复审
        foreach($projectList[1] as $p){
            $j = 0;
            $current_row_start = $jump;
            $current_row_end = $current_row_start + $p['fault_cnt2'] - 1;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump,$i + 1 );
            if($p['fault_cnt2'] != 0){
                foreach($p['fault_list'] as $fault){
                    $inner_current_row = $current_row_start + $j; 
                    $objPHPExcel->getActiveSheet()->setCellValue('B'.$inner_current_row,date("Y-m-d",$p['cs_time']));
                    $objPHPExcel->getActiveSheet()->setCellValue('C'.$inner_current_row, $p['project_no']);
                    $objPHPExcel->getActiveSheet()->setCellValue('D'.$inner_current_row, $p['name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('E'.$inner_current_row, $p['ptype_name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('F'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('G'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('H'.$inner_current_row, $fault['score']);
                    $objPHPExcel->getActiveSheet()->setCellValue('I'.$inner_current_row, $fault['fault_code']);
                    $objPHPExcel->getActiveSheet()->setCellValue('J'.$inner_current_row, $fault['remark']);
                    $objPHPExcel->getActiveSheet()->setCellValue('K'.$inner_current_row, '');
                    
                    $j++;
                }
                
                $objPHPExcel->getActiveSheet()->mergeCells('A'.$current_row_start.':A'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('B'.$current_row_start.':B'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('C'.$current_row_start.':C'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('D'.$current_row_start.':D'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('E'.$current_row_start.':E'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('F'.$current_row_start.':F'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('G'.$current_row_start.':G'.$current_row_end);
            }
            
            $jump += $p['fault_cnt2'];
            $i++;
        }
        
        //复审最后一行行号
        $fushen_row_end = $jump - 1;
        
        // 质检（重新审核勾选的错误)
        foreach($projectList[2] as $p){
            $j = 0;
            $current_row_start = $jump;
            $current_row_end = $current_row_start + $p['fault_cnt3'] - 1;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump,$i + 1 );
            if($p['fault_cnt3'] != 0){
                foreach($p['fault_list'] as $fault){
                    $inner_current_row = $current_row_start + $j; 
                    $objPHPExcel->getActiveSheet()->setCellValue('B'.$inner_current_row,date("Y-m-d",$p['cs_time']));
                    $objPHPExcel->getActiveSheet()->setCellValue('C'.$inner_current_row, $p['project_no']);
                    $objPHPExcel->getActiveSheet()->setCellValue('D'.$inner_current_row, $p['name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('E'.$inner_current_row, $p['ptype_name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('F'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('G'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('H'.$inner_current_row, $fault['score']);
                    $objPHPExcel->getActiveSheet()->setCellValue('I'.$inner_current_row, $fault['fault_code']);
                    $objPHPExcel->getActiveSheet()->setCellValue('J'.$inner_current_row, $fault['remark']);
                    $objPHPExcel->getActiveSheet()->setCellValue('K'.$inner_current_row, '');
                    
                    $j++;
                }
                
                $objPHPExcel->getActiveSheet()->mergeCells('A'.$current_row_start.':A'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('B'.$current_row_start.':B'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('C'.$current_row_start.':C'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('D'.$current_row_start.':D'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('E'.$current_row_start.':E'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('F'.$current_row_start.':F'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('G'.$current_row_start.':G'.$current_row_end);
            }
            
            $jump += $p['fault_cnt3'];
            $i++;
        }
        
        //最后一行行号
        $data_end_row = $jump - 1;
        
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:K1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );

        $objPHPExcel->getActiveSheet()->getStyle('A2:K2')->applyFromArray(
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
            
        if(count($projectList[0]) || count($projectList[1]) || count($projectList[2])){
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump,'合计');
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$jump,'');
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('H'.$jump, '=SUM(H3:H' .($jump - 1). ')');
            $objPHPExcel->getActiveSheet()->setCellValue('I'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('J'.$jump, '');
            $objPHPExcel->getActiveSheet()->setCellValue('K'.$jump, '');

            $objPHPExcel->getActiveSheet()->mergeCells('A'.$jump.':B'.$jump);

            $objPHPExcel->getActiveSheet()->setCellValue('K'.($chushen_row_end + 1), '按《测绘质量管理细则》第6条规定，复审检查出的错误加倍扣分到小组。');
            $objPHPExcel->getActiveSheet()->mergeCells('K'.($chushen_row_end + 1).':K'.$fushen_row_end);

            $jump++;

            $objPHPExcel->getActiveSheet()->setCellValue('D'.($jump + 1), '制表：总工办');
            $objPHPExcel->getActiveSheet()->setCellValue('J'.($jump + 1), '制表日期：'.date("Y-m-d"));

            $objPHPExcel->getActiveSheet()->setCellValue('B'.($jump + 2), '本次缺陷扣分采用修订后缺陷扣分标准。');

            $objPHPExcel->getActiveSheet()->setCellValue('J'.($jump + 4), '初审检查。');
            $objPHPExcel->getActiveSheet()->getStyle('I'.($jump + 4))->applyFromArray(
                    array(
                        'fill' => array(
                            'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                            'startcolor' => array(
                                'argb' => 'FFFFCC99'
                            ),
                            'endcolor'   => array(
                                'argb' => 'FFFFCC99'
                            )
                        )
                    )
            );

            $objPHPExcel->getActiveSheet()->setCellValue('J'.($jump + 5), '复审检查。');
            $objPHPExcel->getActiveSheet()->getStyle('I'.($jump + 5))->applyFromArray(
                    array(
                        'fill' => array(
                            'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                            'startcolor' => array(
                                'argb' => 'FF99CCFF'
                            ),
                            'endcolor'   => array(
                                'argb' => 'FF99CCFF'
                            )
                        )
                    )
            );
            
            //质检
            $objPHPExcel->getActiveSheet()->setCellValue('J'.($jump + 6), '质量检查。');
            $objPHPExcel->getActiveSheet()->getStyle('I'.($jump + 6))->applyFromArray(
                    array(
                        'fill' => array(
                            'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                            'startcolor' => array(
                                'argb' => 'FFF188AE'
                            ),
                            'endcolor'   => array(
                                'argb' => 'FFF188AE'
                            )
                        )
                    )
            );

            

            $objPHPExcel->getActiveSheet()->getStyle('A3:K'.$chushen_row_end)->applyFromArray(
                    array(
                        'fill' => array(
                            'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                            'startcolor' => array(
                                'argb' => 'FFFFCC99'
                            ),
                            'endcolor'   => array(
                                'argb' => 'FFFFCC99'
                            )
                        )
                    )
            );
            
            $objPHPExcel->getActiveSheet()->getStyle('A'.($chushen_row_end + 1) .':K'.$fushen_row_end)->applyFromArray(
                    array(
                        'fill' => array(
                            'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                            'startcolor' => array(
                                'argb' => 'FF99CCFF'
                            ),
                            'endcolor'   => array(
                                'argb' => 'FF99CCFF'
                            )
                        )
                    )
            );
            
            $objPHPExcel->getActiveSheet()->getStyle('A'.($fushen_row_end + 1) .':K'.$data_end_row)->applyFromArray(
                    array(
                        'fill' => array(
                            'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                            'startcolor' => array(
                                'argb' => 'FFF188AE'
                            ),
                            'endcolor'   => array(
                                'argb' => 'FFF188AE'
                            )
                        )
                    )
            );
            

            $objPHPExcel->getActiveSheet()->getStyle('A1:K'.($jump - 1))->applyFromArray(
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
        }else{
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump,'无数据');
            $objPHPExcel->getActiveSheet()->mergeCells('A'.$jump.':K'.$jump);
            
            $objPHPExcel->getActiveSheet()->getStyle('A1:K'.$jump)->applyFromArray(
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
        }
        
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        
        //$filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'质量缺陷扣分项目统计.xls');
        $filename = $_POST['sdate'].'至'.$_POST['edate'].'质量缺陷扣分项目统计.xls';
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
        if($this->isPostRequest()){
            $this->form_validation->set_rules('sdate', '登记开始日期', 'required|valid_date');
            $this->form_validation->set_rules('edate', '登记结束日期', 'required|valid_date');
            if($this->form_validation->run()){
                $this->_report_faults();
            }else{
                $this->display();
            }
        }else{
            $this->display();
        }
    }
    
    
}
