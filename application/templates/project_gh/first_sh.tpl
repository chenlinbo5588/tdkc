<div class="pd20">
    <form name="postform" action="{url_path('project_gh','first_sh')}" method="post" target="post_iframe">
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
                    <td>初审意见</td>
                    <td>
                        <textarea style="width: 500px; height: 50px;" name="cs_yj">{if $info['cs_yj']}{$info['cs_yj']|escape}{else}按规范要求测量，报告符合要求。{/if}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>初审修改和处理意见、说明</td>
                    <td>
                        <textarea style="width: 500px; height: 50px;" name="cs_remark">{$info['cs_remark']|escape}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>电子图件</td>
                    <td>{include file="project_ch/filelist.tpl"}</td>
                </tr>
                <tr>
                    <td>发送给复审</td>
                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="通过初审"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
</div>