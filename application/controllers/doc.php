<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Doc extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Contract_Model');
        $this->load->helper('download');
    }
	
	public function index()
	{
        
        if($_GET['excel']){
            $this->_report_doc($this->_prepareCondition(false));
        }else{
            $this->_getPageData($this->_prepareCondition(true));
            $this->display(); 
        }
	}
    
    
    private function _withPager(){
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }

        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('doc','index')
        );
        
        return $condition;
        
    }
    
    private function _prepareCondition($pager = true){
        
        if($pager){
            $condition = $this->_withPager();
        }
        
        if(!empty($_GET['title'])){
            $condition['like'] = array('title' => $_GET['title']);
        }

        $condition['where'] = array(

        );

        $sortAr = array(
            'title ASC','title DESC','sign_time ASC','sign_time DESC'
        );
        $sort = $_GET['sort'];

        if(!in_array($sort,$sortAr)){
            $sort = "title ASC";
        }

        $condition['order'] = $sort;
        $condition['where']['status'] = '正常';

        if(!empty($_GET['sdate'])){
            $condition['where']['sign_time >='] = $_GET['sdate'];
        }

        if(!empty($_GET['edate'])){
            $condition['where']['sign_time <='] = $_GET['edate'];
        }
        
        return $condition;
    }
    
     private function _report_doc($condition){
        
        require_once PHPExcel_PATH.'PHPExcel.php';
        
        $dataList = $this->Contract_Model->getList($condition);
        
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
        $objPHPExcel->getActiveSheet()->setCellValue('A1', '合同报表');
        $objPHPExcel->getActiveSheet()->mergeCells('A1:H1');
        
        $objPHPExcel->getActiveSheet()->setCellValue('A2', '序号');
        
        $objPHPExcel->getActiveSheet()->setCellValue('B2', '项目名称');
        $objPHPExcel->getActiveSheet()->setCellValue('C2', '签订日期');
        $objPHPExcel->getActiveSheet()->setCellValue('D2', '合同金额');
        $objPHPExcel->getActiveSheet()->setCellValue('E2', '联系人');
        $objPHPExcel->getActiveSheet()->setCellValue('F2', '是否完成');
        $objPHPExcel->getActiveSheet()->setCellValue('G2', '电子档是否已上传');
        $objPHPExcel->getActiveSheet()->setCellValue('H2', '电子档(点击可直接查看)');
        
        
        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(45);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(20);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(30);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(30);
        
        $i = 0;
        $row_start = 3;
        foreach($dataList['data'] as $p){
            $current_row = $i + $row_start;
            
            
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$current_row,$i + 1);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$current_row,$p['title']);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$current_row, $p['sign_time']);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$current_row, $p['amount']);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$current_row, $p['linkman']);
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$current_row, $p['is_comp'] == 1 ? '是' : '否');
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$current_row, $p['file_id'] != 0 ? '是' : '否');
            
            if($p['file_id'] != 0){
                
                $objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row,$p['file_name']); 
                $objPHPExcel->getActiveSheet()->getCell('H'.$current_row)->getHyperlink()->setUrl('http://192.168.1.246'.url_path('attachment','download','id='.$p['file_id']));
                //$objPHPExcel->getActiveSheet()->getCell('H'.$current_row)->setValueExplicit('25', PHPExcel_Cell_DataType::TYPE_NUMERIC); 
                //$objPHPExcel->getActiveSheet()->setCellValue('H'.$current_row, );
            }
            
            /*
            if($p['file_id'] == 0){
                $objPHPExcel->getActiveSheet()->getStyle('A'.$current_row.':H'.$current_row)->applyFromArray(
                        array(
                            'fill' => array(
                                'type'       => PHPExcel_Style_Fill::FILL_PATTERN_LIGHTGRAY,
                                'startcolor' => array(
                                    'argb' => 'FFFC6161'
                                ),
                                'endcolor'   => array(
                                    'argb' => 'FFFC6161'
                                )
                            )
                        )
                );
            }
            */
            $i++;
        }
        
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
        
        $objPHPExcel->getActiveSheet()->getStyle('A1:H'.(count($dataList['data']) + 2))->applyFromArray(
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
        //$filename = iconv('UTF-8','GBK', '合同报表.xls');
        $filename = '合同报表.xls';
        $objWriter->save(ROOT_DIR.'/temp/'.$filename);
        $objPHPExcel->disconnectWorksheets(); 
        unset($objPHPExcel,$objWriter); 
        force_download($filename,  file_get_contents(ROOT_DIR.'/temp/'.$filename));
        
    }
    
    
    private function _getPageData($condition){
        try {
            
            $data = $this->Contract_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('title', '项目名称', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('sign_time', '合同签订日期', 'required|valid_date');
        $this->form_validation->set_rules('amount', '合同金额', 'max_length[100]|htmlspecialchars');
        $this->form_validation->set_rules('linkman', '联系人名称', 'max_length[20]|htmlspecialchars');
        $this->form_validation->set_rules('is_comp', '是否完成', 'required|is_natural|less_than[2]');
    }
    
    public function add()
	{
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                $insertid = $this->Contract_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
		
	}
    
    /**
     * 修改 
     */
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            
            $this->form_validation->set_rules('id', '合同编号', 'required|is_natural_no_zero');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                //print_r($_POST);
                $this->Contract_Model->update($_POST);
                $info = $this->Contract_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            
            $info = $this->Contract_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('add');
    }
    
    
    private function _doOp($action,$msg = ''){
        
        $message = array();
        $reload = 0;
        $success = 0;
        $failed = 0;
        foreach($_POST['opid'] as $v){
            $d = array(
                'updator' => $this->_userProfile['name'],
                'updatetime' => time()
            );
            
            switch($action){
                case 'delete':
                    $d['status'] = '已删除';
                    break;
                case 'complete':
                    $d['is_comp'] = 1;
                    break;
                default:
                    break;
            }
            
            $flag = $this->Contract_Model->updateByWhere($d,array('id' => $v));

            if($flag){
                $success++;
            }else{
                $failed++;
            }
        }

        if($success){
            $reload = 1;
            $message[] = '<p class="success">'.$success.'个'.$msg.'成功</p>';
        }

        if($failed){
            $message[] = '<p class="failed">'.$failed.'个'.$msg.'失败</p>';
        }

        $this->assign('reload',$reload);
        $this->assign('message','<div class="pd20">'.implode('',$message).'</div>');
        $this->display('showmessage','common');
        
    }
    
    /**
     * 删除 
     */
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['opid'])){
            $this->_doOp('delete','删除');
        }else{
            $this->assign('message','参数错误');
            $this->display('showmessage','common');
        }
    }
    
    /**
     * 完成 
     */
    public function complete()
	{
        if($this->isPostRequest() && !empty($_POST['opid'])){
            $this->_doOp('complete','完成');
        }else{
            $this->assign('message','参数错误');
            $this->display('showmessage','common');
        }
    }
}

