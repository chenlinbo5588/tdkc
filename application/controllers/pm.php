<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pm extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('Pm_Model');
    }
    
    
	
	public function index()
	{
        $this->receive();
	}
    
    public function receive(){
        $this->_getPageData('receive');
		$this->display('index');
    }
    
    
    public function send(){
        
        $this->_getPageData('send');
		$this->display('index');
    }
    
    
    public function trash(){
        $this->_getPageData('trash');
		$this->display('index');
    }
    
    private function _getPageData($action = 'index'){
        try {
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('pm','index')
            );
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
            }
            
            $condition['where'] = array();
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']);
            }
            
            $condition['where']['user_id'] = $this->_userProfile['id'];
            $condition['where']['status'] = '正常';
            
            switch($action){
                //默认是已收
                case 'receive':
                    $condition['where']['driection'] = 1;
                    break;
                case 'send':
                    $condition['where']['driection'] = 0;
                    $data = $this->Pm_Model->getList($condition);
                    break;
                case 'trash':
                    $condition['where']['status'] = '已删除';
                    break;
                default:
                    break;
            }
            $data = $this->Pm_Model->getList($condition);
            $this->assign('action',$action);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('title', '标题', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('to_user_id', '收件人', 'trim|required||is_natural_no_zero');
        $this->form_validation->set_rules('to_user_name', '收件人', 'trim|required');
        $this->form_validation->set_rules('content', '内容', 'required|min_length[3]');
    }
    
    public function add()
	{
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                
                $insertid = $this->Pm_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    /**
     * 
     */
    public function detail(){
        
        $id = (int)gpc("id","GP",0);
        $pm = $this->Pm_Model->queryById($id);
        
        if(!$pm){
            die("信息找不到");
        }
        $this->assign('info',$pm);
        $this->display();
    }
    
    
    /**
     * 修改 
     */
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '工作编号', 'required|is_natural_no_zero');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];
                
                $this->Pm_Model->update($_POST);
                $info = $this->Pm_Model->getById(array('where' => array('id' => $_POST['id'],'user_id' => $this->_userProfile['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $info = $this->Pm_Model->getById(array('where' => array('id' => $_GET['id'],'user_id' => $this->_userProfile['id'])));
        }
        
        $this->assign('info',$info);
        $this->display('add');
    }
    
    /**
     * 删除 
     */
    public function delete()
	{
        $message = '';
        if($this->isPostRequest() && !empty($_POST['id'])){
            $action = strtolower($_POST['action']);
            $set = "updator = '{$this->_userProfile['name']}', updatetime = {$this->reqtime},status = '删除',user_id = {$this->_userProfile['id']} ";
            $where = " id IN(" . implode(',',$_POST['id']) .')';
            //echo "UPDATE {$this->Pm_Model->_tableName} SET {$set} WHERE {$where}";
            $this->db->query("UPDATE {$this->Pm_Model->_tableName} SET {$set} WHERE {$where}" );
            $message = '删除成功';
            
        }else{
            $message = '删除失败,参数不正确';
        }
        $_GET['page'] = $_POST['page'];
        
        $this->assign('message',$message) ;
        $this->$action();
    }
    
    
    public function setread()
	{
        $message = '';
        $action = strtolower($_POST['action']);
        if($this->isPostRequest() && !empty($_POST['id'])){
            $set = "updator = '{$this->_userProfile['name']}', updatetime = {$this->reqtime} , isnew = 0";
            $where = " id IN(" . implode(',',$_POST['id']) .')';
            
            //echo "UPDATE {$this->Pm_Model->_tableName} SET {$set} WHERE {$where}";
            $this->db->query("UPDATE {$this->Pm_Model->_tableName} SET {$set} WHERE {$where}" );
            
            $message = '设置已读成功';
            
        }else{
            $message = '设置已读失败,参数不正确';
        }
        $_GET['page'] = $_POST['page'];
        $this->assign('message',$message) ;
        $this->$action();
    }
}

