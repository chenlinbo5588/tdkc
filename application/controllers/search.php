<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Search extends TZ_Admin_Controller {

	public function index()
	{
        
		die(0);
        
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
                'where' => array('status' => '正常','id !=' => $this->_userProfile['id']),
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