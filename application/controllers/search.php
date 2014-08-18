<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Search extends TZ_Controller {

	public function index()
	{
		die(0);
	}
    
    public function getmods(){
        
        $limit = (int)gpc('limit','GP',20);
        $project_id = (int)gpc('project_id','GP',0);
        $user_id = (int)gpc('user_id','GP',0);
        
        $this->load->model('Project_Mod_Model');
        
        $condition['limit'] = $limit;
        $condition['where']['project_id'] = $project_id;
        $condition['where']['type'] = 'workflow';
        if($user_id){
            $condition['where']['user_id'] = $project_id;
        }
        $condition['order'] = 'id DESC';
        $data = $this->Project_Mod_Model->getList($condition);
        $this->assign('list',$data['data']);
        
        $this->display();
    }
    
    
    public function getghmods(){
        
        $limit = (int)gpc('limit','GP',20);
        $project_id = (int)gpc('project_id','GP',0);
        $user_id = (int)gpc('user_id','GP',0);
        
        $this->load->model('Project_Gh_Mod_Model');
        
        $condition['limit'] = $limit;
        $condition['where']['project_id'] = $project_id;
        $condition['where']['type'] = 'workflow';
        if($user_id){
            $condition['where']['user_id'] = $project_id;
        }
        $condition['order'] = 'id DESC';
        $data = $this->Project_Gh_Mod_Model->getList($condition);
        $this->assign('list',$data['data']);
        
        $this->display();
    }
    
    
    public function getContactsList(){
        
        $q = strtolower($_GET["term"]);
        
        if(!$q){
            $this->sendJson(array());
        }
        
        $this->load->model('Contacts_Model');
        
        $data = $this->Contacts_Model->getList(
            array(
                'select' => 'id,company_name,name,virtual_no,mobile,tel',
                'where' => array('status' => '正常'),
                'like' => array('name' => $q)
            )
        );
        
        //header("Content-Type: text/html;charset=utf-8");
        
        $result = array();
        foreach ($data['data'] as $key => $value) {
            array_push($result, array(
                "id"=>$value['id'], 
                "label"=> $value['name'],
                'c' => $value['company_name'],
                'v' => empty($value['virtual_no']) == true ? '' : $value['virtual_no'], 
                'm' => empty($value['mobile']) == true ? '' : $value['mobile'] ,
                't' => empty($value['tel']) == true ? '' : $value['tel'])
            );
        }

        // json_encode is available in PHP 5.2 and above, or you can install a PECL module in earlier versions
        
        $this->sendJson($result);
    }
    
    
    public function getRegionList(){
        $year = (int)gpc("year","GP",date("Y"));
        $this->load->model("Region_Model");
        $regionList = $this->Region_Model->getList(array(
            'select' => 'code,name',
           'where' => array(
               'year' => $year,
               'status' => '正常'
           )
        ));
        
        
        if($regionList['data']){
            $this->sendJson($regionList['data']);
        }else{
            $this->sendJson(array());
        }
    }
    
    
    /*
     * 
     */
    public function getUserList(){
        
        $q = strtolower($_GET["term"]);
        
        if(!$q){
            $this->sendJson(array());
        }
        
        $this->load->model('User_Model');
        
        $data = $this->User_Model->getList(
            array(
                'select' => 'id,name',
                'where' => array('status' => '正常','id !=' => $_GET['user_id']),
                'like' => array('name' => $q)
            )
        );
        
        //header("Content-Type: text/html;charset=utf-8");
        
        $result = array();
        foreach ($data['data'] as $key => $value) {
            array_push($result, array("id"=>$value['id'], "label"=>$value['name']));
        }

        // json_encode is available in PHP 5.2 and above, or you can install a PECL module in earlier versions
        
        $this->sendJson($result);
    }
    
    
    /**
     * 根据项目流水号获得界址列表 
     */
    public function getJzListByProjectNO(){
        $id = gpc('id','GP','');
        if(empty($id)){
            $this->sendJson(array());
        }
        
        $this->load->model('Project_Jz_Model');
            
        $jzList = $this->Project_Jz_Model->getList(array(
            'where' => array(
                'project_id' => $id
            ),
            'order' => 'direction ASC'
        ));
        
        if($jzList['data']){
            $this->sendJson($jzList['data']);
        }else{
            $this->sendJson(array());
        }
    }
    
    
    public function getLandCategory(){
        
        $this->load->model('Land_Category_Model');
        $cate_name1 = $_GET['cate_name1'];
        $cate_name2 = $_GET['cate_name2'];
        $which = $_GET['which'];
        
        $key = $_GET['key'];
        $condition = array(
            'order' => 'cate_id ASC ,code ASC' 
        );
        
        switch($which){
            case '1':
                $condition['where'] = array(
                    'cate_id' => $cate_name1,
                    'pid' => 0
                );
                break;
            case '2':
                $d = $this->Land_Category_Model->queryById($cate_name2,'code');
                $condition['where'] = array(
                    'pid' => $d['id']
                );
                break;
            default:
                break;
        }
        
        
        $data = $this->Land_Category_Model->getList($condition);
        
        if(!$data['data']){
            $data['data'] = array();
        }
        
        $this->sendJson($data['data']);
        
    }
    
    /**
     * 
     */
    public function getNewMsg(){
        
        $this->load->model('Pm_Model');
        $msgCount = $this->Pm_Model->getCount(array(
           'where' => array(
               'user_id' => (int)gpc('uid','GP',0),
               'isnew' => 1
           )
        ));
        
        $this->sendJson(array('newcount' => $msgCount));
    }
    
    
    public function list_taizhang(){
        
        $project_id = (int)gpc('id','GP',0);
        
        $this->assign('project_id',$project_id);
        $this->display();
    }
}

/* End of file search.php */
/* Location: ./application/controllers/search.php */