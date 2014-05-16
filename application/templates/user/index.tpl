{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('user')}" method="get" name="searchform">
                    <input type="hidden" value="user" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>姓名</strong><input type="text" name="name" value="{$smarty.get.name}" placeholder="请输入用户姓名"/></label>
                            <label><strong>工号</strong><input type="text" name="gh" value="{$smarty.get.gh}" placeholder="请输入工号"/></label>
                            <label><strong>包含删除</strong>
                                <select name="inc_del" >
                                    <option value="否" {if $smarty.get.inc_del == '否'}selected{/if}>否</option>
                                    <option value="是" {if $smarty.get.inc_del == '是'}selected{/if}>是</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="user+add"}<a class="addlink" href="{url_path('user','add')}">添加用户</a>{/auth}
                        </li>
                     </ul>
                </form>
                
               
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>工号</th>
                            <th>姓名</th>
                            <th>登陆账号</th>
                            <th>手机号码</th>
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
                           <td>{$item['gh']}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['account']}</td>
                           <td>{$item['mobile']}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="user+edit"}<a href="{url_path('user','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {/if}
                               {if $item['id'] != 1 && $item['status'] != '已删除'}{auth name="user+auth"}<a href="{url_path('user','auth','id=')}{$item['id']}">设置权限</a>{/auth} {auth name="user+delete"}<a href="javascript:void(0);" data-title="{$item['name']}" data-href="{url_path('user','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}{/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="10">找不到数据</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>
{include file="common/main_footer.tpl"}