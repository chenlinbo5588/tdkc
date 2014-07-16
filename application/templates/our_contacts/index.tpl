{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('our_contacts')}" method="get" name="searchform">
                    <input type="hidden" value="our_contacts" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <label><strong>手机号码</strong><input type="text" name="mobile" value="{$smarty.get.mobile}"/></label>
                            <label><strong>固定电话</strong><input type="text" name="tel" value="{$smarty.get.tel}"/></label>
                            <label><strong>虚拟号</strong><input type="text" name="virtual_no" value="{$smarty.get.virtual_no}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                     </ul>
                </form>
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>姓名</th>
                            <th>手机号码</th>
                            <th>固定电话</th>
                            <th>虚拟网号码</th>
                            <th>地址</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['name']|escape}</td>
                           <td>{$item['mobile']}</td>
                           <td>{$item['tel']}</td>
                           <td>{$item['virtual_no']}</td>
                           <td>{$item['address']|escape}</td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="5">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>
{include file="common/main_footer.tpl"}