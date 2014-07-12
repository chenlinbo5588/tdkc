<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
        <style>
            .covertd {
                position:relative;
                boder:1px solid red;
            }
            
            .covertd div {
                position:absolute;
                left:0px;
                top:0px;
            }
            
            #zi {
                top:100px;
                left:200px;
            }
            
            #project_no {
                top:100px;
                left:300px;
            }
            
            #nature {
                top:100px;
                left:550px;
            }
            
            #yddw {
                left:250px;
                top:350px;
            }
            
            #clz {
                left:250px;
                top:500px;
            }
            
            #zlz {
                left:250px;
                top:550px;
            }
            
            #checkor {
                left:250px;
                top:600px;
            }
            
            
        </style>
    </head>
    <body>
        <div class="covertd">
            <div id="zi">{$info['region_name']|cutText:1:''}</div>
            <div id="project_no" class="inputarea">请输入项目编号</div>
            <div id="nature" class="inputarea">{if $info['nature']}{$info['nature']}{else}请输入性质{/if}</div>
            <div id="yddw" class="inputarea">{$info['name']|escape}</div>
            <div id="clz" class="inputarea">{$info['pm']|escape}</div>
            <div id="zlz" class="inputarea">罗陆燕</div>
            <div id="checkor" class="inputarea">王立琴</div>
        </div>
    </body>
    
    <script>
        $(function(){
            var areaReg = /^\d+(.\d*)?$/;
            
            $("body").delegate(".inputarea","click",function(e){
                var txt = $('<input type="text" class="tptxt" name="" value="' + $(e.target).html() + '"/>');
                var that = $(e.target);
                var number = false;
                var mjbTitle = false;
                if(that.hasClass("number")){
                    number = true;
                }else if(that.hasClass('mjb_title')){
                    mjbTitle = true;
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
                        that.html(a);
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
</html>