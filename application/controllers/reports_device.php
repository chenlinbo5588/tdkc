<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 仪器设备清单
 */
class reports_device extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Device_Model');
    }
    
    private function _report_device($param){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $condition['where'] = array(
        );
        
        if(!empty($param['user'])){
            $condition['where']['user'] = $param['user'];
        }
        
        if(!empty($param['sdate'])){
            $condition['where']['createtime >= '] = strtotime($param['sdate']);
        }
        
        if(!empty($param['edate'])){
            $condition['where']['createtime < '] = strtotime($param['edate']) + 86400;
        }
        
        $dataList = $this->Device_Model->getList(array(
            'where' => $condition['where']
        ));
        
        
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
        $objPHPExcel->getActiveSheet()->setCellValue('A1', '设备清单报表');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:H1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '设备名称');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '设备型号');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '购买日期');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '购买金额');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '质检有限期开始');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '质检有限期结束');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '使用人');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '是否报废');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(17);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(10);
        
        
        
        
        $i = 0;
        $row_start = 3;
        foreach($dataList['data'] as $p){
            $current_row = $i + $row_start;
            
            $b = explode(' ',$p['buy_time']);
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,$i + 1);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['type']);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $b[0]);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['pay_amout']);
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['check_sdate']);
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['check_edate']);
            $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, $p['user']);
            $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, ($p['is_off'] == 1 ? '是':'否'));
            $i++;
        }
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:I1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );
        
        $objPHPExcel->getActiveSheet()->getStyle('A2:I2')->applyFromArray(
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:I'.(count($dataList['data']) + 2))->applyFromArray(
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
        $filename = iconv('UTF-8','GBK', '设备清单报表.xls');
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
            $this->_report_device($_POST);
        }else{
            $this->display();
        }
    }
    
    
}
