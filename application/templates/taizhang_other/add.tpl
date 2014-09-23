{include file="common/main_header.tpl"}
            <div class="row-fluid taizhang_detail">
                {include file="{$tplDir}/side.tpl"}
                
                <div class="mainarea">
                    {if $info['id']}
                    <form action="{url_path($tplDir,'edit')}" method="post" name="infoform">
                        <input type="hidden" name="id" value="{$info['id']}"/>
                    {else}
                    <form action="{url_path($tplDir,'add')}" method="post" name="infoform">
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
                                            <option value="">请选择用途</option>
                                            <option value="山塘" {if $info['nature'] == '山塘'}selected{/if}>山塘</option>
                                            <option value="土方" {if $info['nature'] == '土方'}selected{/if}>土方</option>
                                            <option value="地形" {if $info['nature'] == '地形'}selected{/if}>地形</option>
                                            <option value="评估" {if $info['nature'] == '评估'}selected{/if}>评估</option>
                                            <option value="控制" {if $info['nature'] == '控制'}selected{/if}>控制</option>
                                        </select>
                                        {form_error('nature')}
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>单位名称</strong></label></td><td><input type="text" style="width:300px" name="name" value="{$info['name']}" placeholder="请输入项目名称"/><span class="tip">{form_error('name')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>土地坐落</strong></label></td><td><input type="text" style="width:300px" name="address" value="{$info['address']}" placeholder="请输入土地坐落"/><span class="tip">{form_error('address')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>作业负责人</strong></label></td><td><input type="text" style="width:300px" name="pm" value="{$info['pm']|escape}" placeholder="请输入作业负责人"/><span class="tip">{form_error('pm')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="optional"><em></em><strong>备注</strong></label></td><td><textarea name="descripton" style="width:300px;height:150px;"  placeholder="请输入备注">{$info['descripton']}</textarea><br/><span class="tip">{form_error('descripton')}</span></td>
                                </tr>
                                {if $info['id']}
                                <tr>
                                    <td><label class="optional"><em></em><strong>当前状态</strong></label></td>
                                    <td>{$info['status']}</td>
                                </tr>
                                <tr>
                                    <td><label class="optional"><em></em><strong>当前经办人</strong></label></td>
                                    <td>{$info['sendor']}</td>
                                </tr>
                                {/if}
                                <tr>
                                    <td><strong>图件文档</strong></td>
                                    <td>
                                        {include file="taizhang/file_list.tpl"}
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="submit" name="submit" class="btn btn-sm btn-orange" value="{$saveText}保存"/>
                                        <input type="reset" name="rst" class="btn btn-sm btn-gray" value="重置"/>
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
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}