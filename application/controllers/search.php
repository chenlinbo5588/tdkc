<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Search extends TZ_Controller {

	public function index()
	{
		die(0);
	}
    
    public function getProjectModList(){
        
        $limit = (int)gpc('limit','GP',20);
        $project_id = (int)gpc('project_id','GP',0);
        $user_id = (int)gpc('user_id','GP',0);
        
        $condition['limit'] = $limit;
        $condition['where']['project_id'] = $project_id;
        $condition['where']['type'] = 'user';
        if($user_id){
            $condition['where']['user_id'] = $project_id;
        }
        
        $data = $this->Project_Mod_Model->getList($condition);
        
        $this->assign('list',$data['data']);
        
        $this->display();
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
            echo json_encode($regionList['data']);
        }else{
            echo json_encode(array());
        }
    }
    
    
    /*
     * 
     */
    public function getUserList(){
        
        $q = strtolower($_GET["term"]);
        
        if(!$q){
            echo json_encode(array());
            $q = '';
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
        echo json_encode($result);
    }
    
    
    public function getLandCategory(){
        
        $this->load->model('Land_Category_Model');
        $cate_name1 = $_GET['cate_name1'];
        $cate_name2 = $_GET['cate_name2'];
        $which = $_GET['which'];
        
        $key = $_GET['key'];
        $condition = array(
            'order' => 'cate_id ASC ,createtime ASC' 
        );
        
        switch($which){
            case '1':
                $condition['where'] = array(
                    'cate_name' => $cate_name1,
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
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */