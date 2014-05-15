{include file="common/main_header.tpl"}
<style>
    .txt {
        width:200px;
    }

</style>
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('employ','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$user['id']}"/>
                {else}
                <form action="{url_path('employ','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>姓名</strong></label></td><td><input type="text" class="txt" name="name" value="{$user['name']}" placeholder="请输入员工姓名"/><span class="tip">{form_error('name')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>性别</strong></label></td><td></label><span>男<input type="radio"  name="sex" value="m" {if $user['sex'] == '' || $user['sex'] == 'm'}checked{/if} />&nbsp;女<input type="radio" name="sex" value="f" {if $user['sex'] == 'f'}checked{/if} /></span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>登陆账号</strong></label></td><td><input type="text" name="account" class="txt" value="{$user['account']}" placeholder="请输入登陆账号"/><span class="tip">{form_error('account')} 英文字母、数字、下划线、中划线,建议使用姓名拼音的方式,入 王小二 则账号为 wangxiaoer   最大长度15个字符 </span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>工号</strong></label></td><td><input type="text" name="gh" class="txt" value="{$user['gh']}" placeholder="请输入员工工号"/><span class="tip">{form_error('gh')}</span></td>
                        </tr>
                        {if $action == 'edit'}
                        <tr>
                            <td><label class="optional"><em></em><strong>登陆密码</strong></label></td><td><input type="password" name="psw" value="" placeholder="请输入登陆账号密码"/><span class="tip">{form_error('psw')} 如果留空，则表不修改密码 </span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>密码确认</strong></label></td><td><input type="password" name="psw2" value="" placeholder="请输入登陆账号密码确认"/><span class="tip">{form_error('psw2')}</span></td>
                        </tr>
                        {else}
                        <tr>
                            <td><label class="optional"><em></em><strong>登陆密码</strong></label></td><td><input type="password" name="psw" value="{$user['psw']}" placeholder="请输入登陆账号密码"/><span class="tip">{form_error('psw')} 如果留空，则表使用默认密码 {config_item('default_password')} </span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>密码确认</strong></label></td><td><input type="password" name="psw2" value="{$user['psw2']}" placeholder="请输入登陆账号密码确认"/><span class="tip">{form_error('psw2')}</span></td>
                        </tr>
                        {/if}
                        <tr>
                            <td><label class="optional"><em></em><strong>身份证号码</strong></label></td><td><input type="text" class="txt" name="id_card" value="{$user['id_card']}" placeholder="请输入身份证号码"/><span class="tip">{form_error('id_card')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>出生年月</strong></label></td><td><input type="text" class="Wdate" name="birthday" readonly onclick="WdatePicker()"  value="{$user['birthday']|date_format:"Y-m-d"}" placeholder="请输入出生年月"/><span class="tip">{form_error('birthday')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>家庭地址</strong></label></td><td><input type="text" class="txt" name="address" value="{$user['address']|escape}" placeholder="请输入家庭地址"/><span class="tip">{form_error('address')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>邮箱地址</strong></label></td><td><input type="text" class="txt" name="email" value="{$user['email']}" placeholder="请输入邮箱地址"/><span class="tip">{form_error('email')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>手机号码</strong></label></td><td><input type="text" class="txt" name="mobile" value="{$user['mobile']}" placeholder="请输入手机号码"/><span class="tip">{form_error('mobile')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>座机号码</strong></label></td><td><input type="text" class="txt" name="tel" value="{$user['tel']}" placeholder="请输入座机号码"/><span class="tip">{form_error('tel')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>虚拟号码</strong></label></td><td><input type="text"  name="virtual_no" value="{$user['virtual_no']}" placeholder="请输入虚拟号"/><span class="tip">{form_error('virtual_no')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>毕业院校</strong></label></td><td><input type="text" class="txt" name="school_name" value="{$user['school_name']}" placeholder="请输入毕业院校"/><span class="tip">{form_error('school_name')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>专业名称</strong></label></td><td><input type="text" class="txt" name="major" value="{$user['major']}" placeholder="请输入专业名称"/><span class="tip">{form_error('major')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>毕业时间</strong></label></td><td><input type="text" class="txt" name="graduation_date" class="Wdate" readonly onclick="WdatePicker()" value="{$user['graduation_date']}" placeholder="请输入毕业时间"/><span class="tip">{form_error('graduation_date')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>职称名称</strong></label></td><td><input type="text" class="txt" name="job_title" value="{$user['job_title']}" placeholder="请输入职称名称"/><span class="tip">{form_error('job_title')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>职称评定时间</strong></label></td><td><input type="text" class="Wdate" readonly onclick="WdatePicker()" name="title_time" value="{$user['title_time']}" placeholder="请输入职称评定时间"/><span class="tip">{form_error('title_time')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>当前岗位名称</strong></label></td><td><input type="text" class="txt" name="current_job" value="{$user['current_job']}" placeholder="请输入当前岗位名称"/><span class="tip">{form_error('current_job')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>合同年限</strong></label></td><td><input type="text" class="txt" name="contract_year" value="{$user['contract_year']}" placeholder="请输入合同年限"/><span class="tip">{form_error('contract_year')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>入院年月</strong></label></td><td><input type="text" class="Wdate" readonly onclick="WdatePicker()" name="enter_date" value="{$user['enter_date']}" placeholder="请输入当前入院年月"/><span class="tip">{form_error('enter_date')}</span></td>
                        </tr>
                        <tr><td><label class="required"><em>*</em><strong>归属部门</strong></label></td><td>
                            <select name="dept_id">
                            {foreach from=$deptList item=item}
                            <option value="{$item['id']}" {if $user['dept_id'] == $item['id']}selected{/if}>{$item['sep']}{$item['name']}</option>
                            {foreachelse}
                                <option value="">尚未添加任何部门</option>
                            {/foreach}
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>角色</strong></label></td>
                            <td>
                                <select name="role_id">
                                <option value="0">无</option>
                                {foreach from=$roleList item=item}
                                <option value="{$item['id']}" {if $user['role_id'] == $item['id']}selected{/if}>{$item['name']}</option>
                                {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-primary" value="保存"/>
                                <input type="reset" name="rst" class="btn btn-sm btn-default" value="重置"/>
                                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                            </td>
                        </tr>
                        </tbody>
                     </table>
                </form>
                <script>
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('employ','add')}";
                        }else{
                            location.href = "{url_path('employ')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
        {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}