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
        $this->load->model('Project_Mod_Model');
        $this->load->model('User_Event_Model');
        $this->load->model('User_Sendor_Model');
    }
    
	public function index()
	{
        /**
         *项目类型 
         */
        $projectTypeList = $this->Project_Type_Model->getList(array('where' => array('status' => '正常','type' => '测绘项目'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$projectTypeList['data']);
        $this->assign('action','index');
        $this->_getPageData();
		$this->display();
	}
    
    private function _getLastOperator($project,$operaion){
        
        switch($operaion){
            case '退回':
                $user = $this->Project_Mod_Model->getList(array(
                    'limit' => 1,
                    'select' => 'project_id,user_id,creator',
                    'where' => array(
                        'project_id' => $project['id'],
                        'action' => str_replace('已','',$project['status']),
                        'type' => 'user'
                    ),
                    'order' => 'createtime DESC'
                ));
                break;
        }
        
        return $user['data'][0];
    }
    
    
    private function _getProjectModList($project_id,$limit = 20, $user_id = 0){
        
       
        $condition['limit'] = $limit;
        $condition['where']['project_id'] = $project_id;
        $condition['where']['type'] = 'user';
        if($user_id){
            $condition['where']['user_id'] = $project_id;
        }
        
        $data = $this->Project_Mod_Model->getList($condition);
        return $data['data'];
    }
    
    
    
    public function dispatchOne(){
        
        $project_id = (int)gpc("id",'GP',0);
        $event_id = (int)gpc('event_id','GP',0);
        
        if(empty($project_id)){
            die("参数错误,请重新请求");
        }
        
        $this->_getSendorList();
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $info = $this->Project_Model->queryById($project_id);
            for($i = 0; $i < 1; $i++){
                $gobackUrl = $_POST['gobackUrl'];
                $op = $_POST['workflow'];
                $eventReaded = false;
                
                
                if($op == '退回'){
                    $this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                }else{
                    $this->form_validation->set_rules('start_date', '开始日期', 'required|valid_date');
                    $this->form_validation->set_rules('end_date', '结束日期', 'required|valid_date');
                    $this->form_validation->set_rules('sendor', '指派人', 'required|is_natural_no_zero');
                }
                
                if(!$this->form_validation->run()){
                    $info['start_date'] = $_POST['start_date'];
                    $info['end_date'] = $_POST['end_date'];
                    break;
                }
                

                if($op == '退回'){
                    $lastUser = $this->_getLastOperator($info,$op);
                    $data = array(
                        'sendor_id' => $lastUser['user_id'],
                        'sendor' => $lastUser['creator'],
                        'status' => $info['last_status'],
                        'sub_status' => $info['last_sub_status'],
                        'last_status' => '',
                        'last_sub_status' => '',
                        'reason' => cut($_POST['reason'],200),
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time()
                    );

                    //file_put_contents("debug.txt",print_r($info,true));
                    //file_put_contents("debug.txt",print_r($data,true),FILE_APPEND);

                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => $info['status']));

                    if($return){
                        $this->_addProjectLog($info['id'],'退回',"{$this->_userProfile['name']} 退回 {$info['project_no']} {$info['name']} 至 {$lastUser['creator']},退回原因:<span class=\"notice\">{$_POST['reason']}</span>",$data);

                        $this->User_Event_Model->add(array(
                            'user_id' => $lastUser['user_id'],
                            'title' => cut($info['name'],100),
                            'url' => url_path('project_ch','edit','id='.$info['id']),
                            'creator' => $this->_userProfile['name']
                        ));

                        $eventReaded = true;
                        $message = '退回成功';
                    }else{
                        //退回失败
                        $message = '退回失败,或许已经被退回';
                    }
                }else{
                    //分派任务

                    //被指派人信息
                    $sendorInfo = $this->User_Model->queryById($_POST['sendor']);

                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已指派',
                        'sub_status' => '',
                        'last_status' => $info['status'],
                        'last_sub_status' => $info['sub_status'],
                        'updator' => $this->_userProfile['name'],
                        'arrange_date' => time(),
                        'start_date' => strtotime($_POST['start_date']),
                        'end_date' => strtotime($_POST['end_date']),
                        'updatetime' => time()
                    );

                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => $info['status']));

                    if($return){
                        $this->_addProjectLog($info['id'],'指派',"{$this->_userProfile['name']} 指派 {$info['project_no']} {$info['name']} 至 {$sendorInfo['name']}",$data);
                        $this->User_Event_Model->add(array(
                            'user_id' => $sendorInfo['id'],
                            'title' => cut($info['name'],100),
                            'url' => url_path('project_ch','task','id='.$info['id']),
                            'creator' => $this->_userProfile['name']
                        ));

                        $eventReaded = true;
                        $message = '指派成功';
                    }else{
                        //退回失败
                        $message = '指派失败,已经被指派';
                    }
                }

                if($eventReaded){
                    $this->User_Event_Model->updateByWhere(array(
                        'isnew' => 0,
                        'status' => '已处理',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time()
                    ),array('id' => $event_id));

                    //刷新
                    $info = $this->Project_Model->queryById($project_id);
                }
            }
            
        }else{
            $info = $this->Project_Model->queryById($project_id);
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $info['event_id'] = $event_id;
        $this->assign('message',$message);
        $this->assign('info',$info);
        $this->assign('modList',$this->_getProjectModList($project_id));
        //print_r($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
        
    }
    
    /**
     * 项目布施
     */
    public function dispatch(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        
        $this->assign('action','dispatch');

        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_ch','index')
        );
        $condition['where'] = array(
            'status !=' => '已删除',
            'sendor_id' => $this->_userProfile['id']
        );

        $data = $this->Project_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        
        
        $this->display('index');
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('input_type', '录入类型', 'required|is_natural');
        $this->form_validation->set_rules('year', '年份', 'required|integer');
        $this->form_validation->set_rules('region_code', '区域', 'required|alpha');
        $this->form_validation->set_rules('type', '登记类型', 'required' );
        $this->form_validation->set_rules('name', '登记名称', 'trim|required|min_length[3]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '登记地址', 'trim|required|min_length[3]|max_length[200]|htmlspecialchars');
        
        if(!empty($_POST['village'])){
            $this->form_validation->set_rules('village', '村名', 'trim|max_length[50]|htmlspecialchars');
        }else{
            $_POST['village'] = trim($_POST['village']);
        }
        
        $this->form_validation->set_rules('contacter', '联系人名称', 'trim|required|max_length[15]|htmlspecialchars');
        $this->form_validation->set_rules('contacter_mobile', '联系人手机', 'trim|required|valid_mobile');
        
        if(!empty($_POST['contacter_tel'])){
            $this->form_validation->set_rules('contacter_tel', '联系人固定电话', 'trim|valid_telephone');
        }else{
            $_POST['contacter_tel'] = trim($_POST['contacter_tel']);
        }
        
        $this->form_validation->set_rules('manager', '接洽人名称', 'trim|required|max_length[15]|htmlspecialchars');
        $this->form_validation->set_rules('manager_mobile', '接洽人手机', 'trim|required|valid_mobile');
        
        if(!empty($_POST['manager_tel'])){
            $this->form_validation->set_rules('manager_tel', '接洽人固定电话', 'trim|valid_telephone');
        }else{
            $_POST['manager_tel'] = trim($_POST['manager_tel']);
        }
        
         if(!empty($_POST['descripton'])){
            $this->form_validation->set_rules('descripton', '备注', 'trim|max_length[300]|htmlspecialchars');
        }else{
            $_POST['descripton'] = trim($_POST['descripton']);
        }
        
        if(trim($_POST['displayorder'])){
            $this->form_validation->set_rules('displayorder', '优先级', 'trim|is_natural|less_than[10]');
        }
    }
    
    
    private function _formatProjectNo($year,$regionCode,$masterSerial,$regionSerial){
        return strtoupper($regionCode).$year."-".$masterSerial."-".strtoupper($regionCode).$regionSerial;
    }
    
    
    /**
     * 详情
     */
    public function detail(){
        
        $id = (int)gpc("id","GP",0);
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die("信息找不到");
        }
        $this->assign('info',$info);
        
        $this->display();
    }
    
    public function delete(){
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            
        }
    }
    
    public function add()
	{
        
        /**
         *登记年份 
         */
        $addYear = gpc("year","GP",date("Y"));
        $this->_initPageData($addYear);
        
        if($this->isPostRequest()){
            $this->assign('info',$_POST);
            $this->_addRules();
            
            if($this->form_validation->run()){
                $this->_add($addYear);
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"创建成功,您需要继续添加吗");
            }else{
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"创建失败,请核对您输入的信息");
            }
        }
        
        $this->display();
		
	}
    
    
    private function _initPageData($addYear){
        
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
        
    }
    
    
    private function _add($year){
         // add
        $_POST['user_id'] = $this->_userProfile['id'];
        $_POST['creator'] = $this->_userProfile['name'];
        $_POST['project_type'] = 0;

        //$this->db->trans_start();
        $master_serial = $this->Project_Model->getMaxByWhere('master_serial',array(
            'year' => $year,
            'project_type' => 0
        ));

        $region_serial = $this->Project_Model->getMaxByWhere('region_serial',array(
            'year' => $year,
            'region_code' => $_POST['region_code'],
            'project_type' => 0
        ));

        $regionName = $this->Region_Model->getList(array(
                'select' => 'name',
                'where' => array(
                    'year' => $year,
                    'code' => $_POST['region_code'],
                    'status' => '正常'
                )
        ));

        if($regionName['data'][0]['name']){
            $_POST['region_name'] = $regionName['data'][0]['name'];
        }else{
            //$_POST['region_name'] = '';
        }
        
        $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
        $_POST['region_serial'] = $region_serial ? $region_serial + 1 : 1;
        $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['region_code'],$_POST['master_serial'],$_POST['region_serial']);
        
        $insertid = $this->Project_Model->add($_POST);
        //$this->db->trans_complete();
        
        $this->_addProjectLog($insertid,'新增',"{$this->_userProfile['name']} 新增项目,项目编号：{$_POST['project_no']}",$_POST);
        return $insertid;
        
    }
    
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            if(!empty($_POST['gobackUrl'])){
                $this->assign('gobackUrl',$_POST['gobackUrl']);
            }
                    
            $this->_addRules();
            if($this->form_validation->run()){
                $info = $this->Project_Model->getById(array('where' => array('id' => $_POST['id'])));
                //比较是否修改过年和区域，如果修改过的话 则用新记录代替
                if($info['year'] != $_POST['year'] || $info['region_code'] != $_POST['region_code']){
                    /**
                     * 新记录建立 
                     */
                    $insertid = $this->_add($_POST['year']);
                    /**
                     * 原记录删除 
                     */
                    $this->Project_Model->fake_delete(array('id' => $_POST['id'],'updator' => $this->_userProfile['name']));
                    $this->_addProjectLog($_POST['id'],'删除',"修改原记录时修改了年或者区域，则原记录{$_POST['name']}删除，新记录id={$insertid}", $_POST, 'system');
                    
                    $info = $this->Project_Model->getById(array('where' => array('id' => $insertid)));
                    
                }else{
                    //直接修改原记录
                    $_POST['master_serial'] = $info['master_serial'];
                    $_POST['region_serial'] = $info['region_serial'];
                    $_POST['updator'] = $this->_userProfile['name'];
                    $this->Project_Model->update($_POST);
                    
                    $this->_addProjectLog($_POST['id'],'修改',"{$this->_userProfile['name']} 修改了 {$info['project_no']} {$_POST['name']}",$_POST);
                    
                    $info = $this->Project_Model->getById(array('where' => array('id' => $_POST['id'])));
                }
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $this->assign('gobackUrl',$_SERVER['HTTP_REFERER']);
            $info = $this->Project_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->_initPageData($info['year']);
        $this->assign('modList',$this->_getProjectModList($info['id']));
        $this->assign('info',$info);
        $this->display('add');
    }
    
    
    
    
    
    
    private function _doSend($action,$ids,$user){
        
       $projectList = $this->Project_Model->getList(array(
            'where_in' => array(
                array(
                    'key' => 'id', 'value' => $ids
                )
            )
        ));

        $projectInfo = array();
        foreach($projectList['data'] as $v){
            $projectInfo[$v['id']] = $v;
        }

        $event = array();
        $failed = array();

        //用 循环，方式批量更新
        foreach($ids as $id){
            $data = array(
                'status' => "已{$action}",
                'sub_status' => '',
                'last_status' => $projectInfo[$id]['status'],
                'last_sub_status' => $projectInfo[$id]['sub_status'],
                'sendor_id' => $user['id'],
                'sendor' => $user['name']
            );
            
            $return = $this->Project_Model->updateByWhere($data,array('id' => $id, 'status' => '新增'));
            if($return){
                $event[] = $projectInfo[$id];
                $this->_addProjectLog($id,$action,"{$this->_userProfile['name']} {$action} {$projectInfo[$id]['project_no']} {$projectInfo[$id]['name']} 至 {$user['name']}",$data);
            }else{
                $failed[] = $projectInfo[$id];
            }
        }
        
        /**
         * @todo add 
         */
        if($event){
            foreach($event as $value){
                $this->User_Event_Model->add(array(
                    'user_id' => $user['id'],
                    'title' => cut($value['name'],100),
                    'url' => url_path('project_ch','dispatchOne','id='.$value['id']),
                    'creator' => $this->_userProfile['name']
                ));
            }
        }
        
        return array('success' => $event, 'failed' => $failed);
    }
    
    /**
     * 退回 
     */
    public function tuihui(){
        $ids =  gpc('id','GP',array());
        if(empty($ids)){
            die("参数错误,请重新请求");
        }
        if(!is_array($ids)){
            $ids = (array)$ids;
        }
        
        $this->assign("id",$ids);
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            
            $this->assign('reload',0);
            $this->assign('message','测试');
            $this->display('showMessage','common');
            
        }else{
            $projectList = $this->Project_Model->getList(array(
                'where_in' => array(
                    array(
                        'key' => 'id', 'value' => $ids
                    )
                )
            ));
            
            $this->assign('projectList',$projectList['data']);
            $this->display();
        }
    }
    
    
    public function send(){
        
        $ids =  gpc('id','GP',array());
        if(empty($ids)){
            die("参数错误,请重新请求");
        }
        
        if(!is_array($ids)){
            $ids = (array)$ids;
        }
        
        $this->assign("id",$ids);
        if($this->isPostRequest() && !empty($_POST['sendor'])){
            $user = $this->User_Model->queryById($_POST['sendor']);
            $result = $this->_doSend('发送',$ids, $user );
            
            //file_put_contents("debug.txt",print_r($_POST,true));
            //file_put_contents("debug.txt",print_r($user,true),FILE_APPEND);
            
            $message = array();
            $reload = 0;
            if($result['success']){
                foreach($result['success'] as $v){
                    $message[] = '<p class="success">' . $v['project_no'] .'发送成功</p>';
                }
                $reload = 1;
            }else{
                foreach($result['failed'] as $v){
                    $message[] = '<p class="failed">' . $v['project_no'] .'发送失败，可能已经被发送</p>';
                }
            }
            $this->assign('reload',$reload);
            $this->assign('message','<div class="pd20">'.implode('',$message).'</div>');
            $this->display('showMessage','common');
            
        }else{
            
            $this->_getSendorList();
            $this->display();
        }
    }
    
    private function _getSendorList(){
        $userSendorList = $this->User_Sendor_Model->getList(array(
            'where' => array(
                'user_id' => $this->_userProfile['id']
                )
            )
        );
        $this->assign('userSendorList',$userSendorList['data']);
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
                'query_param' => url_path('project_ch','index')
            );
            if(!empty($_GET['name'])){
                $condition['like'] = array('name' => $_GET['name']);
            }
            $condition['where'] = array(
                'status !=' => '已删除'
            );
            
            if(!empty($_GET['type'])){
                $condition['where']['type'] = $_GET['type'];
            }
            
            if($_GET['view'] == 'my'){
                $condition['where']['user_id'] = $this->_userProfile['id'];
            }
            
            $data = $this->Project_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
