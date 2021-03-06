{include file="common/main_header.tpl"}
            <div class="row-fluid taizhang_detail clearfix">
                {include file="{$tplDir}/side.tpl"}
                
                <div class="mainarea">
                    {if $info['id']}
                    <form action="{url_path($tplDir,'edit')}" method="post" name="infoform">
                        <input type="hidden" name="id" value="{$info['id']}"/>
                    {else}
                    <form action="{url_path($tplDir,'add')}" method="post" name="infoform">
                        {include file="taizhang/hidden_var.tpl"}
                    {/if}
                        <table class="maintain">
                            <colgroup>
                                <col width="100"/>
                                <col width="500"/>
                            </colgroup>
                            <tbody>
                                {if $info['id']}
                                <tr>
                                    <td><strong>编号</strong></td>
                                    <td>{$info['project_no']}</td>
                                </tr>
                                {/if}
                                <tr>
                                    <td><label class="required"><em>*</em><strong>区域</strong></label></td>
                                    <td>
                                        <select name="region_name" style="width:300px">
                                            {foreach from=$regionList item=item}
                                            <option value="{$item['name']}" {if $info['region_name'] == $item['name']}selected{/if}>{$item['name']}</option>
                                            {/foreach}
                                        </select>
                                        {form_error('region_name')}
                                    </td>
                                </tr>

                                <tr>
                                    <td><label class="required"><em>*</em><strong>类型</strong></label></td>
                                    <td>
                                        <select name="type_id" style="width:300px">
                                            {foreach from=$projectTypeList item=item}
                                            <option value="{$item['id']}" {if $smarty.post.type_id == $item['id'] || $info['ptype_id'] == $item['id']}selected{/if}>{$item['type']}-{$item['name']}</option>
                                            {/foreach}
                                        </select>
                                        {form_error('type_id')}
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>用途</strong></label></td>
                                    <td>
                                        <select name="nature" style="width:300px">
                                            {foreach from=$natureList item=item}
                                            <option value="{$item['name']}" {if $info['nature'] == $item['name']}selected{/if}>{$item['name']}</option>
                                            {/foreach}
                                        </select>
                                        {form_error('nature')}
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>单位名称</strong></label></td><td><input type="text" style="width:300px" name="name" value="{$info['name']}" placeholder="请输入单位名称"/><span class="tip">{form_error('name')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>土地坐落</strong></label></td><td><input type="text" style="width:300px" name="address" value="{$info['address']}" placeholder="请输入土地坐落"/><span class="tip">{form_error('address')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>总面积</strong></label></td><td><input type="text" style="width:300px" name="total_area" value="{$info['total_area']}" placeholder="请输入总面积"/><span class="tip">M<sup>2</sup>{form_error('total_area')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>作业负责人</strong></label></td><td><input type="text" style="width:300px" name="pm" value="{$info['pm']|escape}" placeholder="请输入作业负责人"/><span class="tip">{form_error('pm')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="optional"><em></em><strong>联系人名称</strong></label></td><td><input type="text" style="width:300px" name="contacter" id="contacter" value="{$info['contacter']}" placeholder="请输入联系人名称"/><span class="tip">{form_error('contacter')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="optional"><em></em><strong>联系人号码</strong></label></td><td><input type="text" style="width:300px" name="contacter_mobile" value="{$info['contacter_mobile']}" placeholder="请输入联系人号码"/><span class="tip">{form_error('contacter_mobile')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="optional"><em></em><strong>备注</strong></label></td><td><textarea name="descripton" style="width:300px;height:150px;"  placeholder="请输入备注">{$info['descripton']}</textarea><br/><span class="tip">{form_error('descripton')}</span></td>
                                </tr>
                                {include file="taizhang/basic_info.tpl"}
                                <tr>
                                    <td><strong>图件文档</strong></td>
                                    <td>
                                        {include file="taizhang/file_list.tpl"}
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        {if $info['status'] == '' || $info['status'] == '新增' || $userProfile['id'] == 1}
                                        <input type="submit" name="submit" class="btn btn-sm btn-orange" value="{$saveText}保存"/>
                                        <input type="reset" name="rst" class="btn btn-sm btn-gray" value="重置"/>
                                        {/if}
                                        {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                {include file="taizhang/upload_file.tpl"}
                {include file="taizhang/dup_tip.tpl"}
                <script>
                    $(function(){
                        $("#filelist").delegate("a.df","click",function(e){
                            if(confirm("确定要删除吗")){
                                $(this).closest("li").remove();
                            }
                        });
                        
                    {if $message}
                        $.jBox.alert('{$message}', '提示');
                    {/if}
                     
                    {if $action == 'add' && $feed == 'success'}
                        setTimeout(function(){
                            location.href = "{url_path($tplDir,'edit','id=')}{$info['id']}";
                        },2000);
                     {/if}
                    
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}