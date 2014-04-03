<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User extends TZ_Admin_Controller {

	public function index()
	{
        $this->_getPageData();
		$this->display();
	}
    
    public function add()
	{
        $feedback = array();
        
        if($this->isPostRequest()){
            $this->load->model('User_Model');
            
            $this->form_validation->set_error_delimiters('<span class="'.config_item('validation_error').'">', '</span>');
            $this->form_validation->set_rules('name', '姓名', 'required|min_length[1]|max_length[20]');
            //$this->form_validation->set_rules('name', '姓名', 'required|min_length[1]|max_length[20]');
            $this->form_validation->set_rules('account', '账号', 'required|min_length[3]|max_length[15]|alpha_numeric|is_unique['.$this->User_Model->_tableName.'.account]');
            if(!empty($_POST['psw'])){
                $this->form_validation->set_rules('psw', '密码', 'required|min_length[6]|max_length[12]|matches[psw2]');
                $this->form_validation->set_rules('psw2', '密码确认', 'required|min_length[6]|max_length[12]');
            }
            
            $this->form_validation->set_rules('gh', '工号', 'required|numeric|is_unique['.$this->User_Model->_tableName.'.gh]' );
            
            if(!empty($_POST['id_card'])){
                //$this->form_validation->set_rules('id_card', '身份证号码', 'callback_id_check');
            }
            
            if(!empty($_POST['email'])){
                $this->form_validation->set_rules('email', '邮箱', 'required|valid_email');
            }
            
            $this->form_validation->set_rules('mobile', '手机号码', 'required|exact_length[11]|numeric');
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $userid = $this->User_Model->add($_POST);
                
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
    public function id_check($str)
    {
        if (!isCreditNo($str))
        {
            $this->form_validation->set_message('id_check', '%s 字段输入不正确');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
     */
    
    public function _getPageData(){
        try {
            
            $this->load->model("User_Model");
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }else{
                $_GET['page'] = inval($_GET['page']);
            }
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "updatetime desc";
            $condition['pager'] = array(
                'page_size' => 10,
                'current_page' => $_GET['page'],
                'query_param' => url_path('news','search',array('name' => $_GET['name']))
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            
            $condition['where'] = array(
              'status = ' => '正常'  
            );
            
            $data = $this->User_Model->getList($condition);
            
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
    public function search(){
        
        
        $this->display();
    }
    
    
}
