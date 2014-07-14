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
            <div class="kcdj">
                <h1 class="title"><span class="inputarea ud">{if $info['name']}{$info['name']|escape}{else}请输入名称{/if}</span>土地勘测定界报告</h1>
                <div class="pg pg1">
                    <h2 class="subtitle">一、概述</h2>
                    <p>
                        <span class="inputarea">受慈溪市国土资源局委托，慈溪市土地勘测规划设计院有限公司于</span><span class="inputarea">{$info['createtime']|date_format:"Y年"}</span><span class="inputarea ud">{$info['createtime']|date_format:"m"}</span>月
                        <span>对</span><span class="inputarea ud">{$info['name']}</span><span>进行土地勘测定界工作。</span>
                    </p>
                    <p>
                        <span>该地块位于慈溪市</span><span class="inputarea ud">{$info['region_name']|escape}</span><span class="inputarea ud">请输入村名</span><span>村,</span>
                        <span>东临：</span><span class="inputarea ud">请输入东临</span><span>;</span>
                        <span>南临：</span><span class="inputarea ud">请输入南临</span><span>;</span>
                        <span>西临：</span><span class="inputarea ud">请输入西临</span><span>;</span>
                        <span>北临：</span><span class="inputarea ud">请输入北临</span><span>。</span>
                        <span>地理位置:东经</span><span class="inputarea ud">121</span><sup>。</sup><span class="inputarea ud">请输入东经</span><sup>'</sup>
                        <span>北纬：</span><span class="inputarea ud">30</span><sup>。</sup><span class="inputarea ud">请输入北纬</span><sup>'。</sup>
                        <span>征收<span class="inputarea ud">{$info['region_name']|escape}</span><span>&nbsp;</span><span class="inputarea ud">请输入村名</span>
                        <span>农用地面积</span><span class="inputarea ud">请输入面积</span><span>公顷。</span>
                    </p>
                </div>
                <div class="pg pg2">
                    <h2 class="subtitle">一、作业依据</h2>
                    <table class="fixtb">
                        <colgroup>
                            <col width="50"/>
                            <col width="500"/>
                        </colgroup>
                        <tr><td>(1)</td><td>《土地勘测定界规程》TD/T 1008-2007；</td></tr>
                        <tr><td>(2)</td><td>《土地利用现状分类》GB/T 21010-2007；</td></tr>
                        <tr><td>(3)</td><td>《浙江省数字地籍调查技术规程》（浙江省国土资源厅2008）；</td></tr>
                        <tr><td>(4)</td><td>《全球定位系统（GPS）测量规范》GB/T 18314-2009；</td></tr>
                        <tr><td>(5)</td><td>《浙江省GPS-RTK测量技术规定（试行）》（浙江省测绘局制定，2008-03-01发布）；</td></tr>
                        <tr><td>(6)</td><td>《城市测量规范》CJJ8-99；</td></tr>
                        <tr><td>(7)</td><td>《1∶500  1∶1000  1∶2000地形图图式》GB/T 20257.1-2007</td></tr>
                    </table>
                </div>
                <div class="pg pg3">
                    <h2 class="subtitle">三、坐标系统</h2>
                    <p>勘测定界测量采用1980西安坐标系，1985国家高程基准。</p>
                </div>
                <div class="pg pg4">
                    <h2 class="subtitle">四、勘测定界测量</h2>
                    <p class="smalltitle">（1）土地权属调查</p>
                    <p>经国土主管部门授权，作业人员对用地范围所涉及的乡（镇）、村的权属界线进行调查，由各方面权利人到实地认真指界，经各相邻双方认同后现场填写权属界线认定书。</p>
                    <p class="smalltitle">（2）土地分类调查</p>
                    <p>对建设规划红线范围内的土地分类进行实地调查，如实反映出实地土地类别的现状、地表植被和相应建筑。以慈溪市1∶10000土地利用现状图、总体规划</p>
                    <p>图和本院实测地形图作为本次植被和地类调查的工作底图，做到三图统一，不统一的以地类高的为准。</p>
                    <p class="smalltitle">（3）拨地定桩测量</p>
                    <p>根据规划部门提供的红线坐标，采用RTK技术实地放样，做出永久性标志符号，在水泥地面上采用刻石、沥青路面上打钢钎，其余地域，埋固定界桩，或采用混凝土现场浇灌，并用红漆标注界址点号。</p>
                    <p class="smalltitle">（4）土地勘测定界图测绘</p>
                    <p>对用地红线范围内地形、地貌进行实地测绘，再根据土地权属调查，土地分类调查，界址点、界址线以及其他地籍要素，制成土地勘测定界图。</p>
                    <p class="smalltitle">（5）面积计算</p>
                    <p>面积计算成果是本次土地勘测的最重要的成果之一，它直接关系到权属单位的土地资产和利益。通过野外的实测调查和权属界线，对用地红线范围内土地进行分类及计算统计。</p>
                </div>
                <div class="pg pg5">
                    <h2 class="subtitle">五、质量保障</h2>
                    <p>为切实保证质量，在开展工作在进行全面的动员和要求，同时各作业组均由专人负责，检查质量，专业人员对各阶段所完成的工作进行全面抽查，发现问题后马上修改和纠正。为质量保障和提供合格的产品打下了坚实的基础。</p>
                </div>
                <div class="pg pg6">
                    <h2 class="subtitle">六、提交资料</h2>
                    <p>(1) 土地勘测报告</p>
                    <p>(2) 土地分类面积统计表</p>
                    <p>(3) 界址点成果表</p>
                    <p>(4) 土地勘测定界图</p>
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
                        if(mjbTitle){
                            if(a == ''){
                                that.closest(".mjb").remove();
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
</html>