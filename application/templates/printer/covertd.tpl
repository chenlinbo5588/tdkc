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
                width:1480px;
                height:1020px;
            }
            
            .preview {
                background:url("/img/doc_cover.jpg") no-repeat left top;
            }
            
            .covertd div {
                position:absolute;
                left:0px;
                top:0px;
                font-size:16px;
                font-weight:bold;
            }
            
            #zi {
                top:318px;
                left:950px;
            }
            
            #project_no {
                top:318px;
                left:1058px;
            }
            
            #nature {
                top:318px;
                left:1220px;
            }
            
            #yddw {
                top:450px;
                left:1050px;
            }
            
            #clz {
                left:1060px;
                top:580px;
            }
            
            #zlz {
                left:1060px;
                top:625px;
            }
            
            #checkor {
                left:1060px;
                top:670px;
            }
            
            #dyear {
                left:990px;
                top:865px;
            }
            
            #dmonth {
                left:1111px;
                top:865px;
            }
            
            #dday {
                left:1190px;
                top:865px;
            }
        </style>
    </head>
    <body>
        <div class="covertd preview">
            <div id="zi">{if strtoupper($info['region_code']) == 'A'}浒{else}{$info['region_name']|cutText:1:''}{/if}</div>
            <div id="project_no" class="inputarea">请输入项目编号</div>
            <div id="nature" class="inputarea">{if $info['nature']}{$info['nature']}{else}请输入性质{/if}</div>
            <div id="yddw" class="inputarea">{$info['name']|escape}</div>
            <div id="clz" class="inputarea">{$info['pm']|escape}</div>
            <div id="zlz" class="inputarea">罗陆燕</div>
            <div id="checkor" class="inputarea">王立琴</div>
            
            <div id="dyear" class="inputarea">{$dateInfo['year']}</div>
            <div id="dmonth" class="inputarea">{$dateInfo['month']}</div>
            <div id="dday" class="inputarea">{$dateInfo['day']}</div>
        </div>
    </body>
    
    <script>
        $(function(){
            var areaReg = /^\d+(.\d*)?$/;
            
            $("body").bind("keydown",function(e){
                if(e.shiftKey && e.keyCode == 13){
                    $(".covertd").toggleClass("preview");
                }
            });
            
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