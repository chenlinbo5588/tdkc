<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_File extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('File_Model');
    }
    
    
	public function index()
	{
        $pid = (int)gpc('pid','GP',0);
        $this->_getList($pid);
		$this->display();
	}
    
    public function _getList($pid = 0){
        
        $this->load->helper('url');
        $this->load->helper('number');
        
        
        if($pid){
            
            $currentFolder = $this->File_Model->getById(array(
                'select' => 'id,pid,status,in_share',
                'where' => array('id' => $pid,'status' => 0)
            ));
            //do update first
            if($currentFolder['in_share']){
                //$this->db->query("UPDATE {$this->File_Model->_tableName} SET in_share = 1 WHERE pid = {$pid} AND in_share = 0 LIMIT 100");
            }else{
                $this->db->query("UPDATE {$this->File_Model->_tableName} SET in_share = 0 WHERE pid = {$pid} AND in_share = 1 LIMIT 500");
            }
        }
        
        $condition = array();
        //$condition['select'] = 'id,pid,file_name,status,is_dir,file_size,createtime';
        $condition['where'] = array(
            'pid' => $pid,
            'user_id' => $this->_userProfile['id'],
            'status' => 0
        );
        
        $data = $this->File_Model->getList($condition);
        
        $sumCondition['field'] = 'file_size';
        $sumCondition['where'] = $condition['where'];
        
        
        $sizeInfo = $this->File_Model->sumByCondition($sumCondition);
        $parents = $this->File_Model->getParents($pid);
        $parents = array_reverse($parents);
        //print_r($parents);
        $this->assign('parents',$parents);
        $this->assign('sizeInfo',$sizeInfo[0]);
        $this->assign('pid',$pid);
        $this->assign('data',$data);
        
    }
    
    
    private function _addRules(){
        $this->form_validation->set_rules('folder_name', '文件夹名称', 'trim|required|min_length[1]|max_length[300]|htmlspecialchars');
    }
    
    
    public function addfolder(){
        $pid = (int)gpc('pid','GP',0);
        
        $message = array();
        
        if($this->isPostRequest() && !empty($_POST['folder_name'])){
            $this->_addRules();
            if($this->form_validation->run()){

                for($i = 0; $i < 1; $i++){
                    $count = $this->File_Model->getCount(array(
                    'where' => array(
                        'user_id' => $this->_userProfile['id'],
                        'file_name' => $_POST['folder_name'],
                        'pid' => $pid,
                        'is_dir' => 1,
                        'status' => 0
                    ) 
                    ));

                    if($count){
                        $message = $_POST['folder_name']. ' 文件夹已经存在';
                        break;
                    }

                    $data = array(
                        'pid' => $_POST['pid'],
                        'file_name' => $_POST['folder_name'],
                        //'file_name' => null,
                        'createtime' => $now,
                        'updatetime' => $now,
                        'is_dir' => 1,
                        'creator' => $this->_userProfile['name'],
                        'updator' => $this->_userProfile['name'],
                        'createtime' => $this->reqtime,
                        'updatetime' => $this->reqtime,
                        'user_id' => $this->_userProfile['id'],
                        'ip' => get_ip()
                    );

                    $fileId = $this->File_Model->add($data);

                    if($fileId){
                        $message = '创建成功';
                    }else{
                        $message = '创建失败,数据库';
                    }
                }
            }else{
                $message = form_error('folder_name');
            }
        }else{
            $message = '请输入文件夹名称';
        }
        
        $this->assign('message',$message);
        
        $this->_getList($pid);
        $this->display('index');
    }
    
    
    /**
     * 
     */
    public function list_dir(){
        $selfid = $_GET['file_id'];
        
        $dirList = $this->File_Model->getListByTree(0,0 ,1,$this->_userProfile['id'],'&nbsp;&nbsp;');
        $this->assign('dirList',$dirList);
        
        $this->display();
    }
    
    private function _do($action){
        
        /**
        * 获得被勾选的文件和目录信息 
        */
        $data = $this->File_Model->getList(array(
            'select' => 'id,pid,is_dir,file_name,file_size',
            'where' => array(
                'status' => 0
            ),
            'where_in' => array(
                array('key' => 'id', 'value' => $_POST['file_id'])
            )
        ));

        //目录层级，包含当前目录
        $parents = $this->File_Model->getParents($_POST['move_id']);
        $this->File_Model->_parentList = array();
        $parentsFrom = $this->File_Model->getParents($_POST['from_id']);
        /**
         * 选中的文件和目录 
         */
        $selectedDir = array();
        $selectedFile = array();
        
        /**
         * 目标目录 目录层级 
         */
        $parentsDir = array();
        
        //记录忽略的文件和目录
        $ignoreDir = array();
        $ignoreFile = array();
        
        
        if(!empty($data['data'])){
            foreach($data['data'] as $v){
                if($v['is_dir']){
                    $selectedDir[$v['id']] = $v;
                }else{
                    $selectedFile[$v['id']] = $v;
                }
            }
        }
        
        if($parents){
            foreach($parents as $v){
                $parentsDir[] = $v['id'];
            }
        }
        /**
        * 被勾选的文件夹不能为 移动目标文件夹的父级,要忽略该目录, 防止循环引用
        */
        $tempDirList = array_keys($selectedDir);
        foreach($tempDirList as $v){
            if(in_array($v,$parentsDir)){
                $ignoreDir[] = $selectedDir[$v];
                unset($selectedDir[$v]);
            }
        }
        
        /**
         * 目标目录 目录和文件不能 和将要移动过来的 有重名,将重名的忽略
         */
        $dupList = $this->File_Model->getList(array(
            'where' => array('pid' => $_POST['move_id'],'status' => 0)
        ));
        
        if($dupList['data']){
            foreach($dupList['data'] as $k => $v){
                if($v['is_dir']){
                    foreach($selectedDir as $dk => $dv){
                        if($v['file_name'] == $dv['file_name']){
                            $ignoreDir[] = $selectedDir[$dk];
                            unset($selectedDir[$dk]);
                        }
                    }
                }else{
                    foreach($selectedFile as $dk => $dv){
                        if($v['file_name'] == $dv['file_name']){
                            $ignoreFile[] = $selectedFile[$dk];
                            unset($selectedFile[$dk]);
                        }
                    }
                    
                }
            }
        }
        
        
        /**
         * 可以开始移动了 
         */
        $updateIds= array();
        $changeSize = 0;
        foreach($selectedDir as $v){
            if($v['pid'] == $_POST['move_id']){
                continue;
            }
            
            $updateIds[] = $v['id'];
            $changeSize += $v['file_size'];
        }
        foreach($selectedFile as $v){
            if($v['pid'] == $_POST['move_id']){
                continue;
            }
            $updateIds[] = $v['id'];
            $changeSize += $v['file_size'];
        }
        
        if($updateIds){
            $this->db->query("UPDATE {$this->File_Model->_tableName} SET pid = {$_POST[move_id]}, updatetime = {$this->reqtime},updator = '{$this->_userProfile['name']}' WHERE id IN(".implode(',',$updateIds).')');
        }
        
        if($parentsFrom){
            $tpsIds = array();
            foreach($parentsFrom as $v){
                $tpsIds[] = $v['id'];
            }
            
            $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_size = file_size - {$changeSize}, updatetime = {$this->reqtime},updator = '{$this->_userProfile['name']}' WHERE id IN(".implode(',',$tpsIds).')');
        }
        if($parentsDir){
            $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_size = file_size + {$changeSize}, updatetime = {$this->reqtime},updator = '{$this->_userProfile['name']}' WHERE id IN(".implode(',',$parentsDir).')');
        }
        
        /*
        file_put_contents("text.txt",print_r($_POST,true));
        file_put_contents("text.txt",print_r($parents,true),FILE_APPEND);
        file_put_contents("text.txt",print_r($parentsFrom,true),FILE_APPEND);
        file_put_contents("text.txt",print_r($ignoreFile,true),FILE_APPEND);
        file_put_contents("text.txt",print_r($ignoreDir,true),FILE_APPEND);
        file_put_contents("text.txt",print_r($updateData,true),FILE_APPEND);
        file_put_contents("text.txt",print_r($changeSize,true),FILE_APPEND);
        file_put_contents("text.txt",print_r($parentsDir,true),FILE_APPEND);
        */
        
        return array(
            'ignored' => array(
                'dir' => $ignoreDir,
                'file' => $ignoreFile
            )
        );
    }
    
    
    
    public function move(){
        
        if($this->isPostRequest() && isset($_POST['move_id']) && isset($_POST['from_id'])){
            
            if($_POST['from_id'] == $_POST['move_id']){
                $this->sendFormatJson('success',array('id' => $_POST['from_id'] , 'text' => "移动成功"),url_path('my_file','index','pid='.$_POST['from_id']));
            }
            
            $message = array();
            $return = $this->_do('move');
            
            $keyname = array(
                'dir' => '文件夹',
                'file' => '文件'
            );
            foreach($return['ignored']['dir'] as $value){
                $message[] = "<p clas=\"notice\">{$value['file_name']}{$keyname['dir']}被忽略，目标文件件有重名</p>";
            }
            foreach($return['ignored']['file'] as $value){
                $message[] = "<p clas=\"notice\">{$value['file_name']}{$keyname['file']}被忽略，目标文件件有重名</p>";
            }
            
            $message[] = "<p>移动成功,2秒后自动刷新</p>";
            
            $this->sendFormatJson('success',array('id' => 0 , 'text' => implode('',$message),'wait' => 2),url_path('my_file','index','pid='.$_POST['from_id']));
            
        }else{
            $this->sendFormatJson('error',array('id' => 0 , 'text' => "请求错误"));
        }
        
        redirect(url_path('my_file','index','pid='.$from_id));
    }
    
    public function delete(){
        $from_id = (int)gpc('pid','GP',0);
        
        if($this->isPostRequest() && !empty($_POST['delete_id'])){
            
            $condition = array(
              'select' => 'id,pid,is_dir,file_size,status',
              'where' => array(
                  'status' => 0,
                  'user_id' => $this->_userProfile['id']
              ),
              'where_in' => array(
                  array(
                      'key' => 'id',
                      'value' => $_POST['delete_id']
                  )
              )
            );
            $files = $this->File_Model->getList($condition);
            $parents = $this->File_Model->getParents($from_id);
            $parentsDir = array();
            if($parents){
                foreach($parents as $v){
                    $parentsDir[] = $v['id'];
                }
            }
        
            if($files['data']){
                $changeSize = 0;
                $updateIds = array();
                foreach($files['data'] as $key => $val){
                    $updateIds[] = $val['id'];
                    $changeSize += $val['file_size'];
                }
                
                if($updateIds){
                    $this->db->query("UPDATE {$this->File_Model->_tableName} SET status = 1 , updatetime = {$this->reqtime},updator = '{$this->_userProfile['name']}' WHERE id IN(".implode(',',$updateIds).')');
                }
                
                if($parentsDir){
                    $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_size = file_size - {$changeSize} , updatetime = {$this->reqtime},updator = '{$this->_userProfile['name']}' WHERE id IN(".implode(',',$parentsDir).')');
                }
            }
            
            //$message = '删除成功';
        }else{
            //$message = '参数错误';
        }
        
        redirect(url_path('my_file','index','pid='.$from_id));
    }
    
    
    public function share(){
        $this->_shareOp('share');
    }
    
    public function unshare(){
        $this->_shareOp('unshare');
    }
    
    
    private function _shareOp($action = 'share'){
        $from_id = (int)gpc('pid','GP',0);
        
        $text = array(
            'share' => '共享',
            'unshare' => '取消共享'
        );
        
        if($this->isPostRequest() && !empty($_POST['id'])){
            
            $condition = array(
              'select' => 'id,pid,is_dir,file_size,status',
              'where' => array(
                  'status' => 0,
                  'user_id' => $this->_userProfile['id']
              ),
              'where_in' => array(
                  array(
                      'key' => 'id',
                      'value' => $_POST['id']
                  )
              )
            );
            $files = $this->File_Model->getList($condition);
            
            /*
            $parents = $this->File_Model->getParents($from_id);
            $parentsDir = array();
            if($parents){
                foreach($parents as $v){
                    $parentsDir[] = $v['id'];
                }
            }
             */
        
            if($files['data']){
                $updateIds = array();
                foreach($files['data'] as $key => $val){
                    $updateIds[] = $val['id'];
                }
                
                if($action == 'share'){
                    $in_share = 1;
                }else{
                    $in_share = 0;
                }
                if($updateIds){
                    $this->db->query("UPDATE {$this->File_Model->_tableName} SET in_share = {$in_share} , updatetime = {$this->reqtime},updator = '{$this->_userProfile['name']}' WHERE id IN(".implode(',',$updateIds).') AND pid = 0');
                }
            }
            
            $message = $text[$action].'成功';
        }else{
            $message = $text[$action].'失败，请提供正确的参数';
        }
        
        if(!empty($_POST['redirectUrl'])){
            redirect($_POST['redirectUrl'],'javascript');
        }else{
            $this->assign('message',$message);
            $this->_getList($from_id);
            $this->display('index');
        }
        
    }
    
    
    public function download(){
        $fid = (int)gpc('id','GP',0);
        $file = $this->File_Model->getById(array(
            'where' => array('id' => $fid),
            'user_id' => $this->_userProfile['id'],
            'is_dir' => 0,
            'status' => 0
        ));
        
        if(!$file){
            redirect(url_path('my_file'),'javascript');
        }else{
            $this->load->helper('download');
            $file_realpath = config_item('filestore_dir').$file['file_store_path'].$file['file_md5'].$file['file_extension'];
            if(file_exists($file_realpath)){
                $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_downs = file_downs + 1 WHERE id = {$file['id']}");
                force_download($file['file_real_name'],  file_get_contents($file_realpath));
            }else{
                redirect(url_path('my_file'),'javascript');
            }
        }
    }
    
}

