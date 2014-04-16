{include file="common/main_header.tpl"}
        <div class="filebar" >
            <a href="{url_path('pm','index','action=send')}" id="upload" class="btn"><img src="/img/wp/upload_file_icon.gif" align="absmiddle"/>已发消息</a>
            <a href="{url_path('pm','index','action=receive')}" id="add_folder" class="btn"><img src="/img/pm/yd.png" align="top"/>已收消息</a>
            <a href="{url_path('pm','index','action=trash')}" id="move_oper" class="btn"><img src="/img/wp/folder.gif" align="absmiddle"/>垃圾箱</a>
        </div>
        
        <div class="searchform row-fluid">
                <form action="{url_path('pm')}" method="get" name="searchform">
                    <input type="hidden" value="pm" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <input type="hidden" value="{$action}" name="action"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('pm','add')}">添加消息</a>
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
                               <a href="{url_path('pm','edit','id=')}{$item['id']}">编辑</a>
                               <a href="javascript:void(0);" data-title="{$item['title']}" data-href="{url_path('pm','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="9">没有消息</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>
             
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}