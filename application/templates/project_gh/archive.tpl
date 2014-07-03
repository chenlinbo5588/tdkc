<div class="pd20 project_detail">
    <form name="postform" action="{url_path('project_gh','archive')}" method="post" target="post_iframe">
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
                    <td>成果资料领取</td>
                    <td>
                        <label><input type="radio" name="get_doc" value="1" {if $info['get_doc'] == 1}checked{/if}>已领取</label>
                        <label><input type="radio" name="get_doc" value="0" {if $info['get_doc'] == 0}checked{/if}>未领取</label>
                    </td>
                </tr>
                <tr>
                    <td>应收金额</td>
                    <td>
                        <input type="text" name="ys_amount" value="{$info['ys_amount']}"/>
                    </td>
                </tr>
                <tr>
                    <td>实收金额</td>
                    <td>
                        <input type="text" name="ss_amount" value="{$info['ss_amount']}"/>
                    </td>
                </tr>
                <tr>
                    <td>欠费情况</td>
                    <td>
                        <label><input type="radio" name="is_owed" value="0" {if $info['is_owed'] == 0}checked{/if}/>不欠费</label>
                        <label><input type="radio" name="is_owed" value="1" {if $info['is_owed'] == 1}checked{/if}/>欠费</label>
                    </td>
                </tr>
                <tr>
                    <td>收费情况</td>
                    <td>
                        <label><input type="radio" name="fee_type" value="1" {if $info['fee_type'] == 1}checked{/if}/>挂账</label>
                        <label><input type="radio" name="fee_type" value="2" {if $info['fee_type'] == 2}checked{/if}/>票开款收</label>
                        <label><input type="radio" name="fee_type" value="3" {if $info['fee_type'] == 3}checked{/if}/>票开款未收</label>
                        <label><input type="radio" name="fee_type" value="4" {if $info['fee_type'] == 4}checked{/if}/>票未开款收</label>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="归档"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
</div>