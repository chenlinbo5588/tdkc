<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Index extends TZ_Controller {
    public function __construct(){
        parent::__construct();
        
        $this->assign('cssFiles',array('site'));
    }
    
    public function index()
    {
        /*
        try {
            $this->load->model("Image_Model");
            $condition['where'] = array('name ' => 'home_page');
            $row = $this->Image_Model->getList($condition);
            
            if(!empty($row[0])){
                $images = json_decode($row[0]['online_images'],true);
                
                if(!empty($images)){
                    $this->assign('data',$images);
                }
            }
            
        }catch(Exception $e){
            //
        }*/
        
        $this->assign('top_menu','首页');
        $this->display('index');
    }
    
    public function preview()
    {
         try {
            $this->load->model("Image_Model");
            $condition['where'] = array('name ' => 'home_page' );
            $row = $this->Image_Model->getList($condition);

            if(!empty($row[0])){
                $row[0]['images'] = json_decode($row[0]['images'],true);
                
                $this->assign('pdata',$row[0]['images']);
            }
            
        }catch(Exception $e){
            //
        }
        
        $this->assign('preview_mode',"preview_mode");
        $this->assign('top_menu','首页');
        $this->setTitle('万达奴官方网站-首页');
        $this->display('index');
    }
    
    
    public function brand()
    {
        
        $ext_arr = array('jpg', 'jpeg');
        $brandPath = realpath(dirname(BASEPATH)).'/img/store/';
        
        
        $file_list = array();
        if ($handle = opendir($brandPath)) {
            $i = 0;
            while (false !== ($filename = readdir($handle))) {
                if ($filename{0} == '.') continue;
                $file = $brandPath . $filename;
                if (is_dir($file)) {
                    continue;
                    /*
                    $file_list[$i]['is_dir'] = true; //是否文件夹
                    $file_list[$i]['has_file'] = (count(scandir($file)) > 2); //文件夹是否包含文件
                    $file_list[$i]['filesize'] = 0; //文件大小
                    $file_list[$i]['is_photo'] = false; //是否图片
                    $file_list[$i]['filetype'] = ''; //文件类别，用扩展名判断
                    
                     */
                } else {
                    $file_list[$i]['is_dir'] = false;
                    $file_list[$i]['has_file'] = false;
                    $file_list[$i]['filesize'] = filesize($file);
                    $file_list[$i]['dir_path'] = '';
                    $file_ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
                    $file_list[$i]['is_photo'] = in_array($file_ext, $ext_arr);
                    $file_list[$i]['filetype'] = $file_ext;
                    
                    
                    $file_list[$i]['filename'] = urlencode($filename); //文件名，包含扩展名
                    if('production' == ENVIRONMENT){
                        $filename = iconv('gb2312','UTF-8',$filename);
                    }
                    if(!strpos($file,$file_ext)){
                        $file_ext = strtoupper($file_ext);
                    }
                    
                    //$file_ext = str_replace('.','',$file_ext) ;
                    
                    $file_list[$i]['showname'] = str_replace('.','',str_replace($file_ext,'',$filename));
                    $file_list[$i]['datetime'] = date('Y-m-d H:i:s', filemtime($file)); //文件最后修改时间
                    $i++;
                }
                
            }
            closedir($handle);
        }
        
        usort($file_list, 'cmp_func');
        
        $current_page = isset($_GET['page']) ? intval($_GET['page']) : 1;
        
        
        $page_size = 6;
        $total_page = ceil(count($file_list)/6);
        $keys = array_keys($file_list);
        
        $list = array();
        
        $start = ($current_page - 1) * $page_size;
        $index = $start;
        
        while(isset($file_list[$index])){
            $list[] = $file_list[$index];
            
            $index++;
            
            if(($index - $start) >= $page_size){
                break;
            }
        }
        
        //print_r($list);
        $this->assign('total_page',$total_page);
        $this->assign('current_page',$current_page);
        $this->assign("list",$list);
        
        $this->assign('prev_link',url_path('index','brand',array('page' => ($current_page <=1 ? 1 : ($current_page - 1))),true));
        $this->assign('next_link',url_path('index','brand',array('page' => ($current_page >= $total_page ?  $total_page : ($current_page + 1))),true));
        
        $this->assign('top_menu','品牌形象');
        $this->setTitle('品牌形象');
        $this->display("brand");
    }
    
    public function contact_us()
    {
        $this->assign('top_menu','联系我们');
        $this->setTitle('联系我们');
        $this->display("contact_us");
    }
    
    public function about_us()
    {
        $this->assign('top_menu','关于我们');
        $this->setTitle('关于我们');
        $this->display("about_us");
    }
    
    public function advertise()
    {
        $this->assign('top_menu','人才招聘');
        $this->setTitle('人才招聘');
        $this->display("advertise");
    }
    
    
    public function join_us()
    {
        $this->assign('join_us_menu','加盟政策');
        $this->setTitle('加盟政策');
        $this->display("join_us");
        
    }
    
    public function join_us_flow()
    {
        $this->assign('join_us_menu','加盟流程');
        $this->setTitle('加盟流程');
        $this->display("join_us_flow");
    }
    
    
    public function news_list()
    {
        
        try {
            $this->load->model("News_Model");
            
            $where = array(
                'status' => '已发布'
            );
            
            $this->db->where($where);
            $config['total_rows'] = $this->db->count_all_results($this->News_Model->_tableName);
            $config['per_page'] = 3;
            
            
            if(empty($_GET['page'])){
                $_GET['page'] = 1;
            }
            
            $pager = pageArrayGenerator($_GET['page'],$config['per_page'],$config['total_rows'],url_path('index','news_list',array(),true));
            $this->assign('page',$pager);
            
            //$condition['select'] = 'a';
            $condition['where'] = $where;
            $condition['pager'] = array(
                'page_size' => $config['per_page'],
                'current_page' => isset($_GET['page']) ? intval($_GET['page']) : 1
            );
            
            $data = $this->News_Model->getList($condition);
            foreach($data as $k => $v ){
                $data[$k]['detail_url'] = url_path('index','news_detail',array('id' => $v['news_id']),true);
            };
            
            //print_r($data);
            //print_r($pager);
            
            $this->assign('list',$data);
            $this->assign('page',$pager);
            $this->setTitle('新闻列表页');
            $this->display("news_list");
        }catch(Exception $e){
            
        }
        
    }
    
    public function news_detail()
    {
        
        try {
            $this->load->model("News_Model");
            $where = array(
                'status' => '已发布',
                'news_id' => isset($_GET['id']) ? $_GET['id'] : 0
            );
            $condition['where'] = $where;
            
            $data = $this->News_Model->getList($condition);
            
            if(isset($data[0])){
                $this->assign('data',$data[0]);
            }
        }catch(Exception $e){
            
        }
        
        $this->setTitle('新闻详情');
        $this->display("news_detail");
    }
    
    
    public function news_preview()
    {
        
        try {
            $this->load->model("News_Model");
            $where = array(
                'news_id' => isset($_GET['id']) ? $_GET['id'] : 0
            );
            $condition['where'] = $where;
            
            $data = $this->News_Model->getList($condition);
            
            if(isset($data[0])){
                $this->assign('data',$data[0]);
            }
        }catch(Exception $e){
            
        }
        
        $this->setTitle('新闻详情');
        $this->display("news_detail");
    }
    
}
