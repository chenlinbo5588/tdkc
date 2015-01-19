<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 工作量统计报表
 */
class reports_work extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Model');
    }
    
    private function _report_work(){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        //file_put_contents("debug.txt",print_r($_POST,true));
        
        $cd = array(
            'where' => array(
                'createtime >= ' => strtotime($_POST['sdate']),
                'createtime < ' => strtotime($_POST['edate']) + 86400
             ),
            'order' => 'worker_id ASC , type ASC , createtime ASC , region_code ASC'
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
        
        $projectList = $this->Project_Model->getList($cd);
        
        
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
        $objPHPExcel->getActiveSheet()->setCellValue('A1', '测绘项目管理:'.$_POST['sdate'].'至'.$_POST['edate'].'小组工作量统计');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:Q1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '登记日期');
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '联系人');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '联系电话');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '项目名称');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '工作性质');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '土地坐落');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '工作量');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '当前状态');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '当前处理人');
        $objPHPExcel->getActiveSheet()->setCellValue('J2', '项目布置人');
        $objPHPExcel->getActiveSheet()->setCellValue('K2', '主要完成人');
        $objPHPExcel->getActiveSheet()->setCellValue('L2', '工期要求');
        $objPHPExcel->getActiveSheet()->setCellValue('M2', '起始时间');
        $objPHPExcel->getActiveSheet()->setCellValue('N2', '结束时间');
        $objPHPExcel->getActiveSheet()->setCellValue('O2', '完成情况');
        $objPHPExcel->getActiveSheet()->setCellValue('P2', '资料领取');
        $objPHPExcel->getActiveSheet()->setCellValue('Q2', '业主附加要求');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(35);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('N')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('O')->setWidth(18);
        $objPHPExcel->getActiveSheet()->getColumnDimension('P')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(20);
        $i = 0;
        $row_start = 3;
        foreach($projectList['data'] as $p){
            $current_row = $i + $row_start;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,date("Y-m-d",$p['createtime']));
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['contacter']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['contacter_mobile']);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['type']);
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['region_name'].$p['address']);
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, '');
            $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, $p['status']);
            $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, $p['sendor']);
            $objPHPExcel->getActiveSheet()->setCellValue('J'.$current_row, $p['pm']);
            $objPHPExcel->getActiveSheet()->setCellValue('K'.$current_row, $p['worker']);
            $objPHPExcel->getActiveSheet()->setCellValue('L'.$current_row, ceil(($p['end_date'] - $p['start_date'])/86400) + 1) ;
            $objPHPExcel->getActiveSheet()->setCellValue('M'.$current_row, date("Y-m-d",$p['start_date']));
            $objPHPExcel->getActiveSheet()->setCellValue('N'.$current_row, date("Y-m-d",$p['end_date']));
            $objPHPExcel->getActiveSheet()->setCellValue('O'.$current_row, '');
            $objPHPExcel->getActiveSheet()->setCellValue('P'.$current_row, '');
            $objPHPExcel->getActiveSheet()->setCellValue('Q'.$current_row, $p['descripton']);
            
            $i++;
        }
        
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:Q1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );
        
        $objPHPExcel->getActiveSheet()->getStyle('A2:Q2')->applyFromArray(
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:Q'.(count($projectList['data']) + 2))->applyFromArray(
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
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'小组工作量统计报表.xls');
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
                $this->_report_work();
            }else{
                $this->display();
            }
        }else{
            $this->display();
        }
    }
    
    
}
