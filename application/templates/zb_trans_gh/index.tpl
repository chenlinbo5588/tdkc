<!DOCTYPE html>
<html>
    <head>
        <title>规划坐标转换程序</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        {include file="zb_trans_gh/trans_header.tpl"}
    </head>
    <body>
        <h1 class="title">规划数据转换 第一步 (Step1)</h1>
        <style>
            .inputtb label {
                font-size:13px;
            }
        </style>    
        <div class="example">
            <form action="{url_path('zb_trans_gh','updata')}" method="post">
            <table class="inputtb">
                <colgroup>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="100"/>
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
                        <td colspan="10"><div class="info">注意列序号从1开始</div></td>
                    </tr>
                    <tr>
                        <td>
                            <label><strong>乡镇代码</strong></label>
                        </td>
                        <td>
                            <label><strong>行政村</strong></label>
                        </td>
                        <td>
                            <label><strong>用途地块编号</strong></label>
                        </td>
                        <td>
                            <label><strong>项目名称</strong></label>
                        </td>
                        <td>
                            <label><strong>面积</strong></label>
                        </td>
                        <td>
                            <label><strong>地块顺序</strong></label>
                        </td>
                        <td>
                            <label><strong>点号</strong></label>
                        </td>
                        <td>
                            <label><strong>X坐标</strong></label>
                        </td>
                        <td>
                            <label><strong>Y坐标</strong></label>
                        </td>
                        <td>
                            <label><strong>列分隔符(不填默认为TAB)</strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>列<input type="text" name="field_region_code" style="width:60px;" value="1"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_viliage" style="width:60px;" value="2"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_purpose_code" style="width:60px;" value="3"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_xmmc" style="width:60px;" value="4"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_mj" style="width:60px;" value="5"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_dkbh" style="width:60px;" value="6"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_fid" style="width:60px;" value="7"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_x" style="width:60px;" value="8"/></label>
                        </td>
                        <td>
                            <label>列<input type="text" name="field_y" style="width:60px;" value="9"/></label>
                        </td>
                        <td>
                            <input type="text" name="field_sepchar" style="width:60px;" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10"><div class="info">不包含标题列，请将待转换数据黏贴到文本框中</div></td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <textarea name="orgdata" style="width:800px;height:400px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10"><input type="submit" name="submit" class="btn-orange" value="提交数据"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>