<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Search extends TZ_Controller {

	public function index()
	{
		die(0);
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
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */