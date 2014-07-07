{include file="common/main_header.tpl"}
    {if $action == 'edit'}
    {include file="project_gh/mod_list.tpl"}
    {/if}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('project_gh','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('project_gh','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>录入类型</strong></label></td>
                            <td>
                                {if $action == 'add'}
                                <label><input type="radio" name="input_type"  value="0" {if $inputType == 0}checked{/if}>正常登记</label>&nbsp;&nbsp;
                                <label><input type="radio" name="input_type"  value="1" {if $inputType == 1}checked{/if}>意向登记</label>
                                <span class="tip">{form_error('input_type')}</span>
                                {else}
                                    {if $info['input_type'] == 0}正常登记{elseif $info['input_type'] == 1}意向登记{/if}
                                {/if}
                            </td>
                        </tr>
                        <tr class="bulu">
                            <td><label class="required"><em>*</em><strong>登记年份</strong></label></td>
                            <td>
                                <select name="year" id="addyear" style="width:300px" >
                                    {foreach from=$yearList item=item}
                                        <option value="{$item}" {if $info['year'] == $item || $smarty.get.year == $item}selected{/if}>{$item}年</option>
                                    {/foreach}
                                </select>
                                <span class="tip">{form_error('year')}</span>
                            </td>
                        </tr>
                        <tr class="bulu">
                            <td><label class="required"><em>*</em><strong>登记月份</strong></label></td>
                            <td>
                                <select name="month" style="width:300px" >
                                    {foreach from=$monthList item=item}
                                        <option value="{$item}" {if $info['month'] == $item || $month == $item}selected{/if}>{if $item < 10}0{/if}{$item}月份</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>区域</strong></label></td>
                            <td>
                                <select name="region_name" style="width:300px">
                                    {foreach from=$regionList item=item}
                                    <option value="{$item['name']}" {if $info['region_name'] == $item['name']}selected{/if}>{$item['name']}</option>
                                    {/foreach}
                                </select>
                                {form_error('region_code')}
                            </td>
                        </tr>
                        
                        <tr>
                            <td><label class="required"><em>*</em><strong>登记类型</strong></label></td>
                            <td>
                                <select name="type_id" style="width:300px">
                                    {foreach from=$projectTypeList item=item}
                                    <option value="{$item['id']}" {if $info['type_id'] == $item['id']}selected{/if}>{$item['name']}</option>
                                    {/foreach}
                                </select>
                                {form_error('type')}
                            </td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>登记名称</strong></label></td><td><input type="text" style="width:600px" name="name" value="{$info['name']}" placeholder="请输入登记名称"/><span class="tip">{form_error('name')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>地址</strong></label></td><td><input type="text" style="width:600px" name="address" value="{$info['address']}" placeholder="请输入地址"/><span class="tip">{form_error('address')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>村名</strong></label></td><td><input type="text" style="width:300px" name="village" value="{$info['village']}" placeholder="请输入村名"/><span class="tip">{form_error('village')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>项目来源</strong></label></td><td><input type="text" style="width:300px" name="source" value="{$info['source']}" placeholder="请输入项目来源"/><span class="tip">{form_error('source')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>要求完成时间</strong></label></td><td><input type="text" name="end_date" class="Wdate" readonly onclick="WdatePicker()" value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}" /><span class="tip">{form_error('end_date')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>联系人名称</strong></label></td><td><input type="text" style="width:300px" name="contacter" id="contacter" value="{$info['contacter']}" placeholder="请输入联系人名称"/><span class="tip">{form_error('contacter')} 输入名称将自动从通讯录匹配</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>联系人号码</strong></label></td><td><input type="text" style="width:300px" name="contacter_mobile" value="{$info['contacter_mobile']}" placeholder="请输入联系人号码"/><span class="tip">{form_error('contacter_mobile')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>联系人固定电话</strong></label></td><td><input type="text" style="width:300px" name="contacter_tel" value="{$info['contacter_tel']}" placeholder="请输入联系人固定电话"/><span class="tip">{form_error('contacter_tel')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>联系单位</strong></label></td><td><input type="text" style="width:600px" name="union_name" value="{$info['union_name']}" placeholder="请输入联系单位名称"/><span class="tip">{form_error('union_name')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>接洽人名称</strong></label></td><td><input type="text" style="width:300px" name="manager" id="manager" value="{$info['manager']}" placeholder="请输入接洽人名称"/><span class="tip">{form_error('manager')} 输入名称将自动从通讯录匹配</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>接洽人号码</strong></label></td><td><input type="text" style="width:300px" name="manager_mobile" value="{$info['manager_mobile']}" placeholder="请输入接洽人号码"/><span class="tip">{form_error('manager_mobile')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>接洽人固定电话</strong></label></td><td><input type="text" style="width:300px" name="manager_tel" value="{$info['manager_tel']}" placeholder="请输入接洽人固定电话"/><span class="tip">{form_error('manager_tel')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>备注</strong></label></td><td><textarea name="descripton" style="width:300px;height:150px;"  placeholder="请输入备注">{$info['descripton']}</textarea><br/><span class="tip">{form_error('descripton')}</span></td>
                        </tr>
                        {*
                        {if $action == 'edit'}
                        <tr>
                            <td>退回原因</td>
                            <td><span class="notice">{$info['reason']|escape}</span></td>
                        </tr>
                        {/if}
                        *}
                        <tr>
                            <td><label class="optional"><em></em><strong>优先级</strong></label></td><td>
                                <input type="text" name="displayorder" value="{$info['displayorder']}" placeholder="优先级"/>
                                <span class="tip">{form_error('displayorder')} 默认空表示普通优先级 数字越大优先级越高 范围(0-9)</span></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                                <input type="reset" name="rst" class="btn btn-sm btn-default" value="重置"/>
                                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                            </td>
                        </tr>
                        </tbody>
                     </table>
                </form>
                <script>
                    $(function(){
                        $("#addyear").bind('change',function(e){
                            $("select[name=region_code]").html('');
                            $.ajax({
                                type:"GET",
                                url:'{url_path("search","getRegionList")}',
                                data:{ year: $("select[name=year]").val() },
                                dataType: "json",
                                success:function(data){
                                    if(data.length){
                                        for(var i = 0; i < data.length; i++){
                                            $("select[name=region_code]").append('<option value="' + data[i]['code'] + '">' + data[i]['name'] + '</option>');
                                        }
                                    }else{
                                        $.jBox.alert('该年度区域数据缺失，请联系管理员添加', '提示');
                                    }
                                },
                                erro:function(xhr, textStatus, errorThrown){
                                    //$.jBox.error(content, title, options);
                                    $.jBox.alert('获取年度镇街数据失败', '提示');
                                }
                            });
                        });
                        
                        $("#contacter").autocomplete({
                            source: "{url_path('search','getContactsList')}",
                            minLength: 1,
                            width: 220,
                            focus: function(event, ui) {
                                $("#contacter").val(ui.item.label );
                            },
                            select: function( event, ui ) {
                                $("input[name=union_name]").val(ui.item.c);
                                
                                if(ui.item.v){
                                    $( "input[name=contacter_mobile]" ).val( ui.item.v );
                                }else{
                                    $( "input[name=contacter_mobile]" ).val( ui.item.m );
                                }
                                
                                $( "input[name=contacter_tel]" ).val( ui.item.t );
                            }
                        })
                        .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
                            return $( "<li>" )
                            .append( "<a>" + item.label + "@" + item.c + "</a>" )
                            .appendTo( ul );
                        };
                        
                        
                        $("#manager").autocomplete({
                            source: "{url_path('search','getContactsList')}",
                            minLength: 1,
                            width: 220,
                            focus: function(event, ui) {
                                $("#manager").val( ui.item.label );
                            },
                            select: function( event, ui ) {
                                $( "#manager" ).val( ui.item.v );
                            
                                if(ui.item.v){
                                    $( "input[name=manager_mobile]" ).val( ui.item.v );
                                }else{
                                    $( "input[name=manager_mobile]" ).val( ui.item.m );
                                }
                                
                                $( "input[name=manager_tel]" ).val( ui.item.t );
                            }
                        })
                        .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
                            return $( "<li>" )
                            .append( "<a>" + item.label + "@" + item.c + "</a>" )
                            .appendTo( ul );
                        };
                        
                    {if $feedback == 'success' && $action != 'edit'}
                        alert('{$feedMessage}');
                        location.href = "{url_path('project_gh','index')}";
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}