<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 测绘项目管理 
 */
class project_ch extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Type_Model');
        $this->load->model('Project_Model');
    }
    
	public function index()
	{
        
        $this->_getPageData();
		$this->display();
	}
    
    
    private function _addRules(){
        $this->form_validation->set_rules('input_type', '录入类型', 'required|is_natural');
        $this->form_validation->set_rules('year', '年份', 'required|integer');
        $this->form_validation->set_rules('region_code', '区域', 'required|alpha');
        $this->form_validation->set_rules('type', '登记类型', 'required' );
        $this->form_validation->set_rules('name', '登记名称', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '登记地址', 'required|min_length[3]|max_length[200]|htmlspecialchars');
        
        if(!empty($_POST['village'])){
            $this->form_validation->set_rules('village', '村名', 'max_length[50]|htmlspecialchars');
        }
        
        $this->form_validation->set_rules('contacter', '联系人名称', 'required|max_length[15]|htmlspecialchars');
        $this->form_validation->set_rules('contacter_mobile', '联系人手机', 'required|valid_mobile');
        
        if(!empty($_POST['contacter_tel'])){
            $this->form_validation->set_rules('contacter_tel', '联系人固定电话', 'trim|valid_telephone');
        }
        
        $this->form_validation->set_rules('manager', '接洽人名称', 'required|max_length[15]|htmlspecialchars');
        $this->form_validation->set_rules('manager_mobile', '接洽人手机', 'required|valid_mobile');
        
        if(!empty($_POST['manager_tel'])){
            $this->form_validation->set_rules('manager_tel', '接洽人固定电话', 'trim|valid_telephone');
        }
        
        if(trim($_POST['displayorder'])){
            $this->form_validation->set_rules('displayorder', '优先级', 'trim|is_natural|less_than[10]');
        }
    }
    
    public function add()
	{
        
        /**
         *登记年份 
         */
        $addYear = gpc("year","GP",date("Y"));
        
        $addMonth = gpc("month","GP",date("m"));
        $this->assign('month',$addMonth);
        
        $inputType = gpc("input_type","GP",0);
        
        $this->assign('month',$addMonth);
        $this->assign('inputType',$inputType);
        
        /**
         * 区域 
         */
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => $addYear),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        /**
         *项目类型 
         */
        $projectTypeList = $this->Project_Type_Model->getList(array('where' => array('status' => '正常','type' => '测绘项目'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$projectTypeList['data']);
        
        $this->assign('yearList',yearList());
        $this->assign('monthList',range(1,12));
        
        
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            $this->_addRules();
            
            if($this->form_validation->run()){
                // add
                $_POST['creator'] = $_POST['updator'] = $this->_userProfile['name'];
                $lang = $this->lang->load('tdkc');
                $_POST['project_type'] = $lang['project_type']['ch'];
                
                /**
                 * 事务
                 */
                $this->db->trans_start();
                $insertid = $this->Project_Model->add($_POST);
                $this->db->trans_complete();
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    public function _getPageData(){
        try {
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            //$condition['select'] = 'a,b';
            
            $condition['order'] = "createtime DESC,displayorder DESC";
            $condition['pager'] = array(
                'page_size' => config_item('page_size'),
                'current_page' => $_GET['page'],
                'query_param' => url_path('user','index',array('name' => $_GET['name']))
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array();
            
            
            $data = $this->Project_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
