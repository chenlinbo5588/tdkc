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
                font-size:20px;
                font-weight:bold;
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
            
            .zi {
                top:315px;
                left:950px;
            }
            
            .project_no {
                top:315px;
                left:1040px;
            }
            
            .nature {
                top:315px;
                left:1220px;
            }
            
            .yddw {
                top:445px;
                left:1050px;
                width:300px;
            }
            
            .clz {
                left:1060px;
                top:580px;
            }
            
            .zlz {
                left:1060px;
                top:625px;
            }
            
            .checkor {
                left:1060px;
                top:670px;
            }
            
            .dyear {
                left:980px;
                top:865px;
            }
            
            .dmonth {
                left:1111px;
                top:865px;
            }
            
            .dday {
                left:1190px;
                top:865px;
            }
            
            .preview .zi {
                left: 505px;
                top: 675px;
            }
            
            .preview .project_no {
                left: 280px;
                top: 675px;
            }
            .preview .nature {
                left: 175px;
                top: 675px;
            }
            
            .preview .yddw {
                left: 145px;
                top: 545px;
            }
            
            .preview .clz {
                left: 350px;
                top: 415px;
            }
            
            .preview .zlz {
                left: 350px;
                top: 370px;
            }
            
            .preview .checkor {
                left: 350px;
                top: 325px;
            }
            
            
            .preview .year {
                left: 250px;
                top: 100px;
            }
            
            .preview .dyear {
                left: 425px;
                top: 130px;
            }
            
            .preview .dmonth {
                left: 350px;
                top: 130px;
            }
            
            .preview .dday {
                left: 250px;
                top: 130px;
            }
        </style>
    </head>
    <body>
        <h1 id="notice">打印时请按键盘 Shift + Enter 组合 预览，并按照预览方向放置封面</h1>
        <div class="covertd">
            <div class="item zi inputarea">{if strtoupper($info['region_code']) == 'A'}浒{else}{$info['region_name']|cutText:1:''}{/if}</div>
            <div class="item project_no inputarea">请输入项目编号</div>
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