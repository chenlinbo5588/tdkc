<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 房产台账统计报表
 */
class reports_house extends TZ_Admin_Controller {
    
    
    
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Taizhang_Model');
    }
    
    private function _report(){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        //file_put_contents("debug.txt",print_r($_POST,true));
        
        $cd = array(
            'where' => array(
                'category' => '房产项目',
                'createtime >= ' => strtotime($_POST['sdate']),
                'createtime < ' => strtotime($_POST['edate']) + 86400
             ),
            'order' => 'createtime ASC ,  region_code ASC'
        );
        
        if($_POST['status']){
            $cd['where_in'][] = array('key' => 'status','value' => $_POST['status']);
        }
        
        
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
        $objPHPExcel->getActiveSheet()->setCellValue('A1', $_POST['sdate'].'至'.$_POST['edate'].'房产台账统计');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:H1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '登记日期');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '项目名称');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '土地坐落');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '面积');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '出报告时间');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '项目负责人');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '合同编号');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '备注');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(25);
        
        
        $i = 0;
        $row_start = 3;
        foreach($projectList['data'] as $p){
            $current_row = $i + $row_start;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,date("Y-m-d",$p['createtime']));
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['region_name'].$p['address']);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, number_format($p['total_area'],2,".",""));
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, date("Y-m-d",$p['complete_time']));
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['pm']);
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['project_no']);
            $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, $p['descripton']);
            
            $i++;
        }
        
        $objPHPExcel->getActiveSheet()->getStyle('A3:H'.(count($projectList['data']) + 2))->getNumberFormat()->setFormatCode('#,##0.00');
        
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:H1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );
        
        $objPHPExcel->getActiveSheet()->getStyle('A2:H2')->applyFromArray(
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:H'.(count($projectList['data']) + 2))->applyFromArray(
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
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'房产台账统计报表.xls');
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
