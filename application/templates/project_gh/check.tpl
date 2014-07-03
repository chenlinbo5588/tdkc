<div class="pd20 project_detail">
    <form name="postform" action="{url_path('project_gh','check')}" method="post" target="post_iframe">
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
                {if $info['status'] == '已完成'}
                <tr>
                    <td>自查主要意见</td>
                    <td>
                        <textarea style="width: 500px; height: 50px;" name="zc_yj">{if $info['zc_yj']}{$info['zc_yj']|escape}{else}外业数据正确。{/if}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>自查修改和处理意见、说明</td>
                    <td>
                        <textarea style="width: 500px; height: 50px;" name="zc_remark">{$info['zc_remark']|escape}</textarea>
                    </td>
                </tr>
                {else}
                 <tr>
                    <td>自查主要意见</td>
                    <td>{$info['zc_yj']}</td>
                </tr>
                <tr>
                    <td>自查修改和处理意见、说明</td>
                    <td>{$info['zc_remark']|escape}</td>
                </tr>   
                {/if}
                
                {if $info['status'] == '已通过初审'}
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
                {/if}
                <tr>
                    <td>电子图件</td>
                    <td>{include file="project_ch/filelist.tpl"}</td>
                </tr>
                <tr>
                    <td>发送给</td>
                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        {if $info['status'] == '已完成'}
                        <input type="submit" name="submit" class="btn btn-orange" value="提交初审"/>
                        {else}
                        <input type="submit" name="submit" class="btn btn-orange" value="提交复审"/>    
                        {/if}
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
</div>