<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Project_Type extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Project_Type_Model');
    }
    
	public function index()
	{
        $this->_getPageData();
		$this->display();
	}
    
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->Project_Type_Model->delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            $this->form_validation->set_rules('name', '名称', 'required|min_length[2]|max_length[30]|callback_checkname[edit-'.$_POST['id'].':'.$_POST['type'].':'.$_POST['cate_name'].']');
            
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['displayorder'] = empty($_POST['displayorder']) ? 0 : intval($_POST['displayorder']);
                $this->Project_Type_Model->update($_POST);
                $info = $this->Project_Type_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Project_Type_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('add');
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('type', '类型', 'required|max_length[50]');
        $this->form_validation->set_rules('cate_name', '类别', 'required|max_length[50]');
        $this->form_validation->set_rules('weight', '权重', 'required|numeric');
        
        if(!empty($_POST['displayorder'])){
            $this->form_validation->set_rules('displayorder', '排序', 'integer');
        }
        
        
    }
    
    
    public function checkname($str,$param){
        list($action,$type,$cate_name) = explode(':',$param);
        
        if($action == 'add'){
            $count = $this->Project_Type_Model->getCount(array(
                'where' => array(
                    'type' => $type,
                    'cate_name' => $cate_name,
                    'name' => $str,
                    'status' => '正常'
                )
            ));
        }else{
            $count = $this->Project_Type_Model->getCount(array(
                'where' => array(
                    'id !=' => str_replace('edit-','',$action),
                    'type' => $type,
                    'cate_name' => $cate_name,
                    'name' => $str,
                    'status' => '正常'
                )
            ));
        }
        
        if ($count)
        {
            $this->form_validation->set_message('checkname', '%s '.htmlspecialchars($str).'在 '.$type.'类型 '.$cate_name.'类别中已经存在');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
            
        
    }

    public function add()
	{
        $this->assign('info',$_POST);
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            $this->form_validation->set_rules('name', '名称', 'required|min_length[2]|max_length[30]|callback_checkname[add:'.$_POST['type'].':'.$_POST['cate_name'].']');
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $this->_userProfile['name'];
                $_POST['displayorder'] = empty($_POST['displayorder']) ? 0 : intval($_POST['displayorder']);
                $insertid = $this->Project_Type_Model->add($_POST);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $info['weight'] = $_POST;
                
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
		
	}
    
    
    public function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('project_type','index',array('name' => $_GET['name']))
            );
            
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            if(!empty($_GET['type'])){
                $condition['where'] = array(
                    'type' => $_GET['type']
                );
            }
            
            $data = $this->Project_Type_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
}

