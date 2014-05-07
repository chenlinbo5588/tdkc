<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
    </head>
    <body>
        <div class="container">
            <div class="check">
                <h1 class="center">{if $info['type'] == '违法用地'}违法用地{/if}审核表</h1>
                <div class="center" style="margin-top:15px;"><strong>QR-10-04</strong></div>
                <table class="fulltable border1" style="table-layout:fixed;margin-top:15px;">
                    <colgroup>
                        <col width="200"/>
                        <col width="200"/>
                        <col width="200"/>
                    </colgroup>
                    <thead>
                        <tr class="noborder">
                            <th>{$info['createtime']|date_format:"Y年m月d日"}</th>
                            <th>编号 {$info['project_no']}</th>
                            <th>项目负责人 {$info['pm']}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="title center">
                            <th>名 &nbsp;称</th>
                            <th>审核主要意见</th>
                            <th>修改、处理意见、说明</th>
                        </tr>
                        <tr class="col">
                            <td class="center">自查</td>
                            <td>{$info['zc_yj']}</td>
                            <td>{$info['zc_remark']}</td>
                        </tr>
                        <tr class="col">
                            <td class="center">初审</td>
                            <td>{$info['cs_yj']}</td>
                            <td>{$info['cs_remark']}</td>
                        </tr>
                        <tr class="col last">
                            <td class="center">复审</td>
                            <td>{$info['fs_yj']}</td>
                            <td>{$info['fs_remark']}</td>
                        </tr>
                    </tbody>
                </table>
                <p style="margin: 20px 0 0 10px;">此卡归档</p>
                <p style="margin: 10px 0 0 10px;">审核人签名:</p>
            </div>
        </div>
    </body>
</html>