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
 * CodeIgniter Number Helpers
 *
 * @package		CodeIgniter
 * @subpackage	Helpers
 * @category	Helpers
 * @author		ExpressionEngine Dev Team
 * @link		http://codeigniter.com/user_guide/helpers/number_helper.html
 */

// ------------------------------------------------------------------------

/**
 * Formats a numbers as bytes, based on size, and adds the appropriate suffix
 *
 * @access	public
 * @param	mixed	// will be cast as int
 * @return	string
 */
if ( ! function_exists('byte_format'))
{
	function byte_format($num, $precision = 1)
	{
		$CI =& get_instance();
		$CI->lang->load('number');

		if ($num >= 1000000000000)
		{
			$num = round($num / 1099511627776, $precision);
			$unit = $CI->lang->line('terabyte_abbr');
		}
		elseif ($num >= 1000000000)
		{
			$num = round($num / 1073741824, $precision);
			$unit = $CI->lang->line('gigabyte_abbr');
		}
		elseif ($num >= 1000000)
		{
			$num = round($num / 1048576, $precision);
			$unit = $CI->lang->line('megabyte_abbr');
		}
		elseif ($num >= 1000)
		{
			$num = round($num / 1024, $precision);
			$unit = $CI->lang->line('kilobyte_abbr');
		}
		else
		{
			$unit = $CI->lang->line('bytes');
			return number_format($num).' '.$unit;
		}

		return number_format($num, $precision).' '.$unit;
	}
}


if ( ! function_exists('to_chinese_number')) {
    
    function to_chinese_number($num,$zero = '零',$lowcase = true){
        //$c_digIT=array("零","拾","佰","仟","万");
        //'O';
        //$c_num=array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖","拾");
        
        if($lowcase){
            $c_num=array("零","一","二","三","四","五","六","七","八","九","十");
        }else{
            $c_num=array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖","拾");
        }
        
        
        //$c_digIT[0] = $zero;
        $c_num[0] = $zero;
        
        
        if($num){
            $str = (string)$num;
            
            $rt = array();
            
            for($i = 0; $i < strlen($str); $i++){
                $rt[] = $c_num[substr($str,$i,1)];
            }
            
            return implode('',$rt);
        }else{
            
            return '';
        }
    }
}
 

/* End of file number_helper.php */
/* Location: ./system/helpers/number_helper.php */