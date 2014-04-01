<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class File extends TZ_Controller {
    public function __construct(){
	parent::__construct();
	
    }
    
    public function index()
    {
        die();
    }
    
    public function dir(){
        
    }
    
    
    
    public function upload(){
        
        $keyname = 'Filedata';
        if(0 === $_FILES['imgFile']['error']){
            $keyname = 'imgFile';
		}
        
        $attachment = array(
            'filename'  => $_FILES[$keyname]['name'],
            'filesize'  => $_FILES[$keyname]['size'],
            'type'		=> $_FILES[$keyname]["type"]
        );
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

        $urlPath = '/img/Files/';
        $attachmentPath = realpath(dirname(APPPATH)).$urlPath;
        
        $monthDir = date("Ym");
        if(!is_dir($attachmentPath.'/'.$monthDir)){
            mkdir($attachmentPath.'/'.$monthDir);
        }
        
        $newfilename = md5($attachment['filename'].$attachment['filesize'].mt_rand(100, 999));
        $newFilePath = $monthDir.'/'.$newfilename.$suffix;
        
        $data['file_name'] = $attachment['filename'];
        $data['file_size'] = $attachment['filesize'];
        $data['file_suffix'] = $suffix;
        $data['path_name'] = $newFilePath;
        $data['width'] = $width;
        $data['height'] = $height;
        $now = date('Y-m-d H:i:s');
        $data['createtime'] = $now;
        $data['updatetime'] = $now;
        
        try {
            $this->load->model('Attachment_Model');
            $fileId = $this->Attachment_Model->add($data);
            
            $retAry = array('error' => 1,"message" => '','width' => $width,'height'=> $height,'size' => $data['file_size'], 'url' => $urlPath.$newFilePath);
                
            if(!$fileId){
                $retAry['message'] = 'db error';
            }else{
                $retAry['id'] = $fileId;
                if(move_uploaded_file($_FILES[$keyname]['tmp_name'],$attachmentPath.$newFilePath)){
                    $retAry['error'] = 0;
                }
            }
        }catch(Exception $e){
            $retAry = array('error' => 1,"message" => 'db error,'.$e->getCode());
        }
        
        if('Filedata' == $keyname){
            $this->sendJson($retAry);
        }else{
            header('Content-type: text/html; charset=UTF-8');
            echo json_encode(array('error' => 0, 'url' => $urlPath.$newFilePath));
           
        }
        
    }
}
