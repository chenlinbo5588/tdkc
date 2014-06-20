<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        
        <style>
            .container {
                width:700px;
            }
            
            .check .center {
                font-size:14px;
            }
            
            .check h1.center {
                font-size:20px;
            }
            
            .check .wd  {
                margin-top:15px;
            }
            .check .wd strong {
                font-size:20px;
            }
            
            .check td,.check th {
                font-size:14px;
            }
            .check .db1 {
                 margin: 20px 0 0 10px;
                 font-size:14px;
            }
            .check .db2 {
                margin: 10px 0 0 10px;
                font-size:14px;
            }
            
            .check .f_name {
                letter-spacing:2em;
            }
            
            .check .f_yj , .check .f_remark {
                letter-spacing:4px;
            }
                
        </style>
    </head>
    <body>
        <div class="container">
            <div class="check">
                <h1 class="center">{if $info['type'] == '违法用地'}违法用地{/if}审核表</h1>
                <div class="center wd"><strong>QR-10-04</strong></div>
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
                            <th class="f_name">名 &nbsp;称</th>
                            <th class="f_yj">审核主要意见</th>
                            <th class="f_remark">修改、处理意见、说明</th>
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
                <p class="db1">此卡归档</p>
                <p class="db2">审核人签名:</p>
            </div>
        </div>
    </body>
</html>