{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('work_log')}" method="get" name="searchform">
                    <input type="hidden" value="work_log" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <label><strong>是否包含已删除</strong>
                                <select name="inc_del" >
                                    <option value="否" {if $smarty.get.inc_del == '否'}selected{/if}>否</option>
                                    <option value="是" {if $smarty.get.inc_del == '是'}selected{/if}>是</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('work_log','add')}">添加工作日志</a>
                        </li>
                     </ul>
                </form>
                
               
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>标题</th>
                            <th>内容</th>
                            <th>状态</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                            <th>最后修改人</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['id']}</td>
                           <td>{$item['title']}</td>
                           <td>{$item['content']|escape}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               <a href="{url_path('work_log','edit','id=')}{$item['id']}">编辑</a>
                               <a href="javascript:void(0);" data-title="{$item['title']}" data-href="{url_path('work_log','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="9">没有工作日志</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}