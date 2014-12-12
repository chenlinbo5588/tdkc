<!DOCTYPE html>
<html>
    <head>
        <title>坐标转换程序</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        {include file="zb_trans/trans_header.tpl"}
    </head>
    <body>
        <h1 class="title">数据转换 第一步 (Step1)</h1>
        <div class="info">请将待转换数据黏贴到文本框中</div>
        <div class="example">
            <form action="{url_path('zb_trans','updata')}" method="post">
            <table>
                <tr>
                    <td>
                        <textarea name="orgdata" style="width:800px;height:500px;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" name="submit" class="btn-orange" value="提交数据"/></td>
                </tr>
            </table>
        </div>
    </body>
</html>