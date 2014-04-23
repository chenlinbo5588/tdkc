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
                'id != ' => $this->_userProfile['id']
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
            $this->assign('feedMessage',"保存成功,是否继续设置");
        }else{
            $this->assign("feedback", "failed");
            $this->assign('feedMessage',"创建失败,请核对您输入的信息");
        }
        
        $this->display();
		
	}
    
    
    
    public function edit(){
        $this->assign('action','edit');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('id', '通讯录编号', 'required|is_natural_no_zero');
            
            $this->_addRules();
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                
                $this->User_Sendor_Model->update($_POST);
                $info = $this->User_Sendor_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $info = $this->User_Sendor_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->assign('info',$info);
        $this->display('add');
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

