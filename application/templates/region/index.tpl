{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('region')}" method="get" name="searchform">
                    <input type="hidden" value="region" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <label><strong>年份</strong>
                                <select name="year"  >
                                    <option value="" {if $smarty.get.year == ''}selected{/if}>全部</option>
                                    {foreach from=$yearList item=item}
                                        <option value="{$item}" {if $smarty.get.year == $item}selected{/if}>{$item}</option>
                                    {/foreach}
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="region+add"}<a class="addlink" href="{url_path('region','add')}">添加镇街</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>排序</th>
                            <th>名称</th>
                            <th>代码</th>
                            <th>编码年份</th>
                            <th>创建时间</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['displayorder']}</td>
                           <td>{$item['code']|escape}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['year']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="region+edit"}<a href="{url_path('region','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="region+delete"}<a href="javascript:void(0);" data-title="{$item['name']|escape}" data-href="{url_path('region','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="7">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}