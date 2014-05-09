<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
    </head>
    <body>
        
        <script type="x-my-template" id="mjbTemplate">
            <div class="mjb">
                <h1 class="center">土地面积分类表</h1>
                <div style="text-align: right;padding:2px 10px;">面积单位：平方米</div>
                <table class="border1" style="table-layout: fixed;">
                    <thead>
                        <tr>
                            <td class="center" colspan="3" style="letter-spacing:20px;">编号</td>
                            <td colspan="4">NO( {$info['project_no']} ) 字 ( {$info['region_name']|cutText:1:''}) 性质: <input type="text" name="nature" class="noborder"  value="{$info['nature']}"/></td>
                        </tr>
                        <tr>
                            <td class="center" colspan="3" style="letter-spacing:20px;">单位名称</td>
                            <td colspan="4">{$info['name']|escape}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="3" style="letter-spacing:20px;">主送部门</td>
                            <td colspan="4" style="letter-spacing:20px;">市国土资源局</td>
                        </tr>
                        <tr class="title_col">
                            <td colspan="3">
                                <span style="float:right">分村土地面积</span>
                                <br/>
                                <span>土地分类</span>
                            </td>
                            <td><input type="text" class="viliage noborder" name="v1" value=""/></td>
                            <td><input type="text" class="viliage noborder" name="v2" value=""/></td>
                            <td><input type="text" class="viliage noborder" name="v3" value=""/></td>
                            <td class="center" style="letter-spacing:20px;">小计</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="center dl_1">
                            <td style="width: 40px;" rowspan="6"><div>农</div><div>用</div><div>地</div></td>
                            <td style="width: 60px;" rowspan="2">
                                <span class="dlname">耕地</span>
                            </td>
                            <td style="width:80px;" class="dlcode2"></td>
                            <td style="width:100px;" class="area"></td>
                            <td style="width:100px;" class="area"></td>
                            <td style="width:100px;" class="area"></td>
                            <td style="width:100px;" class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">园地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">林地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">牧草地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center dl_1">
                            <td><span class="dlname">其他农用地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>

                        <tr class="center dl_2">
                            <td rowspan="5"><div>建</div><div>设</div><div>用</div><div>地</div></td>
                            <td rowspan="2"><span class="dlname">住宅用地</span</td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center">
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center">
                            <td><span class="dlname">交通用地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center">
                            <td><span class="dlname">机关团体</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center">
                            <td><span class="dlname">工矿仓储用地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                        <tr class="center">
                            <td><div>未利</div><div>用地</div></td>
                            <td><span class="dlname">其他用地</span></td>
                            <td class="dlcode2"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="area"></td>
                            <td class="sub_sum"></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td class="center" colspan="3">小计</td>
                            <td class="col_sub_sum"></td>
                            <td class="col_sub_sum"></td>
                            <td class="col_sub_sum"></td>
                            <td class="col_sub_sum"></td>
                        </tr>
                        <tr class="center" >
                            <td colspan="3">收回国有土地</td>
                            <td colspan="4">{$info['area_shgy']}</td>
                        </tr>
                        <tr class="center" >
                            <td colspan="3">合计</td>
                            <td colspan="4" class="total_sum"></td>
                        </tr>
                        <tr class="center">
                            <td rowspan="2">其中</td>
                            <td colspan="2">出让面积</td>
                            <td colspan="4">{$info['area_sell']}</td>
                        </tr>
                        <tr class="center">
                            <td colspan="2">允许使用</td>
                            <td colspan="4">{$info['area_allow']}</td>
                        </tr>
                        <tr style="height:60px;" class="center">
                            <td colspan="3">备注</td>
                            <td style="text-align:left;" colspan="4">
                                <input type="text" class="noborder" style="width:100%;height:60px;" value="{$info['descripton']|escape}"/>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <div style="position:relative;padding:10px 30px;">
                    <p>测量者: {$info['pm']}</p>
                    <p>填写者: {$info['worker']}</p>
                    <p>审核者: {$info['cs_name']}</p>

                    <div class="center" style="position:absolute;right:10px;top:20px;">
                        <p>慈溪市土地勘测规划设计院有限公司</p>
                        <p>{$dateInfo['year']}年{$dateInfo['month']}月{$dateInfo['day']}日</p>
                    </div>
                </div>
            </div>
        </script>
        <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
        <form name="mjbForm" method="post" action="{url_path('project_ch','mjb')}" target="post_iframe">
            <input type="hidden" name="id" value="{$info['id']}"/>
            <div class="center">
                <input type="submit" name="submit" value="保存"  class="btn btn-sm btn-orange"/>
            </div>
            <div class="container">
                <div class="mjb">
                    <h1 class="center">土地面积分类表</h1>
                    <div style="text-align: right;padding:2px 10px;">面积单位：平方米</div>
                    <table class="border1" style="table-layout: fixed;">
                        <thead>
                            <tr>
                                <td class="center" colspan="3" style="letter-spacing:20px;">编号</td>
                                <td colspan="4"><span>NO( {$info['project_no']} ) 字 ( {$info['region_name']|cutText:1:''}) 性质: <input type="text" name="nature" class="noborder"  value="{$info['nature']}"/></span></td>
                            </tr>
                            <tr>
                                <td class="center" colspan="3" style="letter-spacing:20px;">单位名称</td>
                                <td colspan="4">{$info['name']|escape}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="3" style="letter-spacing:20px;">主送部门</td>
                                <td colspan="4" style="letter-spacing:20px;">市国土资源局</td>
                            </tr>
                            <tr class="title_col">
                                <td colspan="3">
                                    <span style="float:right">分村土地面积</span>
                                    <br/>
                                    <span>土地分类</span>
                                </td>
                                <td><input type="text" class="viliage noborder" name="v1" value=""/></td>
                                <td><input type="text" class="viliage noborder" name="v2" value=""/></td>
                                <td><input type="text" class="viliage noborder" name="v3" value=""/></td>
                                <td class="center" style="letter-spacing:20px;">小计</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="center dl_1">
                                <td style="width: 40px;" rowspan="6"><div>农</div><div>用</div><div>地</div></td>
                                <td style="width: 60px;" rowspan="2">
                                    <span class="dlname">耕地</span>
                                </td>
                                <td style="width:80px;" class="dlcode2"></td>
                                <td style="width:100px;" class="area"></td>
                                <td style="width:100px;" class="area"></td>
                                <td style="width:100px;" class="area"></td>
                                <td style="width:100px;" class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">园地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">林地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">牧草地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center dl_1">
                                <td><span class="dlname">其他农用地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>

                            <tr class="center dl_2">
                                <td rowspan="5"><div>建</div><div>设</div><div>用</div><div>地</div></td>
                                <td rowspan="2"><span class="dlname">住宅用地</span</td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td><span class="dlname">交通用地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td><span class="dlname">机关团体</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td><span class="dlname">工矿仓储用地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td><div>未利</div><div>用地</div></td>
                                <td><span class="dlname">其他用地</span></td>
                                <td class="dlcode2"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="area"></td>
                                <td class="sub_sum"></td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td class="center" colspan="3">小计</td>
                                <td class="col_sub_sum"></td>
                                <td class="col_sub_sum"></td>
                                <td class="col_sub_sum"></td>
                                <td class="col_sub_sum"></td>
                            </tr>
                            <tr class="center">
                                <td colspan="3">收回国有土地</td>
                                <td colspan="4">{$info['area_shgy']}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="3">合计</td>
                                <td colspan="4" class="total_sum"></td>
                            </tr>
                            <tr class="center">
                                <td rowspan="2">其中</td>
                                <td colspan="2">出让面积</td>
                                <td colspan="4">{$info['area_sell']}</td>
                            </tr>
                            <tr class="center">
                                <td colspan="2">允许使用</td>
                                <td colspan="4">{$info['area_allow']}</td>
                            </tr>
                            <tr style="height:60px;" class="center">
                                <td colspan="3">备注</td>
                                <td style="text-align:left;" colspan="4">
                                    <input type="text" class="noborder" style="width:100%;height:60px;" value="{$info['descripton']|escape}"/>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    <div style="position:relative;padding:10px 30px;">
                        <p>测量者: {$info['pm']}</p>
                        <p>填写者: {$info['worker']}</p>
                        <p>审核者: {$info['cs_name']}</p>
                        
                        <div class="center" style="position:absolute;right:10px;top:20px;">
                            <p>慈溪市土地勘测规划设计院有限公司</p>
                            <p>{$dateInfo['year']}年{$dateInfo['month']}月{$dateInfo['day']}日</p>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script>
            $(function(){
                $(".noborder").bind("mouseenter",function(e){
                    $(e.target).addClass("stathover");
                });
                
                $(".noborder").bind("mouseleave",function(e){
                    $(e.target).removeClass("stathover");
                });
                
                $(".dlname").bind("click",function(e){
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
                
            });
        
        </script>
    </body>
</html>