{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('contacts')}" method="get" name="searchform">
                    <input type="hidden" value="contacts" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <label><strong>手机号码</strong><input type="text" name="mobile" value="{$smarty.get.mobile}"/></label>
                            <label><strong>固定电话</strong><input type="text" name="tel" value="{$smarty.get.tel}"/></label>
                            <label><strong>范围</strong>
                                <select name="type" >
                                    <option value="">全部</option>
                                    <option value="0" {if $smarty.get.type === '0'}selected{/if}>内部通讯录</option>
                                    <option value="1" {if $smarty.get.type == '1'}selected{/if}>外部通讯录</option>
                                </select>
                            </label>
                            <label><strong>是否包含已删除</strong>
                                <select name="inc_del" >
                                    <option value="否" {if $smarty.get.inc_del == '否'}selected{/if}>否</option>
                                    <option value="是" {if $smarty.get.inc_del == '是'}selected{/if}>是</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="contacts+add"}<a class="addlink" href="{url_path('contacts','add')}">添加通讯录</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>类型</th>
                            <th>单位名称</th>
                            <th>名称</th>
                            <th>手机号码</th>
                            <th>固定电话</th>
                            <th>虚拟网号码</th>
                            <th>传真号码</th>
                            <th>地址</th>
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
                           <td>{if $item['type']}外部{else}内部{/if}通讯录</td>
                           <td>{$item['company_name']|escape}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['mobile']}</td>
                           <td>{$item['tel']}</td>
                           <td>{$item['virtual_no']}</td>
                           <td>{$item['fax']}</td>
                           <td>{$item['address']|escape}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="contacts+edit"}<a href="{url_path('contacts','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="contacts+delete"}<a href="javascript:void(0);" data-title="{$item['name']}" data-href="{url_path('contacts','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="15">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}