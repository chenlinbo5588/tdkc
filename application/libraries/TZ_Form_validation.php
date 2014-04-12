<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class TZ_Form_validation extends CI_Form_validation {
    
    public function is_unique_not_self($str,$field){
        
        list($table, $field,$key,$value)=explode('.', $field);
        
        $query = $this->CI->db->get_where($table, array($field => $str));
        $result = $query->result_array();
        
        /*
        print_r($field);
        var_dump($query);
        print_r($result);
        */
        
        if($query->num_rows() === 0){
            return true;
        }
        
        if($query->num_rows() == 1 && $value == $result[0][$key]){
            return true;
        }else{
            return false;
        }
        
    }
    
    
    
    public function valid_date($datestr,$format = ''){
        //echo $datestr;
        //echo $format;
        
        if(!$format){
            $format = 'yyyy-mm-dd';
        }
        
        switch($format){
            case 'yyyy-mm-dd':
                $info = explode('-',$datestr);
                
                if(count($info) < 3){
                    return false;
                }
                
                return checkdate($info[1],$info[2],$info[0]);
                break;
            default:
                break;
            
        }
        
        return true;
        
    }

    
	
    public function numeric_dash($str)
	{
        return ( ! preg_match("/^([-0-9_-])+$/i", $str)) ? FALSE : TRUE;

	}
    
    

}
// END Form Validation Class

/* End of file TZ_Form_validation.php */
/* Location: ./application/libraries/TZ_Form_validation.php */
