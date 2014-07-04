<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 薪资变动表
 */
class reports_salary extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Model');
        $this->load->model('User_Salary_Model');
    }
    
    private function _report_salary($param){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $condition['where'] = array(
            'id !=' => 1,
            'status' => '正常'
        );
        
        $dataList = $this->User_Model->getList(array(
            'where' => $condition['where'],
            'order' => 'createtime ASC'
        ));
        
        
        
        if(!empty($param['sdate'])){
            $ds = explode('-',$param['sdate']);
            $m = substr($ds[1],0,1) == '0' ? substr($ds[1],1,1) : $ds[1];
            $ts_end = mktime(0,0,0,$m + 1,1,$ds[0]);
            $ts_start = mktime(0,0,0,$m,1,$ds[0]);
        }else{
            $ts_end = mktime(0,0,0,date("n") + 1, 1,date("Y"));
            $ts_start = mktime(0,0,0,date("n"),1,date("Y"));
        }
        
        $ts_range = array(
            'start' => $ts_start,
            'end' => $ts_end - 86400
        );
        
        $salaryList = $this->User_Salary_Model->getList(array(
            'where' => array(
                'status' => 0,
                'createtime <' => $ts_range['end']
            )
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
        $objPHPExcel->getActiveSheet()->setCellValue('A1', $param['sdate'].'工资表');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:J1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '姓名');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', "基本工资\n（含外业补贴）");
        $objPHPExcel->getActiveSheet()->getStyle('C2')->getAlignment()->setWrapText(true); 
        
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '职务津贴');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '多岗津贴');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '技术津贴');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '工资合计');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '奖金');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '合计');
        $objPHPExcel->getActiveSheet()->setCellValue('J2', '备注');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(20);
        
        
        $i = 0;
        $row_start = 3;
        
        $userSalary = array();
        
        foreach($salaryList['data'] as $salary){
            $salary['salary'] = json_decode($salary['salary'],true);
            $userSalary[$salary['user_id']] = $salary;
            
        }
        
        foreach($dataList['data'] as $p){
            $current_row = $i + $row_start;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,$i + 1);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['name']);
            
            if($userSalary[$p['id']]['salary']['基本工资']){
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $userSalary[$p['id']]['salary']['基本工资']);
            }else{
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, 0);
            }
            
            if($userSalary[$p['id']]['salary']['职务津贴']){
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $userSalary[$p['id']]['salary']['职务津贴']);
            }else{
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, 0);
            }
            
            if($userSalary[$p['id']]['salary']['多岗津贴']){
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $userSalary[$p['id']]['salary']['多岗津贴']);
            }else{
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, 0);
            }
            
            if($userSalary[$p['id']]['salary']['技术津贴']){
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $userSalary[$p['id']]['salary']['技术津贴']);
            }else{
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, 0);
            }
            
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, '=SUM(C'.$current_row.':F'.$current_row.')');
            $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, 0);
            $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, '=SUM(G'.$current_row.':H'.$current_row.')');
            $objPHPExcel->getActiveSheet()->setCellValue('J'.$current_row, $userSalary[$p['id']]['reason']);
            /**
             * 有变更
             */
            if($userSalary[$p['id']]['createtime'] >= $ts_range['start'] && $userSalary[$p['id']]['createtime'] < $ts_range['end']){
                $objPHPExcel->getActiveSheet()->getStyle('A'.$current_row.':J'.$current_row)->applyFromArray(
                        array(
                            'fill' => array(
                                'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                                'startcolor' => array(
                                    'argb' => 'FF53AF53'
                                ),
                                'endcolor'   => array(
                                    'argb' => 'FF53AF53'
                                )
                            )
                        )
                );
            }
            
            $i++;
        }
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:J1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );
        
        $objPHPExcel->getActiveSheet()->getStyle('A2:J2')->applyFromArray(
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:J'.(count($dataList['data']) + 2))->applyFromArray(
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
        $filename = iconv('UTF-8','GBK',$param['sdate'].'至'.$param['edate']. '工资表.xls');
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
            if(empty($_POST['sdate'])){
                $_POST['sdate'] = date("Y-m");
            }
            
            $this->_report_salary($_POST);
        }else{
            $this->display();
        }
    }
    
    
}
