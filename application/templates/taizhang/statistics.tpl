{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('taizhang')}" method="get" name="searchform">
                    <input type="hidden" value="taizhang" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="statistics" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>镇乡名称</strong><input type="text" name="region_name" value="{$smarty.get.region_name}" placeholder="请输入镇乡名称"/></label>
                            <label><strong>负责人名称</strong><input type="text" name="pm" value="{$smarty.get.pm}" placeholder="请输入项目负责人"/></label>
                            <label><strong>项目类型</strong>
                                <select name="category" >
                                    <option value="">全部</option>
                                    {foreach from=$projectTypeList key=key item=item}
                                    <option value="{$key}" {if $smarty.get.category == $key}selected{/if}>{$item}</option>
                                    {/foreach}
                                </select>
                            </label>
                            
                            <input type="submit" name="submit" class="btn btn-primary" value="统计"/>
                        </li>
                        
                     </ul>
                </form>
            </div>
            <div class="span12">
                {if $data['data']}
                <table class="table">
                    <thead>
                        <tr>
                            <th>登记年-月</th>
                            <th>镇街名称</th>
                            <th>负责人</th>
                            <th>台账类型</th>
                            <th>用途</th>
                            <th>数量</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['year']}年-{$item['month']}月</td>
                           <td>{$item['region_name']}</td>
                           <td>{$item['pm']}</td>
                           <td>{$item['category']}</td>
                           <td>{$item['nature']}</td>
                           <td>{$item['cnt']}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {else}
                    <p>无数据</p>
                {/if}
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