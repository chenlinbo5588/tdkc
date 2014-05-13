{include file="common/main_header.tpl"}
        <div class="searchform row-fluid">
                <form action="{url_path('notice')}" method="get" name="searchform">
                    <input type="hidden" value="notice" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('notice','add')}">添加滚动公告</a>
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                {if $data['data']}
                <table class="table">
                    <colgroup>
                        <col style="width:300px;"/>
                        <col style="width:80px;"/>
                        <col style="width:100px;"/>
                        <col style="width:200px;"/>
                        <col style="width:200px;"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>标题</th>
                            <th>状态</th>
                            <th>创建人</th>
                            <th>创建日期</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td><a href="javascript:void(0);" class="item_detail" data-href="{url_path('notice','detail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               <a href="{url_path('notice','edit','id=')}{$item['id']}">编辑</a>
                               <a href="javascript:void(0);" class="delete" data-title="{$item['title']|escape}" data-id="{$item['id']}" data-href="{url_path('notice','delete','id=')}{$item['id']}" data-href="">删除</a>
                           </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
                {else}
                    <p>无记录</p>
                {/if}
             </div>
             <script>
                $(function(){
                    {if $message}
                        $.jBox.tip('{$message}');
                    {/if}
                });
                 
             </script>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}