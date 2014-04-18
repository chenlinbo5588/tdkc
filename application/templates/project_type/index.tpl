{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('project_type')}" method="get" name="searchform">
                    <input type="hidden" value="project_type" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <label><strong>类型</strong>
                                <select name="type" >
                                    <option value="" {if $smarty.get.type == ''}selected{/if}>全部</option>
                                    <option value="测绘项目" {if $smarty.get.type === '测绘项目'}selected{/if}>测绘项目</option>
                                    <option value="规划项目" {if $smarty.get.type == '规划项目'}selected{/if}>规划项目</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('project_type','add')}">添加项目类型</a>
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
                            <th>类型</th>
                            <th>创建时间</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['displayorder']}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['type']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               <a href="{url_path('project_type','edit','id=')}{$item['id']}">编辑</a>
                               <a href="javascript:void(0);" data-title="{$item['name']|escape}" data-href="{url_path('project_type','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="6">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}