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
                    <col width="250"/>
                    <col width="600"/>
                </colgroup>
                <tbody>
                    <tr>
                        <td colspan="2"><div class="info">注意列序号从1开始</div></td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>点号字段列列序号(FID)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_fid" value="1"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>地块编号字段列序号(DKBH)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_dkbh" value="2"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>Y坐标字段列序号(POINT_Y)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_y" value="3"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>X坐标字段列序号(POINT_X)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_x" value="4"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>面积字段列序号(Shape_Area)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_mj" value="5"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>项目名称字段列序号(XMMC)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_xmmc" value="6"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>字段分隔符号(不填默认为TAB)</strong></label>
                        </td>
                        <td>
                            <input type="text" name="field_sepchar" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><div class="info">不包含标题列，请将待转换数据黏贴到文本框中</div></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea name="orgdata" style="width:100%;height:400px;"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2"><input type="submit" name="submit" class="btn-orange" value="提交数据"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>