<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 测绘项目管理 
 */
class project_gh extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Type_Model');
        $this->load->model('Project_Gh_Model');
        $this->load->model('Project_Gh_Mod_Model');
        $this->load->model('User_Event_Model');
        $this->load->model('User_Sendor_Model');
        
        $this->load->helper('number');
    }
    
    protected function _addProjectLog($type,$project_id,$action,$content,$userData = array()){
        //记录日志
        $this->Project_Gh_Mod_Model->add(
            array(
                'project_id' => $project_id,
                'user_id' => $this->_userProfile['id'],
                'type' => $type,
                'action' => $action,
                'creator' => "{$this->_userProfile['name']}",
                'content' => cut($content, 100, true),
                'user_data' => json_encode($userData)
            )
        );
    }
    
    
	public function index()
	{
        $projectTypeList = $this->Project_Type_Model->getList(array('where' => array('status' => '正常','type' => '规划项目'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$projectTypeList['data']);
        $this->assign('action','index');
        $this->_getPageData();
		$this->display();
	}
    
    /**
     * 获得上次
     * @param type $project
     * @param type $operaion
     * @return type 
     */
    private function _getLastOperator($project,$operaion){
        
        $user = $this->Project_Gh_Mod_Model->getList(array(
            'limit' => 1,
            'select' => 'project_id,user_id,creator',
            'where' => array(
                'project_id' => $project['id'],
                'action' => $operaion,
                'type !=' => 'system'
            ),
            'order' => 'createtime DESC'
        ));
        
        return $user['data'][0];
    }
    
    
    private function _getProjectModList($project_id,$type = 'workflow',$limit = 50, $user_id = 0){
        
        $condition['limit'] = $limit;
        $condition['where']['project_id'] = $project_id;
        $condition['where']['type'] = $type;
        if($user_id){
            $condition['where']['user_id'] = $project_id;
        }
        
        $data = $this->Project_Gh_Mod_Model->getList($condition);
        return $data['data'];
    }
    
    
    
    /**
     * 项目日志 
     */
    public function log(){
        $project_id = (int)gpc("id",'GP',0);
        
        if(empty($project_id)){
            die("参数错误,请重新请求");
        }
        $info = $this->Project_Gh_Model->queryById($project_id);
        if($this->isPostRequest() && !empty($_POST['id'])){
            if(!empty($_POST['logcontent'])){
                $this->_addProjectLog('worklog', $_POST['id'],'添加',$_POST['logcontent']);
                $this->sendFormatJson('success', array('text' => '添加成功','wait' => 2), array('jsReload' => 1, 'url' => ''));
            }else{
                $this->sendFormatJson('failed', array('text' => '添加失败','wait' => 2), array('jsReload' => 1, 'url' => ''));
            }
        }
        
        $this->assign('worklog',$this->_getProjectModList($project_id,'worklog'));
        $this->assign('info',$info);
        $this->display();
    }
    
    
    /**
     * 测量组任务 处理，退回还是 其他操作
     */
    public function task(){
        
        $project_id = (int)gpc("id",'GP',0);
        $event_id = (int)gpc('event_id','GP',0);
        
        if(empty($project_id)){
            die("参数错误,请重新请求");
        }
        
        $this->_getSendorList();
        $this->load->model('Attachment_Model');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $info = $this->Project_Gh_Model->queryById($project_id);
            for($i = 0; $i < 1; $i++){
                $gobackUrl = $_POST['gobackUrl'];
                $op = $_POST['workflow'];
                
                if(!empty($_POST['file_id'])){
                    $this->assign('files',$this->_getFiles($_POST['file_id']));
                }
                
                if($op == '退回'){
                    $this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                    if($info['status'] == '已发送'){
                        $lastOpName = '新增';//前面那个操作名称
                        $lastStatus = '新增';
                        
                    }elseif($info['status'] == '已布置'){
                        $lastOpName = '布置';
                        $lastStatus = '已发送';
                        
                    }elseif($info['status'] == '已实施'){
                        $lastOpName = '布置';
                        $lastStatus = '已发送';
                        
                    }elseif($info['status'] == '已完成'){
                        $lastOpName = '实施';
                        $lastStatus = '已实施';
                        
                    }elseif($info['status'] == '已提交初审'){
                        $lastOpName = '完成';
                        $lastStatus = '已完成';
                        
                    }elseif($info['status'] == '已通过初审'){
                        $lastOpName = '完成';
                        $lastStatus = '已完成';
                    }elseif($info['status'] == '已提交复审'){
                        $lastOpName = '通过初审';
                        $lastStatus = '已通过初审';
                        
                    }elseif($info['status'] == '已通过复审'){
                        $lastOpName = '通过初审';
                        $lastStatus = '已通过初审';
                        
                    }elseif($info['status'] == '已提交'){
                        $lastOpName = '通过复审';
                        $lastStatus = '已通过复审';
                    }
                    
                }elseif($op == '发送'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if(!$this->form_validation->run()){
                        break;
                    }
                }elseif($op == '布置'){
                    $this->form_validation->set_rules('start_date', '开始日期', 'required|valid_date');
                    $this->form_validation->set_rules('end_date', '结束日期', 'required|valid_date');
                    $this->form_validation->set_rules('bz_remark', '布置备注', 'required|min_length[2]|max_length[100]');
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    
                    if(!$this->form_validation->run()){
                        $info['start_date'] = $_POST['start_date'];
                        $info['end_date'] = $_POST['end_date'];
                        $info['bz_remark'] = $_POST['bz_remark'];
                        break;
                    }
                    
                }elseif($op == '实施'){
                    $this->form_validation->set_rules('ny_enddate', '内业完成时间', 'required|valid_date');
                    $this->form_validation->set_rules('wy_enddate', '外业完成时间', 'required|valid_date');
                    $this->form_validation->set_rules('ss_remark', '实施备注', 'required|min_length[2]|max_length[100]');
                    
                    if(!$this->form_validation->run()){
                        $info['ny_enddate'] = $_POST['ny_enddate'];
                        $info['wy_enddate'] = $_POST['wy_enddate'];
                        $info['ss_remark'] = $_POST['ss_remark'];
                        break;
                    }
                    
                }elseif($op == '完成'){
                    $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if(!$this->form_validation->run()){
                        break;
                    }
                    
                }elseif($op == '提交初审'){
                    $this->form_validation->set_rules('zc_yj', '自查意见', 'required|max_length[300]');
                    $this->form_validation->set_rules('zc_remark', '自查修改和处理意见', 'required|max_length[300]');
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if(!$this->form_validation->run()){
                        break;
                    }
                    
                }elseif($op == '通过初审'){
                    $this->form_validation->set_rules('cs_yj', '初审意见', 'required|max_length[300]');
                    $this->form_validation->set_rules('cs_remark', '初审修改和处理意见', 'required|max_length[300]');
                    
                    $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    if(!$this->form_validation->run()){
                        break;
                    }
                }elseif($op == '提交复审'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    
                    if(!$this->form_validation->run()){
                        break;
                    }
                }elseif($op == '通过复审'){
                    $this->form_validation->set_rules('fs_yj', '复审意见', 'required|max_length[300]');
                    $this->form_validation->set_rules('fs_remark', '复审修改和处理意见', 'required|max_length[300]');
                    
                    $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    if(!$this->form_validation->run()){
                        break;
                    }
                }elseif($op == '提交'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    $this->form_validation->set_rules('title', '项目成功名称', 'required|min_length[3]|max_length[200]');
                    $this->form_validation->set_rules('area', '项目面积', 'required|greater_than[0]|numeric');
                    if(!$this->form_validation->run()){
                        $info['title'] = $_POST['title'];
                        break;
                    }
                }elseif($op == '提交收费'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    $this->form_validation->set_rules('has_doc', '成果资料是否形成', 'required|is_natural_no_zero');
                    
                    if(!$this->form_validation->run()){
                        $info['has_doc'] = $_POST['has_doc'];
                        break;
                    }
                }
                
                $_POST['event_id'] = $event_id;
                $message = $this->_doWorkFlow($info, $_POST, $op, $lastOpName,$lastStatus);
                
                $info = $this->Project_Gh_Model->queryById($project_id);
            }
            
        }else{
            $info = $this->Project_Gh_Model->queryById($project_id);
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            if(!empty($info['files'])){
                $this->assign('files',$this->_getFiles($info['files']));
            }
        }
        
        if(empty($message)){
            $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
        }
        
        
        $status = array(
            '新增' , '发送' ,'布置', '实施','完成','提交初审','通过初审',  '提交复审', '通过复审', '提交','提交收费','归档'
        );
        
        $statusKey = array_keys($status);
        $currentKey = 0;
        
        //print_r($statusKey);
        foreach($statusKey as $v){
            if($status[$v] == str_replace('已','',$info['status'])){
                $currentKey = $v + 1;
            }
        }

        $statusHtml = array();
        foreach($status as $k => $v){
            if($k < $currentKey){
                $statusHtml[] = '<span class="status statusover">'.$v."</span>";
                
            }elseif($k == $currentKey){
                $statusHtml[] = '<span class="status current">'.$v."</span>";
                
            }else{
                $statusHtml[] = '<span class="status">'.$v."</span>";
            }
        }
        
        $this->assign('statusHtml',$statusHtml);
        
        $info['event_id'] = $event_id;
        $this->assign('message',$message);
        $this->assign('info',$info);
        $this->assign('modList',$this->_getProjectModList($project_id));
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
        
    }
    
    private function _getFiles($param){
        
        if(is_string($param)){
            $param = explode(',',$param);
        }
        
        $this->load->model('Attachment_Model');
        $hasFiles = $this->Attachment_Model->getList(array(
            'select' => 'id,file_name,file_size',
            'where_in' => array(
                array('key' => 'id', 'value' => $param)
            )
        ));
        
        return $hasFiles['data'];
        
    }
    
    private function _doWorkFlow($info,$param, $op, $gobackStatus, $lastStatus){
        $eventReaded = false;
        $pm = false;
        $sendorInfo = null;
        
        
        if($op == '退回'){
            $lastUser = $this->_getLastOperator($info,$gobackStatus);
            
            $data = array(
                'sendor_id' => $lastUser['user_id'],
                'sendor' => $lastUser['creator'],
                'status' => $lastStatus,
                'reason' => cut($param['reason'],200),
                'updator' => $this->_userProfile['name'],
                'updatetime' => time()
            );

            //file_put_contents("debug.txt",print_r($info,true));
            //file_put_contents("debug.txt",print_r($data,true),FILE_APPEND);

            $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => $info['status'],'sendor_id' => $this->_userProfile['id']));

            if($return){
                $this->_addProjectLog('workflow', $info['id'],'退回',"{$this->_userProfile['name']} 退回 {$info['project_no']} {$info['name']} 至 {$lastUser['creator']},退回原因:<span class=\"notice\">{$param['reason']}</span>",$data);
                switch($gobackStatus){
                    case '新增':
                        $url = url_path('project_gh','edit','id='.$info['id']);
                        break;
                    default:
                        $url = url_path('project_gh','task','id='.$info['id']);
                        break;
                }
                
                /**
                 * @todo delete old project event 
                 */
                $this->User_Event_Model->add(array(
                    'project_id' => $info['id'],
                    'user_id' => $lastUser['user_id'],
                    'title' => cut($info['name'],100),
                    'url' => $url,
                    'creator' => $this->_userProfile['name']
                ));

                $eventReaded = true;
                $message = '退回成功';
            }else{
                //退回失败
                $message = '退回失败,或许已经被退回';
            }
        }else{
            switch($op){
                case '发送':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time()
                    );
                    
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '新增','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']} 至 {$sendorInfo['name']}",$data);
                        $pm = true;
                        $eventReaded = true;
                    }
                    break;
                
                case '布置':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'pm_id' => $sendorInfo['id'],
                        'pm' => $sendorInfo['name'],
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'arrange_date' => time(),
                        'start_date' => strtotime($param['start_date']),
                        'end_date' => strtotime($param['end_date']),
                        'updatetime' => time(),
                        'bz_remark' => $param['bz_remark']
                    );
                    
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已发送','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']} 至 {$sendorInfo['name']}",$data);
                        $pm = true;
                        $eventReaded = true;
                    }
                    break;
                case '实施':
                    //实施任务
                    $data = array(
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        /** 实际实施的人 */
                        'worker_id' => $this->_userProfile['id'],
                        'worker' => $this->_userProfile['name'],
                        'dept_id' => $this->_userProfile['dept_id'],
                        'real_startdate' => time(),
                        'ny_enddate' => strtotime($_POST['ny_enddate']),
                        'wy_enddate' => strtotime($_POST['wy_enddate']),
                        'updatetime' => time(),
                        'ss_remark' => $param['ss_remark']
                    );

                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已布置','sendor_id' => $this->_userProfile['id']));
                    
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']}",$data);
                        $eventReaded = true;
                    }
                    
                    break;
                case '完成':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'real_enddate' => time(),
                        'updatetime' => time(),
                        'files' => implode(',',$param['file_id'])
                    );
                    
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已实施','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']} 并发送至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    
                    break;
                case '提交初审':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time(),
                        'zc_time' => time(),
                        'zc_name' => $this->_userProfile['name'],
                        'zc_yj' => $param['zc_yj'],
                        'zc_remark' => $param['zc_remark'],
                        'files' => implode(',',$param['file_id'])
                    );
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已完成','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']} 并发送至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    break;
                case '通过初审':
                    $data = array(
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time(),
                        'cs_time' => time(),
                        'cs_name' => $this->_userProfile['name'],
                        'cs_yj' => $param['cs_yj'],
                        'cs_remark' => $param['cs_remark'],
                    );
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']}",$data);
                        $eventReaded = true;
                    }
                    break;
                case '提交复审':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time(),
                        'files' => implode(',',$param['file_id'])
                    );
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已通过初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']} 并发送至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    break;
                case '通过复审':
                    $data = array(
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time(),
                        'fs_time' => time(),
                        'fs_name' => $this->_userProfile['name'],
                        'fs_yj' => $param['fs_yj'],
                        'fs_remark' => $param['fs_remark'],
                    );
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']}",$data);
                        $eventReaded = true;
                    }
                    break;
                case '提交':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'title' => $param['title'],
                        'area' => $param['area'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => time()
                    );
                    
                    $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已通过复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} {$info['project_no']} {$info['name']} 并发送至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    
                    break;
                case '收费':
                    /**
                     * @todo 待完成  
                     */
                    
                    break;
                default:
                    break;
            }
        }
        
        if($return){
            $message = '操作成功';
        }else{
            $message = '操作失败,请检查项目状态';
        }

        
        if($pm && $sendorInfo['id']){
            $this->User_Event_Model->add(array(
                'project_id' => $info['id'],
                'user_id' => $sendorInfo['id'],
                'title' => cut($info['name'],100),
                'url' => url_path('project_gh','task','id='.$info['id']),
                'creator' => $this->_userProfile['name']
            ));
        }
        
        
        if($eventReaded && $param['event_id']){
            $this->User_Event_Model->updateByWhere(array(
                'isnew' => 0,
                'status' => '已处理',
                'updator' => $this->_userProfile['name'],
                'updatetime' => time()
            ),array('id' => $param['event_id']));
        }
        
        return $message;
    }

    /**
     * 项目发送
     */
    public function send(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        
        $this->assign('action','send');

        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_gh','index')
        );
        $condition['where'] = array(
            'status' => '新增',
            'sendor_id' => $this->_userProfile['id']
        );

        $data = $this->Project_Gh_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        
        
        $this->display('index');
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
            'query_param' => url_path('project_gh','index')
        );
        $condition['where'] = array(
            'status' => '已发送',
            'sendor_id' => $this->_userProfile['id']
        );

        $data = $this->Project_Gh_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        
        
        $this->display('index');
    }
    
    
    /**
     * 项目实施
     */
    public function implement(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        $this->assign('action','implement');

        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_gh','index')
        );
        $condition['where'] = array(
            'sendor_id' => $this->_userProfile['id']
        );
        
        $condition['where_in'] = array(
            array('key' => 'status' ,'value' => array('已布置','已实施','已提交'))
        );

        $data = $this->Project_Gh_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        
        $this->display('index');
    }
    
     /**
     * 项目检查 
     */
    public function check(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        $this->assign('action','check');

        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_gh','index')
        );
        $condition['where'] = array(
            'sendor_id' => $this->_userProfile['id']
        );
        
        $condition['where_in'] = array(
            array('key' => 'status' ,'value' => array('已完成'))
        );

        $data = $this->Project_Gh_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        
        $this->display('index');
    }
    
    
    /**
     * 初审 
     */
    public function first_sh(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        $this->assign('action','first_sh');
        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['where'] = array(
            'sendor_id' => $this->_userProfile['id']
        );
        
        $condition['where_in'] = array(
          array('key' => 'status' ,'value' => array('已提交初审','已通过初审'))  
        );
        
        
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_gh','index')
        );

        $data = $this->Project_Gh_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        $this->display('index');
    }
    
    /**
     * 复审 
     */
    public function second_sh(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        $this->assign('action','second_sh');
        
        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['where'] = array(
            'sendor_id' => $this->_userProfile['id']
        );
        
        
        $condition['where_in'] = array(
          array('key' => 'status' ,'value' => array('已通过复审','已提交复审'))  
        );
        
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_gh','index')
        );

        $data = $this->Project_Gh_Model->getList($condition);
        $this->assign('page',$data['pager']);
        $this->assign('data',$data);
        $this->display('index');
    }
    
    
    /**
     * 收费 
     */
    public function fee(){
        
        if(empty($_GET['page'])){
            $_GET['page'] = 1;
        }
        
        $this->assign('action','fee');
        //$condition['select'] = 'a,b';
        $condition['order'] = "createtime DESC,displayorder DESC";
        $condition['where'] = array(
            'status' => '已提交'
        );
        
        $condition['pager'] = array(
            'page_size' => config_item('page_size'),
            'current_page' => $_GET['page'],
            'query_param' => url_path('project_gh','index')
        );

        $data = $this->Project_Gh_Model->getList($condition);
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
        $this->form_validation->set_rules('address', '登记地址', 'trim|required|min_length[2]|max_length[200]|htmlspecialchars');
        
        if(!empty($_POST['village'])){
            $this->form_validation->set_rules('village', '村名', 'trim|max_length[50]|htmlspecialchars');
        }else{
            $_POST['village'] = trim($_POST['village']);
        }
        
        if(!empty($_POST['union_name'])){
            $this->form_validation->set_rules('union_name', '联系单位名称', 'trim|max_length[200]|htmlspecialchars');
        }else{
            $_POST['union_name'] = trim($_POST['union_name']);
        }
        
        if(!empty($_POST['source'])){
            $this->form_validation->set_rules('source', '项目来源', 'trim|max_length[50]|htmlspecialchars');
        }else{
            $_POST['source'] = trim($_POST['source']);
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
        $info = $this->Project_Gh_Model->queryById($id);
        
        if(!$info){
            die("信息找不到");
        }
        $this->assign('info',$info);
        
        $this->display();
    }
    
    
    /**
     * @todo delete 
     */
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
        $projectTypeList = $this->Project_Type_Model->getList(array('where' => array('status' => '正常','type' => '规划项目'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$projectTypeList['data']);
        
        $this->assign('yearList',yearList());
        $this->assign('monthList',range(1,12));
        
    }
    
    
    private function _add($year){
         // add
        $_POST['user_id'] = $this->_userProfile['id'];
        $_POST['creator'] = $this->_userProfile['name'];

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
            $_POST['region_name'] = '';
        }
        
        
        $insertid = $this->Project_Gh_Model->add($_POST);
        
        $this->_addProjectLog('workflow', $insertid,'新增',"{$this->_userProfile['name']} 新增项目,项目编号：{$_POST['project_no']}",$_POST);
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
                $info = $this->Project_Gh_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $_POST['updator'] = $this->_userProfile['name'];
                $this->Project_Gh_Model->update($_POST);

                $this->_addProjectLog('system', $_POST['id'],'修改',"{$this->_userProfile['name']} 修改了 {$info['project_no']} {$_POST['name']}",$_POST);

                $info = $this->Project_Gh_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $this->assign("feedback", "success");
                $this->assign('feedMessage',"修改成功");
            }else{
                $info = $_POST;
                $this->assign("feedback", "failed");
                $this->assign('feedMessage',"修改失败,请核对您输入的信息");
            }
        }else{
            $this->assign('gobackUrl',$_SERVER['HTTP_REFERER']);
            $info = $this->Project_Gh_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->_initPageData($info['year']);
        $this->assign('modList',$this->_getProjectModList($info['id']));
        $this->assign('info',$info);
        $this->display('add');
    }
    
    
    
    
    
    
    private function _doSend($action,$ids,$user){
        
       $projectList = $this->Project_Gh_Model->getList(array(
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
                'sendor_id' => $user['id'],
                'sendor' => $user['name'],
                'reason' => ''
            );
            
            $return = $this->Project_Gh_Model->updateByWhere($data,array('id' => $id, 'status' => '新增'));
            if($return){
                $event[] = $projectInfo[$id];
                $this->_addProjectLog('workflow', $id,$action,"{$this->_userProfile['name']} {$action} {$projectInfo[$id]['project_no']} {$projectInfo[$id]['name']} 至 {$user['name']}",$data);
            }else{
                $failed[] = $projectInfo[$id];
            }
        }
        
        if($event){
            foreach($event as $value){
                $this->User_Event_Model->add(array(
                    'project_id' => $value['id'],
                    'user_id' => $user['id'],
                    'title' => cut($value['name'],100),
                    'url' => url_path('project_gh','task','id='.$value['id']),
                    'creator' => $this->_userProfile['name']
                ));
            }
        }
        
        return array('success' => $event, 'failed' => $failed);
    }
    
    
    public function sendOne(){
        
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
                'query_param' => url_path('project_gh','index')
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
            
            $data = $this->Project_Gh_Model->getList($condition);
            $this->assign('page',$data['pager']);
            $this->assign('data',$data);
            
        }catch(Exception $e){
            //@todo error code here
        }
        
    }
    
}
