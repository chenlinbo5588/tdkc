<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cron extends CI_Controller {

	
    /**
     * 合同 到期提醒他
     */
	public function index()
	{
        
        if(!$this->input->is_cli_request()){
            die();
        }
        
        $this->load->model('User_Model');
        $this->load->model('Pm_Model');
        
		$userList = $this->User_Model->getList(array(
            'where' => array(
                'status' => '正常',
                'id !=' => 1
            )
        ));
        
        /**
         * 提前半个月通知 
         */
        $now = time();
        $halfMonthLater  = $now +  + 86400 * 15;
        $notifyUser = array( "杨丽敏" => 12 );
        //$notifyUser = array( "陈林波" => 61 );
        
        $content = array();
        foreach($userList['data'] as $user){
            
            if(!empty($user['contract_end'])){
                $contract_end = strtotime($user['contract_end']);
                
                if($contract_end){
                    
                    if($contract_end <= $now ){
                        //过期的合同
                        //$content[] = "<p>{$user['name']} 合同即将到期，请注意查看合同详情</p>";
                    }else if($halfMonthLater > $contract_end){
                        $content[] = "<p>{$user['name']} 合同即将到期，请注意查看合同详情</p>";
                    }
                    
                    
                }
            }
        }
        
        $param['title'] = "【合同到期提醒】";
        print_r($content);
        if($content){
            $param['content'] = implode('',$content);
            $param['creator'] = "系统通知";
            
            foreach($notifyUser as $key => $notify){
                $param['to_user_id'] = $notify;
                $param['to_user_name'] = $key;
                $this->Pm_Model->add($param);
            }
        }
	}
}

/* End of file cron.php */
/* Location: ./application/controllers/cron.php */