<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class File extends TZ_Controller {
    public function __construct(){
        parent::__construct();
        $this->load->model('File_Model');
    }
    
    public function index()
    {
        $folder_id = (int)gpc('folder_id','G',0);
        $uid = (int)gpc('uid','G',0);
        
        $this->assign('folder_id',$folder_id);
        $this->assign('uid',$uid);
        
        $this->display();
    }
    
    public function dir(){
        
    }
    
    public function upload(){
        
        $this->load->helper('directory');
        $this->load->helper('file');
        
        $folder_id = (int)gpc('folder_id','G',0);
        $uid = (int)gpc('uid','G',0);
        
        
        $keyname = 'Filedata';
        if(0 === $_FILES['imgFile']['error']){
            $keyname = 'imgFile';
		}
        //file_put_contents("text.txt", print_r($_FILES,true));
        $attachment = array(
            'filename'  => $_FILES[$keyname]['name'],
            'filesize'  => $_FILES[$keyname]['size'],
            'type'		=> $_FILES[$keyname]["type"],
        );
        
        $count = $this->File_Model->getCount(array(
            'where' => array(
                'user_id' => $uid,
                'status' => 0,
                'pid' => $folder_id,
                'file_name' => $attachment['filename']
            )
        ));
        
        if($count){
            $this->sendJson(array('error' => 1,"message" => '文件已经存在'));
        }
        
        
        $suffix = substr($attachment['filename'],strrpos($attachment['filename'],'.'));
        $suffix = strtolower($suffix);

        $imgTypes = array(
            "image/jpeg",
            "image/pjpeg",
            "image/png",
            "image/x-png",
            "image/gif",
            "image/bmp"
        );

        $isImage = 0;
        if(in_array($_FILES[$keyname]['type'],$imgTypes) || in_array($suffix,array('.jpg','.jpeg','.png','.gif','.bmp'))){
            $isImage = 1;
        }
        
        $width = true == empty($_POST['width']) ? 960 : intval($_POST['width']);
        $height = true == empty($_POST['height']) ? 540 : intval($_POST['height']);
        if(1 == $isImage){
            list($width, $height, $type, $attr) = getimagesize($_FILES[$keyname]['tmp_name']);
        }
        
        $urlPath = config_item('filestore_path');
        $filePath = realpath(dirname(APPPATH)).$urlPath;
        
        $fileDir = date("Y/m/d");
        
        make_dir($filePath.'/'.$fileDir.'/');
        $file_md5 = md5($attachment['filename'].$attachment['filesize'].mt_rand(100, 999));
        $newFilePath = $fileDir.'/'.$file_md5.$suffix;
        
        $now = time();
        $file_key = random(8);
        $file_description = '';
        
        
        
        $data = array(
            'pid' => $folder_id,
            'file_name' => $attachment['filename'],
            'file_key' => $file_key,
            'file_extension' => $suffix,
            'is_image' => $isImage,
            'file_mime' => $attachment['type'],
            'file_description' => $file_description ? $file_description : '',
            'file_store_path' => $fileDir.'/',
            'file_real_name' => $attachment['filename'],
            'file_md5' => $file_md5 ? $file_md5 : '',
            'file_size' => $attachment['filesize'],
            'thumb_size' => 0,
            'user_id' => $uid,
            'createtime' => $now,
            'updatetime' => $now,
            'ip' => get_ip()
        );
      
        try {
            
            $fileId = $this->File_Model->add($data);
            
            /**
             * 目录数上 每个节点都要增加 
             */
            $parents = $this->File_Model->getParents($folder_id);
            $increseIds = array();
            foreach($parents as $v){
                $increseIds[] = $v['id'];
            }
            
            
            if($increseIds){
                //file_put_contents("incres_parent.txt",print_r($increseIds,true));
                $this->db->set('file_size', 'file_size+'. $attachment['filesize'], FALSE);
                $this->db->where_in('id' ,$increseIds);
                $this->db->update($this->File_Model->_tableName);
            }
            
            $retAry = array('error' => 1,"message" => '上传成功','width' => $width,'height'=> $height,'size' => $data['file_size'], 'url' => $urlPath.$newFilePath);
                
            if(!$fileId){
                $retAry['message'] = '数据库错误';
            }else{
                $retAry['id'] = $fileId;
                if(move_uploaded_file($_FILES[$keyname]['tmp_name'],$filePath.$newFilePath)){
                    $retAry['error'] = 0;
                }
            }
        }catch(Exception $e){
            $retAry = array('error' => 1,"message" => '数据库错误,'.$e->getCode());
        }
        
        @unlink($_FILES[$keyname]['tmp_name']);
        
        if('Filedata' == $keyname){
            $this->sendJson($retAry);
        }else{
            header('Content-type: text/html; charset=UTF-8');
            echo json_encode(array('error' => 0, 'url' => $urlPath.$newFilePath));
           
        }
    }
}
