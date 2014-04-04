{include file="common/header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('user','edit')}" method="post" name="userform">
                    <input type="hidden" name="id" value="{$user['user_id']}"/>
                {else}
                <form action="{url_path('user','add')}" method="post" name="userform">
                {/if}
                    <ul>
                        <li>
                            <label class="required"><em>*</em><strong>姓名</strong><input type="text" name="name" value="{$user['name']}" placeholder="请输入员工姓名"/></label><span class="tip">{form_error('name')}</span>
                        </li>
                        <li>
                            <label class="required"><em>*</em><strong>性别</strong></label><span>男<input type="radio" name="sex" value="m" {if $user['sex'] == '' || $user['sex'] == 'm'}checked{/if} />&nbsp;女<input type="radio" name="sex" value="f" {if $user['sex'] == 'f'}checked{/if} /></span>
                        </li>
                        {if $action == 'edit'}
                        <li>
                            <label class="required"><em></em><strong>登陆账号</strong>{$user['account']}</label>
                        </li>
                        <li>
                            <label class="required"><em></em><strong>工号</strong>{$user['gh']}</label>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>登陆密码</strong><input type="password" name="psw" value="" placeholder="请输入登陆账号密码"/></label><span class="tip">{form_error('psw')} 如果留空，则表不修改密码 </span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>密码确认</strong><input type="password" name="psw2" value="" placeholder="请输入登陆账号密码确认"/></label><span class="tip">{form_error('psw2')}</span>
                        </li>
                        {else}
                        <li>
                            <label class="required"><em>*</em><strong>登陆账号</strong><input type="text" name="account" value="{$user['account']}" placeholder="请输入登陆账号"/></label><span class="tip">{form_error('account')} 英文字母、数字、下划线、中划线,建议使用姓名拼音的方式,入 王小二 则账号为 wangxiaoer   最大长度15个字符 </span>
                        </li>
                        <li>
                            <label class="required"><em>*</em><strong>工号</strong><input type="text" name="gh" value="{$user['gh']}" placeholder="请输入员工工号"/></label><span class="tip">{form_error('gh')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>登陆密码</strong><input type="password" name="psw" value="{$user['psw']}" placeholder="请输入登陆账号密码"/></label><span class="tip">{form_error('psw')} 如果留空，则表使用默认密码 #123456! </span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>密码确认</strong><input type="password" name="psw2" value="{$user['psw2']}" placeholder="请输入登陆账号密码确认"/></label><span class="tip">{form_error('psw2')}</span>
                        </li>
                        {/if}
                        <li>
                            <label class="optional"><em></em><strong>身份证号码</strong><input type="text" name="id_card" value="{$user['id_card']}" placeholder="请输入身份证号码"/></label><span class="tip">{form_error('id_card')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>邮箱地址</strong><input type="text" name="email" value="{$user['email']}" placeholder="请输入邮箱地址"/></label><span class="tip">{form_error('email')}</span>
                        </li>
                        <li>
                            <label class="required"><em>*</em><strong>手机号码</strong><input type="text" name="mobile" value="{$user['mobile']}" placeholder="请输入手机号码"/></label><span class="tip">{form_error('mobile')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>座机号码</strong><input type="text" name="tel" value="{$user['tel']}" placeholder="请输入座机号码"/></label><span class="tip">{form_error('tel')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>虚拟号码</strong><input type="text" name="virtual_no" value="{$user['virtual_no']}" placeholder="请输入虚拟号"/></label><span class="tip">{form_error('virtual_no')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>毕业院校</strong><input type="text" name="school_name" value="{$user['school_name']}" placeholder="请输入毕业院校"/></label><span class="tip">{form_error('virtual_no')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>专业名称</strong><input type="text" name="major" value="{$user['major']}" placeholder="请输入专业名称"/></label><span class="tip">{form_error('virtual_no')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>毕业时间</strong><input type="text" name="graduation_date" class="Wdate" readonly onclick="WdatePicker()" value="{$user['graduation_date']}" placeholder="请输入毕业时间"/></label><span class="tip">{form_error('graduation_date')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>职称名称</strong><input type="text" name="job_title" value="{$user['job_title']}" placeholder="请输入职称名称"/></label><span class="tip">{form_error('job_title')}</span>
                        </li>
                        <li>
                            <label class="optional"><em></em><strong>当前岗位名称</strong><input type="text" name="current_job" value="{$user['current_job']}" placeholder="请输入当前岗位名称"/></label><span class="tip">{form_error('current_job')}</span>
                        </li>
                        <li>
                            <label class="required"><em>*</em><strong>入院年月</strong><input type="text" class="Wdate" readonly onclick="WdatePicker()" name="enter_date" value="{$user['enter_date']}" placeholder="请输入当前入院年月"/></label><span class="tip">{form_error('enter_date')}</span>
                        </li>
                        <li>
                            <input type="submit" name="submit" class="btn btn-primary" value="保存"/>
                            <input type="reset" name="reset" class="btn btn-default" value="重置"/>
                        </li>
                     </ul>
                </form>
                <script>
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('user','add')}";
                        }else{
                            location.href = "{url_path('user')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        alert('{$feedMessage}');
                    {/if}
                    });
                </script>
            </div>
        <script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
{include file="common/footer.tpl"}