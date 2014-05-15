<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Region extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('District_Model');
    }
    
	public function index()
	{
        $this->_initYear();
        
        $this->_getPageData();
		$this->display();
	}
    
    
    public function delete()
	{
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->Region_Model->fake_delete($_POST);
            $this->sendFormatJson('success',array('operation' => 'delete','id' => $_POST['id'] , 'text' => '删除成功'));
        }else{
            $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => '删除失败'));
        }
    }
    
    public function edit(){
        $this->assign('action','edit');
        $this->_initSelect();
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            $this->form_validation->set_rules('code', '代码', 'required|alpha|min_length[1]|max_length[5]|callback_checkcode[edit-'.$_POST['id'].':'.$_POST['code'].':'.$_POST['year'].':'.$_POST['name'].']');
            $this->form_validation->set_rules('name', '名称', 'required|min_length[1]|max_length[50]|callback_checkname[edit-'.$_POST['id'].':'.$_POST['code'].':'.$_POST['year'].':'.$_POST['name'].']');
            
            if($this->form_validation->run()){
                // add
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['displayorder'] = empty($_POST['displayorder']) ? 0 : intval($_POST['displayorder']);
                $this->Region_Model->update($_POST);
                $info = $this->Region_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Region_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display('add');
    }
    
    private function _addRules(){
        $this->form_validation->set_rules('year', '年份', 'is_natural_no_zero');
        
        if(!empty($_POST['displayorder'])){
            $this->form_validation->set_rules('displayorder', '排序', 'integer');
        }
    }
    
    
    /**
     * 验证代码
     */
    public function checkcode($str,$param){
        $info = explode(':',$param);
        
        if($info[0] == 'add'){
            $count = $this->Region_Model->getCount(array(
                'where' => array(
                    'code' => strtoupper($info[1]),
                    'year' => $info[2],
                    'status' => '正常',
                )
            ));
        }else{
            $count = $this->Region_Model->getCount(array(
                'where' => array(
                    'id !=' => str_replace('edit-','',$info[0]),
                    'code' => strtoupper($info[1]),
                    'year' => $info[2],
                    'status' => '正常'
                )
            ));
        }
        
        if ($count)
        {
            $this->form_validation->set_message('checkcode', '%s' .$info[1]. '在年份'.$info[2].'度已经存在');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
        
    }
    
    public function checkname($str,$param){
        $info = explode(':',$param);
        
        if($info[0] == 'add'){
            $count = $this->Region_Model->getCount(array(
                'where' => array(
                    'name' => $info[3],
                    'year' => $info[2],
                    'status' => '正常'
                )
            ));
        }else{
            $count = $this->Region_Model->getCount(array(
                'where' => array(
                    'id !=' => str_replace('edit-','',$info[0]),
                    'name' => $info[3],
                    'year' => $info[2],
                    'status' => '正常'
                )
            ));
        }
        
        if ($count)
        {
            $this->form_validation->set_message('checkname', '%s '.htmlspecialchars($info[3]).'在年份'.$info[2].'度已经存在');
            return FALSE;
        }
        else
        {
            return TRUE;
        }
            
        
    }
    
    
    
    private function _initYear(){
        $this->assign('yearList',yearList());
    }
    
    private function _initZj(){
        $zxList = $this->District_Model->getList(array(
           'where' => array(
               'upid' => 2151
           ),
           'order' => 'displayorder DESC '
        ));
        
        $this->assign('zxList',$zxList);
    }
    
    private function _initSelect(){
        
        $this->_initYear();
        $this->_initZj();
        
    }

    public function add()
	{
        $this->assign('info',$_POST);
        
        $this->_initSelect();
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            
            $_POST['name'] = str_replace(array('[',']',':'),array('','',''),$_POST['name']);
            
            $this->form_validation->set_rules('code', '代码', 'required|alpha|min_length[1]|max_length[5]|callback_checkcode[add:'.$_POST['code'].':'.$_POST['year'].':'.$_POST['name'].']');
            $this->form_validation->set_rules('name', '名称', 'required|min_length[1]|max_length[50]|callback_checkname[add:'.$_POST['code'].':'.$_POST['year'].':'.$_POST['name'].']');
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $_POST['displayorder'] = empty($_POST['displayorder']) ? 0 : intval($_POST['displayorder']);
                $insertid = $this->Region_Model->add($_POST);
                
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
    
    
    public function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('region','index',array('name' => $_GET['name'],'type' => $_GET['type']))
            );
            
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            
            if(!empty($_GET['year'])){
                $condition['where'] = array(
                    'year' => $_GET['year']
                );
            }
            
            $data = $this->Region_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
}

