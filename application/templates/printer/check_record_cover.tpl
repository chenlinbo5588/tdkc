<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
        <style type="text/css">
            body,div,span,ul,ol,li,dl,dt,dd,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,select,button,textarea,p,blockquote,iframe,table,th,td,article,aside,details,figcaption,figure,footer,header,hgroupd,nav,section {
                font-family: "隶书","Microsoft YaHei", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
                font-size: 16px;
            }
            
            #check_record_cover {
                padding-top:50px;
                text-align:center;
                
            }
            
            #check_record_cover h1 {
                font-size:60px;
            }
            #check_record_cover h2 {
                font-size:30px;
            }
            
            #check_record_cover .company {
                margin-top:300px;
                font-size:20px;
            }
            
            #check_record_cover .check_date {
                margin-top:20px;
                font-size:20px;
            }
            
        </style>    
    </head>
    <body>
        <div class="container">
            <div id="check_record_cover">
                <h1 class="inputarea">测绘外业检查记录</h1>
                <h2 class="inputarea">编号：{$info['project_no']}</h2>
                <h4 class="inputarea company">{$smarty.const.OUR_COMPANY_NAME}</h4>
                <h4 class="inputarea check_date">{$dateInfo['year']}年</h4>
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