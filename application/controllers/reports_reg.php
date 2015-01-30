<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 备案导出报表
 */
class reports_reg extends TZ_Admin_Controller {
    
    public $projectTypeList = null;
    
    public function __construct(){
        parent::__construct();
        //$this->projectTypeList = getTaizhangList();
        //$this->load->model('Region_Model');
        $this->load->model('Taizhang_Model');
    }
    
    private function _report($param){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $condition['where'] = array(
            'createtime >= ' => strtotime($_POST['sdate']),
            'createtime < ' => strtotime($_POST['edate']) + 86400
        );
        
        
        
        $dataList = $this->Taizhang_Model->getList(array(
            'select' => "category,name,ptype_name,ss_amount,createtime,get_doctime",
            'where' => $condition['where'],
            'where_in' => array(
                array(
                    'key' => 'category',
                    'value' => array(TAIZHANG_TD,TAIZHANG_FG,TAIZHANG_HOUSE)
                )
                
            ),
            
            'order' => 'createtime ASC '
        ));
        
        
        $cacheMethod = PHPExcel_CachedObjectStorageFactory::cache_to_discISAM; 
        $cacheSettings = array( 'dir'  => ROOT_DIR.'/temp' );
        PHPExcel_Settings::setLocale('zh_CN');
        PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);
        
        $objPHPExcel = new PHPExcel();
        
        $objPHPExcel->setActiveSheetIndex(0);
        $objPHPExcel->getActiveSheet()->setCellValue('A1', '项目名称（不能为空）');
        $objPHPExcel->getActiveSheet()->setCellValue('B1', '委托单位（不能为空）');
        $objPHPExcel->getActiveSheet()->setCellValue('C1', '项目类型（不能为空）');
        $objPHPExcel->getActiveSheet()->setCellValue('D1', '金额（元）（不能为空）');
        $objPHPExcel->getActiveSheet()->setCellValue('E1', '开始时间(如:2013/1/1)');
        $objPHPExcel->getActiveSheet()->setCellValue('F1', '完工时间(如:2013/1/1)');
        $objPHPExcel->getActiveSheet()->setCellValue('G1', '总包备案号');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(25);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(25);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(25);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(25);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(25);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(25);
        
        //$objPHPExcel->getActiveSheet()->getStyle('D')->getNumberFormat() ->setFormatCode('#,##0.00'); 
        
        $i = 0;
        $row_start = 2;
        $valid_count = 0;
        
        foreach($dataList['data'] as $p){
            $current_row = $i + $row_start;
            
            if(empty($p['get_doctime']) || $p['get_doctime'] == '0000-00-00'){
                continue;
            }
            
            if($p['ss_amount'] == 0 || $p['ss_amount'] > 100000){
                continue;
            }
            
            $p['category_name'] = '';
            
            if(TAIZHANG_TD == $p['category']){
                if(!in_array($p['nature'] , array('重测','转让','发证','新增'))){
                    continue;
                }
                
                $p['category_name'] = '地籍测量';
            }else if(TAIZHANG_FG == $p['category']){
                $p['category_name'] = '工程测量';
            }else if(TAIZHANG_HOUSE == $p['category']){
                $p['category_name'] = '房产测量';
            }
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,$p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['category_name']);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['ss_amount']);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, date("Y/m/d",$p['createtime']));
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['get_doctime'] == '0000-00-00' ? '' : str_replace('-','/',$p['get_doctime']));
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, '');
            
            $i++;
            $valid_count++;
            
            if($valid_count % 50 == 0){
                $i++;
            }
        }
        
        
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $filename = iconv('UTF-8','GBK', $_POST['sdate'].'至'.$_POST['edate'].'待备案报表.xls');
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
        //$regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => date("Y")),'order' => 'displayorder DESC ,createtime ASC'));
        //$this->assign('regionList',$regionList['data']);
        //$this->assign('projectTypeList',$this->projectTypeList);
        
        if($this->isPostRequest()){
            
            $this->form_validation->set_rules('sdate', '登记开始日期', 'required|valid_date');
            $this->form_validation->set_rules('edate', '登记结束日期', 'required|valid_date');
            
            if($this->form_validation->run()){
                $this->_report($_POST);
            }else{
                $this->display();
            }
        }else{
            $this->display();
        }
    }
    
    
}
