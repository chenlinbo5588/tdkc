<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Consume extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Consume_Type_Model');
        $this->load->model('Consume_Model');
    }
    
    
	
	public function index()
	{
        $this->assign('action','index');
        $this->_getPageData('index');
		$this->display();
	}
    
    public function in(){
        $this->assign('action','in');
        $this->_getPageData('in');
		$this->display();
    }
    
    
    public function out(){
        $this->assign('action','out');
        $this->_getPageData('out');
		$this->display();
    }
    
    private function _getPageData($action = 'index'){
        try {
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('consume','index')
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            $condition['where'] = array();
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            $condition['where']['status'] = '正常';
            
            switch($action){
                //默认是
                case 'in':
                    $condition['where']['direction'] = 0;
                    $data = $this->Consume_Model->getList($condition);
                    break;
                case 'out':
                    $condition['where']['direction'] = 1;
                    
                    if(!empty($_GET['owner'])){
                        $condition['like']['owner'] = $_GET['owner'];
                    }
                    
                    $data = $this->Consume_Model->getList($condition);
                    break;
                default:
                    $data = $this->Consume_Type_Model->getList($condition);
                    break;
            }
            
            $this->assign('action',$action);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addInRules(){
        $this->form_validation->set_rules('name', '耗材名称', 'required|is_natural_no_zero');
        $this->form_validation->set_rules('quantity', '数量', 'required|is_natural_no_zero');
    }
    
    
    private function _addOutRules(){
        $this->form_validation->set_rules('name', '耗材名称', 'required|is_natural_no_zero');
        $this->form_validation->set_rules('quantity', '数量', 'required|is_natural_no_zero');
        $this->form_validation->set_rules('owner', '领取人', 'required|min_length[1]|max_length[10]');
    }
    
    
    private function _getConsumeType(){
        $d = $this->Consume_Type_Model->getList(array(
            'where' => array(
                'status' => '正常'
            )
        ));
        return $d['data'];
    }
    
    public function addin()
	{
        
        $this->assign('consumeTypeList',$this->_getConsumeType());
        
        if($this->isPostRequest() && !empty($_POST['name'])){
            $this->assign('info',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addInRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                
                $typeInfo = $this->Consume_Type_Model->queryById($_POST['name']);
                
                if($typeInfo){
                    $_POST['name'] = $typeInfo['name'];
                    $_POST['type'] = $typeInfo['type'];
                    $_POST['unit_name'] = $typeInfo['unit_name'];
                    $_POST['direction'] = 0;
                    $_POST['owner'] = '';
                    $insertid = $this->Consume_Model->add($_POST);
                    
                    /**
                     * 增加库存 
                     */
                    $this->db->set('quantity', 'quantity+'. $_POST['quantity'], FALSE);
                    $this->db->where('id' ,$typeInfo['id']);
                    $this->db->update($this->Consume_Type_Model->_tableName);
                    
                    $this->assign("feedback", "success");
                    $this->assign('feedMessage',"创建成功,您需要继续添加吗");
                }else{
                    $this->assign("feedback", "failed");
                    $this->assign('feedMessage',"创建失败,找不到对应的耗材信息");
                }
                
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
    
    
    public function addout()
	{
        $this->assign('consumeTypeList',$this->_getConsumeType());
        
        if($this->isPostRequest() && !empty($_POST['name'])){
            $this->assign('info',$_POST);
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addOutRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                $typeInfo = $this->Consume_Type_Model->queryById($_POST['name']);
                
                if($typeInfo){
                    
                    $_POST['name'] = $typeInfo['name'];
                    $_POST['type'] = $typeInfo['type'];
                    $_POST['unit_name'] = $typeInfo['unit_name'];
                    $_POST['direction'] = 1;
                    
                    if($typeInfo['quantity'] >= (int)$_POST['quantity']){
                        $this->db->set('quantity', 'quantity-'. $_POST['quantity'], FALSE);
                        $this->db->where('id' ,$typeInfo['id']);
                        $this->db->update($this->Consume_Type_Model->_tableName);
                        
                        $insertid = $this->Consume_Model->add($_POST);
                        
                        $this->assign("feedback", "success");
                        $this->assign('feedMessage',"创建成功,您需要继续添加吗");
                    }else{
                        $this->assign("feedback", "failed");
                        $this->assign('feedMessage',"库存不够");
                    }
                }else{
                    $this->assign("feedback", "failed");
                    $this->assign('feedMessage',"创建失败,找不到对应的耗材信息");
                }
                
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
    public function editin(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->form_validation->set_rules('id', '收文ID', 'required|is_natural_no_zero');
            
            $this->_addInRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                $this->Consume_Model->update($_POST);
                $info = $this->Consume_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Consume_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('addin');
    }
    
    
    /**
     * 修改 
     */
    public function editout(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->form_validation->set_rules('id', '发文ID', 'required|is_natural_no_zero');
            
            $this->_addOutRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                $this->Consume_Model->update($_POST);
                $info = $this->Consume_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Consume_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('addout');
    }
    
    /**
     * 删除 收文
     */
    public function deletein()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->Consume_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
}

