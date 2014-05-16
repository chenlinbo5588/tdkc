{include file="common/main_header.tpl"}
        <div class="filebar" >
            {auth name="inout+receive"}<a href="{url_path('inout','receive')}" class="btn {if $action == 'receive'}active{/if}">收文管理</a>{/auth}
            {auth name="inout+send"}<a href="{url_path('inout','send')}" class="btn {if $action == 'send'}active{/if}">发文管理</a>{/auth}
        </div>
        
        <div class="searchform row-fluid">
                <form action="{url_path('inout')}" method="get" name="searchform">
                    <input type="hidden" value="inout" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="send" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="inout+addout"}<a class="addlink" href="{url_path('inout','addout')}">添加发文</a>{/auth} 
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                {*
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                </div>
                *}
                {if $data['data']}
                <table class="table">
                    <colgroup>
                        <col style="width:300px;"/>
                        <col style="width:80px;"/>
                        <col style="width:100px;"/>
                        <col style="width:100px;"/>
                        <col style="width:60px;"/>
                        <col style="width:100px;"/>
                        <col style="width:60px;"/>
                        <col style="width:100px;"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>标题</th>
                            <th>文件文号</th>
                            <th>发送时间</th>
                            <th>创建时间</th>
                            <th>创建人</th>
                            <th>最后修改时间</th>
                            <th>最后修改人</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['title']|escape}</td>
                           <td>{$item['file_code']|escape}</td>
                           <td>{$item['send_time']|date_format:"Y-m-d"}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>
                               {auth name="inout+editout"}<a href="{url_path('inout','editout','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="inout+deleteout"}<a href="javascript:void(0);" class="delete" data-href="{url_path('inout','deleteout')}" data-id="{$item['id']}" data-title="{$item['title']|escape}">删除</a>{/auth}
                           </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {else}
                    <p>无记录</p>
                {/if}
                {include file="pagination.tpl"}
                
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