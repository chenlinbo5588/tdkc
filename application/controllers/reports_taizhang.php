<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 台账明细报表
 */
class reports_taizhang extends TZ_Admin_Controller {
    public $projectTypeList = null;
    
    public function __construct(){
        parent::__construct();
        
        $this->projectTypeList = getTaizhangList();
        $this->load->model('Region_Model');
        $this->load->model('Taizhang_Model');
        $this->load->model('Project_Nature_Model');
    }
    
    
    
    private function _writeWorkSheet($objPHPExcel , $list){
        
        $objPHPExcel->getActiveSheet()->setCellValue('A1', '登记日期');
        $objPHPExcel->getActiveSheet()->setCellValue('B1', '编号');
        $objPHPExcel->getActiveSheet()->setCellValue('C1', '单位名称');
        $objPHPExcel->getActiveSheet()->setCellValue('D1', '用途');
        $objPHPExcel->getActiveSheet()->setCellValue('E1', '坐落');
        $objPHPExcel->getActiveSheet()->setCellValue('F1', '作业组');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(50);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        
        
        $i = 0;
        $row_start = 2;
        foreach($list['data'] as $p){
            $current_row = $i + $row_start;
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,date("Y-m-d",$p['createtime']));
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['project_no']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['nature']);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['address']);
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['pm']);
            
            if('已删除' == $p['status']){
                $objPHPExcel->getActiveSheet()->getStyle('A'.$current_row.':F'.$current_row)->applyFromArray(
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
        
        /*
        $objPHPExcel->getActiveSheet()->getStyle('A1:F1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );
        */
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:F1')->applyFromArray(
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:F'.(count($list['data']) + 1))->applyFromArray(
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
        
        if($_POST['status']){
            $cd['where_in'][] = array('key' => 'status','value' => $_POST['status']);
        }else{
            $cd['where']['status'] = 'XXXX';
        }
        
        
        if($_POST['category']){
            $cd['where']['category'] = $_POST['category'];
            //$cd['where_in'][] = array('key' => 'category','value' => array($_POST['category']));
        }else{
            $cd['where']['category'] = 'XXXX';
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
        $objPHPExcel->getActiveSheet()->setTitle("总台账");
        //$objPHPExcel->getActiveSheet()->setCellValue('A1', $_POST['sdate'].'至'.$_POST['edate'].'台账明细报表');
        //$objPHPExcel->getActiveSheet()->mergeCells('A1:F1');
        
        $this->_writeWorkSheet($objPHPExcel,$projectList);
        
        /**
         * region code 
         */
        $regionCondition = array(
            'where' => array(
                'status' => '正常','year' => date("Y"),
            ),
            'order' => 'displayorder DESC ,createtime ASC'
        );
        
        if($_POST['region_name']){
            $regionCondition['where_in'][] = array(
                'key' => 'name',
                'value' => $_POST['region_name']
            );
        }
        
        if(TAIZHANG_TD == $_POST['category'] || TAIZHANG_WF == $_POST['category'] || TAIZHANG_PERSON == $_POST['category'] ){
            
            $regionList = $this->Region_Model->getList($regionCondition);
            
            foreach($regionList['data'] as $rk => $region){
                $myWorkSheet = new PHPExcel_Worksheet($objPHPExcel,$region['name'] ."({$region['code']})"); 
                $objPHPExcel->addSheet($myWorkSheet);
                $objPHPExcel->setActiveSheetIndex($rk + 1);
                $cd['where']['region_name'] = $region['name'];

                $tempList = $this->Taizhang_Model->getList($cd); 
                $this->_writeWorkSheet($objPHPExcel,$tempList);
            }
        }elseif(TAIZHANG_FG == $_POST['category'] || TAIZHANG_OTHER == $_POST['category']){
            
            $this->load->model('Project_Nature_Model');
            $natureList = $this->Project_Nature_Model->getList(array(
                'where' => array(
                    'type' => $_POST['category']
                )
            ));
            
            foreach($natureList['data'] as $rk => $nature){
                $myWorkSheet = new PHPExcel_Worksheet($objPHPExcel,$nature['name']); 
                $objPHPExcel->addSheet($myWorkSheet);
                $objPHPExcel->setActiveSheetIndex($rk + 1);
                $cd['where']['nature'] = $nature['name'];

                $tempList = $this->Taizhang_Model->getList($cd);
                $this->_writeWorkSheet($objPHPExcel,$tempList);
            }
        }
        
        $objPHPExcel->setActiveSheetIndex(0);
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        //$filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].$_POST['category'].'台账明细报表.xls');
        $filename = $_POST['sdate'].'至'.$_POST['edate'].$_POST['category'].'台账明细报表.xls';
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
