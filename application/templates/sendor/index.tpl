{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
            <a class="addlink" href="{url_path('sendor','add')}">设置发送人</a>
            {*
                <form action="{url_path('sendor')}" method="get" name="searchform">
                    <input type="hidden" value="sendor" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>发送人名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            
                        </li>
                     </ul>
                </form>
                *}
            </div>
            
            
            <div class="span12">
                
                <table class="table wauto">
                    <colgroup>
                        <col width="100"/>
                        {*<col width="100"/>*}
                        <col width="150"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>名称</th>
                            {*<th>是否默认发送人</th>*}
                            <th>创建时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['sendor']|escape}</td>
                           {*<td>{if $item['isdefault'] == 1}是{else}否{/if}</td>*}
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="2">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
             </div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}