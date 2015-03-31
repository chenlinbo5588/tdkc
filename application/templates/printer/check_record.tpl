<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
        <style type="text/css">
            
             .check_record .title {
                 font-size:30px;
             }
             
             #pingyu {
                 height:300px;
                 overflow:hidden;
                 padding:5px;
                 text-indent:2em;
             }
             
             .custom_checkbox {
                 background:#fff;
                 width:20px;
                 height:20px;
             }
             
             .little_font td {
                 font-size:14px;
             }
             
             .check_record_header {
                 padding:5px 5px 5px 20px;
                 position:relative;
             }
             .check_record_foot {
                 padding:20px;
                 position:relative;
              }
             
             .team_sign , .check_record_date {
                 position:absolute;
                 top:18px;
                 right:100px;
             }
             
             .check_record_date {
                 top:5px;
             }
             
        </style>    
    </head>
    <body>
        <div class="container">
            <div class="check_record">
                <h1 class="title center inputarea">检 查 记 录 表</h1>
                <div class="check_record_header clearfix"><span class="inputarea">小   组：{$info['pm']}</span><span class="inputarea check_record_date">日  期：{$info['createtime']|date_format:"Y-m-d"}</span></div>
                <table class="fulltable border1">
                    <colgroup>
                        <col width="100"/>
                        <col width="130"/>
                        <col width="130"/>
                        <col width="130"/>
                        <col width="160"/>
                    </colgroup>
                    <tbody>
                        <tr class="center">
                            <th>项目名称</th>
                            <td colspan="4">{$info['name']}</td>
                        </tr>
                        <tr class="center">
                            <th>项目类型</th>
                            <td colspan="4" style="padding:0;" class="alignleft" >
                                <table class="inner_table inner_col_table">
                                    <colgroup>
                                        <col width="25%"/>
                                        <col width="18%"/>
                                        <col width="18%"/>
                                        <col width="18%"/>
                                        <col width="18%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <td class="first_col"><input class="custom_checkbox" type="checkbox" {if in_array('地形、地籍',$info['type'])}checked{/if} />地形、地籍</td>
                                            <td><input class="custom_checkbox" type="checkbox" {if in_array('放样',$info['type'])}checked{/if}/>放样</td>
                                            <td><input class="custom_checkbox" type="checkbox" {if in_array('竣工',$info['type'])}checked{/if}/>竣工</td>
                                            <td><input class="custom_checkbox" type="checkbox" {if in_array('房产',$info['type'])}checked{/if}/>房产</td>
                                            <td class="last_col"><input class="custom_checkbox" type="checkbox" {if in_array('其它',$info['type'])}checked{/if}/>其它</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr class="center">
                            <th>检查方法</th>
                            <td><input class="custom_checkbox" type="checkbox" {if in_array('图面巡视',$info['method'])}checked{/if}/>图面巡视</td>
                            <td><input class="custom_checkbox" type="checkbox" {if in_array('采点检查',$info['method'])}checked{/if}/>采点检查</td>
                            <td><input class="custom_checkbox" type="checkbox" {if in_array('量边检查',$info['method'])}checked{/if}/>量边检查</td>
                            <td><input class="custom_checkbox" type="checkbox" {if in_array('其它检查',$info['method'])}checked{/if}/>其它检查</td>
                        </tr>
                        {foreach from=$jdList key=key item=item}
                        <tr class="center">
                            <th colspan="2">{$item['title']}精度（限差）</th>
                            <td>{$info[$item[0]]} cm</td>
                            <th>实 测</th>
                            <td class="alignleft" style="padding:0;">
                                <table class="inner_table inner_row_table little_font">
                                    <tr class="first_row"><td class="alignleft">点数：{$info[$item[1]]}个</td></tr>
                                    <tr><td class="alignleft">误差均值：{$info[$item[2]]} cm</td></tr>
                                    <tr class="last_row"><td class="alignleft">超限点个数：{$info[$item[3]]}个</td></tr>
                                </table>
                            </td>
                        </tr>
                        {/foreach}
                        <tr class="center">
                            <th>精度评定</th>
                            <td><input class="custom_checkbox" type="checkbox" {if $info['evaluate'] == '优'}checked{/if}/>优</td>
                            <td><input class="custom_checkbox" type="checkbox" {if $info['evaluate'] == '良'}checked{/if}/>良</td>
                            <td><input class="custom_checkbox" type="checkbox" {if $info['evaluate'] == '合格'}checked{/if}/>合格</td>
                            <td><input class="custom_checkbox" type="checkbox" {if $info['evaluate'] == '不合格'}checked{/if}/>不合格</td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <h3>检查评语：</h3>
                                <div id="pingyu">
                                    {$info['remark']}
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="check_record_foot clearfix"><span>检查者:</span><span class="inputarea">{if $info['checkor']}{$info['checkor']}{else}沈铭、郭连山、戚中东{/if}</span><span class="team_sign">组长签字:</span></div>
            </div>
        </div>
        
        <script>
            
            $(function(){
                var areaReg = /^\d+(.\d*)?$/;
                
                $("body").delegate(".inputarea","click",function(e){
                    var txt = $('<input type="text" class="tptxt" name="" value="' + $(e.target).html() + '"/>');
                    var that = $(e.target);
                    var number = false;
                    if(that.hasClass("number")){
                        number = true;
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
                            if($.trim(a).length != 0){
                                that.html(a);
                            }else{
                                that.html('请输入内容');
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