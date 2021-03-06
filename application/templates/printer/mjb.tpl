<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
        <script type="text/javascript" src="/js/jquery.transform2d.js"></script>
        <style>
            body,div,span,ul,ol,li,dl,dt,dd,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,select,button,textarea,p,blockquote,iframe,table,th,td,article,aside,details,figcaption,figure,footer,header,hgroupd,nav,section {
                font-family: "隶书","Microsoft YaHei", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
                font-size: 16px;
            }
            
            .border1 th , .border1 td {
                padding: 3px;
            }
            
            .mjb .font15 , .mjb .font15 td , .mjb .font15 .dlname , .mjb .font15 .inputarea {
                font-size:15px !important;
            }
            
            .mjb .font14 ,  .mjb .font14 td, .mjb .font14 .dlname , .mjb .font14 .inputarea {
                font-size:14px !important;
            }
            
            .notice {
                color:#f00;
            }
        </style>
        <!--[if lt IE 7]>
        <link rel="stylesheet" type="text/css" href="/css/ie6.css" />
        <![endif]-->
    </head>
    <body>
        
        <form name="mjbForm" method="post" action="{url_path('project_ch','savemjb')}" target="post_iframe">
            <input type="hidden" name="id" value="{$info['id']}"/>
            <textarea name="mjb" style="display: none;"></textarea>
            <div id="oparea" class="center" {if $smarty.get.mode == 'print'}style="display: none;"{/if}>
                <input type="submit" name="submit" value="保存"  class="btn btn-sm btn-orange"/>
                <input type="button" name="addDjx" value="添加对角线"  class="btn btn-sm btn-gray"/>
                <input type="button" name="resetDjx" value="重置对角线"  class="btn btn-sm btn-gray"/>
                <a href="javascript:void(0);" id="addMjb">+增加面积表</a>
                <div><em>键盘组合建 Shift + Enter 隐藏本区域</em></div>
                <div class="alignleft" style="border:1px solid black;">
                    <strong>名称过长导致打印超出范围，调节字体大小</strong>
                    <div>
                        <label>范围控制<input type="text" name="range" value="" /></label><br/>
                        <em class="notice">不填表示全部面积表, 1,2表示第一张和第二张应用字体控制</em><br/>
                        <label>字体控制
                            <select name="fontCtrl">
                                <option value="">默认大小</option>
                                <option value="font15">字体减小1号</option>
                                <option value="font14">字体减小2号</option>
                            </select>
                        </label>
                    </div>
                </div>
            </div>
            <div class="container">
                {if $mjb}
                    {$mjb['content']}
                {else}
                <div class="mjb">
                    <h1 title="将文字清空可删除当前面积分类表" class="center inputarea mjb_title">{if $info['category'] == $smarty.const.TAIZHANG_WF}违法用地面积分类表{else}土地面积分类表{/if}</h1>
                    <div  class="unit">面积单位：平方米</div>
                    <table class="border1" style="table-layout: fixed;">
                        <thead>
                            <tr>
                                <td class="center toptitle" colspan="3">编号</td>
                                <td colspan="4"><span class="bh inputarea" >NO( {$info['project_no']} )</span> <span class="word inputarea" > 字 ({if strtoupper($info['region_code']) == 'A'}浒{else if ($info['region_name'] == '慈东滨海区' || $info['region_name'] == '浙江慈溪滨海经济开发区')}龙{else}{$info['region_name']|cutText:1:''}{/if}) </span> <span class="nature">性质: <span class="inputarea">{if $info['nature']}{$info['nature']}{else}请填写性质{/if}</span></span></td>
                            </tr>
                            <tr>
                                <td class="center toptitle" colspan="3" >单位名称</td>
                                <td colspan="4" class="inputarea center">{$info['name']|escape}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="3" class="toptitle">主送部门</td>
                                <td colspan="4" class="toptitle">慈溪市国土资源局</td>
                            </tr>
                            <tr class="title_col">
                                <td colspan="3" class="two_title">
                                    <div class="two_title_wrap">
                                        <span class="two_text" style="float:right">分村土地面积</span>
                                        <br/>
                                        <span class="two_text">土地分类</span>
                                        <div class="djline"></div>
                                        <div class="adjust_area">
                                            <a href="javascript:void(0);" class="adjust_add">+增加角度</a>&nbsp;
                                            <label>步长<input type="text" class="step" name="step" value="0.01"/></label>
                                            <a href="javascript:void(0);" class="adjust_minus">-减少角度</a>
                                        </div>
                                    </div>
                                </td>
                                <td class="center inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="center inputarea"></td>
                                <td class="center xj">小计</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="center dl_1">
                                <td class="cp1" rowspan="7">农<br/>用<br/>地</td>
                                <td class="cp2" rowspan="2">
                                    <span class="dlname">耕地</span>
                                </td>
                                <td class="cp3 dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="cp4 area"></td>
                                <td class="cp5 area"></td>
                                <td class="cp6 area"></td>
                                <td class="cp7 sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">园地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">林地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">草地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td rowspan="2"><span class="dlname">其他农用地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            
                            <tr class="center dl_2">
                                <td rowspan="5">建<br/>设<br/>用<br/>地</td>
                                <td rowspan="2"><span class="dlname">住宅用地</span</td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_2">
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_2">
                                <td><span class="dlname">交通用地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_2">
                                <td><span class="dlname">机关团体</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_2">
                                <td><span class="dlname">工矿仓储用地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_3">
                                <td>未利<br/>用地</td>
                                <td><span class="dlname">水域及水利设施用地</span></td>
                                <td class="dlcode2">
                                    <span class="showtext"></span>
                                    <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                                </td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr class="center" >
                                <td colspan="3">小计</td>
                                <td class="col_sum"></td>
                                <td class="col_sum"></td>
                                <td class="col_sum"></td>
                                <td class="col_sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td colspan="3">收回国有土地</td>
                                <td colspan="4" class="number inputarea">{$info['area_shgy']}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="3">合计</td>
                                <td colspan="4" class="total_sum inputarea"></td>
                            </tr>
                            <tr class="center">
                                <td rowspan="2">其中</td>
                                <td colspan="2">出让面积</td>
                                <td colspan="4" class="number inputarea">{$info['area_sell']}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="2">允许使用</td>
                                <td colspan="4" class="number inputarea">{$info['area_allow']}</td>
                            </tr>
                            <tr class="remark center">
                                <td colspan="3">备注</td>
                                <td class="alignleft inputarea" colspan="4">{$info['descripton']|escape}</td>
                            </tr>
                        </tfoot>
                    </table>
                    <div class="mjb_db">
                        <p><span class="inputarea">测量者: {$info['pm']|escape}</span></p>
                        <p><span class="inputarea">填写者: {$info['pm']|escape}</span></p>
                        <p><span class="inputarea">审核者: 王立琴</span></p>

                        <div class="center mjb_lk">
                            <p>慈溪市土地勘测规划设计院有限公司</p>
                            <p><span class="inputarea">{$dateInfo['year']}年{$dateInfo['month']}月{$dateInfo['day']}日</span></p>
                        </div>
                    </div>
                </div>
                {/if}
            </div>
        </form>
        <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
        
        <script type="x-my-template" id="mjbTemplate">
            <div class="mjb">
                <h1 title="将文字清空可删除当前面积分类表" class="center inputarea mjb_title">{if $info['category'] == $smarty.const.TAIZHANG_WF}违法用地面积分类表{else}土地面积分类表{/if}</h1>
                <div  class="unit">面积单位：平方米</div>
                <table class="border1" style="table-layout: fixed;">
                    <thead>
                        <tr>
                            <td class="center toptitle" colspan="3">编号</td>
                            <td colspan="4"><span class="bh inputarea" >NO( {$info['project_no']} )</span> <span class="word inputarea" > 字 ( {if strtoupper($info['region_code']) == 'A'}浒{else}{$info['region_name']|cutText:1:''}{/if}) </span> <span class="nature">性质: <span class="inputarea">{if $info['nature']}{$info['nature']}{else}请填写性质{/if}</span></span></td>
                        </tr>
                        <tr>
                            <td class="center toptitle" colspan="3" >单位名称</td>
                            <td colspan="4" class="inputarea center">{$info['name']|escape}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="3" class="toptitle">主送部门</td>
                            <td colspan="4" class="toptitle">慈溪市国土资源局</td>
                        </tr>
                        <tr class="title_col">
                            <td colspan="3" class="two_title">
                                <div class="two_title_wrap">
                                    <span class="two_text" style="float:right">分村土地面积</span>
                                    <br/>
                                    <span class="two_text">土地分类</span>
                                    <div class="adjust_area">
                                        <a href="javascript:void(0);" class="adjust_add">+增加角度</a>&nbsp;
                                        <label>步长<input type="text" class="step" name="step" value="0.01"/></label>
                                        <a href="javascript:void(0);" class="adjust_minus">-减少角度</a>
                                    </div>
                                    <div class="djline"></div>
                                </div>
                            </td>
                            <td class="center inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="center inputarea"></td>
                            <td class="center xj">小计</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="center dl_1">
                            <td class="cp1" rowspan="7"><div>农</div><div>用</div><div>地</div></td>
                            <td class="cp2" rowspan="2">
                                <span class="dlname">耕地</span>
                            </td>
                            <td class="cp3 dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="cp4 area"></td>
                            <td class="cp5 area"></td>
                            <td class="cp6 area"></td>
                            <td class="cp7 sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">园地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">林地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">草地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td rowspan="2"><span class="dlname">其他农用地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_2">
                            <td rowspan="5"><div>建</div><div>设</div><div>用</div><div>地</div></td>
                            <td rowspan="2"><span class="dlname">住宅用地</span</td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_2">
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_2">
                            <td><span class="dlname">交通用地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_2">
                            <td><span class="dlname">机关团体</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_2">
                            <td><span class="dlname">工矿仓储用地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_3">
                            <td><div>未利</div><div>用地</div></td>
                            <td><span class="dlname">水域及水利设施用地</span></td>
                            <td class="dlcode2">
                                <span class="showtext"></span>
                                <select type="text" class="txtcode2 hidden" name="dlcode2"></select>
                            </td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="center" >
                            <td colspan="3">小计</td>
                            <td class="col_sum"></td>
                            <td class="col_sum"></td>
                            <td class="col_sum"></td>
                            <td class="col_sub_sum"></td>
                        </tr>
                        <tr class="center">
                            <td colspan="3">收回国有土地</td>
                            <td colspan="4" class="number inputarea">{$info['area_shgy']}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="3">合计</td>
                            <td colspan="4" class="total_sum"></td>
                        </tr>
                        <tr class="center">
                            <td rowspan="2">其中</td>
                            <td colspan="2">出让面积</td>
                            <td colspan="4" class="number inputarea">{$info['area_sell']}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="2">允许使用</td>
                            <td colspan="4" class="number inputarea">{$info['area_allow']}</td>
                        </tr>
                        <tr class="remark center">
                            <td colspan="3">备注</td>
                            <td class="alignleft inputarea" colspan="4">{$info['descripton']|escape}</td>
                        </tr>
                    </tfoot>
                </table>
                <div class="mjb_db">
                    <p><span class="inputarea">测量者: {$info['pm']|escape}</span></p>
                    <p><span class="inputarea">填写者: {$info['pm']|escape}</span></p>
                    <p><span class="inputarea">审核者: 王立琴</span></p>

                    <div class="center mjb_lk">
                        <p>慈溪市土地勘测规划设计院有限公司</p>
                        <p><span class="inputarea">{$dateInfo['year']}年{$dateInfo['month']}月{$dateInfo['day']}日</span></p>
                    </div>
                </div>
            </div>    
        </script>
        <script>
            var dlList = {
                'd1':[
                {foreach name="dl" from=$dlList[1] item=item}
                   { "code" : "{$item['code']}", "name" : "{$item['name']}" } {if !$smarty.foreach.dl.last},{/if}
                {/foreach}
                ],
                'd2':[
                {foreach name="dl" from=$dlList[2] item=item}
                   { "code" : "{$item['code']}", "name" : "{$item['name']}" } {if !$smarty.foreach.dl.last},{/if}
                {/foreach}
                ],
                'd3':[
                {foreach name="dl" from=$dlList[3] item=item}
                   { "code" : "{$item['code']}", "name" : "{$item['name']}" } {if !$smarty.foreach.dl.last},{/if}
                {/foreach}
                ]
            };
            
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
                
                var dataToOption = function(index,sel){
                    var html = [];
                    html.push('<option value="">请选择</option>');
                    for(var i = 0; i < dlList[index].length; i++){
                        html.push('<option value="' + dlList[index][i].code + '" ' + (sel == dlList[index][i].code ? "selected" : '') + '>' + dlList[index][i].name + '(' + dlList[index][i].code + ')</option>');
                    }
                   return html.join('');
                }
                
                $("form[name=mjbForm]").bind("keydown",function(e){
                    if(e.keyCode == 13){
                        return false;
                    }
                });
                
                
                $("select[name=fontCtrl]").bind("change",function(e){
                    var v = $(e.target).val();
                    var range = $("input[name=range]").val();
                    var rangeAr = range.split(/[,，]/);
                    var rangeList = [];
                    var i = 0;
                    
                    for(i = 0; i < rangeAr.length; i++){
                        rangeAr[i] = $.trim(rangeAr[i]);
                        
                        if(parseInt(rangeAr[i]) > 0){
                            rangeList.push(parseInt(rangeAr[i]) - 1);
                        }
                    }
                    
                    if(rangeList.length == 0){
                        if(v == ""){
                            $(".mjb table.border1").removeClass("font14").removeClass("font15");
                        }else if(v == "font14"){
                            $(".mjb table.border1").removeClass("font15").addClass("font14");
                        }else if(v == "font15"){
                            $(".mjb table.border1").removeClass("font14").addClass("font15");
                        }
                    
                    }else{
                        for(i = 0; i < rangeList.length; i++){
                            if(v == ""){
                                $(".mjb:eq(" + rangeList[i] + ") table.border1").removeClass("font14").removeClass("font15");
                            }else if(v == "font14"){
                                $(".mjb:eq(" + rangeList[i] + ") table.border1").removeClass("font15").addClass("font14");
                            }else if(v == "font15"){
                                $(".mjb:eq(" + rangeList[i] + ") table.border1").removeClass("font14").addClass("font15");
                            }
                        }
                    }                    
                });
                
                var reSum = function(obj){
                    var table = $(obj).closest("table");
                    var col_sub_sum = 0;
                    
                    $(".sub_sum",table).each(function(index){
                        var sub_sum = $(this);
                        var total = 0;
                        var areas = $(sub_sum).closest("tr").find(".area");
                        
                        $(areas).each(function(idx){
                            if($(this).html() != ''){
                                total += parseFloat($(this).html());
                            }
                        });
                        
                        if(total > 0){
                           {if ($info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征')}
                           sub_sum.html(total);
                           {else}
                            sub_sum.html(total.toFixed(2));
                           {/if}
                        }else{
                            sub_sum.html('');
                        }
                        
                        col_sub_sum += total;
                    });
                    
                    
                    $(".col_sum",table).each(function(index){
                        var total = 0;
                        var col_sub_sum = $(this);
                        $("tbody tr",table).each(function(idx){
                            var area = $(".area:eq(" + index + ")",this).html();
                            
                            if(area != ''){
                                total += parseFloat(area);
                            }
                        });
                        if(total > 0){
                            {if ($info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征')}
                            $(this).html(total);
                            {else}
                            $(this).html(total.toFixed(2));
                            {/if}
                        }else{
                            $(this).html('');
                        }
                        
                        col_sub_sum += total;
                    });
                    
                    if(col_sub_sum > 0){
                        {if ($info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征')}
                        $(".col_sub_sum",table).html(col_sub_sum);
                        $(".total_sum",table).html(col_sub_sum);
                        {else}
                        $(".col_sub_sum",table).html(col_sub_sum.toFixed(2));
                        $(".total_sum",table).html(col_sub_sum.toFixed(2));
                        {/if}
                    }else{
                        $(".col_sub_sum",table).html('');
                        $(".total_sum",table).html('');
                    }
                    
                };
                
                $("#addMjb").bind('click',function(e){
                    $(".container").append($($("#mjbTemplate").html()));
                });
                
                
                $("body").bind("keydown",function(e){
                    if(e.shiftKey && e.keyCode == 13){
                        $("#oparea").slideToggle();
                    }
                });
                
                {*
                 面积处理
                 *}
                $("body").delegate(".area","click",function(e){
                    var that = $(e.target);
                    var txt = $('<input type="text" class="tptxt" name="" value="' + $(e.target).html() + '"/>');
                    that.html(txt);
                    txt.focus();
                    
                    var doSetVal = function(){
                        if($.trim(txt.val()) != '' && areaReg.test(txt.val())){
                            var v = parseFloat(txt.val());
                            {if ($info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征')}
                                that.html(v);
                            {else}
                                that.html(v.toFixed(2));
                            {/if}
                        }else{
                            that.html('');
                        }
                        txt.remove();
                        
                        reSum(that);
                    };
                    
                    txt.bind("keydown",function(e){
                        if(e.keyCode == 13){
                            doSetVal();
                        }
                    });
                    
                    txt.bind('blur',function(e){
                        doSetVal();
                    });
                });
                
                
                {*
                 地类选择
                 *}
                $("body").delegate(".dlcode2","click",function(e){
                    var that = $(e.target);
                    var code = '';
                    var currentHtml = that.find(".showtext").html();
                   
                   if(currentHtml){
                        var leftc = currentHtml.indexOf('(');
                        var right = currentHtml.indexOf(')');
                        
                        if(leftc && right){
                            code = currentHtml.substring(leftc + 1, right);
                        }
                   }
                   
                    that.find(".txtcode2").html('');
                    that.find(".showtext").hide();
                    if(that.closest("tr").hasClass("dl_1")){
                        that.find(".txtcode2").html(dataToOption('d1',code));
                    }else if(that.closest("tr").hasClass("dl_2")){
                        that.find(".txtcode2").html(dataToOption('d2',code));
                    }else if(that.closest("tr").hasClass("dl_3")){
                        that.find(".txtcode2").html(dataToOption('d3',code));
                    }
                    
                    that.find(".txtcode2").show().focus();
                });
                
                {*
                 地类选择后显示的文本
                 *}
                $("body").delegate(".showtext","click",function(e){
                    $(e.target).closest(".dlcode2").trigger("click");
                });
                
                {*
                    地类下拉框
                 *}
                $("body").delegate(".txtcode2","change",function(e){
                    var that = $(e.target);
                    var v = that.val();
                    var name = '';
                    if(v != ''){
                        name = $("option:selected",that).html();
                        name = name.substring(0, name.indexOf('('));
                        
                        that.siblings(".showtext").html(name + '<br/>(' + v  + ')').show();
                    }
                    
                    that.hide();
                });
                
                
                $("body").delegate(".noborder","mouseenter",function(e){
                    $(e.target).addClass("stathover");
                });
                
                $("body").delegate(".noborder","mouseleave",function(e){
                    $(e.target).removeClass("stathover");
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
                                {if ($info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征')}
                                    that.html(parseFloat(a));
                                {else}
                                    that.html(parseFloat(a).toFixed(2));
                                {/if}
                            }else{
                                that.html('');
                            }
                        }else{
                            if(mjbTitle){
                                if(a == ''){
                                    that.closest(".mjb").remove();
                                }else{
                                    that.html('土地面积分类表');
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
                
                {*
                    一级分类名称修改，主要为了防止有 行不够用的情况,可以利用没有用到大类 ，将其修改掉名称
                 *}
                $("body").delegate(".dlname","click",function(e){
                    var txt = $('<input type="text" class="tptxt" name="" value="' + $(e.target).html() + '"/>');
                    $(e.target).hide();
                    txt.insertBefore($(e.target));
                    
                    txt.focus();
                    
                    txt.bind('blur',function(e){
                        var that = $(e.target);
                        
                        if($.trim(that.val()) != ''){
                            that.siblings('.dlname').html(that.val()).show();
                        }else{
                            that.siblings('.dlname').show();
                        }
                        that.remove();
                    });
                });
                
                {* 提交按钮 *}
                $("input[name=submit]").bind("click",function(e){
                    $("input[name=resetDjx]").trigger("click", {});
                    $("input[name=addDjx]").trigger("click", {});
                    
                    $("textarea[name=mjb]").val($(".container").html());
                    
                });
                
                {* 添加对角线按钮 *}
                
                $("body").delegate(".two_title_wrap",'mouseenter',function(e){
                    $(this).find(".adjust_area").show();
                });
                
                $("body").delegate(".two_title_wrap",'mouseleave',function(e){
                    $(this).find(".adjust_area").hide();
                });
                
                $("body").delegate(".adjust_area a",'click',function(e){
                    var that = $(this);
                    var n = parseFloat($(this).closest('.adjust_area').find('.step').val());
                    var m ;
                    if(!$(this).hasClass('adjust_minus')){
                        n = -n;
                    }
                    var line = that.parent().siblings(".djline");
                    var matrix = '';
                    var pre = '';
                    var pre = ['-webkit-transform','-moz-transform','-o-transform','-ms-transform', 'transform'];
                    
                    for(var i = 0; i < pre.length; i++){
                        matrix = line.css(pre[i]);
                        if(/matrix/.test(matrix)){
                            break;
                        }
                    }
                    
                    if(!/matrix/.test(matrix)){
                        line.css({  "transform": "matrix(1,0,0,1,0,0)" });
                    }
                    
                    for(var i = 0; i < pre.length; i++){
                        matrix = line.css(pre[i]);
                        if(/matrix/.test(matrix)){
                            break;
                        }
                    }
                    
                    if(matrix){
                        m = matrix.match('matrix\\((.*)\\)');
                    }
                    
                    //console.log(matrix);
                    if(m){
                        
                        var sp = m[1].split(',');
                        //console.log(sp);
                        sp[0] = parseFloat(sp[0]) + n;
                        sp[1] = parseFloat(sp[1]) - n;
                        sp[2] = -sp[1];
                        sp[3] = sp[0];
                        line.css({ 
                            "transform": "matrix(" + sp.join(',') + ")" ,
                            "margin-top":0,
                            "margin-left":0
                        });
                    }
                });
                
                $("input[name=resetDjx]").bind('click',function(e){
                    $('.djline').css({
                         "transform": "matrix(1,0,0,1,0,0)"
                    }).hide();
                });
                
                $("input[name=addDjx]").bind('click',function(e){
                    $(".two_title_wrap").each(function(){
                        //console.log($(this).height());
                        //console.log($(this).closest("td").height());
                        $(this).css({ height: $(this).closest("td").height() + "px" });
                        
                        var w = $(this).outerWidth();
                        var h = $(this).outerHeight();
                        var s = Math.sqrt(w * w + h * h);
                        var sina = (h / s) ;
                        var cosa = (w / s) ;
                        
                        //console.log(h);
                        //console.log(w);
                        //console.log($('.djline',$(this)).css("transform"));
                        
                        $('.djline',$(this).closest("table")).css({
                             "transform": "matrix(" + cosa + "," + sina + ",-" + sina + "," + cosa + ",0,0)",
                             "margin-top":0,
                             "margin-left":0
                            }).show();
                    });
                });
                
                //自动描绘对角线
                $("input[name=resetDjx]").trigger("click", {});
                $("input[name=addDjx]").trigger("click", {});
            });
        
        </script>
    </body>
</html>