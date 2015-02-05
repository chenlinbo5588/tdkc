<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 台账归档目录报表
 */
class reports_archive extends TZ_Admin_Controller {
    public $projectTypeList = null;
    
    public function __construct(){
        parent::__construct();
        
        $this->projectTypeList = getTaizhangList();
        $this->load->model('Region_Model');
        $this->load->model('Taizhang_Model');
        $this->load->model('Project_Nature_Model');
    }
    
    
    
    private function _writeWorkSheet($objPHPExcel ,$sheetName , $list){
        
        
        if('土地' == $sheetName){
            $objPHPExcel->getActiveSheet()->setCellValue('A1', '土地勘测定界成果档案案卷目录');
            $objPHPExcel->getActiveSheet()->mergeCells('A1:J2');
            $objPHPExcel->getActiveSheet()->setCellValue('A3', '全宗号:请填入全宗号');
            $objPHPExcel->getActiveSheet()->mergeCells('A3:J3');

            $objPHPExcel->getActiveSheet()->setCellValue('A4','案卷号');
            $objPHPExcel->getActiveSheet()->mergeCells('A4:A5');
            $objPHPExcel->getActiveSheet()->setCellValue('B4','目录号');
            $objPHPExcel->getActiveSheet()->mergeCells('B4:B5');
            $objPHPExcel->getActiveSheet()->setCellValue('C4', '分类号');
            $objPHPExcel->getActiveSheet()->mergeCells('C4:C5');
            $objPHPExcel->getActiveSheet()->setCellValue('D4','编号');
            $objPHPExcel->getActiveSheet()->mergeCells('D4:D5');
            $objPHPExcel->getActiveSheet()->setCellValue('E4','单 位 或 个 人');
            $objPHPExcel->getActiveSheet()->mergeCells('E4:E5');
            $objPHPExcel->getActiveSheet()->setCellValue('F4', '土地座落');
            $objPHPExcel->getActiveSheet()->mergeCells('F4:G4');
            
            $objPHPExcel->getActiveSheet()->setCellValue('F5','镇');
            $objPHPExcel->getActiveSheet()->setCellValue('G5','村');
            $objPHPExcel->getActiveSheet()->setCellValue('H4','年  度');
            $objPHPExcel->getActiveSheet()->mergeCells('H4:H5');
            $objPHPExcel->getActiveSheet()->setCellValue('I4','保管');
            $objPHPExcel->getActiveSheet()->setCellValue('I5','期限');
            $objPHPExcel->getActiveSheet()->setCellValue('J4','备注');
            $objPHPExcel->getActiveSheet()->mergeCells('J4:J5');
            
            $row_start = 6;
            
            $objPHPExcel->getActiveSheet()->getStyle('A1:J2')->applyFromArray(
                    array(
                        'font'    => array(
                            'bold'      => true,
                            'size'     => 28
                        )
                    )
            );
            
            $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(25);
            $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
            $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(12);
            
            $objPHPExcel->getActiveSheet()->getRowDimension('1')->setRowHeight(45);
            $objPHPExcel->getActiveSheet()->getRowDimension('3')->setRowHeight(25);
        }else{
            
            $objPHPExcel->getActiveSheet()->setCellValue('B1', '卷内文件目录');
            $objPHPExcel->getActiveSheet()->mergeCells('B1:F1');
            $objPHPExcel->getActiveSheet()->setCellValue('B2','填报单位（盖章）：'.OUR_COMPANY_NAME.'                          '.date("Y").'年');
            $objPHPExcel->getActiveSheet()->mergeCells('B2:F2');
            
            $objPHPExcel->getActiveSheet()->setCellValue('A3','案卷号');
            $objPHPExcel->getActiveSheet()->setCellValue('B3','序号');
            $objPHPExcel->getActiveSheet()->setCellValue('C3','材料名称');
            $objPHPExcel->getActiveSheet()->setCellValue('D3','编号');
            $objPHPExcel->getActiveSheet()->setCellValue('E3','页号');
            $objPHPExcel->getActiveSheet()->setCellValue('F3','备注');
            
            $row_start = 4;
            
            $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(12);
            $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(10);
            $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
            $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
            $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
            $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
            
            $objPHPExcel->getActiveSheet()->getRowDimension('1')->setRowHeight(30);
            $objPHPExcel->getActiveSheet()->getRowDimension('2')->setRowHeight(25);
        }
        
        
        
        $i = 0;
        
        if('土地' == $sheetName) {
            foreach($list['data'] as $p){
                $current_row = $i + $row_start;
                $projectNo = explode('-',$p['project_no']);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $projectNo[1].'-'.$projectNo[2]);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['name']);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['region_name']);
                $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['address']);
                $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, $p['year']);
                $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, '永  久');

                $i++;
            }
        }else{
            foreach($list['data'] as $p){
                $current_row = $i + $row_start;
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['name']);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['project_no']);

                $i++;
            }
        }
        
        
        $endRow = (count($list['data']) + $row_start  - 1);
        
        if('土地' == $sheetName){
            $range = 'A1:J'.$endRow;
            $nameColumn = "E{$row_start}:E".$endRow;
            
        }else{
            $range = 'A1:F'.$endRow;
            $nameColumn = "C{$row_start}:C".$endRow;
        }
        
        $objPHPExcel->getActiveSheet()->getStyle($range)->applyFromArray(
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
        
        
        $objPHPExcel->getActiveSheet()->getStyle($nameColumn)->applyFromArray(
                array(
                    'alignment' => array(
                        'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_LEFT,
                    )
                )
        );
        
    }
    
    
    private function _report(){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        //file_put_contents("debug.txt",print_r($_POST,true));
        $cd = array(
            'where' => array(
                'createtime >= ' => strtotime($_POST['sdate']),
                'createtime < ' => strtotime($_POST['edate']) + 86400
             ),
            'order' => 'createtime ASC'
        );
        
        
        
        
        $dtCondtion = array(
            '土地' => array(
                'where' => $cd['where'],
                'order' => $cd['order']
            ),
            '放线' => array(
                'where' => $cd['where'],
                'order' => $cd['order']
            ),
            '竣工' => array(
                'where' => $cd['where'],
                'order' => $cd['order']
            ),
            '房产' => array(
                'where' => $cd['where'],
                'order' => $cd['order']
            )
        );
        
        
        $dtCondtion['土地']['where']['category'] = TAIZHANG_TD;
        $dtCondtion['放线']['where']['category'] = TAIZHANG_FG;
        $dtCondtion['放线']['where']['nature'] = '放线';
        
        $dtCondtion['竣工']['where']['category'] = TAIZHANG_FG;
        $dtCondtion['竣工']['where']['nature'] = '竣工';
        
        
        $dtCondtion['房产']['where']['category'] = TAIZHANG_HOUSE;
        $dtCondtion['房产']['where']['nature'] = '竣工';
        
        
        
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
        
        $objPHPExcel->removeSheetByIndex(0); 
        
        $sheetIndex = 0;
        foreach($dtCondtion as $dk => $dt) {
            $myWorkSheet = new PHPExcel_Worksheet($objPHPExcel,$dk); 
            $objPHPExcel->addSheet($myWorkSheet);
            $objPHPExcel->setActiveSheetIndex($sheetIndex);

            if($_POST['status']){
                $dt['where_in'][] = array('key' => 'status','value' => $_POST['status']);
            }else{
                $dt['where']['status'] = 'XXXX';
            }
            
            $tempList = $this->Taizhang_Model->getList($dt); 
            $this->_writeWorkSheet($objPHPExcel,$dk,$tempList);
            
            $sheetIndex++;
        }
        
        $objPHPExcel->setActiveSheetIndex(0);
        
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'归档报表.xls');
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
