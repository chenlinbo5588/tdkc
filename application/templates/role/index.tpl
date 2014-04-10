{include file="common/header.tpl"}
            <div class="row-fluid">
                <form action="{url_path('role')}" method="get" name="roleform">
                    <input type="hidden" value="role" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>角色名称</strong><input type="text" name="name" value="{$smarty.get.name}" placeholder="请输入角色姓名"/></label>
                            <label><strong>包含删除</strong>
                                <select name="inc_del" >
                                    <option value="否" {if $smarty.get.inc_del == '否'}selected{/if}>否</option>
                                    <option value="是" {if $smarty.get.inc_del == '是'}selected{/if}>是</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                     </ul>
                </form>
                
               <a href="{url_path('role','add')}">添加角色</a>
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>编号</th>
                            <th>角色名称</th>
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
                           <td>{$item['name']|escape}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               <a href="{url_path('role','auth','id=')}{$item['id']}">设置权限</a>
                               <a href="{url_path('role','edit','id=')}{$item['id']}">编辑</a>
                               {if $item['status'] != '已删除'}
                               <a href="javascript:void(0);" data-title="{$item['name']}" data-href="{url_path('role','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>
                               {/if}
                           </td>
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="6">还没有角色 <a href="{url_path('role','add')}">点击开始添加</a></td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>
{include file="common/footer.tpl"}