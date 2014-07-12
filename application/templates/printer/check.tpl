<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
        <style>
            .container {
                width:650px;
            }
            
            .check .center {
                font-size:14px;
            }
            
            .check h1.center {
                font-size:25px;
            }
            
            .check .wd  {
                margin-top:5px;
            }
            .check .wd strong {
                font-size:20px;
            }
            
            .check td,.check th {
                font-size:16px;
            }
            .check .db1 {
                 margin: 20px 0 0 10px;
            }
            .check .db2 {
                margin: 10px 0 0 10px;
                font-size:14px;
            }
            .font1 , .font1 b {
                font-size:16px;
                
            }
            #sign {
                margin: -25px 0 0 115px;
             }
            #sign .font1 {
                font-weight:bold;
            }
            .check .f_name {
                letter-spacing:2em;
            }
            
            .check .f_yj , .check .f_remark {
                letter-spacing:4px;
            }
            
            .check textarea {
                overflow:hidden;
                resize:none;
                width:100%;
                height:150px;
                
            }
            #bianhao {
                position: absolute;
                font-weight: bold;
                font-size:16px;
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
                            <th class="inputarea">{$info['createtime']|date_format:"Y年m月d日"}</th>
                            <th class="inputarea">编号:</th>
                            <th class="inputarea">项目负责人： {$info['pm']}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="title center">
                            <th class="f_name">名 &nbsp;称</th>
                            <th class="f_yj">审核主要意见</th>
                            <th class="f_remark">修改、处理意见、说明</th>
                        </tr>
                        <tr class="col">
                            <td class="center" rowspan="3"><b class="font1">{$info['name']|escape}</b></td>
                            <td>
                                <div><b  class="font1">自查：</b></div>
                                <div><textarea class="noborder font1">{$info['zc_yj']}</textarea></div>
                            </td>
                            <td>
                                {if $info['zc_remark'] != '合格'}
                                    <b class="font1">{$info['zc_remark']|escape}</b>
                                {/if}
                                
                            </td>
                        </tr>
                        <tr class="col">
                            <td>
                                <div><b class="font1">初审：</b></div>
                                <div><textarea class="noborder font1">{$info['cs_yj']}</textarea></div>
                            </td>
                            <td>
                                {if $info['cs_remark'] != '合格'}
                                    <b class="font1">{$info['cs_remark']|escape}</b>
                                {/if}
                                <div>
                                    {foreach from=$csFault item=item}
                                        <div>{$item['fault_code']}
                                        {$item['fault_name']}
                                        {$item['remark']|escape}</div>
                                    {/foreach}
                                </div>
                            </td>
                        </tr>
                        <tr class="col last">
                            <td>
                                <div><b class="font1">复审：</b></div>
                                <div><textarea class="noborder font1">{$info['fs_yj']}</textarea></div>
                            </td>
                            <td>
                                {if $info['fs_remark'] != '合格'}
                                    <b class="font1">{$info['fs_remark']|escape}</b>
                                {/if}
                                <div>
                                    {foreach from=$fsFault item=item}
                                        <div>{$item['fault_code']}
                                        {$item['fault_name']}
                                        {$item['remark']|escape}</div>
                                    {/foreach}
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="db1"><b class="font1">此卡归档</b></p>
                <p class="db2">
                    <b class="font1">审核人签名:  </b>
                </p>
                <ul id="sign">
                    <li class="font1">自查：</li>
                    <li class="font1">初审：</li>
                    <li class="font1">复审：</li>
                </ul>
            </div>
        </div>
        <script>
            $(function(){
                var areaReg = /^\d+(.\d*)?$/;
                
                
                $("body").delegate(".inputarea","click",function(e){
                    var txt = $('<input type="text" class="tptxt" name="" value="' + $(e.target).html() + '"/>');
                    var that = $(e.target);
                    var number = false;
                    var jzbTitle = false;
                    if(that.hasClass("number")){
                        number = true;
                    }else if(that.hasClass('jzb_title')){
                        jzbTitle = true;
                    }
                    
                    that.html(txt);
                    txt.focus();
                    
                    var setval = function(){
                        var a = txt.val();
                        
                        if(number){
                            if(areaReg.test(a)){
                                that.html(parseFloat(a).toFixed(2));
                            }else{
                                that.html('');
                            }
                        }else{
                            if(jzbTitle){
                                if(a == ''){
                                    that.closest(".jzb").remove();
                                }else{
                                    that.html('宗地界址调查表');
                                }
                            }else{
                                that.html(a);
                            }
                        }
                        txt.remove();
                    }
                    
                    txt.bind("keydown",function(e){
                        if(e.keyCode == 13){
                            setval();
                        }
                    });
                    
                    txt.bind('blur',function(e){
                        setval();
                    });
                });
            });
            
        </script>
    </body>
</html>