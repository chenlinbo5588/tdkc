<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cron extends CI_Controller {

	
    public function __construct(){
        parent::__construct();
        
        if(!$this->input->is_cli_request()){
            die();
        }
    }
    
    /**
     * 合同 到期提醒他
     */
	public function index()
	{
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
    
    /**
     * 新的一年，默认初始化上一年的乡镇数据
     */
    public function region(){
        
        
        $current_year = date("Y");
        $last_year = $current_year - 1;
        
        $this->load->model('Region_Model');
        
        $last_regions = $this->Region_Model->getList(array(
           'where' => array(
               'year' => $last_year,
               'status' => '正常'
           ) 
        ));

        if(empty($last_regions['data'])){
            foreach($last_regions['data'] as $region){
                $this->Region_Model->add(array(
                    'code' => $region['code'],
                    'name' => $region['name'],
                    'year' => $current_year,
                    'displayorder' => $region['displayorder'],
                    'creator' => '后台任务',
                    'updator' => '后台任务',
                ));
            }
        }
    }
    
    public function clean_zb_trans(){
        $this->load->model('Zb_Trans_Model');
        $this->Zb_Trans_Model->deleteByWhere(array(
            'createtime <' => time()
        ));
    }
}
/* End of file cron.php */
/* Location: ./application/controllers/cron.php */