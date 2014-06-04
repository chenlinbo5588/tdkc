{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('project_gh_type')}" method="get" name="searchform">
                    <input type="hidden" value="project_gh_type" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <label><strong>类型</strong>
                                <select name="type" >
                                    <option value="" {if $smarty.get.type == ''}selected{/if}>全部</option>
                                    <option value="市内项目" {if $smarty.get.type === '市内项目'}selected{/if}>市内项目</option>
                                    <option value="市外项目" {if $smarty.get.type == '市外项目'}selected{/if}>市外项目</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="project_gh_type+add"}<a class="addlink" href="{url_path('project_gh_type','add')}">添加规划项目类型</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>排序</th>
                            <th>类型</th>
                            <th>名称</th>
                            <th>创建时间</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['displayorder']}</td>
                           <td>{$item['type']|escape}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="project_gh_type+edit"}<a href="{url_path('project_gh_type','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="project_gh_type+delete"}<a href="javascript:void(0);" data-title="{$item['name']|escape}" data-href="{url_path('project_gh_type','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}
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

{include file="common/main_footer.tpl"}