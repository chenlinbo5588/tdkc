<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| Hooks
| -------------------------------------------------------------------------
| This file lets you define "hooks" to extend CI without hacking the core
| files.  Please see the user guide for info:
|
|	http://codeigniter.com/user_guide/general/hooks.html
|
*/


/**
 * 每个钩子可以用以下格式的数组来定义:
 * 
 * $hook['pre_controller'] = array(
                                'class'    => 'MyClass',
                                'function' => 'Myfunction',
                                'filename' => 'Myclass.php',
                                'filepath' => 'hooks',
                                'params'   => array('beer', 'wine', 'snacks')
                                );
 * 
 * 说明：
    数组的索引与你使用的指定挂钩点名字相关.上面的例子中挂钩点是pre_controller. 挂钩点参数列表如下所示. 以下各项将定义在你的相关钩子数组里：

    class  你希望调用的类名.如果你更喜欢使用过程函数代替类的话,此项保留为 false.
    function  你希望调用的函数名.
    filename  包含有你的类/函数的文件名.
    filepath  包含你的脚本的目录名. 注意: 你的脚本放在 application 文件夹下的目录里, 
 *		这样 filepath就以那个文件夹(application)为基准. 
 *		例如, 如果你的脚本放在application/hooks下, 你可以把hooks 作为你的filepath. 
 *		如果你的脚本放在application/hooks/utilities下你可以把 hooks/utilities作为filepath. 注意后面没有"/".
 *		如果不放在根目录下可以根据相对路径的配置，来完成调用。这样就可以完成，多个应用共享一个钩子。
    params  你希望传递给脚本的任何参数. 此项是可选的.

 *  
 */





/* End of file hooks.php */
/* Location: ./application/config/hooks.php */