<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/*
|--------------------------------------------------------------------------
| File and Directory Modes
|--------------------------------------------------------------------------
|
| These prefs are used when checking and setting modes when working
| with the file system.  The defaults are fine on servers with proper
| security, but you may wish (or even need) to change the values in
| certain environments (Apache running a separate process for each
| user, PHP under CGI with Apache suEXEC, etc.).  Octal values should
| always be used to set the mode correctly.
|
*/
define('FILE_READ_MODE', 0644);
define('FILE_WRITE_MODE', 0666);
define('DIR_READ_MODE', 0755);
define('DIR_WRITE_MODE', 0777);

/*
|--------------------------------------------------------------------------
| File Stream Modes
|--------------------------------------------------------------------------
|
| These modes are used when working with fopen()/popen()
|
*/

define('FOPEN_READ',							'rb');
define('FOPEN_READ_WRITE',						'r+b');
define('FOPEN_WRITE_CREATE_DESTRUCTIVE',		'wb'); // truncates existing file data, use with care
define('FOPEN_READ_WRITE_CREATE_DESTRUCTIVE',	'w+b'); // truncates existing file data, use with care
define('FOPEN_WRITE_CREATE',					'ab');
define('FOPEN_READ_WRITE_CREATE',				'a+b');
define('FOPEN_WRITE_CREATE_STRICT',				'xb');
define('FOPEN_READ_WRITE_CREATE_STRICT',		'x+b');



define('TZ_SMATY_VERSION','3.1.12');
define('TZ_TPL_PATH',APPPATH.'templates/');
define('PHPExcel_PATH',dirname(APPPATH).'/Classes/');



define('OUR_COMPANY_NAME','慈溪市土地勘测规划设计院有限公司');
define('CH_RCZD','日常宗地');
define('CH_JGCL','竣工测量');
define('CH_FCCH','房产测绘');

define('CH_WFYD','违法用地');



define('TAIZHANG_TD','土地勘测');
define('TAIZHANG_FG','放线竣工');
define('TAIZHANG_HOUSE','房产项目');
define('TAIZHANG_WF','违法用地勘测');
define('TAIZHANG_OTHER','土方山塘地形评估控制');
define('TAIZHANG_PERSON','个人建房');

define('TAIZHANG_SH','散活');

/* End of file constants.php */
/* Location: ./application/config/constants.php */