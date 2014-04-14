<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_File extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('File_Model');
    }
    
    
	public function index()
	{
        $this->load->helper('url');
        $pid = empty($_GET['pid']) ? 0 : intval($_GET['pid']);
        
        $condition = array();
        $condition['where'] = array(
            'pid' => $pid,
            'user_id' => $this->_userProfile['id']
        );
        
        $this->load->helper('number');
        
        $data = $this->File_Model->getList($condition);
        $this->assign('pid',$pid);
        $this->assign('data',$data);
		$this->display();
	}
    
    private function _addRules(){
        $this->form_validation->set_rules('folder_name', '文件夹名称', 'required|min_length[1]|max_length[300]|htmlspecialchars');
    }
    
    
    public function addfolder(){
        
        if($this->isPostRequest() && !empty($_POST['folder_name'])){
            $this->_addRules();
            if($this->form_validation->run()){
                $data = array(
                    'pid' => $_POST['pid'],
                    'file_name' => $_POST['folder_name'],
                    //'file_name' => null,
                    'createtime' => $now,
                    'updatetime' => $now,
                    'is_dir' => 1,
                    'creator' => $this->_userProfile['name'],
                    'updator' => $this->_userProfile['name'],
                    'createtime' => $this->reqtime,
                    'updatetime' => $this->reqtime,
                    'user_id' => $this->_userProfile['id'],
                    'ip' => get_ip()
                );

                $fileId = $this->File_Model->add($data);

                if($fileId){
                     $this->sendFormatJson('success',array('id' => $_POST['id'] , 'text' => '创建成功'),$_SERVER['HTTP_REFERER']);
                }else{
                    $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => form_error('name')));
                }
            }else{
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => form_error('name')));
            }
        }else{
            $this->sendFormatJson('error',array('id' => 0 , 'text' => "请输入文件夹名称"));
        }
    }
    
    
}

