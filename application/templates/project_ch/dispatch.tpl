<div class="pd20">
    <form name="postform" action="{url_path('project_ch','dispatch')}" method="post" target="post_iframe">
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
                    <td>时间要求</td>
                    <td>
                        <label>开始日期<input type="text" name="start_date" id="ds_sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'ds_edate\')}'})"{/literal} value="{if $info['start_date']}{$info['start_date']|date_format:"Y-m-d"}{/if}"/></label>
                        <label>结束日期<input type="text" name="end_date" id="ds_edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'ds_sdate\')}'})"{/literal} value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}"/></label>
                    </td>
                </tr>
                <tr>
                    <td>布置备注</td>
                    <td>
                        <textarea name="bz_remark" rows="8" cols="50">{$info['bz_remark']|escape}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>发送给</td>
                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="布置"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
</div>