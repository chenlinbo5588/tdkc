<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_File extends TZ_Admin_Controller {

	public function __construct(){
        parent::__construct();
        $this->load->model('File_Model');
    }
    
    
	public function index()
	{
        $this->load->helper('url');
        $pid = empty($_GET['pid']) ? 0 : intval($_GET['pid']);
        $this->load->helper('number');
        
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
		$this->display();
	}
    
    private function _addRules(){
        $this->form_validation->set_rules('folder_name', '文件夹名称', 'trim|required|min_length[1]|max_length[300]|htmlspecialchars');
    }
    
    
    public function addfolder(){
        
        if($this->isPostRequest() && !empty($_POST['folder_name'])){
            $this->_addRules();
            if($this->form_validation->run()){
                
                $pid = (int)gpc('pid','GP',0);
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
                    $this->sendFormatJson('error',array( 'text' => '文件夹已经存在'));
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
                     $this->sendFormatJson('success',array('id' => $_POST['id'] , 'text' => '创建成功','wait' => 1),$_SERVER['HTTP_REFERER']);
                }else{
                    $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => form_error('name')));
                }
            }else{
                $this->sendFormatJson('error',array('id' => $_POST['id'] , 'text' => form_error('name')));
            }
        }else{
            $this->sendFormatJson('error',array('id' => 0 , 'text' => "请输入文件夹名称"));
        }
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
            $this->db->query("UPDATE {$this->File_Model->_tableName} SET pid = {$_POST[move_id]} WHERE id IN(".implode(',',$updateIds).')');
        }
        
        if($parentsFrom){
            $tpsIds = array();
            foreach($parentsFrom as $v){
                $tpsIds[] = $v['id'];
            }
            
            $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_size = file_size - " .$changeSize ." WHERE id IN(".implode(',',$tpsIds).')');
        }
        if($parentsDir){
            $this->db->query("UPDATE {$this->File_Model->_tableName} SET file_size = file_size + " .$changeSize ." WHERE id IN(".implode(',',$parentsDir).')');
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
        
    }
}

