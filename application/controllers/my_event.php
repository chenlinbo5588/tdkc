<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_event extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('User_Event_Model');
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
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "isnew DESC,createtime DESC";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('my_event','index')
            );
            if(!empty($_GET['title'])){
                $condition['like'] = array('title' => $_GET['title']);
            }
            $condition['where'] = array(
                'status != ' => '已删除',
                'user_id' => $this->_userProfile['id'],
            );
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
            }
            
            if(!empty($_GET['status'])){
                $condition['where']['status'] = $_GET['status'];
            }
            
            $data = $this->User_Event_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
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
                case 'deal':
                    $d['status'] = '已处理';
                    $d['isnew'] = 0;
                    
                    break;
                case 'delete':
                    $d['status'] = '已删除';
                    $d['isnew'] = 0;
                    break;
                default:
                    break;
            }
            
            $flag = $this->User_Event_Model->updateByWhere($d,array(
                'id' => $v,
                'user_id' => $this->_userProfile['id']
            ));

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
     *  设为已处理
     */
    public function deal(){
        
        if($this->isPostRequest() && !empty($_POST['opid'])){
            $this->_doOp('deal','设为已处理');
        }else{
            $this->assign('message','参数错误');
            $this->display('showmessage','common');
        }
    }
    
    
    /**
     * 删除 
     */
    public function delete(){
        
        $ids =  gpc('opid','GP',array());
        if(!is_array($ids)){
            $ids = (array)$ids;
        }
        
        if($this->isPostRequest() && !empty($_POST['opid'])){
            $this->_doOp('delete','删除');
        }else{
            $this->assign('message','参数错误');
            $this->display('showmessage','common');
        }
    }
}

