<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Sendor extends TZ_Admin_Controller {

    
    public function __construct(){
        parent::__construct();
        $this->load->model('User_Sendor_Model');
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
            
            
            /*
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('contacts','index')
            );
             */
            
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array(
                'status' => '正常',
                'user_id' => $this->_userProfile['id']
            );
            
            
            $data = $this->User_Sendor_Model->getList($condition);
            //$this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    
    private function _addRules(){
        
    }
    
    public function add()
	{
        $userList = $this->User_Model->getList(array(
            'where' => array(
                'status' => '正常',
                'id !=  ' => 1,
            )
        ));
        
        $userSendorList = $this->User_Sendor_Model->getList(array(
                'where' => array(
                   'user_id' => $this->_userProfile['id']
                )
            )
        );
        
        $this->assign('userList',$userList['data']);
        
        $selectedIds = array();
        foreach($userSendorList['data'] as $val){
            $selectedIds[] = $val['sendor_id'];
        }
        
        ///print_r($selectedIds);
        $this->assign('userSendorList',$selectedIds);
        $this->assign('userList',$userList['data']);
        
        
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            if(!empty($_POST['sendor'])){
                $selectedUser = $this->User_Model->getList(array(
                    'where_in' => array(
                        array(
                            'key' => 'id','value' => $_POST['sendor']
                        )
                    )
                ));

                $data = array();

                $now = time();
                foreach($selectedUser['data'] as $val){
                    $temp['user_id'] = $this->_userProfile['id'];
                    $temp['sendor_id'] = $val['id'];
                    $temp['sendor'] = $val['name'];
                    $temp['creator'] = $this->_userProfile['name'];
                    $temp['updator'] = $this->_userProfile['name'];
                    $temp['createtime'] = $now;
                    $temp['updatetime'] = $now;

                    $data[] = $temp;
                }


                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['user_id'] = $this->_userProfile['id'];

                $this->User_Sendor_Model->deleteByWhere(array('user_id' => $this->_userProfile['id']));
                //$this->User_Sendor_Model->updateByWhere(array('status' => '已删除'),array('user_id' => $this->_userProfile['id']));
                $this->User_Sendor_Model->batchInsert($data);
            }else{
                $this->User_Sendor_Model->deleteByWhere(array('user_id' => $this->_userProfile['id']));
            }
            
            $this->assign("feedback", "success");
            $this->assign('feedMessage',"保存成功");
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
		
	}
    
    
    
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            foreach($_POST['id'] as $val){
                $update = array();
                $ch = $_POST['ch_'.$val];
                
                if(!empty($ch)){
                    $update['ch_workflow'] = in_array('workflow',$ch) == true ? 'y' : 'n';
                    $update['ch_cs'] = in_array('cs',$ch) == true ? 'y' : 'n';
                    $update['ch_fs'] = in_array('fs',$ch) == true ? 'y' : 'n';
                    $update['ch_fee'] = in_array('fee',$ch) == true ? 'y' : 'n';
                    $update['ch_archive'] = in_array('archive',$ch) == true ? 'y' : 'n';
                }else{
                    $update['ch_workflow'] = 'n';
                    $update['ch_cs'] = 'n';
                    $update['ch_fs'] = 'n';
                    $update['ch_fee'] = 'n';
                    $update['ch_archive'] = 'n';
                }
                
                $ch2 = $_POST['gh_'.$val];
                if(!empty($ch2)){
                    $update['gh_workflow'] = in_array('workflow',$ch2) == true ? 'y' : 'n';
                    $update['gh_cs'] = in_array('cs',$ch2) == true ? 'y' : 'n';
                    $update['gh_fs'] = in_array('fs',$ch2) == true ? 'y' : 'n';
                    $update['gh_fee'] = in_array('fee',$ch2) == true ? 'y' : 'n';
                    $update['gh_archive'] = in_array('archive',$ch2) == true ? 'y' : 'n';
                }else{
                    $update['gh_workflow'] = 'n';
                    $update['gh_cs'] = 'n';
                    $update['gh_fs'] = 'n';
                    $update['gh_fee'] = 'n';
                    $update['gh_archive'] = 'n';
                }
                
                $update['displayorder'] = (int)$_POST['displayorder_'.$val];
                
                $this->User_Sendor_Model->updateByWhere($update,array('id' => $val,'user_id' => $this->_userProfile['id']));
            }
            
            $message = '<p class="success">修改成功</p>';
            $gobackUrl = $_POST['gobackUrl'];
                
        }else{
            $message = '<p class="failed">参数错误，修改失败</p>';
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        $this->assign('message','<div class="pd20">'.$message.'</div>');
        $this->display('showmessage','common');
    }
    
    /**
     * 删除日程 
     */
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->User_Sendor_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete', 'id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
}

