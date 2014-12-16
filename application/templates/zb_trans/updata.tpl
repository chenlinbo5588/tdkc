<!DOCTYPE html>
<html>
    <head>
        <title>坐标转换程序</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        {include file="zb_trans/trans_header.tpl"}
    </head>
    <body>
        <h1 class="title">数据转换 第二步 (Step2)</h1>
        
        <div class="info">
            <div>导入批次号: {$rows['batch_id']} </div>
            <div class="success">导入成功行数: {$rows['success']}</div>
            <div class="warning">导入失败行数: {$rows['failed']}</div>
        </div>
        <div class="example">
            <form name="fx" action="{url_path('zb_trans','fx')}" method="get" target="_blank">
                <input type="hidden" value="zb_trans" name="{config_item('controller_trigger')}"/>
                <input type="hidden" value="fx" name="{config_item('function_trigger')}"/>
                <table>
                    <tr>
                        <td>批次号</td>
                        <td><input type="text" name="batch_id" value="{$rows['batch_id']}"/></td>
                    </tr>
                    <tr>
                        <td>界址点前缀</td>
                        <td><input type="text" name="point_pre" value="J"/></td>
                    </tr>
                    <tr>
                        <td>坐标精度</td>
                        <td>
                            <select name="point_jd">
                                <option value="3" selected>小数点3位有效数字</option>
                                <option value="4">小数点4位有效数字</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>X坐标添加前缀</td>
                        <td>
                            <input type="text" name="x_pre" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td>Y坐标添加前缀</td>
                        <td>
                            <input type="text" name="y_pre" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" class="btn-orange" name="submit" value="获取坐标表"/></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>