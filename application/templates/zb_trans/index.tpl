<!DOCTYPE html>
<html>
    <head>
        <title>坐标转换程序</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        {include file="zb_trans/trans_header.tpl"}
    </head>
    <body>
        <h1 class="title">数据转换 第一步 (Step1)</h1>
        
        <div class="example">
            <form action="{url_path('zb_trans','updata')}" method="post">
            <table>
                <colgroup>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                </colgroup>
                <tbody>
                    <tr>
                        <td colspan="7"><div class="info">注意列序号从1开始</div></td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>项目名称(XMMC)</strong></label>
                        </td>
                        <td>
                            <label><strong>地块编号(DKBH)</strong></label>
                        </td>
                        <td>
                            <label><strong>点号(FID)</strong></label>
                        </td>
                        <td>
                            <label><strong>X坐标</strong></label>
                        </td>
                        <td>
                            <label><strong>Y坐标</strong></label>
                        </td>
                        <td>
                            <label><strong>面积字段</strong></label>
                        </td>
                        <td>
                            <label><strong>列分隔符(不填默认为TAB)</strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>列<input type="text" name="field_xmmc" style="width:60px;" value="6"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_dkbh" style="width:60px;" value="2"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_fid" style="width:60px;" value="1"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_x" style="width:60px;" value="4"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_y" style="width:60px;" value="3"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_mj" style="width:60px;" value="5"/></label>
                        </td>
                        <td>
                            <input type="text" name="field_sepchar" style="width:60px;" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7"><div class="info">不包含标题列，请将待转换数据黏贴到文本框中</div></td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <textarea name="orgdata" style="width:800px;height:400px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7"><input type="submit" name="submit" class="btn-orange" value="提交数据"/></td>
                    </tr>
                </tbody>
            </table>
            </form>
        </div>
    </body>
</html>