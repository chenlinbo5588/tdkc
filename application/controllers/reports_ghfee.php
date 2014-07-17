<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class reports_ghfee extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Project_Gh_Model');
        $this->load->model('Gh_Fee_Model');
        $this->load->helper('number');
    }
    
    private function _report_fee(){
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $projects = array();
        $projectIds = array();
        //项目列表
        $projectList = $this->Project_Gh_Model->getList(array(
            'where' => array(
                'createtime >= ' => strtotime($_POST['sdate']),
                'createtime < ' => strtotime($_POST['edate']) + 86400
             ),
            'where_in' => array(
                array(
                    'key' => 'status','value' => array('已收费','已归档')
                )
            ),
            'order' => 'createtime ASC ,name ASC'
        ));
        
        if($projectList['data']){
            foreach($projectList['data'] as $key => $v){
                $projects[$v['id']] = $v;
                $projectIds[] = $v['id'];
            }
        }
        
        if($projectIds){
            $feeList = $this->Gh_Fee_Model->getList(array(
                'where_in' => array(
                    array(
                        'key' => 'project_id','value' => $projectIds
                    )
                ),
                'order' => 'project_id ASC , createtime ASC'
            ));
        }
        
        if($feeList['data']){
            foreach($feeList['data'] as $v){
                $projects[$v['project_id']]['fee_list'][] = $v;
            }
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
        
        $objPHPExcel->setActiveSheetIndex(0);
        $objPHPExcel->getActiveSheet()->setCellValue('A1', $_POST['sdate'].'至'.$_POST['edate'].'规划项目费用报表');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:M1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '时间');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '负责人');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '联系单位');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '联系人');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '电话');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '项目名称、内容及要求');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '规格');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '数量');
        $objPHPExcel->getActiveSheet()->setCellValue('J2', '单价');
        $objPHPExcel->getActiveSheet()->setCellValue('K2', '制作费');
        $objPHPExcel->getActiveSheet()->setCellValue('L2', '小计');
        $objPHPExcel->getActiveSheet()->setCellValue('M2', '费用备注');
        $objPHPExcel->getActiveSheet()->setCellValue('N2', '备注');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(13);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('N')->setWidth(15);
        
        $i = 0;
        $j = 0;
        $row_start = 3;
        $jump = $row_start;
        
        foreach($projects as $p){
            $j = 0;
            $current_row_start = $jump;
            $current_row_end = $current_row_start + count($p['fee_list']) - 1;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump,$i + 1);
            if(count($p['fee_list']) !=0){
                foreach($p['fee_list'] as $fk => $fee){
                    $inner_current_row = $current_row_start + $j; 
                    
                    $objPHPExcel->getActiveSheet()->setCellValue('B'.$inner_current_row,date("Y-m-d",$p['createtime']));
                    $objPHPExcel->getActiveSheet()->setCellValue('C'.$inner_current_row, $p['pm']);
                    $objPHPExcel->getActiveSheet()->setCellValue('D'.$inner_current_row, $p['union_name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('E'.$inner_current_row, $p['contacter']);
                    $objPHPExcel->getActiveSheet()->setCellValue('F'.$inner_current_row, $p['contacter_mobile']);
                    $objPHPExcel->getActiveSheet()->setCellValue('G'.$inner_current_row, $p['name']);
                    $objPHPExcel->getActiveSheet()->setCellValue('H'.$inner_current_row, $fee['size']);
                    $objPHPExcel->getActiveSheet()->setCellValue('I'.$inner_current_row, $fee['num']);
                    $objPHPExcel->getActiveSheet()->setCellValue('J'.$inner_current_row, $fee['price']);
                    $objPHPExcel->getActiveSheet()->setCellValue('K'.$inner_current_row, $fee['charge_make']);
                    
                    //$subTotal = $fee['num'] * $fee['price'] + $fee['charge_make'];
                    
                    $objPHPExcel->getActiveSheet()->setCellValue('L'.$inner_current_row, "=I{$inner_current_row}*J{$inner_current_row}+K{$inner_current_row}");
                    $objPHPExcel->getActiveSheet()->setCellValue('M'.$inner_current_row, $fee['remark']);
                    
                    if($fk == 0){
                        $objPHPExcel->getActiveSheet()->setCellValue('N'.$inner_current_row, $p['descripton']);
                    }
                    
                    $j++;
                }
                
                $objPHPExcel->getActiveSheet()->mergeCells('A'.$current_row_start.':A'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('B'.$current_row_start.':B'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('C'.$current_row_start.':C'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('D'.$current_row_start.':D'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('E'.$current_row_start.':E'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('F'.$current_row_start.':F'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('G'.$current_row_start.':G'.$current_row_end);
                $objPHPExcel->getActiveSheet()->mergeCells('N'.$current_row_start.':N'.$current_row_end);
                
            }else{
                $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row_start,date("Y-m-d",$p['createtime']));
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row_start, $p['pm']);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row_start, $p['union_name']);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row_start, $p['contacter']);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row_start, $p['contacter_mobile']);
                $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row_start, $p['name']);
                $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row_start, '');
                $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row_start, 0);
                $objPHPExcel->getActiveSheet()->setCellValue('J'.$current_row_start, 0);
                $objPHPExcel->getActiveSheet()->setCellValue('K'.$current_row_start, 0);
                $objPHPExcel->getActiveSheet()->setCellValue('L'.$current_row_start, "=I{$current_row_start}*J{$current_row_start}+K{$current_row_start}");
                $objPHPExcel->getActiveSheet()->setCellValue('M'.$current_row_start, '');
                $objPHPExcel->getActiveSheet()->setCellValue('N'.$current_row_start, $p['descripton']);
                $jump += 1;
            }
            
            $jump += count($p['fee_list']);
            $i++;
        }
        
        $objPHPExcel->getActiveSheet()->setCellValue('A'.$jump, '合计');
        $objPHPExcel->getActiveSheet()->setCellValue('L'.$jump, '=SUM(L3:L'.($jump -1).')');
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:N1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );

        $objPHPExcel->getActiveSheet()->getStyle('A2:N2')->applyFromArray(
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
            
        if($projects){

            $objPHPExcel->getActiveSheet()->getStyle('A1:N'.$jump)->applyFromArray(
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
            $objPHPExcel->getActiveSheet()->mergeCells('A'.$jump.':N'.$jump);
            
            $objPHPExcel->getActiveSheet()->getStyle('A1:N'.$jump)->applyFromArray(
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
        
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'规划项目费用报表.xls');
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
                $this->_report_fee();
            }else{
                $this->display();
            }
        }else{
            $this->display();
        }
    }
    
    
}
