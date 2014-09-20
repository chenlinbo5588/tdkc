<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Taizhang_Ch extends TZ_Admin_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('Region_Model');
        $this->load->model('Project_Nature_Model');
        $this->load->model('Taizhang_Model');
        $this->load->model('Project_Type_Model');
        
        $this->load->helper('number');
        
    }
    
    private function _addRules(){
        
        //$this->form_validation->set_rules('year', '年份', 'required|integer');
        //自动生成
        //$this->form_validation->set_rules('master_serial', '总编号', 'required|numeric');
        //$this->form_validation->set_rules('region_serial', '分编号', 'required|numeric');
        $this->form_validation->set_rules('region_name', '区域', 'required');
        $this->form_validation->set_rules('name', '单位名称', 'trim|required|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('address', '土地坐落', 'trim|required|max_length[200]|htmlspecialchars');
        $this->form_validation->set_rules('nature', '用途', 'required' );
        $this->form_validation->set_rules('total_area', '总面积', 'required|numeric');
        //$this->form_validation->set_rules('churan_area', '出让面积', 'required|numeric');
        $_POST['churan_area'] = 0;
        
        if(!empty($_POST['contacter'])){
            $this->form_validation->set_rules('contacter', '联系人名称', 'trim|required|max_length[15]|htmlspecialchars');
        }else{
            $_POST['contacter'] = '';
        }
        
        if(!empty($_POST['contacter_mobile'])){
            $this->form_validation->set_rules('contacter_mobile', '联系人号码', 'trim|numeric|min_length[4]|max_length[15]');
        }else{
            $_POST['contacter_mobile'] = '';
        }
        
        if(!empty($_POST['contacter_tel'])){
            $this->form_validation->set_rules('contacter_tel', '联系人座机', 'trim|numeric|min_length[4]|max_length[15]');
        }else{
            $_POST['contacter_tel'] = '';
        }
        
        $this->form_validation->set_rules('pm', '作业组负责人', 'trim|required|callback_checkname');
        //$this->form_validation->set_rules('fee_type', '收费情况', 'required|integer|greater_than[0]|less_than[5]');
        //$this->form_validation->set_rules('has_doc', '成果资料', 'required|integer|less_than[2]');
        
        if(!empty($_POST['descripton'])){
            $this->form_validation->set_rules('descripton', '备注', 'trim|max_length[300]|htmlspecialchars');
        }else{
            $_POST['descripton'] = isset($_POST['descripton'])  == true ? trim($_POST['descripton']) : '';
        }
        
        if(!empty($_POST['file_id'])){
            $this->form_validation->set_rules('file_id[]', '图件文档', 'required|is_natural_no_zero');
        }
        
    }
    
    
    public function checkname($name){
        
        $this->load->model('User_Model');
        $count = $this->User_Model->getCount(array('where' => array('name' => $name)));
        
        if($count){
            return true;
        }else{
            $this->form_validation->set_message('checkname', '%s 字段参数不正确，没有这个人员');
            return FALSE;
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
     *  基本信息
     */
    public function add(){
        
        $year = date("Y");
        
        $this->assign('action','add');
        $this->_initPageData($year);
        
        
        if($this->isPostRequest()){
            $gobackUrl = $_POST['gobackUrl'];
            $this->_addRules();
            if($this->form_validation->run()){
                $message = '';
                
                for($i = 0 ; $i < 1; $i++){
                    
                    if('保存' == $_POST['submit']){
                        $dupTips = $this->_getDupList(TAIZHANG_TD, $_POST['name']);
                        if($dupTips){
                            $info = $_POST;
                            $this->assign('saveText','确认');
                            $this->assign('dupTips','<p>名称'.$_POST['name'].'已入'.TAIZHANG_TD.'台账，点击<span class=\"notice\">确定</span>继续保存，</p><p>原台账号信息:</p>'.  implode('', $dupTips));
                            break;
                        }
                    }

                    $_POST['year'] = date("Y");
                    $_POST['month'] = date("m");
                    $_POST['category'] = TAIZHANG_TD;
                    $_POST['user_id'] = $this->_userProfile['id'];
                    $_POST['creator'] = $this->_userProfile['name'];
                    $_POST['sendor_id'] = $_POST['user_id'] ;
                    $_POST['sendor'] = $_POST['creator'];

                    $insertid = $this->_op($_POST['year'],'add');
                    $info = $this->Taizhang_Model->queryById($insertid);

                    $message = '操作成功';
                    $feed = 'success';
                    $this->assign('feed',$feed);
                    //$this->sendFormatJson('success', array('text' => '创建成功'));
                }
            }else{
                $info = $_POST;
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                //$message = strip_tags(validation_errors());
            }
            
            if($info['file_id']){
                $this->assign('files',$this->_getFiles($info['file_id']));
            }
            
            $this->assign('info',$info);
            $this->assign('message',$message);
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $projectInfo = $this->_fetchProjectInfo(TAIZHANG_TD);
        }
        $this->assign('gobackUrl',$gobackUrl);
        $this->_getStep($info);
        $this->display();
    }
    
    
    private function _op($year,$action = 'add'){
         // add
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
        
        if($action == 'add'){
            $master_serial = $this->Taizhang_Model->getCount(array(
                'where' => array(
                    'year' => $year,
                    'category' => TAIZHANG_TD
                )
            ));

            $region_serial = $this->Taizhang_Model->getCount(array(
                'where' => array(
                    'year' => $year,
                    'category' => TAIZHANG_TD,
                    'region_code' => $_POST['region_code']
                )
            ));
            
            $_POST['master_serial'] = $master_serial ? $master_serial + 1 : 1;
            $_POST['region_serial'] = $region_serial ? $region_serial + 1 : 1;
            $offset = config_item('offset_'.$year);
            if(!empty($offset)){
                $_POST['master_serial'] += (int)$offset['TD_TOTAL'];
                $_POST['region_serial'] += (int)$offset['TD'][$_POST['region_code']];
            }

            $_POST['project_no'] = $this->_formatProjectNo($year,$_POST['region_code'],$_POST['master_serial'],$_POST['region_serial']);
        }else{
            /*
            $master_serial = $this->Taizhang_Model->getMaxByWhere('master_serial',array(
                'year' => $year,
                'category' => TAIZHANG_TD,
                'id !=' => $_POST['id']
            ));

            $region_serial = $this->Taizhang_Model->getMaxByWhere('region_serial',array(
                'year' => $year,
                'category' => TAIZHANG_TD,
                'region_code' => $_POST['region_code'],
                'id !=' => $_POST['id']
            ));
             */
        }

        
        $project_type = $this->Project_Type_Model->queryById($_POST['type_id']);
        
        $_POST['ptype_id'] = $project_type['id'];
        $_POST['ptype_name'] = $project_type['name'];
        $_POST['pcate_name'] = $project_type['cate_name'];
        $_POST['weight'] = $project_type['weight'];
        
        if(!empty($_POST['file_id'])){
            $_POST['files'] = implode(',',$_POST['file_id']);
        }
        
        if($action == 'add'){
            $insertid = $this->Taizhang_Model->add($_POST);
            return $insertid;
        }else{
            $rows = $this->Taizhang_Model->update($_POST);
            return $rows;
        }
        
    }
    
    public function edit(){
        $this->assign('action','edit');
     
        if($this->isPostRequest() && !empty($_POST['id'])){
            $this->_addRules();
            $gobackUrl = $_POST['gobackUrl'];
            $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_POST['id'])));
            
            if($this->form_validation->run()){
                $_POST['updator'] = $this->_userProfile['name'];
                $_POST['id'] = $info['id'];
                
                $affectRow = $this->_op($info['year'],'edit');
                
                $this->_cleanFile($info['files'],$_POST['file_id']);
                
                
                $message = '操作成功';
                
                $info = $this->Taizhang_Model->getById(array('where' => array('id' => $info['id'])));
                //$this->sendFormatJson('success', array('text' => '修改成功'));
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                //$this->sendFormatJson('failed', array('text' => $message));
            }
            
            $this->assign('message',$message);
            
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
            $info = $this->Taizhang_Model->getById(array('where' => array('id' => $_GET['id'])));
        }
        
        $this->_initPageData($info['year']);
        if($info['files']){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        $this->_getStep($info);
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        if($info['churan_area']){
            $info['churan_area'] = sprintf("%.2f",$info['churan_area']);
        }
        
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display('add');
    }
    
    private function _initPageData($addYear){
        
        /**
         * 区域 
         */
        $regionList = $this->Region_Model->getList(array('where' => array('status' => '正常','year' => $addYear , 'name !=' => '其他'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('regionList',$regionList['data']);
        
        
        $projectTypeList = $this->Project_Type_Model->getList(array(
           'where_in' => array(
               array('key' => 'name','value' => array('日常宗地','招拍挂','供地','新征用地'))
           ),
           'order' => 'createtime ASC'
        ));
        
        $this->assign('projectTypeList',$projectTypeList['data']);
        /**
         * 项目性质 
         */
        $natureList = $this->Project_Nature_Model->getList(array('where' => array('status' => '正常','type' => '测绘项目'),'order' => 'displayorder DESC ,createtime ASC'));
        $this->assign('natureList',$natureList['data']);
        
        //$this->assign('yearList',yearList());
        //$this->assign('monthList',range(1,12));
        
    }
    
    /**
     * 
     */
    public function check(){
        $id = (int)gpc('id','GP',0);
        
        $info = $this->Taizhang_Model->queryById($id);
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
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

            $this->form_validation->set_rules('sendor', '发送给初审', 'required|is_natural_no_zero');
            
            if($this->form_validation->run()){
                $now = time();
                $op = '提交初审';
                $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                $data = array(
                    'sendor_id' => $sendorInfo['id'],
                    'sendor' => $sendorInfo['name'],
                    'status' => '已'.$op,
                    'updator' => $this->_userProfile['name'],
                    'updatetime' => $now,
                    'zc_time' => $now,
                    'zc_name' => $this->_userProfile['name'],
                    'zc_yj' => $_POST['zc_yj'],
                    'zc_remark' => $_POST['zc_remark']
                );
                $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '新增','sendor_id' => $this->_userProfile['id']));
                
                if($return){
                    $message = '操作成功';
                    $this->_addPm($info,$sendorInfo,2);
                    $info = $this->Taizhang_Model->queryById($id);
                }else{
                    $message = '操作失败';
                }
                
                $info = $this->Taizhang_Model->getById(array('where' => array('id' => $info['id'])));
                //$this->sendFormatJson('success', array('text' => '修改成功'));
            }else{
                $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                //$this->sendFormatJson('failed', array('text' => $message));
            }
            
            $this->assign('message',$message);
        }else{
            
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        if($info['files']){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        $this->_getSendorList(array(
            'ch_cs' => 'y'
        ));
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        $this->_getStep($info);
        $this->_getProjectFault($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display();
    }
    
    
    /**
     * 初审
     */
    public function first_sh(){
        $id = (int)gpc('id','GP',0);
        
        $info = $this->Taizhang_Model->queryById($id);
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            if($_POST['workflow'] == '退回'){
                
                //$this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
                    $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
                }
                if($this->form_validation->run()){
                    $d = $this->_addProjectFault($info,$_POST,0);
                    
                    $sendorInfo = $this->User_Model->queryById($info['zc_name'],'name');
                    $now = time();
                    $data = array(
                        'cs_time' => 0,
                        'cs_name' => '',
                        'cs_yj' => '',
                        'cs_remark' => '',
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'fault_cnt1' => (int)$d['fault_cnt1'],
                        'total_fault' => (int)$d['total_fault'],
                        'status' => '新增',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = '操作成功';
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = '操作失败';
                    }
                    
                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
                
            }else{
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
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交初审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = '操作成功';
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = '操作失败';
                    }

                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
            }
            
            $this->assign('message',$message);
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $this->_getStep($info);
        $this->_getSendorList(array(
            'ch_fs' => 'y'
        ));
        if(!empty($info['files'])){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        $this->_getProjectFault($info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->assign('info',$info);
        $this->display();
    }
    
    /**
     * 初审
     */
    public function second_sh(){
        $id = (int)gpc('id','GP',0);
        
        $info = $this->Taizhang_Model->queryById($id);
        if($this->isPostRequest() && !empty($_POST['id'])){
            $gobackUrl = $_POST['gobackUrl'];
            if($_POST['workflow'] == '退回'){
                
                //$this->form_validation->set_rules('reason', '退回原因', 'required|min_length[3]|htmlspecialchars');
                if($info['status'] == '已提交初审' || $info['status'] == '已提交复审'){
                    $this->form_validation->set_rules('fault[]', '缺陷信息', 'required');
                }
                if($this->form_validation->run()){
                    $d = $this->_addProjectFault($info,$_POST,0);
                    
                    $sendorInfo = $this->User_Model->queryById($info['cs_name'],'name');
                    $now = time();
                    $data = array(
                        'fs_time' => 0,
                        'fs_name' => '',
                        'fs_yj' => '',
                        'fs_remark' => '',
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'fault_cnt2' => (int)$d['fault_cnt2'],
                        'total_fault' => (int)$d['total_fault'],
                        'status' => '已提交初审',
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = '操作成功';
                        
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = '操作失败';
                    }
                    
                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
                
            }else{
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

                $this->form_validation->set_rules('sendor', '发送给', 'required|is_natural_no_zero');
                if($this->form_validation->run()){
                    $op = '通过复审';
                    
                    $sendorInfo = $this->User_Model->queryById($_POST['sendor']);
                    $now = time();
                    $data = array(
                        'sendor_id' => $sendorInfo['id'],
                        'sendor' => $sendorInfo['name'],
                        'status' => '已'.$op,
                        'updator' => $this->_userProfile['name'],
                        'updatetime' => $now,
                        'fs_time' => $now,
                        'fs_name' => $this->_userProfile['name'],
                        'fs_yj' => $_POST['fs_yj'],
                        'fs_remark' => $_POST['fs_remark']
                    );
                    $return = $this->Taizhang_Model->updateByWhere($data,array('id' => $info['id'], 'status' => '已提交复审','sendor_id' => $this->_userProfile['id']));
                    if($return){
                        $this->_addPm($info,$sendorInfo,2);
                        $message = '操作成功';
                        $info = $this->Taizhang_Model->queryById($id);
                    }else{
                        $message = '操作失败';
                    }

                }else{
                    $message = str_replace(array('"',"'","\n"),array('','','<br/>'),strip_tags(validation_errors()));
                }
            }
            
            $this->assign('message',$message);
        }else{
            $gobackUrl = $_SERVER['HTTP_REFERER'];
        }
        
        $this->_getStep($info);
        $this->_getSendorList(array(
            'ch_fee' => 'y'
        ));
        if(!empty($info['files'])){
            $this->assign('files',$this->_getFiles($info['files']));
        }
        
        if($info['total_area']){
            $info['total_area'] = sprintf("%.2f",$info['total_area']);
        }
        
        $this->_getProjectFault($info);
        $this->assign('info',$info);
        $this->assign('gobackUrl',$gobackUrl);
        $this->display();
    }
    
}
