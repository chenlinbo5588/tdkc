<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
    </head>
    <body>
        
        <div class="container">
            {foreach name=pg from=$pageAr item=pageIndex}
            <div class="jzb">
                <h1 class="title center jzb_title">宗地界址调查表</h1>
                <div><strong>QR-10-03</strong></div>
                <table class="fulltable border1">
                    <colgroup>
                        <col width="40"/>
                        <col width="40"/>
                        <col width="150"/>
                        <col width="150"/>
                        <col width="70"/>
                    
                    </colgroup>
                    <tbody>
                        <tr class="center">
                            <td colspan="2">土地使用者名称</td>
                            <td class="alignleft" colspan="3">{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="2">本宗地用签名盖章</td>
                            <td class="alignleft" colspan="3"></td>
                        </tr>
                        <tr class="center">
                            <td colspan="2">宗地坐落</td>
                            <td class="alignleft" colspan="3">{$info['address']|escape}</td>
                        </tr>
                        <tr class="center vmd">
                            <td>四址</td>
                            <td>界址线</td>
                            <td>界址线位置</td>
                            <td>邻居名称</td>
                            <td>
                                <div>邻居签名</div>
                                <div>盖章</div>
                            </td>
                        </tr>
                        {foreach name=jz from=$jzList[$pageIndex] key=key item=item}
                        <tr>
                            <td class="direction direction_{$item['direction']}">
                                {*
                                {if $item['direction'] == 1}西
                                {elseif $item['direction'] == 2}北
                                {elseif $item['direction'] == 3}东
                                {elseif $item['direction'] == 4}南
                                {/if}
                                *}
                            </td>
                            <td class="center">{($pageIndex - 1) * 10 + $key + 1} <strong class="sepline">--</strong> {if $smarty.foreach.pg.last && $smarty.foreach.jz.last}1{else}{($pageIndex - 1) * 10 + $key + 2}{/if}</td>
                            <td>{$item['name']}</td>
                            <td>{$item['neighbor']}</td>
                            <td></td>
                        </tr>
                        {/foreach}
                        
                        {if $smarty.foreach.pg.last}
                        {foreach from=$padTr item=t}
                        <tr>
                            <td class="direction"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        {/foreach}
                        {/if}
                        <tr class="center sth">
                            <td rowspan="2">备<br/>注</td>
                            <td colspan="4" class="as">
                                <div>调查人:</div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="bs">
                                <ul class="cs">
                                    <li class="zjr">指界人： </li>
                                    <li class="clz">测量者: {$info['pm']}</li>
                                </ul>
                            </td>
                        </tr>
                        <tr class="center">
                            <td> 
                                <ul class="cs">
                                    <li class="fjyj">分局确认意见</li>
                                    <li class="jdyj">镇、街道土管所</li>
                                </ul>
                            </td>
                            <td colspan="4" class="ba">
                                <p class="yj_item">该宗地地号：</p>
                                <p class="yj_item">调查人签名：        (公章)</p>
                                <ul class="yj_item">
                                    <li class="d1">所（分局）领导签字：</li>
                                    <li class="d2">{$dateInfo['year']}年{$dateInfo['month']}月{$dateInfo['day']} 日</li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="jf"><span>勘测日期</span> <span>{$info['arrange_date']|date_format:"Y年m月d日"}</p>
            </div>
           {/foreach}
        </div>
        <script>
            $(function(){
                $(".jzb table").each(function(index){
                    $(".direction_1:eq(0)",$(this)).html('西').addClass("borderTop");
                    $(".direction_2:eq(0)",$(this)).html('北').addClass("borderTop");
                    $(".direction_3:eq(0)",$(this)).html('东').addClass("borderTop");
                    $(".direction_4:eq(0)",$(this)).html('南').addClass("borderTop");
                });
            });
        </script>
    </body>
</html>