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
        <form name="jzbForm" method="post" action="{url_path('project_ch','savefastjzb')}" target="post_iframe">
            <input type="hidden" name="id" value="{$info['id']}"/>
            <textarea name="jzb" style="display: none;"></textarea>
            <div id="oparea" class="center">
                <input type="submit" name="submit" value="保存"  class="btn btn-sm btn-orange"/>
                <input type="button" name="merginDirection" value="合并方向"  class="btn btn-sm btn-gray"/>
                <a href="javascript:void(0);" id="addJzb">+增加界址表</a>
                <div><em>键盘组合建 Shift + Enter 隐藏本区域</em></div>
                <div>
                    <ul class="jz_sample">
                        <li><strong>界址范例</strong></li>
                        <li>自墙外侧</li>
                        <li>自围墙外侧</li>
                        <li>自(围)墙外侧</li>
                        <li>拼墙基中</li>
                        <li>拼围墙基中</li>
                        <li>拼(围)墙基中</li>
                        <li>他墙外侧</li>
                        <li>他围墙外侧</li>
                        <li>他(围)墙外侧</li>
                        <li>界点连线外侧</li>
                        <li>河石坎外侧</li>
                        <li>河岸线外侧</li>
                        <li>×道路中心线往××米</li>
                    </ul>
                </div>
            </div>
            <div class="container">
                {if $jzb}
                    {$jzb['content']}
                {else}
                <div class="jzb">
                    <h1 class="title center jzb_title inputarea">宗地界址调查表</h1>
                    {*<div><strong>QR-10-03</strong></div>*}
                    <table class="fulltable border1">
                        <colgroup>
                            <col width="40"/>
                            <col width="80"/>
                            <col width="150"/>
                            <col width="150"/>
                            <col width="70"/>
                        </colgroup>
                        <tbody>
                            <tr class="center">
                                <td colspan="2">土地使用者名称</td>
                                <td class="inputarea" colspan="3">{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="2">本宗地用签名盖章</td>
                                <td class="inputarea" colspan="3"></td>
                            </tr>
                            <tr class="center">
                                <td colspan="2">宗地坐落</td>
                                <td class="inputarea" colspan="3">{$info['region_name']}{$info['address']|escape}</td>
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
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <td class="jdr inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                                <td class="inputarea"></td>
                            </tr>
                            <tr class="center sth" >
                                <td rowspan="2">备<br/>注</td>
                                <td colspan="4" class="as">
                                    <div><span class="inputarea">调查人:</span></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="bs">
                                    <ul class="cs">
                                        <li class="zjr"><span class="inputarea">指界人： </span></li>
                                        <li class="clz"><span class="inputarea">测量者: {$info['pm']}</span></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr class="last">
                                <td> 
                                    <ul class="cs">
                                        <li class="fjyj">分局确认意见</li>
                                        <li class="jdyj">镇、街道土管所</li>
                                    </ul>
                                </td>
                                <td colspan="4" class="ba">
                                    <p class="yj_item"><span class="inputarea">该宗地地号：</span></p>
                                    <p class="yj_item">调查人签名：        <span class="gz">(公章)</span></p>
                                    <ul class="yj_item">
                                        <li class="d1">所（分局）领导签字：</li>
                                        <li class="d2"><span class="inputarea">&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</span></li>
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <p class="jf"><span>勘测日期</span><span class="inputarea">{$info['createtime']|date_format:"Y年m月d日"}</span></p>
                </div>
                {/if}
            </div>
        </form>
        <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
        
        <script type="x-my-template" id="jzbTemplate">
            <div class="jzb">
                <h1 class="title center jzb_title inputarea">宗地界址调查表</h1>
                <table class="fulltable border1">
                    <colgroup>
                        <col width="40"/>
                        <col width="80"/>
                        <col width="150"/>
                        <col width="150"/>
                        <col width="70"/>
                    </colgroup>
                    <tbody>
                        <tr class="center">
                            <td colspan="2">土地使用者名称</td>
                            <td class="inputarea" colspan="3">{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="2">本宗地用签名盖章</td>
                            <td class="inputarea" colspan="3"></td>
                        </tr>
                        <tr class="center">
                            <td colspan="2">宗地坐落</td>
                            <td class="inputarea" colspan="3">{$info['region_name']}{$info['address']|escape}</td>
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
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr>
                            <td class="jdr inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                            <td class="inputarea"></td>
                        </tr>
                        <tr class="center sth" >
                            <td rowspan="2">备<br/>注</td>
                            <td colspan="4" class="as">
                                <div><span class="inputarea">调查人:</span></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="bs">
                                <ul class="cs">
                                    <li class="zjr"><span class="inputarea">指界人： </span></li>
                                    <li class="clz"><span class="inputarea">测量者: {$info['pm']}</span></li>
                                </ul>
                            </td>
                        </tr>
                        <tr class="last">
                            <td> 
                                <ul class="cs">
                                    <li class="fjyj">分局确认意见</li>
                                    <li class="jdyj">镇、街道土管所</li>
                                </ul>
                            </td>
                            <td colspan="4" class="ba">
                                <p class="yj_item"><span class="inputarea">该宗地地号：</span></p>
                                <p class="yj_item">调查人签名：        <span class="gz">(公章)</span></p>
                                <ul class="yj_item">
                                    <li class="d1">所（分局）领导签字：</li>
                                    <li class="d2"><span class="inputarea">&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</span></li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="jf"><span>勘测日期</span><span class="inputarea">{$info['createtime']|date_format:"Y年m月d日"}</span></p>
            </div>
        </script>
        <script>
            
            function showConfirm(message,reload,sec,title,width,height){
                title = title ? title : '提示';
                width = width ? width : 'auto';
                height = height ? height : 'auto';

                alert(message);
                
                if(reload){
                    location.reload();
                }
            }
            
            
            $(function(){
                var areaReg = /^\d+(.\d*)?$/;
                
                
                $("body").bind("keydown",function(e){
                    if(e.shiftKey && e.keyCode == 13){
                        $("#oparea").slideToggle();
                    }
                });
                
                
                $("form[name=jzbForm]").bind("keydown",function(e){
                    if(e.keyCode == 13){
                        return false;
                    }
                });
                
                {* 提交按钮 *}
                $("input[name=submit]").bind("click",function(e){
                    $("textarea[name=jzb]").val($(".container").html());
                });
                
                $("input[name=merginDirection]").bind("click",function(e){
                    $(".jdr").each(function(index){
                        if($(this).html() != ''){
                            $(this).addClass("borderTop");
                        }else{
                            $(this).removeClass("borderTop");
                        }
                    });
                });
                
                $("#addJzb").bind('click',function(e){
                    $("div.container").append($($("#jzbTemplate").html()));
                });
                
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