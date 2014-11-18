{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('reports_monthly','index')}" method="post" name="searchform" target="post_iframe">
                    <input type="hidden" value="reports_monthly" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    
                    <table class="normal">
                        <tr>
                            <td colspan="2">
                                <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({ maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.post.sdate}"/>{form_error('sdate')}</label>
                                <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({ minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.post.edate}"/>{form_error('edate')}</label>
                                <input type="submit" name="submit" class="btn btn-primary" value="导出Excel"/>
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>台账类型</strong></label></td>
                            <td>
                                {foreach from=$projectTypeList key=key item=item}
                                    <label><input type="checkbox" name="category[]" value="{$item}" checked="checked"/>{$item}</label>&nbsp;
                                {/foreach}
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>状态</strong></label></td>
                            <td>
                                <label><input type="checkbox" name="status[]" value="新增"/>新增</label>
                                <label><input type="checkbox" name="status[]" value="已提交初审"/>已提交初审</label>
                                <label><input type="checkbox" name="status[]" value="已通过初审"/>已通过初审</label>
                                <label><input type="checkbox" name="status[]" value="已提交复审"/>已提交复审</label>
                                <label><input type="checkbox" name="status[]" value="已通过复审" checked/>已通过复审</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>负责人名称</strong></label></td>
                            <td>
                                <input type="text" name="pm" value="{$smarty.post.pm}" placeholder="请输入项目负责人"/><span class="tip">如果有多个名称请用英文逗号,隔开</span>
                            </td>
                        </tr>
                        
                        <tr>
                            <td><label><strong>镇乡名称(<span class="notice">按住Ctrl点击多选</span>)</strong></label></td>
                            <td>
                                <select name="region_name[]" multiple="" size="{count($regionList)}">
                                    {foreach from=$regionList item=item}
                                    <option value="{$item['name']}" {if $info['region_name'] == $item['name']}selected{/if}>{$item['name']}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                     </table>
                </form>
            </div>
                            
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>             
            <div class="span12">
                
             </div>
             <script>
                 $(function(){
                    $("form[name=searchform]").bind("submit",function(e){
                        if($("#sdate").val() == ''){
                            $.jBox.tip("请输入登记日期开始","提示");
                            $("#sdate").focus();
                            return false;
                        }
                        
                        if($("#edate").val() == ''){
                            $.jBox.tip("请输入登记日期结束","提示");
                            $("#edate").focus();
                            return false;
                        }
                    });
                 });
              </script>    
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}