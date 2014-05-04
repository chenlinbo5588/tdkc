<div class="pd20 doc doc_zdmj">
    <h1>土地面积分类表</h1>
    <div>面积单位：平方米</div>
    <form name="mj" method="post" action="{url_path('project_ch','mj')}">
    <table class="border1">
        <thead>
            <tr>
                <td colspan="3">编号</td>
                <td colspan="4">NO( {$info['project_no']} ) 字 ( {$info['region_name']|cutText:1:''}) 性质: {$info['type']}</td>
            </tr>
            <tr>
                <td colspan="3">单位名称</td>
                <td colspan="4">{$info['name']|escape}</td>
            </tr>
            <tr>
                <td colspan="3">主送部门</td>
                <td colspan="4">市国土资源局</td>
            </tr>
       </thead>
       <tbody>
            <tr class="title_col">
                <td colspan="3">
                    <span style="float:right">分村土地面积</span>
                    <br/>
                    <span>土地分类</span>
                </td>
                <td><input type="text" name="v1" placeholder="请填写村名" value=""/></td>
                <td><input type="text" name="v2" placeholder="请填写村名" value=""/></td>
                <td><input type="text" name="v3" placeholder="请填写村名" value=""/></td>
                <td>小计</td>
            </tr>
            <tr>
                <td rowspan="6">农<br/>用<br/>地</td>
                <td rowspan="2" style="width:70px;">耕地</td>
                <td style="width:65px;">
                    <select name="dl">
                        <option value="农用地,水田">水田</option>
                        <option value="农用地,旱地">旱地</option>
                        <option value="农用地,水浇地">水浇地</option>
                    </select>
                </td>
                <td><input type="text" class="txt" name="area_1_v1" value="0"/></td>
                <td><input type="text" class="txt" name="area_1_v2" value="0"/></td>
                <td><input type="text" class="txt" name="area_1_v3" value="0"/></td>
                <td><input type="text" class="txt" name="area_1_sum" value="0"/></td>
            </tr>
            <tr>
                <td>
                    <select name="dl">
                        <option value="农用地,水田">水田</option>
                        <option value="农用地,旱地">旱地</option>
                        <option value="农用地,水浇地">水浇地</option>
                    </select>
                </td>
                <td><input type="text" class="txt" name="area_2_v1" value="0"/></td>
                <td><input type="text" class="txt" name="area_2_v2" value="0"/></td>
                <td><input type="text" class="txt" name="area_2_v3" value="0"/></td>
                <td><input type="text" class="txt" name="area_2_sum" value="0"/></td>
            </tr>
            <tr>
                <td>园地</td>
                <td>
                    <select name="dl">
                        <option value="园地,果园">果园</option>
                        <option value="园地,茶园">茶园</option>
                        <option value="园地,其他园地">其他园地</option>
                    </select>
                </td>
                <td><input type="text" class="txt" name="area_3_v1" value="0"/></td>
                <td><input type="text" class="txt" name="area_3_v2" value="0"/></td>
                <td><input type="text" class="txt" name="area_3_v3" value="0"/></td>
                <td><input type="text" class="txt" name="area_3_sum" value="0"/></td>
            </tr>
            <tr>
                <td>林地</td>
                <td>
                    
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td rowspan="2">其他农用地</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            
            
             <tr>
                <td rowspan="5">建<br/>设<br/>用<br/>地</td>
                <td rowspan="2">住宅用地</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>公共建筑<br/>用地</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>商业用地</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>工矿用地</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            
            
            <tr>
                <td>未利<br/>用地</td>
                <td>水域及水<br/>利设施<br/>用地</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
        <tfoot>
        
        </tfoot>
   </table>
   </form>
</div>
