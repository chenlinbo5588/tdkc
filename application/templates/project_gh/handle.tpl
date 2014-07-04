<div class="pd20">
    <form name="postform" action="{url_path('project_gh','handle')}" method="post" target="post_iframe">
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
                    <td>项目成果名称</td>
                    <td><input type="text" name="title" value="{$info['title']}" placeholder="请填写项目成果名称"/></td>
                </tr>
                <tr>
                    <td>项目面积</td>
                    <td><input type="text" name="area" value="{if $info['area']}{$info['area']}{/if}" placeholder="请填写项目面积" /></td>
                </tr>
                <tr>
                    <td>电子图件</td>
                    <td>{include file="project_ch/filelist.tpl"}</td>
                </tr>
                <tr>
                    <td>发送给收费</td>
                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="项目提交"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
</div>