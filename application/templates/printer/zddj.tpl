<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
        <style>
            body,div,span,ul,ol,li,dl,dt,dd,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,select,button,textarea,p,blockquote,iframe,table,th,td,article,aside,details,figcaption,figure,footer,header,hgroupd,nav,section {
                font-size: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="zddj">
                <h1 class="title">宗地勘测定界成果报告</h1>
                <div class="pg pg1">
                    <span class="inputarea">慈溪市土地勘测规划设计院有限公司于</span><span class="inputarea">{$info['createtime']|date_format:"Y年"}</span><span class="inputarea ud">{$info['createtime']|date_format:"m"}</span>月
                    <span>受</span><span class="inputarea ud">{$info['name']}</span>及<span class="inputarea ud">{$info['region_name']}</span><span>国土资源所</span><span>委托，对位于</span><span class="inputarea ud">{$info['address']}</span><span>的该宗地所在地块进行土地勘测定界测量和属性、权属调查。经实地调查，其征收土地</span><span >总面积</span><span class="inputarea ud">{if $info['total_area']}{$info['total_area']}{else}请输入面积{/if}</span><span>m<sup>2</sup>,<span class="inputarea">平面坐标为宁波独立坐标系</span><span>，高程基准为1985国家高程基准。</span>
                </div>
                <div class="pg pg2">
                    <h2 class="subtitle">一、作业依据</h2>
                    <table class="fixtb">
                        <colgroup>
                            <col width="50"/>
                            <col width="550"/>
                        </colgroup>
                        <tr><td>1、</td><td>GB/T 21010-2007 中华人民共和国关于《土地利用现状分类》。</td></tr>
                        <tr><td>2、</td><td>[2003] 《浙江省土地利用现状更新调查技术规范》。</td></tr>
                        <tr><td>3、</td><td>[2005] 《浙江省城镇数字地籍调查暂行规定》。</td></tr>
                        <tr><td>4、</td><td>CJJ-99 《城市测量规范》。</td></tr>
                        <tr><td>5、</td><td>[2003] 《宁波市控制测量技术补充规程(试行)》。</td></tr>
                    </table>
                    <h2 class="subtitle">二、人员组成及仪器设备</h2>
                    <table class="fixtb">
                        <colgroup>
                            <col width="50"/>
                            <col width="550"/>
                        </colgroup>
                        <tr><td>1、</td><td>本次作业根据任务情况，组织三名测绘技术人员（其中测绘助理工程师一名，技术员一名，测工一名），提供技术保障。</td></tr>
                        <tr><td>2、</td><td>本次作业投入的仪器设备有拓普康全站仪一台采用全野外数字法观测、Trimble 5700 GPS RTK 仪器一套，投入的仪器设备均经过质检。电脑成图由“瑞德”软件作为基本软件。</td></tr>
                    </table>
                </div>
                <div class="pg pg3">
                    <h2 class="subtitle">三、土地勘测定界情况</h2>
                    <ul>
                        <li>
                            <h3 class="subtitle" style="padding: 0 0 30px 0;" >1、权属及地类调查</h3>
                            <div class="pagemarker">&nbsp;</div>
                            <p>对收集到的资料进行整理、分析、实地调查用地范围内的权属性质、地类性质、查清用地范围内的土地权属界线，查清用地范围内的土地利用类型及分布。</p>
                        </li>
                        <li>
                            <h3 class="subtitle">2、面积计算</h3>
                            <p>通过野外的实测权属和地类界线,并根据GB/T21010-2007 《土地利用现状分类》的标准，在土地勘测定界电子图上对征地红线范围内的地块进行土地分类及面积计算统计，数据直接提取空间数据库，保证了图形数据、属性数据的一致性。</p>
                        </li>
                    </ul>
                </div>
                <div class="pg pg4">
                    <h2 class="subtitle">四、质量保证措施</h2>
                    <ul>
                        <li>
                            <p>为了保证勘测成果的质量，本院严格实行测绘产品质量二级检查一级验收制度。（室）级检查做到100%质量检查和互查，完全符合质量要求后，才可进行下道工序；质量检查组对交来的成果进行100%内查，外业抽查20%以上；院级验收由总工室负责实施，确保用地界址点与相邻宗地界址点或地物点一致，勘测定界成果导入本院地籍管理信息系统，并签署验审意见，确保成果的准确无误。</p>
                        </li>
                    </ul>
                 </div>
                <div class="sign">
                        <p>慈溪市土地勘测规划设计院有限公司</p>
                        <span class="inputarea">{$dateInfo['year']}年{$dateInfo['month']}月{$dateInfo['day']}日</span>
                </div>
            </div>
        </div>
    </body>
    
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
</html>