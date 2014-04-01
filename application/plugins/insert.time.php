<?php

/**
 * 
 * @param type $params
 * @param type $smarty
 * @return type 
 */
function smarty_insert_time($params, &$smarty){
    
    if (empty($params['format'])) {
	$smarty->trigger_error("insert time: missing 'format' parameter");
	return;
    }

    $datetime = strftime($params['format']);
    return $datetime;
}
