<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 人事报表
 */
class reports_employ extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Model');
    }
    
    private function _report_employ($param){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $condition['where'] = array(
            'id !=' => 1
        );
        
        $dataList = $this->User_Model->getList(array(
            'select' => implode(',',$param['select']),
            'where' => $condition['where'],
            'order' => 'createtime ASC'
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
        $year = date("Y");
        
        $objPHPExcel->setActiveSheetIndex(0);
        $objPHPExcel->getActiveSheet()->setCellValue('A1', $year.'人事报表');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:S1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '姓名');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '性别');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '户籍');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '出生年月');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '身份照号码');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '学历');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '毕业院校');
        $objPHPExcel->getActiveSheet()->setCellValue('I2', '毕业时间');
        $objPHPExcel->getActiveSheet()->setCellValue('J2', '专业');
        $objPHPExcel->getActiveSheet()->setCellValue('K2', '入院时间');
        $objPHPExcel->getActiveSheet()->setCellValue('L2', '职称');
        $objPHPExcel->getActiveSheet()->setCellValue('M2', '取得时间');
        $objPHPExcel->getActiveSheet()->setCellValue('N2', '家庭地址/现住地址');
        $objPHPExcel->getActiveSheet()->setCellValue('O2', '联系方式(宅)');
        $objPHPExcel->getActiveSheet()->setCellValue('P2', '手机号码');
        $objPHPExcel->getActiveSheet()->setCellValue('Q2', '虚拟号码');
        $objPHPExcel->getActiveSheet()->setCellValue('R2', '合同期限');
        $objPHPExcel->getActiveSheet()->setCellValue('S2', '合同签订日期');
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(13);
        $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('N')->setWidth(30);
        $objPHPExcel->getActiveSheet()->getColumnDimension('O')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('P')->setWidth(14);
        $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('R')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('S')->setWidth(24);
        
        
        if(!in_array('name',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setVisible(false); 
        }
        if(!in_array('sex',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setVisible(false); 
        }
        
        if(!in_array('huji',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setVisible(false); 
        }
        
        if(!in_array('birthday',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setVisible(false); 
        }
        
        if(!in_array('id_card',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setVisible(false); 
        }
        
        if(!in_array('edu',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setVisible(false); 
        }
        
        if(!in_array('school_name',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setVisible(false); 
        }
        
        if(!in_array('graduation_date',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setVisible(false); 
        }
        
        if(!in_array('major',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setVisible(false); 
        }
        
        if(!in_array('enter_date',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setVisible(false); 
        }
        
        if(!in_array('job_title',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setVisible(false); 
        }
        
        if(!in_array('title_time',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setVisible(false); 
        }
        
        if(!in_array('address',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('N')->setVisible(false); 
        }
        
        if(!in_array('tel',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('O')->setVisible(false); 
        }
        
        if(!in_array('mobile',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('P')->setVisible(false); 
        }
        
        if(!in_array('virtual_no',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setVisible(false); 
        }
        
        if(!in_array('contract_year',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('R')->setVisible(false); 
        }
        
        if(!in_array('contract_start',$param['select'])){
            $objPHPExcel->getActiveSheet()->getColumnDimension('S')->setVisible(false); 
        }
        
        
        $i = 0;
        $row_start = 3;
        foreach($dataList['data'] as $p){
            $current_row = $i + $row_start;
            
            $b = explode(' ',$p['birthday']);
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,$i + 1);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['name']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['sex'] == 'm' ? '男' : '女');
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['huji']);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $b[0]);
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, ' '.$p['id_card']);
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['edu']);
            $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, $p['school_name']);
            $objPHPExcel->getActiveSheet()->setCellValue('I'.$current_row, date("Y-m-d",$p['graduation_date']));
            $objPHPExcel->getActiveSheet()->setCellValue('J'.$current_row, $p['major']);
            $objPHPExcel->getActiveSheet()->setCellValue('K'.$current_row, date("Y-m-d",$p['enter_date']));
            $objPHPExcel->getActiveSheet()->setCellValue('L'.$current_row, $p['job_title']);
            $objPHPExcel->getActiveSheet()->setCellValue('M'.$current_row, date("Y-m-d",$p['title_time']));
            $objPHPExcel->getActiveSheet()->setCellValue('N'.$current_row, $p['address']);
            $objPHPExcel->getActiveSheet()->setCellValue('O'.$current_row, ' '.$p['tel']);
            $objPHPExcel->getActiveSheet()->setCellValue('P'.$current_row, (string)$p['mobile']);
            $objPHPExcel->getActiveSheet()->setCellValue('Q'.$current_row, (string)$p['virtual_no']);
            $objPHPExcel->getActiveSheet()->setCellValue('R'.$current_row, $p['contract_year']);
            $objPHPExcel->getActiveSheet()->setCellValue('S'.$current_row, $p['contract_start'] .'至'.$p['contract_end']);
            $i++;
        }
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:S1')->applyFromArray(
                array(
                    'font'    => array(
                        'bold'      => true,
                        'size'     => 20
                    )

                )
        );
        
        $objPHPExcel->getActiveSheet()->getStyle('A2:S2')->applyFromArray(
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:S'.(count($dataList['data']) + 2))->applyFromArray(
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
        $filename = iconv('UTF-8','GBK', $year.'人事报表.xls');
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
            
            $fields = $this->db->list_fields($this->User_Model->_tableName);
            
            $_POST['select'] = array();
            foreach($_POST['field'] as $v){
                if(in_array($v,$fields)){
                    $_POST['select'][] = $v;
                }
            }
            
            if($_POST['select']){
                $this->_report_employ($_POST);
            }else{
               $this->display(); 
            }
        }else{
            $this->display();
        }
    }
    
    
}
