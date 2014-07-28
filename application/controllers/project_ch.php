<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 测绘项目管理 
 */
class project_ch extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Type_Model');
        $this->load->model('Project_Nature_Model');
        $this->load->model('Project_Model');
        $this->load->model('Project_Mod_Model');
        $this->load->model('User_Event_Model');
        $this->load->model('User_Sendor_Model');
        $this->load->model('Taizhang_Model');
        
        $this->load->helper('number');
    }
    
    
    protected function _addProjectLog($type,$project_id,$action,$content,$userData = array()){
        //记录日志
        $this->Project_Mod_Model->add(
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
        
        /**
         *登记年份 
         */
        $addYear = gpc("year","GP",date("Y"));
        $this->_initPageData($addYear);
        
        $this->_getSendorList(array(
            'ch_workflow' => 'y'
        ));
        
        /**
         *项目类型 
         */
        //$projectTypeList = $this->Project_Type_Model->getList(array('order' => 'displayorder DESC ,createtime ASC'));
        //$this->assign('projectTypeList',$projectTypeList['data']);
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
        
        $user = $this->Project_Mod_Model->getList(array(
            'limit' => 1,
            'select' => 'project_id,user_id,creator',
            'where' => array(
                'project_id' => $project['id'],
                'action' => $operaion,
                'type' => 'workflow'
            ),
            'order' => 'createtime DESC'
        ));
        
        return $user['data'][0];
    }
    
    
    private function _getProjectModList($project_id,$type = 'workflow',$limit = 0, $user_id = 0){
        
        if($limit){
            $condition['limit'] = $limit;
        }
        
        $condition['where']['project_id'] = $project_id;
        $condition['where']['type'] = $type;
        $condition['order'] = 'id DESC';
        if($user_id){
            $condition['where']['user_id'] = $project_id;
        }
        
        $data = $this->Project_Mod_Model->getList($condition);
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
        $info = $this->Project_Model->queryById($project_id);
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
    
    public function savejzb(){
        $project_id = (int)gpc("id",'GP',0);
        
        if($this->isPostRequest() && !empty($_POST['id'])){

            $info = $this->Project_Model->queryById($project_id);
            if(empty($info)){
                $this->sendFormatJson('failed', array('text' => '参数错误，项目不存在'));
            }
            
            $param = $_POST;
            $this->load->model('Project_Jz_Model');
            $this->Project_Jz_Model->deleteByWhere(array(
                'project_id' => $info['id']
            ));

            $insertData = array();

            if(!empty($param['direction'])){
                foreach($param['direction'] as $key => $val){
                    $insertTime = time();

                    $insertData[] = array(
                        'project_id' => $info['id'],
                        'direction' => $val,
                        'name' => !empty($param['jz_name'][$key]) ? $param['jz_name'][$key] : '',
                        'neighbor' => !empty($param['neighbor'][$key]) ? $param['neighbor'][$key] : '',
                        'creator' => $this->_userProfile['name'],
                        'updator' => $this->_userProfile['name'],
                        'createtime' => $insertTime,
                        'updatetime' => $insertTime
                    );
                }

                $this->Project_Jz_Model->batchInsert($insertData);
            }

            $this->sendFormatJson('success', array('text' => '保存成功'));
        }else{
            $this->sendFormatJson('failed', array('text' => '参数错误,请重新请求'));
        }
        
    }
    
    
    /**
     *  保存变更表
     */
    public function savebgb(){
        $project_id = (int)gpc("id",'GP',0);
        
        $reload = false;
        if(empty($project_id)){
            $message = "参数错误,请重新请求";
        }else{
            
            for($i = 0; $i < 1; $i++){
                $info = $this->Taizhang_Model->queryById($project_id);

                if(!$info){
                    $message = "保存失败,找不到记录";
                    break;
                }
                /*
                if(!in_array($this->_userProfile['id'] , array($info['worker_id'],$info['pm_id']))){
                    $message = '保存失败,您无权保存，只有项目负责人和实施人才能保存';
                    break;
                }
                */
                $this->load->model('Project_Bgb_Model');
                
                $this->Project_Bgb_Model->deleteByWhere(array(
                    'type' => 0,
                    'project_id' => $info['id']
                ));
                $_POST['type'] = 0;
                $_POST['project_id'] = $info['id'];
                $_POST['creator'] = $this->_userProfile['name'];
                $this->Project_Bgb_Model->add($_POST);
                
                $message = '保存成功';
            }
        }
        
        $this->assign('message',$message);
        $this->display('showmessage','common');
        
    }
    
    
    /**
     *  推荐方式 保存界址表
     */
    public function savefastjzb(){
        $project_id = (int)gpc("id",'GP',0);
        
        $reload = false;
        if(empty($project_id)){
            $message = "参数错误,请重新请求";
        }else{
            
            for($i = 0; $i < 1; $i++){
                $info = $this->Taizhang_Model->queryById($project_id);

                if(!$info){
                    $message = "保存失败,找不到记录";
                    break;
                }
                
                /*
                if(!in_array($this->_userProfile['id'] , array($info['worker_id'],$info['pm_id']))){
                    $message = '保存失败,您无权保存，只有项目负责人和实施人才能保存';
                    break;
                }
                */
                
                $this->load->model('Project_Jzb_Model');
                
                $this->Project_Jzb_Model->deleteByWhere(array(
                    'type' => 0,
                    'project_id' => $info['id']
                ));
                $_POST['type'] = 0;
                $_POST['project_id'] = $info['id'];
                $_POST['creator'] = $this->_userProfile['name'];
                $this->Project_Jzb_Model->add($_POST);
                
                $message = '保存成功';
            }
        }
        
        $this->assign('message',$message);
        $this->display('showmessage','common');
        
    }
    
    /**
     * 保存面积表 
     */
    public function savemjb(){
        $project_id = (int)gpc("id",'GP',0);
        
        $reload = false;
        if(empty($project_id)){
            $message = "参数错误,请重新请求";
        }else{
            
            for($i = 0; $i < 1; $i++){
                $info = $this->Taizhang_Model->queryById($project_id);

                if(!$info){
                    $message = "保存失败,找不到记录";
                    break;
                }
                /*
                if(!in_array($this->_userProfile['id'] , array($info['worker_id'],$info['pm_id']))){
                    $message = '保存失败,您无权保存，只有项目负责人和实施人才能保存';
                    break;
                }
                */
                //if(!preg_match("/<div class=\"mjb\">/", $_POST['mjb'])){
                    //$message = '保存失败,没有发现面积表';
                    //break;
                //}
                
                $this->load->model('Project_Area_Model');
                
                $this->Project_Area_Model->deleteByWhere(array(
                    'type' => 0,
                    'project_id' => $info['id']
                ));
                $_POST['type'] = 0;
                $_POST['project_id'] = $info['id'];
                $_POST['creator'] = $this->_userProfile['name'];
                $this->Project_Area_Model->add($_POST);
                
                $message = '保存成功';
            }
            
        }
        
        $this->assign('message',$message);
        $this->display('showmessage','common');
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
        
        
        $this->load->model('Attachment_Model');
        if($this->isPostRequest() && !empty($_POST['id'])){
            $info = $this->Project_Model->queryById($project_id);
            for($i = 0; $i < 1; $i++){
                $gobackUrl = $_POST['gobackUrl'];
                $op = $_POST['workflow'];
                
                if(!empty($_POST['file_id'])){
                    $this->assign('files',$this->_getFiles($_POST['file_id']));
                }
                
                if($op == '退回'){
                    $this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                    if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
                        $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
                    }
                    
                    if(!$this->form_validation->run()){
                        $this->assign('reasonTxt',$_POST['reason']);
                        break;
                    }
                    
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
                        
                    }elseif($info['status'] == '项目已提交'){
                        $lastOpName = '通过复审';
                        $lastStatus = '已通过复审';
                        
                    }elseif($info['status'] == '已收费'){
                        $lastOpName = '项目提交';
                        $lastStatus = '项目已提交';
                        
                    }elseif($info['status'] == '已归档'){
                        $lastOpName = '收费';
                        $lastStatus = '已收费';
                    }
                    
                }elseif($op == '发送'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if(!$this->form_validation->run()){
                        break;
                    }
                }elseif($op == '布置'){
                    $this->form_validation->set_rules('start_date', '开始日期', 'required|valid_date');
                    $this->form_validation->set_rules('end_date', '结束日期', 'required|valid_date');
                    
                    if(!empty($_POST['bz_remark'])){
                        $this->form_validation->set_rules('bz_remark', '布置备注', 'min_length[2]|max_length[100]');
                    }else{
                        $_POST['bz_remark'] = '';
                    }
                    
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
                    
                    if(!empty($_POST['ss_remark'])){
                        $this->form_validation->set_rules('ss_remark', '实施备注', 'min_length[2]|max_length[100]');
                    }else{
                        $_POST['ss_remark'] = '';
                    }
                    
                    if(!$this->form_validation->run()){
                        $info['ny_enddate'] = $_POST['ny_enddate'];
                        $info['wy_enddate'] = $_POST['wy_enddate'];
                        $info['ss_remark'] = $_POST['ss_remark'];
                        break;
                    }
                    
                }elseif($op == '完成'){
                    
                    if($info['cate_name'] != CH_FCCH){
                        $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    }
                    //$this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    
                    if($info['type'] == CH_RCZD){
                        //界址可选， 因为有人打字速度慢
                        //$this->form_validation->set_rules('jz_name[]', '界址信息', 'required');
                    }
                    
                    if(!$this->form_validation->run()){
                        $info['direction'] = $_POST['direction'];
                        $info['jz_name'] = $_POST['jz_name'];
                        $info['neighbor'] = $_POST['neighbor'];
                        break;
                    }
                    
                }elseif($op == '提交初审'){
                    if(!empty($_POST['zc_yj'])){
                        $this->form_validation->set_rules('zc_yj', '自查意见', 'max_length[300]');
                    }else{
                        $_POST['zc_yj'] = '合格';
                    }
                    if(!empty($_POST['zc_remark'])){
                        $this->form_validation->set_rules('zc_remark', '自查修改和处理意见', 'max_length[300]');
                    }else{
                        $_POST['zc_remark'] = '合格';
                    }
                    
                    if($info['cate_name'] != CH_FCCH){
                        $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    }
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if(!$this->form_validation->run()){
                        $info['zc_yj'] = $_POST['zc_yj'];
                        $info['zc_remark'] = $_POST['zc_remark'];
                        break;
                    }
                    
                }elseif($op == '通过初审'){
                    
                    if(!empty($_POST['cs_yj'])){
                        $this->form_validation->set_rules('cs_yj', '初审意见', 'max_length[300]');
                    }else{
                        $_POST['cs_yj'] = '合格';
                    }
                    if(!empty($_POST['cs_remark'])){
                        $this->form_validation->set_rules('cs_remark', '初审修改和处理意见', 'max_length[300]');
                    }else{
                        $_POST['cs_remark'] = '合格';
                    }
                    
                    if($info['cate_name'] != CH_FCCH){
                        $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    }
                    if(!$this->form_validation->run()){
                        $info['cs_yj'] = $_POST['cs_yj'];
                        $info['cs_remark'] = $_POST['cs_remark'];
                        break;
                    }
                }elseif($op == '提交复审'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if($info['cate_name'] != CH_FCCH){
                        $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    }
                    
                    if(!$this->form_validation->run()){
                        break;
                    }
                }elseif($op == '通过复审'){
                    if(!empty($_POST['fs_yj'])){
                        $this->form_validation->set_rules('fs_yj', '复审意见', 'max_length[300]');
                    }else{
                        $_POST['fs_yj'] = '经查资料齐全，合格。';
                    }
                    if(!empty($_POST['fs_remark'])){
                        $this->form_validation->set_rules('fs_remark', '复审修改和处理意见', 'max_length[300]');
                    }else{
                        $_POST['fs_remark'] = '合格';
                    }
                    if($info['cate_name'] != CH_FCCH){
                        $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    }
                    if(!$this->form_validation->run()){
                        $info['fs_yj'] = $_POST['fs_yj'];
                        $info['fs_remark'] = $_POST['fs_remark'];
                        break;
                    }
                }elseif($op == '项目提交'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    if($info['cate_name'] != CH_FCCH){
                        $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
                    }
                    $this->form_validation->set_rules('title', '项目成功名称', 'required|min_length[3]|max_length[200]');
                    $this->form_validation->set_rules('area', '项目面积', 'required|greater_than[0]|numeric');
                    
                    if($info['cate_name'] == CH_JGCL){
                        $this->form_validation->set_rules('building_cnt', '建筑物幢数', 'required|is_natural_no_zero');
                    }
                    
                    if(!$this->form_validation->run()){
                        $info['title'] = $_POST['title'];
                        break;
                    }
                }elseif($op == '收费'){
                    $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                    $this->form_validation->set_rules('get_doc', '成果资料领取', 'required|is_natural');
                    $this->form_validation->set_rules('ys_amount', '应收金额', 'required|numeric');
                    $this->form_validation->set_rules('ss_amount', '实收金额', 'required|numeric');
                    $this->form_validation->set_rules('is_owed', '欠费情况', 'required|is_natural');
                    $this->form_validation->set_rules('fee_type', '收费情况', 'required|is_natural');
                    
                    if(!$this->form_validation->run()){
                        $info['get_doc'] = $_POST['get_doc'];
                        $info['ys_amount'] = $_POST['ys_amount'];
                        $info['ss_amount'] = $_POST['ss_amount'];
                        $info['is_owed'] = $_POST['is_owed'];
                        $info['fee_type'] = $_POST['fee_type'];
                        
                        break;
                    }
                }
                
                $_POST['event_id'] = $event_id;
                $message = $this->_doWorkFlow($info, $_POST, $op, $lastOpName,$lastStatus);
                
                $info = $this->Project_Model->queryById($project_id);
            }
            
        }else{
            $info = $this->Project_Model->queryById($project_id);
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            if(!empty($info['files'])){
                $this->assign('files',$this->_getFiles($info['files']));
            }
        }
        
        if(empty($message)){
            $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
        }
        
        $sendorWhere = array();
        if($info['status'] == '已完成'){
            $sendorWhere['ch_cs'] = 'y';
        }elseif($info['status'] == '已通过初审'){
            $sendorWhere['ch_fs'] = 'y';
        }elseif($info['status'] == '已通过复审'){
            $sendorWhere['ch_fee'] = 'y';
        }elseif($info['status'] == '项目已提交'){
            $sendorWhere['ch_archive'] = 'y';
        }else{
            $sendorWhere['ch_workflow'] = 'y';
        }
        
        $this->_getSendorList($sendorWhere);
        
        $status = array(
           // '新增' , '发送' ,'布置', '实施','完成','提交初审','通过初审',  '提交复审', '通过复审', '项目提交','收费','归档'
            '新增' , '发送' ,'布置', '实施',/*'完成','提交初审','通过初审',  '提交复审', '通过复审'*/
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
        
        /*
        if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
            
            $this->load->model('Fault_Model');
            $sysFaultList = $this->Fault_Model->getList(array(
                'order' => 'type ASC,level DESC'
            ));
            
            $tmpFaultList = array();
            foreach($sysFaultList['data'] as $v){
                if(!isset($tmpFaultList[$v['type']])){
                    $tmpFaultList[$v['type']] = array(
                        'title' => $v['typename'],
                        'list' => array()
                    );
                    $tmpFaultList[$v['type']]['list'][] = $v;
                }else{
                    $tmpFaultList[$v['type']]['list'][] = $v;
                }
            }
            
            $this->assign('sysFaultList',$tmpFaultList);
        }
        
        
        $this->load->model('Project_Fault_Model');
        
        //初审错误
        $userFaultList[] = $this->Project_Fault_Model->getList(array(
            'where' => array(
                'project_type' => 0,
                'type' => 0,
                'project_id' => $info['id'],
                'status' => 0
            )
        ));
        //复审错误
        $userFaultList[] = $this->Project_Fault_Model->getList(array(
                'where' => array(
                    'project_type' => 0,
                    'type' => 1,
                    'project_id' => $info['id'],
                    'status' => 0
                )
            ));
        
       
        $info['faultScore'] = 0;
        foreach($userFaultList as $value){
            foreach($value['data'] as $v){
                $info['faultScore'] += $v['score'];
            }
        }
        
        $this->assign('userFaultList0',$userFaultList[0]['data']);
        $this->assign('userFaultList1',$userFaultList[1]['data']);
            
        //取得界址信息 
        $this->load->model('Project_Jz_Model');

        $jzList = $this->Project_Jz_Model->getList(array(
            'where' => array(
                'project_id' => $info['id']
            ),
            'order' => 'direction ASC'
        ));

        $this->assign('jzList',$jzList['data']);
        */
        
        $this->assign('statusHtml',$statusHtml);
        $info['event_id'] = $event_id;
        $this->assign('message',$message);
        $this->assign('info',$info);
        $this->assign('modList',$this->_getProjectModList($project_id));
        $this->assign('worklog',$this->_getProjectModList($project_id,'worklog'));
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
        
    }
    
    
    
    private function _doWorkFlow($info,$param, $op, $gobackStatus, $lastStatus){
        $eventReaded = false;
        $pm = false;
        $sendorInfo = null;
        $now = time();
        
        if($op == '退回'){
            $lastUser = $this->_getLastOperator($info,$gobackStatus);
            
            $data = array(
                'sendor_id' => $lastUser['user_id'],
                'sendor' => $lastUser['creator'],
                'status' => $lastStatus,
                'reason' => cut($param['reason'],200),
                'updator' => $this->_userProfile['name'],
                'updatetime' => $now
            );

            if(!empty($param['fault']) && ($info['status'] == '已提交初审' || $info['status'] == '已提交复审')){
                if($info['status'] == '已提交初审'){
                    $fault_step = 0;
                }else{
                    $fault_step = 1;
                }
                
                $this->load->model('Project_Fault_Model');
                $this->load->model('Fault_Model');
                $this->Project_Fault_Model->updateByWhere(array('status' => 1),array(
                    'project_type' => 0,
                    'project_id' => $info['id'],
                    'type' => $fault_step,
                    'status' => 0
                ));
                
                //print_r($param);
                
                $sysFaultList = $this->Fault_Model->getList(array(
                    'where_in' => array(
                        array('key' => 'code','value' => $param['fault'])
                    )
                ));
                $insertData = array();
                
                foreach($sysFaultList['data'] as $fkey => $fvalue){
                    $insertTime = time();
                    $insertData[] = array(
                        'project_type' => 0,
                        'project_id' => $info['id'],
                        'type' => $fault_step,
                        'fault_code' => $fvalue['code'],
                        'fault_name' => $fvalue['name'],
                        'remark' => !empty($param[strtoupper($fvalue['code']).'_remark']) ? $param[strtoupper($fvalue['code']).'_remark'] : '',
                        'score' => (double)$fvalue['score'],
                        'creator' => $this->_userProfile['name'],
                        'updator' => $this->_userProfile['name'],
                        'createtime' => $insertTime,
                        'updatetime' => $insertTime
                    );
                }
                
                if($fault_step == 0){
                    $data['fault_cnt1'] = count($param['fault']);
                    $data['total_fault'] = $data['fault_cnt1'] + $info['fault_cnt2'];
                }else if($fault_step == 1){
                    $data['fault_cnt2'] = count($param['fault']); 
                    $data['total_fault'] = $data['fault_cnt2'] + $info['fault_cnt1'];
                }
                
                $this->Project_Fault_Model->batchInsert($insertData);
            }
            
            $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => $info['status'],'sendor_id' => $this->_userProfile['id']));

            if($return){
                $this->_addProjectLog('workflow', $info['id'],$op,"{$this->_userProfile['name']} {$op}至 {$lastUser['creator']},{$op}原因:<span class=\"notice\">{$param['reason']}</span>",$data);
                $lastUser['id'] = $lastUser['user_id'];
                $this->_addPm($info,$lastUser, 0);
                $eventReaded = true;
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
                        'updatetime' => $now
                    );
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '新增','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 至 {$sendorInfo['name']}",$data);
                        $pm = true;
                        $eventReaded = true;
                    }
                    break;
                
                case '布置':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        /* 执行布置操作人 为项目负责人 */
                        'pm_id' => $this->_userProfile['id'],
                        'pm' => $this->_userProfile['name'],
                        'dept_id' => $this->_userProfile['dept_id'],
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'arrange_date' => $now,
                        'start_date' => strtotime($param['start_date']),
                        'end_date' => strtotime($param['end_date']),
                        'updatetime' => $now,
                        'bz_remark' => $param['bz_remark']
                    );
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已发送','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 至 {$sendorInfo['name']}",$data);
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
                        'real_startdate' => $now,
                        'ny_enddate' => strtotime($_POST['ny_enddate']),
                        'wy_enddate' => strtotime($_POST['wy_enddate']),
                        'updatetime' => $now,
                        'ss_remark' => $param['ss_remark']
                    );

                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已布置','sendor_id' => $this->_userProfile['id']));
                    
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
                        $eventReaded = true;
                    }
                    
                    break;
                case '完成':
                    if($info['status'] == '已实施'){
                        
                        $this->load->model('Project_Jz_Model');
                        $this->Project_Jz_Model->deleteByWhere(array(
                            'project_id' => $info['id']
                        ));
                        
                        $insertData = array();
                        
                        if(!empty($param['direction'])){
                            foreach($param['direction'] as $key => $val){
                                $insertTime = time();

                                $insertData[] = array(
                                    'project_id' => $info['id'],
                                    'direction' => $val,
                                    'name' => !empty($param['jz_name'][$key]) ? $param['jz_name'][$key] : '',
                                    'neighbor' => !empty($param['neighbor'][$key]) ? $param['neighbor'][$key] : '',
                                    'creator' => $this->_userProfile['name'],
                                    'updator' => $this->_userProfile['name'],
                                    'createtime' => $insertTime,
                                    'updatetime' => $insertTime
                                );
                            }

                            $this->Project_Jz_Model->batchInsert($insertData);
                        
                        }
                    }
                    /**
                     * 完成时不需要发送了 
                     */
                    //$sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        //'sendor_id' => $sendorInfo['id'],
                        //'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'real_enddate' => $now,
                        'updatetime' => $now,
                        'files' => implode(',',$param['file_id'])
                    );
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已实施','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        //$this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 并流转至 {$sendorInfo['name']}",$data);
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
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
                        'updatetime' => $now,
                        'zc_time' => $now,
                        'zc_name' => $this->_userProfile['name'],
                        'zc_yj' => $param['zc_yj'],
                        'zc_remark' => $param['zc_remark'],
                        'files' => implode(',',$param['file_id'])
                    );
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已完成','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 并流转至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    break;
                case '通过初审':
                    $data = array(
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'cs_time' => $now,
                        'cs_name' => $this->_userProfile['name'],
                        'cs_yj' => $param['cs_yj'],
                        'cs_remark' => $param['cs_remark'],
                    );
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
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
                        'updatetime' => $now,
                        'files' => implode(',',$param['file_id'])
                    );
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已通过初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 并流转至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    break;
                case '通过复审':
                    $data = array(
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'fs_time' => $now,
                        'fs_name' => $this->_userProfile['name'],
                        'fs_yj' => $param['fs_yj'],
                        'fs_remark' => $param['fs_remark'],
                    );
                    
                    if($info['total_fault'] == 1){
                        $data['score'] = $info['weight'] * 0.3;
                    }elseif($info['total_fault'] == 2){
                        $data['score'] = $info['weight'] * 0.6;
                    }else{
                        if($info['total_fault'] != 0){
                            $data['score'] = 0;
                        }
                    }
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
                        $eventReaded = true;
                    }
                    break;
                case '项目提交':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'title' => $param['title'],
                        'area' => $param['area'],
                        'status' => '项目已提交',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now
                    );
                    
                    if($info['cate_name'] == CH_JGCL){
                        $data['building_cnt'] = $param['building_cnt'];
                    }
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已通过复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 并流转至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    
                    break;
                case '收费':
                    $sendorInfo = $this->User_Model->queryById($param['sendor']);
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'get_doc' => $param['get_doc'],
                        'get_doctime' => time(),
                        'ys_amount' => $param['ys_amount'],
                        'ss_amount' => $param['ss_amount'],
                        'is_owed' => $param['is_owed'],
                        'collect_date' => $now,
                        'fee_type' => $param['fee_type'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now
                    );
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '项目已提交','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 并流转至 {$sendorInfo['name']}",$data);
                        $eventReaded = true;
                        $pm = true;
                    }
                    
                    break;
                case '归档':
                    $data = array(
                        'has_archiver' => 1,
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now
                    );
                    
                    $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已收费','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
                        $eventReaded = true;
                    }
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
            $this->_addPm($info,$sendorInfo,0);
        }
        
        return $message;
    }
    
    public function tuihui(){
        
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $op = '退回';
            
            $this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
            
            if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
                $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
            }

            if($this->form_validation->run()){
            
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

                }elseif($info['status'] == '项目已提交'){
                    $lastOpName = '通过复审';
                    $lastStatus = '已通过复审';

                }elseif($info['status'] == '已收费'){
                    $lastOpName = '项目提交';
                    $lastStatus = '项目已提交';

                }elseif($info['status'] == '已归档'){
                    $lastOpName = '收费';
                    $lastStatus = '已收费';
                }


                $lastUser = $this->_getLastOperator($info,$lastOpName);
                $data = array(
                    'sendor_id' => $lastUser['user_id'],
                    'sendor' => $lastUser['creator'],
                    'status' => $lastStatus,
                    'reason' => cut($_POST['reason'],200),
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => time()
                );

                if(!empty($_POST['fault']) && ($info['status'] == '已提交初审' || $info['status'] == '已提交复审')){
                    if($info['status'] == '已提交初审'){
                        $fault_step = 0;
                    }else{
                        $fault_step = 1;
                    }

                    $this->load->model('Project_Fault_Model');
                    $this->load->model('Fault_Model');
                    $this->Project_Fault_Model->updateByWhere(array('status' => 1),array(
                        'project_type' => 0,
                        'project_id' => $info['id'],
                        'type' => $fault_step,
                        'status' => 0
                    ));

                    $sysFaultList = $this->Fault_Model->getList(array(
                        'where_in' => array(
                            array('key' => 'code','value' => $_POST['fault'])
                        )
                    ));

                    $insertData = array();

                    foreach($sysFaultList['data'] as $fkey => $fvalue){
                        $insertTime = time();
                        $insertData[] = array(
                            'project_type' => 0,
                            'project_id' => $info['id'],
                            'type' => $fault_step,
                            'fault_code' => $fvalue['code'],
                            'fault_name' => $fvalue['name'],
                            'remark' => !empty($_POST[strtoupper($fvalue['code']).'_remark']) ? $_POST[strtoupper($fvalue['code']).'_remark'] : '',
                            'score' => (double)$fvalue['score'],
                            'creator' => $this->_userProfile['name'],
                            'updator' => $this->_userProfile['name'],
                            'createtime' => $insertTime,
                            'updatetime' => $insertTime
                        );
                    }

                    if($fault_step == 0){
                        $data['fault_cnt1'] = count($_POST['fault']);
                        $data['total_fault'] = $data['fault_cnt1'] + $info['fault_cnt2'];
                    }else if($fault_step == 1){
                        $data['fault_cnt2'] = count($_POST['fault']);
                        $data['total_fault'] = $data['fault_cnt2'] + $info['fault_cnt1'];
                    }

                    $this->Project_Fault_Model->batchInsert($insertData);
                }

                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => $info['status'],'sendor_id' => $this->_userProfile['id']));

                if($return){
                    $this->_addProjectLog('workflow', $info['id'],$op,"{$this->_userProfile['name']} {$op}至 {$lastUser['creator']},{$op}原因:<span class=\"notice\">{$_POST['reason']}</span>",$data);
                    $lastUser['id'] = $lastUser['user_id'];
                    $this->_addPm($info,$lastUser,0);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op.'失败</div>');
                }
                
                $this->display('showmessage','common');
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
                $this->display('showmessage','common');
            }
        }else{
            if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
            
                $this->load->model('Fault_Model');
                $sysFaultList = $this->Fault_Model->getList(array(
                    'order' => 'type ASC,level DESC'
                ));

                $tmpFaultList = array();
                foreach($sysFaultList['data'] as $v){
                    if(!isset($tmpFaultList[$v['type']])){
                        $tmpFaultList[$v['type']] = array(
                            'title' => $v['typename'],
                            'list' => array()
                        );
                        $tmpFaultList[$v['type']]['list'][] = $v;
                    }else{
                        $tmpFaultList[$v['type']]['list'][] = $v;
                    }
                }

                $this->assign('sysFaultList',$tmpFaultList);
            }


            $this->load->model('Project_Fault_Model');

            //初审错误
            $userFaultList[] = $this->Project_Fault_Model->getList(array(
                'where' => array(
                    'project_type' => 0,
                    'type' => 0,
                    'project_id' => $info['id'],
                    'status' => 0
                )
            ));
            //复审错误
            $userFaultList[] = $this->Project_Fault_Model->getList(array(
                    'where' => array(
                        'project_type' => 0,
                        'type' => 1,
                        'project_id' => $info['id'],
                        'status' => 0
                    )
                ));

            /**
            * @todo 需要计算权重 
            */
            $info['faultScore'] = 0;
            foreach($userFaultList as $value){
                foreach($value['data'] as $v){
                    $info['faultScore'] += $v['score'];
                }
            }

            $this->assign('userFaultList0',$userFaultList[0]['data']);
            $this->assign('userFaultList1',$userFaultList[1]['data']);
        
            $this->assign('info',$info);
            $this->display();
        }
        
    }

    
    /**
     * 项目布置
     */
    public function dispatch(){
        
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $this->form_validation->set_rules('start_date', '开始日期', 'required|valid_date');
            $this->form_validation->set_rules('end_date', '结束日期', 'required|valid_date');

            if(!empty($_POST['bz_remark'])){
                $this->form_validation->set_rules('bz_remark', '布置备注', 'min_length[2]|max_length[100]');
            }else{
                $_POST['bz_remark'] = '';
            }

            $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
            if($this->form_validation->run()){
                $op = '布置';
                $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                
                $now = time();
                $data = array(
                    /* 执行布置操作人 为项目负责人 */
                    'pm_id' => $this->_userProfile['id'],
                    'pm' => $this->_userProfile['name'],
                    'dept_id' => $this->_userProfile['dept_id'],
                    'sendor_id' => $sendorInfo['id'],
                    'sendor' => $sendorInfo['name'],
                    'status' => '已'.$op,
                    'updator' => $this->_userProfile['name'],
                    'arrange_date' => $now,
                    'start_date' => strtotime($_POST['start_date']),
                    'end_date' => strtotime($_POST['end_date']),
                    'updatetime' => $now,
                    'bz_remark' => $_POST['bz_remark']
                );

                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已发送','sendor_id' => $this->_userProfile['id']));
                if($return){
                    $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 至 {$sendorInfo['name']}",$data);
                    $this->_addPm($info,$sendorInfo,0);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op.'失败</div>');
                }
                
                $this->display('showmessage','common');
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
                $this->display('showmessage','common');
            }
        }else{
            $this->_getSendorList(array(
               'ch_workflow' => 'y' 
            ));
            $this->assign('info',$info);
            $this->display();
        }
    }
    
    
    /**
     * 项目实施
     */
    public function implement(){
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->form_validation->set_rules('ny_enddate', '内业完成时间', 'required|valid_date');
            $this->form_validation->set_rules('wy_enddate', '外业完成时间', 'required|valid_date');

            if(!empty($_POST['ss_remark'])){
                $this->form_validation->set_rules('ss_remark', '实施备注', 'min_length[2]|max_length[100]');
            }else{
                $_POST['ss_remark'] = '';
            }
            
            if($this->form_validation->run()){
                $op = '实施';
                $now = time();
                $data = array(
                    'status' => '已'.$op,
                    'updator' => $this->_userProfile['name'],
                    /** 实际实施的人 */
                    'worker_id' => $this->_userProfile['id'],
                    'worker' => $this->_userProfile['name'],
                    'real_startdate' => $now,
                    'ny_enddate' => strtotime($_POST['ny_enddate']),
                    'wy_enddate' => strtotime($_POST['wy_enddate']),
                    'updatetime' => $now,
                    'ss_remark' => $_POST['ss_remark']
                );

                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已布置','sendor_id' => $this->_userProfile['id']));
                if($return){
                    $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op.'失败</div>');
                }
                
                $this->display('showmessage','common');
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
                $this->display('showmessage','common');
            }
        }else{
            $this->_getSendorList(array(
               'ch_workflow' => 'y'
            ));
            $this->assign('info',$info);
            $this->display();
        }
    }
    
    /**
     * 作业完成
     */
    
    /*
    public function complete(){
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            if(!empty($_POST['zc_yj'])){
                $this->form_validation->set_rules('zc_yj', '自查意见', 'max_length[300]');
            }else{
                $_POST['zc_yj'] = '合格';
            }
            if(!empty($_POST['zc_remark'])){
                $this->form_validation->set_rules('zc_remark', '自查修改和处理意见', 'max_length[300]');
            }else{
                $_POST['zc_remark'] = '合格';
            }
            
            if($info['cate_name'] != CH_FCCH){
                $this->form_validation->set_rules('file_id[]', '图件文档', 'required');
            }
            
            $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
            if($info['type'] == CH_RCZD){
                //界址可选， 因为有人打字速度慢
                //$this->form_validation->set_rules('jz_name[]', '界址信息', 'required');
            }

            if($this->form_validation->run()){
                $op1 = '完成';
                $op2 = '提交初审';
                
                if($info['status'] == '已实施'){
                    $this->load->model('Project_Jz_Model');
                    $this->Project_Jz_Model->deleteByWhere(array(
                        'project_id' => $info['id']
                    ));

                    $insertData = array();

                    if(!empty($_POST['direction'])){
                        foreach($_POST['direction'] as $key => $val){
                            $insertTime = time();

                            $insertData[] = array(
                                'project_id' => $info['id'],
                                'direction' => $val,
                                'name' => !empty($_POST['jz_name'][$key]) ? $_POST['jz_name'][$key] : '',
                                'neighbor' => !empty($_POST['neighbor'][$key]) ? $_POST['neighbor'][$key] : '',
                                'creator' => $this->_userProfile['name'],
                                'updator' => $this->_userProfile['name'],
                                'createtime' => $insertTime,
                                'updatetime' => $insertTime
                            );
                        }
                        $this->Project_Jz_Model->batchInsert($insertData);
                    }
                }
                
                $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                
                $now = time();
                $data = array(
                    'sendor_id' => $sendorInfo['id'],
                    'sendor' => $sendorInfo['name'],
                    'status' => '已'.$op2,
                    'updator' => $this->_userProfile['name'],
                    'real_enddate' => $now,
                    'updatetime' => $now,
                    'zc_time' => $now,
                    'zc_name' => $this->_userProfile['name'],
                    'zc_yj' => $_POST['zc_yj'],
                    'zc_remark' => $_POST['zc_remark'],
                    'files' => implode(',',$_POST['file_id'])
                );
                
                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已实施','sendor_id' => $this->_userProfile['id']));
                if($return){
                    $this->_addProjectLog('workflow',  $info['id'],$op2,"{$this->_userProfile['name']} {$op2} 并流转至 {$sendorInfo['name']}",$data);
                    $this->_addProjectLog('workflow',  $info['id'],$op1,"{$this->_userProfile['name']} {$op1}",$data);
                    $this->_addPm($info,$sendorInfo,0);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op2.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op2.'失败</div>');
                }
                
                $this->display('showmessage','common');
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
                $this->display('showmessage','common');
            }
        }else{
            
            
            //取得界址信息 
            $this->load->model('Project_Jz_Model');

            $jzList = $this->Project_Jz_Model->getList(array(
                'where' => array(
                    'project_id' => $info['id']
                ),
                'order' => 'direction ASC'
            ));

            $this->assign('jzList',$jzList['data']);
            
            $this->_getSendorList(array(
               'ch_cs' => 'y' 
            ));
            
            $this->assign('info',$info);
            $this->display();
        }
    }
     */
    
    /**
     * 提交初审 或者 复审 
     */
    
    
    /*
    public function check(){
        
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            if($info['status'] == '已完成'){
                $op = '提交初审';
                
                if(!empty($_POST['zc_yj'])){
                    $this->form_validation->set_rules('zc_yj', '自查意见', 'max_length[300]');
                }else{
                    $_POST['zc_yj'] = '合格';
                }
                if(!empty($_POST['zc_remark'])){
                    $this->form_validation->set_rules('zc_remark', '自查修改和处理意见', 'max_length[300]');
                }else{
                    $_POST['zc_remark'] = '合格';
                }
            }else if($info['status'] == '已通过初审'){
                
                $op = '提交复审';
                
                if(!empty($_POST['cs_yj'])){
                    $this->form_validation->set_rules('cs_yj', '初审意见', 'max_length[300]');
                }else{
                    $_POST['cs_yj'] = '按规范要求测量，报告符合要求。';
                }
                if(!empty($_POST['cs_remark'])){
                    $this->form_validation->set_rules('cs_remark', '初审修改和处理意见', 'max_length[300]');
                }else{
                    $_POST['cs_remark'] = '合格';
                }
            }
            
            $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
            
            if($this->form_validation->run()){
                
                $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                $now = time();
                $data = array(
                    'sendor_id' => $sendorInfo['id'],
                    'sendor' => $sendorInfo['name'],
                    'status' => '已'.$op,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now,
                    
                );
                
                if($info['status'] == '已完成'){
                    $data['zc_time'] = $now;
                    $data['zc_name'] = $this->_userProfile['name'];
                    $data['zc_yj'] = $_POST['zc_yj'];
                    $data['zc_remark'] = $_POST['zc_remark'];
                    
                }else if($info['status'] == '已通过初审'){
                    $data['cs_time'] = $now;
                    $data['cs_name'] = $this->_userProfile['name'];
                    $data['cs_yj'] = $_POST['cs_yj'];
                    $data['cs_remark'] = $_POST['cs_remark'];
                }
                
                
                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => $info['status'],'sendor_id' => $this->_userProfile['id']));
                if($return){
                    $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op} 并流转至 {$sendorInfo['name']}",$data);
                    $this->_addPm($info,$sendorInfo,0);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op.'失败</div>');
                }
                
                $this->display('showmessage','common');
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
                $this->display('showmessage','common');
            }
        }else{
            
            if($info['status'] == '已完成'){
                $this->_getSendorList(array(
                    'ch_cs' => 'y' 
                ));
                
            }else{
                $this->_getSendorList(array(
                    'ch_fs' => 'y' 
                ));
            }
            
            if(!empty($info['files'])){
                $this->assign('files',$this->_getFiles($info['files']));
            }
            $this->assign('info',$info);
            $this->display();
        }
        
    }
    */
    
    
    /**
     * 初审 操作
     */
    
    /*
    public function first_sh(){
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            if(!empty($_POST['cs_yj'])){
                $this->form_validation->set_rules('cs_yj', '初审意见', 'max_length[300]');
            }else{
                $_POST['cs_yj'] = '按规范要求测量，报告符合要求。';
            }
            if(!empty($_POST['cs_remark'])){
                $this->form_validation->set_rules('cs_remark', '初审修改和处理意见', 'max_length[300]');
            }else{
                $_POST['cs_remark'] = '合格';
            }
            
            $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
            if($this->form_validation->run()){
                $op1 = '通过初审';
                $op2 = '提交复审';
                
                $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                $now = time();
                $data = array(
                    'sendor_id' => $sendorInfo['id'],
                    'sendor' => $sendorInfo['name'],
                    'status' => '已'.$op2,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now,
                    'cs_time' => $now,
                    'cs_name' => $this->_userProfile['name'],
                    'cs_yj' => $_POST['cs_yj'],
                    'cs_remark' => $_POST['cs_remark']
                );
                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                if($return){
                    $this->_addProjectLog('workflow',  $info['id'],$op1,"{$this->_userProfile['name']} {$op1}",$data);
                    $this->_addProjectLog('workflow',  $info['id'],$op2,"{$this->_userProfile['name']} {$op2} 并流转至 {$sendorInfo['name']}",$data);
                    $this->_addPm($info,$sendorInfo,0);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op2.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op2.'失败</div>');
                }
                
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
            }
            
            $this->display('showmessage','common');
        }else{
            $this->_getSendorList(array(
               'ch_fs' => 'y'
            ));
            if(!empty($info['files'])){
                $this->assign('files',$this->_getFiles($info['files']));
            }
            $this->assign('info',$info);
            $this->display();
        }
    }
    */
    
    /**
     * 复审 
     */
    
    /*
    public function second_sh(){
        
        $id = (int)gpc('id','GP',0);
        
        if(empty($id)){
            die('参数错误');
        }
        
        $info = $this->Project_Model->queryById($id);
        
        if(!$info){
            die('找不到项目');
        }
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            if(!empty($_POST['fs_yj'])){
                $this->form_validation->set_rules('fs_yj', '复审意见', 'max_length[300]');
            }else{
                $_POST['fs_yj'] = '按规范要求测量，报告符合要求。';
            }
            if(!empty($_POST['fs_remark'])){
                $this->form_validation->set_rules('fs_remark', '复审修改和处理意见', 'max_length[300]');
            }else{
                $_POST['fs_remark'] = '合格';
            }
            
            if($this->form_validation->run()){
                $op = '通过复审';
                $now = time();
                //$sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                $data = array(
                    'status' => '已'.$op,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now,
                    'fs_time' => $now,
                    'fs_name' => $this->_userProfile['name'],
                    'fs_yj' => $_POST['fs_yj'],
                    'fs_remark' => $_POST['fs_remark'],
                );
                $return = $this->Project_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                if($return){
                    $this->_addProjectLog('workflow',  $info['id'],$op,"{$this->_userProfile['name']} {$op}",$data);
                    $this->assign('reload',1);
                    $this->assign('message','<div class="pd20 success">'.$op.'成功</div>');
                }else{
                    $this->assign('message','<div class="pd20 failed">'.$op.'失败</div>');
                }
                
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $this->assign('message','<div class="pd20 failed">'.$message.'</div>');
            }
            
            $this->display('showmessage','common');
        }else{
            $this->_getSendorList(array(
               'ch_cs' => 'y'
            ));
            if(!empty($info['files'])){
                $this->assign('files',$this->_getFiles($info['files']));
            }
            $this->assign('info',$info);
            $this->display();
        }
    }
    
    */
    
    
    private function _addRules(){
        
        //$this->form_validation->set_rules('year', '年份', 'required|integer');
        $this->form_validation->set_rules('region_name', '区域', 'required');
        $this->form_validation->set_rules('type_id', '登记类型', 'required|is_natural_no_zero' );
        $this->form_validation->set_rules('name', '登记名称', 'trim|required|min_length[1]|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '登记地址', 'trim|required|min_length[2]|max_length[200]|htmlspecialchars');
        
        if(!empty($_POST['village'])){
            $this->form_validation->set_rules('village', '村名', 'trim|max_length[100]|htmlspecialchars');
        }else{
            $_POST['village'] = isset($_POST['village'])  == true ? trim($_POST['village']) : '';
        }
        
        if(!empty($_POST['union_name'])){
            $this->form_validation->set_rules('union_name', '联系单位名称', 'trim|max_length[200]|htmlspecialchars');
        }else{
            $_POST['union_name'] = isset($_POST['union_name'])  == true ? trim($_POST['union_name']) : '';
        }
        
        if(!empty($_POST['source'])){
            $this->form_validation->set_rules('source', '项目来源', 'trim|max_length[50]|htmlspecialchars');
        }else{
            $_POST['source'] = isset($_POST['source'])  == true ?  trim($_POST['source']) : '';
        }
        
        $this->form_validation->set_rules('contacter', '联系人名称', 'trim|required|max_length[15]|htmlspecialchars');
        $this->form_validation->set_rules('contacter_mobile', '联系人手机', 'trim|numeric_dash|min_length[4]|max_length[15]');
        
        if(!empty($_POST['contacter_tel'])){
            $this->form_validation->set_rules('contacter_tel', '联系人固定电话', 'trim|valid_telephone');
        }else{
            $_POST['contacter_tel'] = isset($_POST['contacter_tel'])  == true ?  trim($_POST['contacter_tel']) : '';
        }
        
        if(!empty($_POST['manager'])){
            $this->form_validation->set_rules('manager', '接洽人名称', 'trim|max_length[15]|htmlspecialchars');
        }
        
        $this->form_validation->set_rules('manager_mobile', '接洽人手机', 'trim|numeric_dash|min_length[4]|max_length[15]');
        
        if(!empty($_POST['manager_tel'])){
            $this->form_validation->set_rules('manager_tel', '接洽人固定电话', 'trim|valid_telephone');
        }else{
            $_POST['manager_tel'] = isset($_POST['manager_tel'])  == true ? trim($_POST['manager_tel']) : '';
        }
        
        $this->form_validation->set_rules('pm_id', '项目负责人', 'trim|required|is_natural_no_zero');
        
        $this->form_validation->set_rules('end_date', '要求完成时间', 'trim|required|valide_date');
        
         if(!empty($_POST['descripton'])){
            $this->form_validation->set_rules('descripton', '备注', 'trim|max_length[300]|htmlspecialchars');
        }else{
            $_POST['descripton'] = isset($_POST['descripton'])  == true ? trim($_POST['descripton']) : '';
        }
        
        $this->form_validation->set_rules('has_doc', '成果资料', 'required|integer|less_than[2]');
        
        if(!empty($_POST['displayorder'])){
            $this->form_validation->set_rules('displayorder', '优先级', 'trim|is_natural|less_than[10]');
        }else{
            $_POST['displayorder'] = (int)$_POST['displayorder'];
        }

    }
    
    
    private function _formatProjectNo($year,$regionCode,$masterSerial,$regionSerial,$prefix = 'A'){
        
        if($masterSerial < 1000){
            $masterSerial = str_pad($masterSerial, 4,'0', STR_PAD_LEFT);
        }

        if($regionSerial < 1000){
            $regionSerial = str_pad($regionSerial, 3,'0', STR_PAD_LEFT);
        }
        
        return $prefix.$year."-".$masterSerial."-".strtoupper($regionCode).$regionSerial;
    }
    
    /**
     * 删除 
     */
    public function delete(){
        if($this->isPostRequest() && !empty($_POST['delete_id'])){
            $message = array();
            $reload = 0;
            
            $successCnt = 0;
            $failedCnt = 0;
            
            foreach($_POST['delete_id'] as $val){
                $flag = $this->Project_Model->updateByWhere(
                    array(
                        'status' => '已删除',
                        'updatetime' => time(), 
                        'updator' => $this->_userProfile['name']
                    ),
                    array(
                        'status' => '新增',
                        'id' => $val
                    )
                );
                
                if($flag){
                    $successCnt++;
                }else{
                    $failedCnt++;
                }
            }
            
            if($successCnt){
                $reload = 1;
            }
            
            if($successCnt){
                $message[] = '<p class="success">'.$successCnt.'个记录被删除成功</p>';
            }
            
            if($failedCnt){
                $message[] = '<p class="failed">'.$failedCnt.'个记录被删除失败</p>';
            }
            $this->assign('reload',$reload);
            $this->assign('message','<div class="pd20">'.implode('',$message).'</div>');
            $this->display('showmessage','common');
            
        }else{
            $this->assign('message','删除失败参数错误');
            $this->display('showmessage','common');
        }
        
    }
    
    public function add()
	{
        $this->assign('action','add');
        if($this->isPostRequest()){
            /**
             *登记年份 
             */
            $addYear = date("Y");
            $this->_addRules();
            if($this->form_validation->run()){
                $_POST['year'] = $addYear;
                $_POST['month'] = date("m");
                $_POST['input_type'] = 0;
                $_POST['nature'] = '';
                $new_projectId =  $this->_add($addYear);
                
                $this->sendFormatJson('success', array('text' => '创建成功'));
            }else{
                //$message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                $message = strip_tags(validation_errors());
                $this->sendFormatJson('failed', array('text' => $message));
            }
        }else{
            $this->sendFormatJson('failed', array('text' => '参数错误'));
        }
		
	}
    
    
    private function _initPageData($addYear){
        
        /**
         * 区域 
         */
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => $addYear),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        /**
         *项目类型 
         */
        $projectTypeList = $this->Project_Type_Model->getList(array('order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('projectTypeList',$projectTypeList['data']);
        
        /**
         * 项目性质 
         */
        //$natureList = $this->Project_Nature_Model->getList(array('where' => array('status' => '正常','type' => '测绘项目'),'order' => 'displayorder DESC ,createtime ASC'));
        //$this->assign('natureList',$natureList['data']);
        
        //$this->assign('yearList',yearList());
        //$this->assign('monthList',range(1,12));
        
    }
    
    
    private function _add($year){
         // add
        $_POST['user_id'] = $this->_userProfile['id'];
        $_POST['creator'] = $this->_userProfile['name'];

        //$this->db->trans_start();
        
        /*
        $master_serial = $this->Project_Model->getMaxByWhere('master_serial',array(
            'year' => $year
        ));

        $region_serial = $this->Project_Model->getMaxByWhere('region_serial',array(
            'year' => $year,
            'region_code' => $_POST['region_code']
        ));

        $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
            
        $totalOffset = config_item('total_offset');
        if(!empty($totalOffset)){
            $_POST['master_serial'] += (int)$totalOffset[date("Y")];
        }

        $_POST['region_serial'] = $region_serial ? $region_serial + 1 : 1;

        $regionOffset = config_item('region_offset_'.date("Y"));

        if(!empty($regionOffset)){
            $_POST['region_serial'] += (int)$regionOffset[$_POST['region_code']];
        }

        $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['region_code'],$_POST['master_serial'],$_POST['region_serial']);
        */
        $_POST['master_serial'] = 0;
        $_POST['region_serial'] = 0;
        $_POST['project_no'] = '';
        
        $region_code = $this->Region_Model->getList(array(
                'select' => 'code',
                'where' => array(
                    'year' => $year,
                    'name' => $_POST['region_name'],
                    'status' => '正常'
                )
        ));
        
        if($region_code['data'][0]['code']){
            $_POST['region_code'] = $region_code['data'][0]['code'];
        }else{
            $_POST['region_code'] = '';
        }
        
        $project_type = $this->Project_Type_Model->queryById($_POST['type_id']);
        
        $_POST['type_id'] = $project_type['id'];
        $_POST['type'] = $project_type['name'];
        $_POST['type_name'] = $project_type['type'];
        $_POST['cate_name'] = $project_type['cate_name'];
        $_POST['weight'] = $project_type['weight'];
        
        if(!empty($_POST['end_date'])){
            $_POST['start_date'] = time();
            $_POST['end_date'] = strtotime($_POST['end_date']);
        }
        
        /**
         * * 如果指定了项目负责人
         */
        if(!empty($_POST['pm_id'])){
            $pmInfo = $this->User_Model->queryById($_POST['pm_id']);
            $_POST['pm_id'] = $pmInfo['id'];
            $_POST['pm'] = $pmInfo['name'];
        }
        
        /**
         * * 如果指定了当前操作人
         */
        //$desc = '';
        if(!empty($_POST['sendor_id'])){
            $sendorInfo = $this->User_Model->queryById($_POST['sendor_id']);
            if($sendorInfo){
                $_POST['sendor_id'] = $sendorInfo['id'];
                $_POST['sendor'] = $sendorInfo['name'];

                //"并设置当前操作人为 {$_POST['sendor']}";
            }
        }
        
        if(empty($sendorInfo)){
            $_POST['sendor_id'] = $this->_userProfile['id'];
            $_POST['sendor'] = $this->_userProfile['name'];
        }
        
        $insertid = $this->Project_Model->add($_POST);
        //$this->db->trans_complete();
        
        $this->_addProjectLog('workflow', $insertid,'新增',"{$this->_userProfile['name']} 新增",$_POST);
        
        if($_POST['sendor_id'] != $this->_userProfile['id']  && $sendorInfo){
            $info = $this->Project_Model->queryById($insertid);
            $this->_addPm($info,$sendorInfo,0);
        }
        
        return $insertid;
        
    }
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->_addRules();
            if($this->form_validation->run()){
                $info = $this->Project_Model->getById(array('where' => array('id' => $_POST['id'])));
                
                $_POST['updator'] = $this->_userProfile['name'];
                $project_type = $this->Project_Type_Model->queryById($_POST['type_id']);
                $_POST['type_id'] = $project_type['id'];
                $_POST['type'] = $project_type['name'];
                $_POST['type_name'] = $project_type['type'];
                $_POST['cate_name'] = $project_type['cate_name'];
                $_POST['weight'] = $project_type['weight'];
                
                $region_code = $this->Region_Model->getList(array(
                    'select' => 'code',
                    'where' => array(
                        'year' => $info['year'],
                        'name' => $_POST['region_name'],
                        'status' => '正常'
                    )
                ));

                if($region_code['data'][0]['code']){
                    $_POST['region_code'] = $region_code['data'][0]['code'];
                }else{
                    $_POST['region_code'] = '';
                }
                
                if(!empty($_POST['pm_id'])){
                    $pmInfo = $this->User_Model->queryById($_POST['pm_id']);
                    $_POST['pm'] = $pmInfo['name'];
                }
                
                if($info['status'] == '新增' && !empty($_POST['sendor_id'])){
                    $sendorInfo = $this->User_Model->queryById($_POST['sendor_id']);
                    
                    if($sendorInfo){
                        $_POST['sendor'] = $sendorInfo['name'];
                    }
                }
                
                if(!empty($_POST['end_date'])){
                    $_POST['end_date'] = strtotime($_POST['end_date']);
                }
                
                $this->Project_Model->update($_POST);
                $this->_addProjectLog('system', $_POST['id'],'修改',"{$this->_userProfile['name']} 修改了 {$info['project_no']} {$_POST['name']}",$_POST);
                $this->sendFormatJson('success', array('text' => '修改成功'));
            }else{
                $message = strip_tags(validation_errors());
                $this->sendFormatJson('failed', array('text' => $message));
            }
        }else{
            $info = $this->Project_Model->getById(array('where' => array('id' => $_GET['id'])));
            $this->_initPageData($info['year']);
            $this->_getSendorList(array(
                'ch_workflow' => 'y'
            ));
            $this->assign('info',$info);
            $this->display('edit');
        }
        
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
                'sendor_id' => $user['id'],
                'sendor' => $user['name'],
                'reason' => ''
            );
            
            $return = $this->Project_Model->updateByWhere($data,array('id' => $id, 'status' => '新增'));
            if($return){
                $event[] = $projectInfo[$id];
                $this->_addProjectLog('workflow', $id,$action,"{$this->_userProfile['name']} {$action} 至 {$user['name']}",$data);
            }else{
                $failed[] = $projectInfo[$id];
            }
        }
        
        if($event){
            foreach($event as $value){
                $this->_addPm($value,$user,0);
            }
        }
        
        return array('success' => $event, 'failed' => $failed);
    }
    
    public function sendone(){
        
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
                    $message[] = '<p class="success">' . $v['id'] .'发送成功</p>';
                }
                $reload = 1;
            }else{
                foreach($result['failed'] as $v){
                    $message[] = '<p class="failed">' . $v['id'] .'发送失败，可能已经被发送</p>';
                }
            }
            $this->assign('reload',$reload);
            $this->assign('message','<div class="pd20">'.implode('',$message).'</div>');
            $this->display('showmessage','common');
            
        }else{
            
            $this->_getSendorList(array(
                'ch_workflow' => 'y'
            ));
            $this->display();
        }
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
            
            if(!empty($_GET['project_no'])){
                $condition['like']['project_no'] = $_GET['project_no'];
            }
            
            if(!empty($_GET['name'])){
                $condition['like']['name'] = $_GET['name'];
            }
            
            $condition['where'] = array(
                'status !=' => '已删除'
            );
            
            if(!empty($_GET['status'])){
                $condition['where']['status'] = $_GET['status'];
            }
            
            if(!empty($_GET['type'])){
                $condition['where']['type'] = $_GET['type'];
            }
            
            if(!empty($_GET['sdate'])){
                $condition['where']['createtime >='] = strtotime($_GET['sdate']);
            }
            
            if(!empty($_GET['edate'])){
                $condition['where']['createtime <='] = strtotime($_GET['edate']) + 86400;
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
