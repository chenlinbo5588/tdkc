<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * CodeIgniter
 *
 * An open source application development framework for PHP 5.1.6 or newer
 *
 * @package		CodeIgniter
 * @author		ExpressionEngine Dev Team
 * @copyright	Copyright (c) 2008 - 2011, EllisLab, Inc.
 * @license		http://codeigniter.com/user_guide/license.html
 * @link		http://codeigniter.com
 * @since		Version 1.0
 * @filesource
 */

// ------------------------------------------------------------------------

/**
 * Common Functions
 *
 * Loads the base classes and executes the request.
 *
 * @package		CodeIgniter
 * @subpackage	codeigniter
 * @category	Common Functions
 * @author		ExpressionEngine Dev Team
 * @link		http://codeigniter.com/user_guide/
 */

// ------------------------------------------------------------------------

/**
* Determines if the current version of PHP is greater then the supplied value
*
* Since there are a few places where we conditionally test for PHP > 5
* we'll set a static variable.
*
* @access	public
* @param	string
* @return	bool	TRUE if the current version is $version or higher
*/
if ( ! function_exists('is_php'))
{
	function is_php($version = '5.0.0')
	{
		static $_is_php;
		$version = (string)$version;

		if ( ! isset($_is_php[$version]))
		{
			$_is_php[$version] = (version_compare(PHP_VERSION, $version) < 0) ? FALSE : TRUE;
		}

		return $_is_php[$version];
	}
}

// ------------------------------------------------------------------------

/**
 * Tests for file writability
 *
 * is_writable() returns TRUE on Windows servers when you really can't write to
 * the file, based on the read-only attribute.  is_writable() is also unreliable
 * on Unix servers if safe_mode is on.
 *
 * @access	private
 * @return	void
 */
if ( ! function_exists('is_really_writable'))
{
	function is_really_writable($file)
	{
		// If we're on a Unix server with safe_mode off we call is_writable
		if (DIRECTORY_SEPARATOR == '/' AND @ini_get("safe_mode") == FALSE)
		{
			return is_writable($file);
		}

		// For windows servers and safe_mode "on" installations we'll actually
		// write a file then read it.  Bah...
		if (is_dir($file))
		{
			$file = rtrim($file, '/').'/'.md5(mt_rand(1,100).mt_rand(1,100));

			if (($fp = @fopen($file, FOPEN_WRITE_CREATE)) === FALSE)
			{
				return FALSE;
			}

			fclose($fp);
			@chmod($file, DIR_WRITE_MODE);
			@unlink($file);
			return TRUE;
		}
		elseif ( ! is_file($file) OR ($fp = @fopen($file, FOPEN_WRITE_CREATE)) === FALSE)
		{
			return FALSE;
		}

		fclose($fp);
		return TRUE;
	}
}

// ------------------------------------------------------------------------

/**
* Class registry
*
* This function acts as a singleton.  If the requested class does not
* exist it is instantiated and set to a static variable.  If it has
* previously been instantiated the variable is returned.
*
* @access	public
* @param	string	the class name being requested
* @param	string	the directory where the class should be found
* @param	string	the class name prefix
* @return	object
*/
if ( ! function_exists('load_class'))
{
	function &load_class($class, $directory = 'libraries', $prefix = 'CI_')
	{
		static $_classes = array();

		// Does the class exist?  If so, we're done...
		if (isset($_classes[$class]))
		{
			return $_classes[$class];
		}

		$name = FALSE;

		// Look for the class first in the local application/libraries folder
		// then in the native system/libraries folder
		foreach (array(APPPATH, BASEPATH) as $path)
		{
			if (file_exists($path.$directory.'/'.$class.'.php'))
			{
				$name = $prefix.$class;

				if (class_exists($name) === FALSE)
				{
					require($path.$directory.'/'.$class.'.php');
				}

				break;
			}
		}

		// Is the request a class extension?  If so we load it too
		if (file_exists(APPPATH.$directory.'/'.config_item('subclass_prefix').$class.'.php'))
		{
			$name = config_item('subclass_prefix').$class;

			if (class_exists($name) === FALSE)
			{
				require(APPPATH.$directory.'/'.config_item('subclass_prefix').$class.'.php');
			}
		}

		// Did we find the class?
		if ($name === FALSE)
		{
			// Note: We use exit() rather then show_error() in order to avoid a
			// self-referencing loop with the Excptions class
			exit('Unable to locate the specified class: '.$class.'.php');
		}

		// Keep track of what we just loaded
		is_loaded($class);

		$_classes[$class] = new $name();
		return $_classes[$class];
	}
}

// --------------------------------------------------------------------

/**
* Keeps track of which libraries have been loaded.  This function is
* called by the load_class() function above
*
* @access	public
* @return	array
*/
if ( ! function_exists('is_loaded'))
{
	function &is_loaded($class = '')
	{
		static $_is_loaded = array();

		if ($class != '')
		{
			$_is_loaded[strtolower($class)] = $class;
		}

		return $_is_loaded;
	}
}

// ------------------------------------------------------------------------

/**
* Loads the main config.php file
*
* This function lets us grab the config file even if the Config class
* hasn't been instantiated yet
*
* @access	private
* @return	array
*/
if ( ! function_exists('get_config'))
{
	function &get_config($replace = array())
	{
		static $_config;

		if (isset($_config))
		{
			return $_config[0];
		}

		require APPPATH.'config/config.php';
		// Is the config file in the environment folder?
		if (file_exists($file_path = APPPATH.'config/'.ENVIRONMENT.'/config.php'))
		{
			require $file_path;
		}
		
		// Does the $config array exist in the file?
		if ( ! isset($config) OR ! is_array($config))
		{
			exit('Your config file does not appear to be formatted correctly.');
		}

		// Are any values being dynamically replaced?
		if (count($replace) > 0)
		{
			foreach ($replace as $key => $val)
			{
				if (isset($config[$key]))
				{
					$config[$key] = $val;
				}
			}
		}

		return $_config[0] =& $config;
	}
}

// ------------------------------------------------------------------------

/**
* Returns the specified config item
*
* @access	public
* @return	mixed
*/
if ( ! function_exists('config_item'))
{
	function config_item($item)
	{
		static $_config_item = array();

		if ( ! isset($_config_item[$item]))
		{
			$config =& get_config();

			if ( ! isset($config[$item]))
			{
				return FALSE;
			}
			$_config_item[$item] = $config[$item];
		}

		return $_config_item[$item];
	}
}

// ------------------------------------------------------------------------

/**
* Error Handler
*
* This function lets us invoke the exception class and
* display errors using the standard error template located
* in application/errors/errors.php
* This function will send the error page directly to the
* browser and exit.
*
* @access	public
* @return	void
*/
if ( ! function_exists('show_error'))
{
	function show_error($message, $status_code = 500, $heading = 'An Error Was Encountered')
	{
		$_error =& load_class('Exceptions', 'core');
		echo $_error->show_error($heading, $message, 'error_general', $status_code);
		exit;
	}
}

// ------------------------------------------------------------------------

/**
* 404 Page Handler
*
* This function is similar to the show_error() function above
* However, instead of the standard error template it displays
* 404 errors.
*
* @access	public
* @return	void
*/
if ( ! function_exists('show_404'))
{
	function show_404($page = '', $log_error = TRUE)
	{
		$_error =& load_class('Exceptions', 'core');
		$_error->show_404($page, $log_error);
		exit;
	}
}

// ------------------------------------------------------------------------

/**
* Error Logging Interface
*
* We use this as a simple mechanism to access the logging
* class and send messages to be logged.
*
* @access	public
* @return	void
*/
if ( ! function_exists('log_message'))
{
	function log_message($level = 'error', $message, $php_error = FALSE)
	{
		static $_log;

		if (config_item('log_threshold') == 0)
		{
			return;
		}

		$_log =& load_class('Log');
		$_log->write_log($level, $message, $php_error);
	}
}

// ------------------------------------------------------------------------

/**
 * Set HTTP Status Header
 *
 * @access	public
 * @param	int		the status code
 * @param	string
 * @return	void
 */
if ( ! function_exists('set_status_header'))
{
	function set_status_header($code = 200, $text = '')
	{
		$stati = array(
							200	=> 'OK',
							201	=> 'Created',
							202	=> 'Accepted',
							203	=> 'Non-Authoritative Information',
							204	=> 'No Content',
							205	=> 'Reset Content',
							206	=> 'Partial Content',

							300	=> 'Multiple Choices',
							301	=> 'Moved Permanently',
							302	=> 'Found',
							304	=> 'Not Modified',
							305	=> 'Use Proxy',
							307	=> 'Temporary Redirect',

							400	=> 'Bad Request',
							401	=> 'Unauthorized',
							403	=> 'Forbidden',
							404	=> 'Not Found',
							405	=> 'Method Not Allowed',
							406	=> 'Not Acceptable',
							407	=> 'Proxy Authentication Required',
							408	=> 'Request Timeout',
							409	=> 'Conflict',
							410	=> 'Gone',
							411	=> 'Length Required',
							412	=> 'Precondition Failed',
							413	=> 'Request Entity Too Large',
							414	=> 'Request-URI Too Long',
							415	=> 'Unsupported Media Type',
							416	=> 'Requested Range Not Satisfiable',
							417	=> 'Expectation Failed',

							500	=> 'Internal Server Error',
							501	=> 'Not Implemented',
							502	=> 'Bad Gateway',
							503	=> 'Service Unavailable',
							504	=> 'Gateway Timeout',
							505	=> 'HTTP Version Not Supported'
						);

		if ($code == '' OR ! is_numeric($code))
		{
			show_error('Status codes must be numeric', 500);
		}

		if (isset($stati[$code]) AND $text == '')
		{
			$text = $stati[$code];
		}

		if ($text == '')
		{
			show_error('No status text available.  Please check your status code number or supply your own message text.', 500);
		}

		$server_protocol = (isset($_SERVER['SERVER_PROTOCOL'])) ? $_SERVER['SERVER_PROTOCOL'] : FALSE;

		if (substr(php_sapi_name(), 0, 3) == 'cgi')
		{
			header("Status: {$code} {$text}", TRUE);
		}
		elseif ($server_protocol == 'HTTP/1.1' OR $server_protocol == 'HTTP/1.0')
		{
			header($server_protocol." {$code} {$text}", TRUE, $code);
		}
		else
		{
			header("HTTP/1.1 {$code} {$text}", TRUE, $code);
		}
	}
}

// --------------------------------------------------------------------

/**
* Exception Handler
*
* This is the custom exception handler that is declaired at the top
* of Codeigniter.php.  The main reason we use this is to permit
* PHP errors to be logged in our own log files since the user may
* not have access to server logs. Since this function
* effectively intercepts PHP errors, however, we also need
* to display errors based on the current error_reporting level.
* We do that with the use of a PHP error template.
*
* @access	private
* @return	void
*/
if ( ! function_exists('_exception_handler'))
{
	function _exception_handler($severity, $message, $filepath, $line)
	{
		 // We don't bother with "strict" notices since they tend to fill up
		 // the log file with excess information that isn't normally very helpful.
		 // For example, if you are running PHP 5 and you use version 4 style
		 // class functions (without prefixes like "public", "private", etc.)
		 // you'll get notices telling you that these have been deprecated.
		if ($severity == E_STRICT)
		{
			return;
		}

		$_error =& load_class('Exceptions', 'core');

		// Should we display the error? We'll get the current error_reporting
		// level and add its bits with the severity bits to find out.
		if (($severity & error_reporting()) == $severity)
		{
			$_error->show_php_error($severity, $message, $filepath, $line);
		}

		// Should we log the error?  No?  We're done...
		if (config_item('log_threshold') == 0)
		{
			return;
		}

		$_error->log_exception($severity, $message, $filepath, $line);
	}
}

// --------------------------------------------------------------------

/**
 * Remove Invisible Characters
 *
 * This prevents sandwiching null characters
 * between ascii characters, like Java\0script.
 *
 * @access	public
 * @param	string
 * @return	string
 */
if ( ! function_exists('remove_invisible_characters'))
{
	function remove_invisible_characters($str, $url_encoded = TRUE)
	{
		$non_displayables = array();
		
		// every control character except newline (dec 10)
		// carriage return (dec 13), and horizontal tab (dec 09)
		
		if ($url_encoded)
		{
			$non_displayables[] = '/%0[0-8bcef]/';	// url encoded 00-08, 11, 12, 14, 15
			$non_displayables[] = '/%1[0-9a-f]/';	// url encoded 16-31
		}
		
		$non_displayables[] = '/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]+/S';	// 00-08, 11, 12, 14-31, 127

		do
		{
			$str = preg_replace($non_displayables, '', $str, -1, $count);
		}
		while ($count);

		return $str;
	}
}

// ------------------------------------------------------------------------

/**
* Returns HTML escaped variable
*
* @access	public
* @param	mixed
* @return	mixed
*/
if ( ! function_exists('html_escape'))
{
	function html_escape($var)
	{
		if (is_array($var))
		{
			return array_map('html_escape', $var);
		}
		else
		{
			return htmlspecialchars($var, ENT_QUOTES, config_item('charset'));
		}
	}
}


/**
 * 截取字符串
 *
 * @param string $str
 * @param int $len
 * @param int $mode
 *
 * @return string
 */
function cut($str, $len, $mode = true) {
	$tmp = '';
	
	$sLen = mb_strlen($str, 'UTF-8');
	if (($sLen <= $len) || (true === empty($len))) {
		
		return $str;
	} else {
		$tmp = mb_substr($str, 0, $len, 'UTF-8');
		
	}
	return ($mode) ? $tmp . '...' : $tmp;
}


/**
 * 跳转
 *
 * @param string $url
 * @param int $method
 * @param mix $extend
 *
 * @return void
 */
function location($url, $method = 1, $extend = 2) {
    switch ($method) {
	case 3:
		if (is_int($extend)) {
			header("HTTP/1.1 200 OK");
			echo '<meta http-equiv="refresh" content="' . $extend . '; url=' . $url . '" >';
		}
		break;
	case 2:
		if (is_string($extend)) {
			header("HTTP/1.1 200 OK");
			echo '<script language="javascript" >alert("' . $extend . '");window.location.replace(\'' . $url . '\');</script>';
		}
		break;
	case 4:
		if (is_string($extend)) {
			header("HTTP/1.1 200 OK");
			echo '<script language="javascript" >history.go('.$extend.');</script>';
		}
		break;
	case 5:
		if (is_string($extend)) {
			//header("HTTP/1.1 200 OK");
			echo '<script language="javascript" >alert("' . $extend . '");window.location.href = "'. $url .'";</script>';
		}
		break;
	case 6:
		if (is_string($extend)) {
			//header("HTTP/1.1 200 OK");
			echo '<script language="javascript" >alert("' . $extend . '");window.close();</script>';
		}
		break;
	case 1:	//302方式
	default:
		header('Location:' . $url);
		break;
    }
    exit;
}

/**
 * 组装URL 路径 支持查询串 和 URL rewrite 路径
 * @param type $control
 * @param type $method
 * @param type $param 
 * @param type $widthEntrance 
 */
function url_path($control = 'index',$method = 'index',$param = '',$widthEntrance = true){
    
    $url_path = array();
    $s = array();
    $t = array();
    
    if(is_array($param)){
        foreach($param as $k => $v){
            $t[] = $k.'='.urlencode($v);
        }
        
        if(!empty($t)){
            $param = implode('&',$t);
        }
    }
    
    if(config_item('enable_query_strings')){
        $url_path[config_item('controller_trigger')] = $control;
        $url_path[config_item('function_trigger')] = $method;
        
        foreach($url_path as $k => $v){
            $s[] = $k.'='.urlencode($v);
        }
        
        return ($widthEntrance == true ? '/'.config_item('index_page').'?': '').implode('&', $s).($param ? '&'.$param : '');
    }else{
        $string  = '/'.$control.'/'.$method.'/';
        $tparam = explode('&',$param);
        
        foreach($tparam as $k => $v){
            $s[] = $k .'/'.$v;
        }
        
        return ($widthEntrance == true ? '/'.config_item('index_page') : '').$string.implode('/', $s);
    }
    
}


function pagination_config($page_param_name = 'per_page'){
   
    $config['full_tag_open'] = '<ul class="pagination">';
    $config['full_tag_close'] = '</ul>';
    $config['first_link'] = '第一页';
    $config['first_tag_open'] = '<li>';
    $config['first_tag_close'] = '</li>';
    $config['last_link'] = '最后页';
    $config['last_tag_open'] = '<li>';
    $config['last_tag_close'] = '</li>';
    $config['next_link'] = '&gt;';
    $config['next_tag_open'] = '<li>';
    $config['next_tag_close'] = '</li>';
    $config['prev_link'] = '&lt;';
    $config['prev_tag_open'] = '<li>';
    $config['prev_tag_close'] = '</li>';
    $config['cur_tag_open'] = '<li class="active"><a href="javascript:void(0);">';
    $config['cur_tag_close'] = '</a></li>';
    $config['num_tag_open'] = '<li>';
    $config['num_tag_close'] = '</li>';
    $config['query_string_segment'] = $page_param_name;

    return $config;
    
}

/**
 * 分页函数
 * @param type $currPage
 * @param type $pageSize
 * @param type $total
 * @param type $callJs
 * @return type 
 */
function pageArrayGenerator($currPage,$pageSize,$total, $url = '',$callJs = 'pageJs'){
    $step=5; //显示的页面间隔
    $stepTmp = ceil($step/2);
    $pageEnd = ceil($total/$pageSize); //总页数
    $pageEndNum = $pageSize*$currPage;   //本页最后的记录
    if($currPage==$pageEnd){
        $pageEndNum = $total;
    }
    $pagePrevNum = ($currPage==1)?1:($currPage-1);
    $pageNextNum = ($currPage==$pageEnd)?$pageEnd:($currPage+1);
    $pageAb = ($currPage-$stepTmp)>0?($currPage-$stepTmp):1;
    $pageAe = ($currPage+$stepTmp)>$pageEnd?($pageEnd):($currPage+$stepTmp);
    
    return array(
        'pager'=>array(
            'pageUnit'=>'条',
            'pageTit'=>'记录',
            'pageBeginNum'=> ($currPage-1)*$pageSize+1,
            'pageEndNum'=> $pageEndNum,
            'pageSum'=> $total,
            'pageNow'=> $currPage,
            'pagePrevNum'=> $pagePrevNum,
            'pageNextNum'=> $pageNextNum,
            'pageFirstNum'=> 1,
            'pageLastNum'=> $pageEnd,
            'pageAb'=> $pageAb,
            'pageAe'=> $pageAe,
            'url' => $url,
            'callJs' => $callJs
        )

    );
}


//排序
function cmp_func($a, $b) {
	return strcmp($a['datetime'], $b['datetime']);
}



function idcard_verify_number($idcard_base){
    if (strlen($idcard_base) != 17){ return false;}
    
    $factor = array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);

    //校验码对应值
    $verify_number_list = array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
    $checksum = 0;
    for ($i = 0; $i < strlen($idcard_base); $i++){
        $checksum += substr($idcard_base, $i, 1) * $factor[$i];
    }
    $mod = $checksum % 11;
    $verify_number = $verify_number_list[$mod];

    return $verify_number;

}

//15位升级18位
function idcard_15to18($idcard){
    if (strlen($idcard) != 15){
        return false;
    }else{
    //若身份证顺序码是996 997 998 999，说明是为百岁老人准备的特殊码
    if (array_search(substr($idcard, 12, 3), array('996', '997', '998', '999')) !== false){
        $idcard = substr($idcard, 0, 6) . '18'. substr($idcard, 6, 9);
    }else{
        $idcard = substr($idcard, 0, 6) . '19'. substr($idcard, 6, 9);
    }
    }
    $idcard = $idcard . idcard_verify_number($idcard);
    return $idcard;
}


/**
 * 验证身份证号
 * @param $vStr
 * @return bool
 */

function isCreditNo($vStr)
{
    $vCity = array(
        '11','12','13','14','15','21','22',
        '23','31','32','33','34','35','36',
        '37','41','42','43','44','45','46',
        '50','51','52','53','54','61','62',
        '63','64','65','71','81','82','91'
    );
    if (!preg_match('/^([\d]{17}[xX\d]|[\d]{15})$/', $vStr)) return false;
    if (!in_array(substr($vStr, 0, 2), $vCity)) return false;
    $vStr = preg_replace('/[xX]$/i', 'a', $vStr);
    $vLength = strlen($vStr);
    
    if ($vLength == 18)
    {
        $vBirthday = substr($vStr, 6, 4) . '-' . substr($vStr, 10, 2) . '-' . substr($vStr, 12, 2);
    } else {
        $vBirthday = '19' . substr($vStr, 6, 2) . '-' . substr($vStr, 8, 2) . '-' . substr($vStr, 10, 2);
    }

    if (date('Y-m-d', strtotime($vBirthday)) != $vBirthday) return false;
    if ($vLength == 18)
    {
        $vSum = 0;
        for ($i = 17 ; $i >= 0 ; $i--)
        {
            $vSubStr = substr($vStr, 17 - $i, 1);
            $vSum += (pow(2, $i) % 11) * (($vSubStr == 'a') ? 10 : intval($vSubStr , 11));
        }
        if($vSum % 11 != 1) return false;
    }
    return true;
}

function random($length){
	$seed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	$str = "";
	while(strlen($str) < $length){
		$str .= substr($seed,(mt_rand() % strlen($seed)),1);
	}
	return $str;
}

function get_ip(){
	if(getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown')) {
		$onlineip = getenv('HTTP_CLIENT_IP');
	} elseif(getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), 'unknown')) {
		$onlineip = getenv('HTTP_X_FORWARDED_FOR');
	} elseif(getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), 'unknown')) {
		$onlineip = getenv('REMOTE_ADDR');
	} elseif(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], 'unknown')) {
		$onlineip = $_SERVER['REMOTE_ADDR'];
	}
	$onlineip = addslashes($onlineip);
	@preg_match("/[\d\.]{7,15}/", $onlineip, $onlineipmatches);
	$onlineip = $onlineipmatches[0] ? $onlineipmatches[0] : 'unknown';
	unset($onlineipmatches);
	return $onlineip;
}



/**
 * 生产缩略图
 * @param type $srcFile
 * @param type $toFile
 * @param type $toW
 * @param type $toH 
 */
function make_thumb($srcFile,$toFile="",$toW,$toH){
   if($toFile==""){ $toFile = $srcFile; }
   $info = "";
   $arr = getimagesize($srcFile,$info);
   switch ($arr[2]){
	   case 1:
		  if(!function_exists("imagecreatefromgif")){
		  	exit("function [imagecreatefromgif] not exists!");
		  }
		  $src_file = imagecreatefromgif($srcFile);
	   break;
	   case 2:
		  if(!function_exists("imagecreatefromjpeg")){
		  	exit("function [imagecreatefromjpeg] not exists!");
		  }
		  $src_file = imagecreatefromjpeg($srcFile);    
	   break;
	   case 3:
		  if(!function_exists("imagecreatefrompng")){
		  	exit("function [imagecreatefrompng] not exists!");
		  }
		  $src_file = imagecreatefrompng($srcFile);    
	   break;
	   case 6:
		  if(!function_exists("imagecreatefromwbmp")){
		  	exit("function [imagecreatefromwbmp] not exists!");
		  }
		  $src_file = imagecreatefromwbmp($srcFile);    
	   break;
	   default:

   }
  $srcW = imagesx($src_file);
  $srcH = imagesy($src_file);
  $toWH = $toW/$toH;
  $srcWH = $srcW/$srcH;
  if($toWH <= $srcWH){
       $ftoW = $toW;
       $ftoH = $ftoW*($srcH/$srcW);
  }else{
      $ftoH = $toH;
      $ftoW = $ftoH*($srcW/$srcH);
  }    
  if($srcW>$toW || $srcH>$toH){
     if(function_exists("imagecreatetruecolor")){
        @$dest_file = imagecreatetruecolor($ftoW,$ftoH);
        if($dest_file){
			imagecopyresampled($dest_file,$src_file,0,0,0,0,$ftoW,$ftoH,$srcW,$srcH);
        }else{
          	$dest_file = imagecreate($ftoW,$ftoH);
          	imagecopyresized($dest_file,$src_file,0,0,0,0,$ftoW,$ftoH,$srcW,$srcH);
        }
     }else{
        $dest_file = imagecreate($ftoW,$ftoH);
        imagecopyresized($dest_file,$src_file,0,0,0,0,$ftoW,$ftoH,$srcW,$srcH);
     }
	 switch ($arr[2]){
	 	case 1:
			if(!function_exists('imagegif')){
				exit("function [imagegif] not exists!");
			}
			imagegif($dest_file,$toFile);
		break;
		case 2:
			if(!function_exists('imagejpeg')){
				exit("function [imagejpeg] not exists!");
			}
			imagejpeg($dest_file,$toFile);
		break;
		case 3:
			if(!function_exists('imagepng')){
				exit("function [imagepng] not exists!");
			}
			imagepng($dest_file,$toFile);
		break;
		case 6:
			if(!function_exists('imagewbmp')){
				exit("function [imagewbmp] not exists!");
			}
			imagewbmp($dest_file,$toFile);
		break;
		default:
	 }
     @imagedestroy($dest_file);
  }
  @imagedestroy($src_file);
}


function defend_xss($val){
	return is_array($val) ? $val : htmlspecialchars($val);
}

function gpc($name,$w = 'GPC',$default = '',$d_xss=0){
	$i = 0;
	for($i = 0; $i < strlen($w); $i++) {
		if($w[$i] == 'G' && isset($_GET[$name])) return $d_xss ? defend_xss($_GET[$name]) : $_GET[$name];
		if($w[$i] == 'P' && isset($_POST[$name])) return $d_xss ? defend_xss($_POST[$name]) : $_POST[$name];
		if($w[$i] == 'C' && isset($_COOKIE[$name])) return $d_xss ? defend_xss($_COOKIE[$name]) : $_COOKIE[$name];
	}
	return $default;
}


/**
 *
 * @param type $file_extension
 * @return string 
 */
function filetype_url($file_extension = '',$size = ''){
    
    if(!$file_extension){
        return config_item('fileicon_path').$size.'/unknow.gif';
    }else{
        
        if(strpos($file_extension,'.') !== false){
            $file_extension = substr($file_extension,1);
        }
        $file =  realpath(dirname(APPPATH)).config_item('fileicon_path').$size.'/'.$file_extension.".gif";
        
        if(file_exists($file)){
            return config_item('fileicon_path').$size.'/'.$file_extension.'.gif';
        }else{
            return config_item('fileicon_path').$size.'/unknow.gif';
        }
        
    }

}


/* End of file Common.php */
/* Location: ./system/core/Common.php */