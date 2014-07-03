<div class="pd20 project_detail">
    <form name="postform" action="{url_path('project_ch','tuihui')}" method="post" target="post_iframe">
        <input type="hidden" name="id" value="{$info['id']}"/>
        <table class="maintain border1">
            <tbody>
                <tr>
                    <td>登记名称</td>
                    <td>{$info['name']|escape}</td>
                </tr>
                <tr>
                    <td>项目负责人</td>
                    <td>{$info['pm']|escape}</td>
                </tr>
                <tr>
                    <td>退回原因</td>
                    <td>
                        <textarea name="reason" style="width: 500px; height: 50px;">{$info['reason']|escape}</textarea>
                    </td>
                </tr>
                {include file="project_ch/faultlist.tpl"}
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="退回"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
</div>