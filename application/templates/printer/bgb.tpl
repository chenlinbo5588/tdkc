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
        <form name="bgbForm" method="post" action="{url_path('project_ch','savebgb')}" target="post_iframe">
            <input type="hidden" name="id" value="{$info['id']}"/>
            <textarea name="bgb" style="display: none;"></textarea>
            <div id="oparea" class="center">
                <input type="submit" name="submit" value="保存"  class="btn btn-sm btn-orange"/>
                <div><em>键盘组合建 Shift + Enter 隐藏本区域</em></div>
            </div>
            <div class="container">
                {if $bgb}
                    {$bgb['content']}
                {else}
                <div class="bgb">
                    <h1 class="title center bgb_title inputarea">土地勘测定界成果变更情况表</h1>
                    <table class="fulltable border1">
                        <colgroup>
                            <col width="150"/>
                            <col width="500"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="center">原土地使用者名称</th>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <th class="center">宗地坐落</th>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <th class="center">原编号</th>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <th class="center">变更原因</th>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <th class="center">现土地使用者名称</th>
                                <td class="inputarea"></td>
                            </tr>
                            <tr>
                                <th class="center">现编号</th>
                                <td class="inputarea"></td>
                            </tr>
                            <tr class="last">
                                <td colspan="2">
                                    <div class="namelist">
                                        <div class="sign"><span>计算者:</span><span class="ud inputarea">{if $info['worker']}{$info['worker']}{else}请填写{/if}</span></div>
                                        <div class="sign"><span>填写者:</span><span class="ud inputarea">{if $info['worker']}{$info['worker']}{else}请填写{/if}</span></div>
                                        <div class="sign"><span>审核者:</span><span class="ud inputarea">{if $info['pm']}{$info['pm']}{else}请填写{/if}</span></div>
                                    </div>
                                    
                                    <div class="ct"><span>变更日期：</span><span class="inputarea ud">请输入变更日期</span></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                {/if}
            </div>
        </form>
        <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
        
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
                
                
                $("form[name=bgbForm]").bind("keydown",function(e){
                    if(e.keyCode == 13){
                        return false;
                    }
                });
                
                {* 提交按钮 *}
                $("input[name=submit]").bind("click",function(e){
                    $("textarea[name=bgb]").val($(".container").html());
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