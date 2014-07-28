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
                background:url("/img/doc_cover.jpg") no-repeat left top;
                left:-740px;
            }
            
            .preview {
                1background:url("/img/doc_cover_roll.jpg") no-repeat left top;
                background:none;
                left:0px;
            }
            
            .covertd .item {
                position:absolute;
                font-size:34px;
                font-family: "隶书";
            }
            
            .preview .item {
                 -moz-transform-origin: 50% 50%;
                -webkit-transform-origin: 50% 50%;
                -o-transform-origin: 50% 50%;
                -ms-transform-origin: 50% 50%;
                transform-origin: 50% 50%;
                
                -moz-transform: rotate(180deg);
                -webkit-transform: rotate(180deg);
                -o-transform: rotate(180deg);
                -ms-transform: rotate(180deg);
                transform: rotate(180deg);
            }
            
            .covertd .zi {
                top:315px;
                left:950px;
                font-size:30px;
            }
            
            .covertd .project_no {
                top:315px;
                left:1040px;
                font-size:26px;
            }
            
            .covertd .nature {
                top:315px;
                left:1220px;
                font-size:30px;
            }
            
            .covertd .yddw {
                top:445px;
                left:1050px;
                width:500px;
                line-height:30px;
            }
            
            .covertd .clz {
                left:1060px;
                top:575px;
            }
            
            .covertd .zlz {
                left:1060px;
                top:620px;
            }
            
            .covertd .checkor {
                left:1060px;
                top:665px;
            }
            
            .covertd .dyear {
                left:970px;
                top:860px;
            }
            
            .covertd .dmonth {
                left:1105px;
                top:860px;
            }
            
            .covertd .dday {
                left:1185px;
                top:860px;
            }
            
            .preview .zi {
                left: 650px;
                top: 980px;
                
            }
            
            .preview .project_no {
                left: 345px;
                top: 980px;
                
            }
            .preview .nature {
                left: 150px;
                top: 980px;
                
            }
            
            .preview .yddw {
                left: 20px;
                top: 780px;
            }
            
            .preview .clz {
                left: 410px;
                top: 580px;
            }
            
            .preview .zlz {
                left: 410px;
                top: 510px;
            }
            
            .preview .checkor {
                left: 410px;
                top: 440px;
            }
            
            .preview .dyear {
                left: 530px;
                top: 150px;
            }
            
            .preview .dmonth {
                left: 415px;
                top: 150px;
            }
            
            .preview .dday {
                left: 240px;
                top: 150px;
            }
        </style>
    </head>
    <body>
        <h1 id="notice" style="display:none;">打印时请按键盘 Shift + Enter 组合 预览，并按照预览方向放置封面</h1>
        <div class="covertd preview">
            <div class="item zi inputarea">{if strtoupper($info['region_code']) == 'A'}浒{else}{$info['region_name']|cutText:1:''}{/if}</div>
            <div class="item project_no inputarea">{$info['project_no']}</div>
            <div class="item nature inputarea">{if $info['nature']}{$info['nature']}{else}请输入性质{/if}</div>
            <div class="item yddw inputarea">{$info['name']|escape}</div>
            <div class="item clz inputarea">{$info['pm']|escape}</div>
            <div class="item zlz inputarea">罗陆燕</div>
            <div class="item checkor inputarea">王立琴</div>
            <div class="item dyear inputarea">{$dateInfo['year']}</div>
            <div class="item dmonth inputarea">{$dateInfo['month']}</div>
            <div class="item dday inputarea">{$dateInfo['day']}</div>
        </div>
    </body>
    
    <script>
        $(function(){
            var areaReg = /^\d+(.\d*)?$/;
            
            $("body").bind("keydown",function(e){
                if(e.shiftKey && e.keyCode == 13){
                    $(".covertd").toggleClass("preview");
                    $("#notice").toggle();
                    /*
                    var lineh = $(".yddw").height();
                    var numrow = Math.ceil(lineh / 30);
                    //console.log($(".yddw").css("top"));
                    
                    if($(".covertd").hasClass("preview")){
                        $(".yddw").css({
                            top: parseInt($(".yddw").css("top")) - ((numrow - 1) * 30)
                        });
                    }else{
                        $(".yddw").removeAttr("style");
                    }
                    */
                }
            });
            
            $("body").delegate(".inputarea","click",function(e){
                var txt = $('<input type="text" class="tptxt" name="" value="' + $(e.target).html() + '"/>');
                var that = $(e.target);
                var number = false;
                var mjbTitle = false;
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
</html>