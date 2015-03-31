<?php

require(APPPATH.'third_party/smarty'.TZ_SMATY_VERSION.'/Smarty.class.php');

/**
 *
 * 自定义 控制器 
 */
class TZ_Controller extends CI_Controller {
    public $_smarty = null;
    public $tplDir = '';
    public $tplName = '';
    public $isAjax = 0;
    public $reqtime;
    
    
    public function __construct(){
        parent::__construct();
        
        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        
        $this->form_validation->set_error_delimiters('<span class="'.config_item('validation_error').'">', '</span>');
        /*
        echo $this->uri->uri_string();
        //var_dump($this->uri);
        $array = array('product' => 'shoes', 'size' => 'large', 'color' => 'red');
        $str = $this->uri->assoc_to_uri($array);
        //echo $str;
         */
        $this->tplDir =  gpc(config_item('controller_trigger'), 'GP', 'index');
        $this->tplName = gpc(config_item('function_trigger'),'GP', 'index');
        $this->isAjax = gpc('isajax','GP',0);
        
        $this->reqtime = $_SERVER['REQUEST_TIME'];
        
        $this->_init_smarty();
        $this->_init_config();
        $this->_init_mobile();
        
        $this->setDefaultSEO();
    }
    
    protected function _init_smarty(){
        $this->_smarty = new Smarty();

        if(ENVIRONMENT == 'production'){
            //运行一段时间后再修改
            //$this->_smarty->compile_check = false;
            $this->_smarty->compile_check = true;
        }else{
            $this->_smarty->compile_check = true;
        }

        $this->_smarty->setTemplateDir(APPPATH.'templates'.DS);
        $this->_smarty->setCompileDir(APPPATH.'templates_c'.DS);
        //$this->_smarty->setPluginsDir(APPPATH.'plugins'.DS);
        $this->_smarty->setCacheDir(APPPATH.'cache'.DS);
        $this->_smarty->setConfigDir(APPPATH.'config'.DS);
    }
    
    protected function _init_config(){
        $this->load->model('Menu_Model');
        
        $currentMenuInfo = $this->Menu_Model->getById(array(
           'where' => array(
               'url' => config_item('controller_trigger').'='.$this->tplDir.'&'.config_item('function_trigger').'='.$this->tplName
           )
        ));
        
        if($currentMenuInfo){
            $parents = $this->Menu_Model->getParents($currentMenuInfo['id']);
        }
        
        if($parents){
            $parents = array_reverse($parents);
            $this->_smarty->assign('breadcrumb',$parents);
        }
        
        if(ENVIRONMENT == 'production'){
            $this->_smarty->assign('js_compress','min.');
        }
        
        $this->assign('tplDir',$this->tplDir);
        $this->assign('tplName',$this->tplName);
    }
    
    protected function _init_mobile(){
        
        
    }
    
    
    /**
     *
     * @param type $property
     * @param type $value 
     */
    protected function assign($property, $value) {
        $this->_smarty->assign($property, $value);
    }
    public function setTitle($title = ''){
        $this->assign('TITLE',$title);
    }
    
    public function setSEO($title = '', $keywords = '', $desc = ''){
        $this->assign('TITLE',$title);
        $this->assign('KEYWORDS',$keywords);
        $this->assign('DESCRIPTION',$desc);
    }
    
    public function setDefaultSEO(){
        $this->assign('TITLE','慈溪市土地勘测规划设计院有限公司协同办公系统');
        $this->assign('KEYWORDS','');
        $this->assign('DESCRIPTION','');
    }
    /**
     *
     * @param type $turn 
     */
    public function setCaching($turn = false){
        if($turn === Smarty::CACHING_LIFETIME_SAVED){
            ////表示 要自定义缓存时间
        }else{
            $turn = $turn === true ? true : false;
        }

        $this->_smarty->caching = $turn;
    }

    
    /**
     * 设置缓存时间
     * @param type $sec 
     */
    public function setCacheLifeTime($sec = 3600){
        $this->_smarty->cache_lifetime = $sec;
    }
    
    /**
     *
     * @param type $tplName
     * @param type $cache_id
     * @return type 
     */
    public function isCached($pageTplName,$cache_id = false){
        if(false != $cache_id){
            return $this->_smarty->isCached(TZ_TPL_PATH.$pageTplName.'.tpl',$cache_id);
        }else{
            return $this->_smarty->isCached(TZ_TPL_PATH.$pageTplName.'.tpl');
        }
    }
    
    /**
     *
     * @param type $page
     * @return boolean 
     */
    protected function fetch($pageTplName = null) {
        if (!is_null($pageTplName)) {
            return $this->_smarty->fetch(TZ_TPL_PATH.$pageTplName.'.tpl');
        }
        return false;
    }
    
    /**
     *
     * @param type $pageTplName 
     */
    public function display($pageTplName = '',$dir = ''){
        
        $pageTplName = strtolower($pageTplName);
        
        if(!$dir){
            $path = TZ_TPL_PATH.trim($this->tplDir,'/').'/';
        }else{
            $path = TZ_TPL_PATH.trim($dir,'/').'/';
        }
        
        $ajaxFile = '';
        
        if(!$pageTplName){
            $ajaxFile = 'ajax_'.$this->tplName .'.tpl';
            $file = $this->tplName .'.tpl';
        }else{
            $ajaxFile = 'ajax_'.$pageTplName.'.tpl';
            $file = $pageTplName.'.tpl';
        }
        
        header('P3P:CP=CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR")');
        if($this->isAjax && file_exists($path.$ajaxFile)){
            $this->_smarty->display($path.$ajaxFile);
        }elseif(file_exists($path.$file)){
            $this->_smarty->display($path.$file);
        }else{
            echo "$file not found";
        }
        die();
    }
    
    public function isGetRequest(){
        return 'get' == strtolower($_SERVER['REQUEST_METHOD']) ? 1 : 0;
    }
    public function isPostRequest(){
        return 'post' == strtolower($_SERVER['REQUEST_METHOD']) ? 1 : 0;
    }
    
    /**
     * 废弃
     * @param type $mainPageName 
     */
    public function setMainPage($mainPageName = 'index'){
        $this->assign('MAIN_PAGE_NAME',$mainPageName.'.tpl');
    }
    
    /**
     *
     * @param type $data
     * @param type $isJsonHead 
     */
    public function sendJson($data, $isJsonHead = true) {
        if($isJsonHead){
            header('P3P: CP="CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR"');
            header("Content-Type:application/json; charset=utf-8");
        }
            
         exit(json_encode($data));
    }
    
    
    /**
     *
     * @param type $respCode
     * @param type $body
     * @param type $redirectUrl
     * @param type $isJsonHead 
     */
    public function sendFormatJson($respCode,$body,$redirectUrl = '',$isJsonHead = true){
        if($isJsonHead){
            header("Content-Type:application/json; charset=utf-8");
            header('P3P: CP="CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR"');
        }
                
        $data = array(
            'code' => $respCode,
            'body' => $body
        );

        //重定向URL
        if('' != $redirectUrl){
            if(is_array($redirectUrl)){
                /**
                 * array(
                 *     'jsReload' => true, //js reload 可以不需要传入url, 当前页面自身刷新
                 *     'url' => ''
                 * ) 
                 */
                $data['redirectInfo'] = $redirectUrl;
            }else{
                $data['redirectUrl'] = $redirectUrl;
            }
        }

        exit(json_encode($data));
    }
    
    protected function getGobackUrl(){
    	$gobackUrl = '';
    	if($this->isGetRequest()){
    		$gobackUrl = $_SERVER['HTTP_REFERER'];
    	}elseif($this->isPostRequest()){
    		$gobackUrl = $_POST['gobackUrl'];
    	}
    	
    	return $gobackUrl;
    }
}