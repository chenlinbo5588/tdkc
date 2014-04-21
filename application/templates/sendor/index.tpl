{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('sendor')}" method="get" name="searchform">
                    <input type="hidden" value="sendor" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>发送人名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('sendor','add')}">添加发送人</a>
                        </li>
                     </ul>
                </form>
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>名称</th>
                            <th>是否默认发送人</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['name']|escape}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               <a href="{url_path('contacts','edit','id=')}{$item['id']}">编辑</a>
                               <a href="javascript:void(0);" data-title="{$item['name']}" data-href="{url_path('sendor','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="4">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
             </div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}