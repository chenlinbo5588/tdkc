{include file="common/main_header.tpl"}
            <div class="row-fluid taizhang_detail">
                {include file="{$tplDir}/side.tpl"}
                <style type="text/css">
                    .wucha_dt .ft  {
                        display:block;
                        float:left;
                        width:100px;
                        
                    }
                    
                    .wucha_dt li {
                        padding:3px 0;
                    }
                    
                </style>
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
                                <col width="550"/>
                            </colgroup>
                            <tbody>
                                {if $info['id']}
                                <tr>
                                    <td><strong>编号</strong></td>
                                    <td>{$info['project_no']}</td>
                                </tr>
                                {/if}
                                 <tr>
                                    <td><label class="required"><em>*</em><strong>项目名称</strong></label></td><td><input type="text" style="width:300px" name="name" value="{$info['name']}" placeholder="请输入名称"/><span class="tip">{form_error('name')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>项目类型</strong></label></td>
                                    <td>
                                        {foreach from=$projectTypeList item=item}
                                        <label><input type="checkbox" name="type[]" value="{$item}" {if is_array($info['type']) && in_array($item,$info['type'])}checked{/if}/>{$item}</label>
                                        {/foreach}
                                        {form_error('type[]')}
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>检查方法</strong></label></td>
                                    <td>
                                        {foreach from=$checkMethod item=item}
                                        <label><input type="checkbox" name="method[]" value="{$item}" {if is_array($info['method']) && in_array($item,$info['method'])}checked{/if}/>{$item}</label>
                                        {/foreach}
                                        {form_error('method[]')}
                                    </td>
                                </tr>
                                {foreach from=$jdList key=key item=item}
                                <tr>
                                    <td><label class="required"><em>*</em><strong>{$item['title']}</strong></label></td>
                                    <td>
                                        <div>
                                           <ul class="wucha_dt">
                                               <li class="clearfix"><label><span class="ft">精度（限差）</span><input type="text" name="{$item[0]}" value="{$info[$item[0]]}" placeholder="{$item['title']}精度（限差）"/>cm &nbsp;{form_error($item[0])}</label></li>
                                               <li class="clearfix"><label><span class="ft">实测点数</span><input type="text" name="{$item[1]}" value="{$info[$item[1]]}" placeholder="{$item['title']}实测点数"/>个{form_error($item[1])}</label></li>
                                               <li class="clearfix"><label><span class="ft">实测误差均值：</span><input type="text" name="{$item[2]}" value="{$info[$item[2]]}" placeholder="{$item['title']}实测误差均值"/>cm {form_error($item[2])}</label></li>
                                               <li class="clearfix"><label><span class="ft">实测超限点个数：</span><input type="text" name="{$item[3]}" value="{$info[$item[3]]}" placeholder="{$item['title']}实测超限点个数"/>个 {form_error($item[3])}</label></li>
                                           </ul>
                                        </div>
                                    </td>
                                </tr>
                                {/foreach}
                                <tr>
                                    <td><label class="required"><em>*</em><strong>检查者</strong></label></td>
                                    <td>
                                        <input type="text" name="checkor" value="{if $info['checkor']}{$info['checkor']|escape}{else}{$userProfile['name']}{/if}" placeholder="请输入检查者名称"/><span class="tip">{form_error('checkor')}</span>
                                        {form_error('checkor')}
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>精度评定</strong></label></td>
                                    <td>
                                        {foreach from=$evaluate item=item}
                                        <label><input type="radio" name="evaluate" value="{$item}" {if $info['evaluate'] == $item}checked{/if}>{$item}</label>
                                        {/foreach}
                                        {form_error('evaluate')}
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>作业负责人</strong></label></td><td><input type="text" name="pm" value="{$info['pm']|escape}" placeholder="请输入作业负责人"/><span class="tip">{form_error('pm')}</span></td>
                                </tr>
                                <tr>
                                    <td><label class="required"><em>*</em><strong>检查评语</strong></label></td><td><textarea name="remark" style="width:300px;height:150px;"  placeholder="请输入检查评语">{$info['remark']}</textarea><br/><span class="tip">{form_error('remark')}</span></td>
                                </tr>
                                {if $info['id']}
                                <tr>
                                    <td><label><em></em><strong>当前经办人</strong></label></td>
                                    <td>{$info['sendor']|escape}</td>
                                </tr>
                                {/if}
                                {include file="./fault_list.tpl"}
                                {include file="./fault_standard.tpl"}
                                <tr>
                                    <td><strong>图件文档</strong></td>
                                    <td>
                                        {include file="taizhang/file_list.tpl"}
                                    </td>
                                </tr>
                                <tr>
                                    <td>发送给</td>
                                    <td>{include file="project_ch/sendorlist.tpl"}</td>
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
                <script>
                    $(function(){
                        $("#filelist").delegate("a.df","click",function(e){
                            if(confirm("确定要删除吗")){
                                $(this).closest("li").remove();
                            }
                        });
                        
                        $("#fault_cate").bind("click",function(e){
                            var that = $(e.target);
                            var selVal = that.val();

                            switch(selVal){
                                case "":
                                    $(".fault_list .fault_cate").show();
                                    break;
                                default:
                                    $(".fault_list .fault_cate").hide();
                                    $(".fault_list .fault_cate_" + selVal).show();
                                    break;
                            };
                        });
                        
                        $("input[name=submit]").bind('click',function(e){
                            var cansubmit = true;
                            $("#faultList input[type=checkbox]").each(function(index){
                                var that = $(this);
                                if(that.prop("checked") && $.trim(that.closest("tr").find("input[type=text]:eq(0)").val()) == ''){
                                    that.closest("tr").find("input[type=text]:eq(0)").addClass("input_error").focus();
                                    $.jBox.tip("请填写扣分项目备注",'提示');

                                    cansubmit = false;
                                    return false;
                                }
                            });
                            
                            if(cansubmit && $("input[name=sendor]:checked").length == 0){
                                $.jBox.tip("请选择发送人",'提示');
                                cansubmit = false;
                            }
                            
                            if(!cansubmit){
                                e.preventDefault();
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