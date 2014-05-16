{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('salary')}" method="get" name="searchform">
                    <input type="hidden" value="salary" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>姓名</strong><input type="text" name="name" value="{$smarty.get.name|escape}" placeholder="请输入用户姓名"/></label>
                            <label><strong>工号</strong><input type="text" name="gh" value="{$smarty.get.gh|escape}" placeholder="请输入工号"/></label>
                            <label><strong>职称</strong><input type="text" name="job_title" value="{$smarty.get.job_title|escape}" placeholder="请输入职称"/></label>
                            <label><strong>从年龄</strong><input type="text" style="width:40px;" name="age_s" value="{$smarty.get.age_s|escape}" placeholder="从年龄"/></label>
                            <label><strong>到年龄</strong><input type="text" style="width:40px;" name="age_e" value="{$smarty.get.age_e|escape}" placeholder="到年龄"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
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
                            <th>职称</th>
                            <th>年龄</th>
                            <th>手机号码</th>
                            <th>虚拟号</th>
                            <th>入院年月</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['gh']}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['account']}</td>
                           <td>{$item['job_title']|escape}</td>
                           <td>{$item['age']}</td>
                           <td>{$item['mobile']}</td>
                           <td>{$item['virtual_no']}</td>
                           <td>{$item['enter_date']|date_format:"Y-m-d"}</td>
                           <td>{$item['status']}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="salary+adjust"}<a href="{url_path('salary','adjust','user_id=')}{$item['id']}">调整工资</a>{/auth}
                               {/if}
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