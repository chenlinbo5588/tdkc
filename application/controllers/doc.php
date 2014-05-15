<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Doc extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Contract_Model');
    }
	
	public function index()
	{
        $this->_getPageData();
        $this->display();
	}
    
    private function _getPageData(){
        try {
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('doc','index')
            );
            
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
            }
            
            $condition['where'] = array();
            $condition['where']['status'] = '正常';
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
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
        $this->form_validation->set_rules('amount', '合同金额', 'required|is_numeric');
        $this->form_validation->set_rules('linkman', '联系人名称', 'required|max_length[20]|htmlspecialchars');
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

