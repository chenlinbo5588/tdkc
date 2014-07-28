{include file="common/main_header.tpl"}
            <div class="row-fluid taizhang_detail">
                {include file="{$tplDir}/side.tpl"}
                
                <div class="mainarea">
                    <form action="{url_path($tplDir,'check')}" method="post" name="infoform">
                        <input type="hidden" name="id" value="{$info['id']}"/>
                        <table class="maintain">
                            <caption>基本信息</caption>
                            <colgroup>
                                <col width="100"/>
                                <col width="500"/>
                            </colgroup>
                            <tbody>
                                {include file="{$tplDir}/basic.tpl"}
                            </tbody>
                        </table>
                        <table class="maintain">
                            <caption>审核信息</caption>
                            <colgroup>
                                <col width="100"/>
                                <col width="500"/>
                            </colgroup>
                            <tbody>
                                {include file="taizhang/zc.tpl"}
                                {include file="taizhang/cs.tpl"}
                                {include file="taizhang/fs.tpl"}
                            </tbody>
                         </table>
                         <table class="maintain">
                             <caption>缺陷信息</caption>
                                <colgroup>
                                    <col width="100"/>
                                    <col width="500"/>
                                </colgroup>
                                <tbody>
                                    {include file="taizhang/fault_list.tpl"}
                                </tbody>
                         </table>
                            
                         <table class="maintain">
                             <tbody>
                                {if $info['status'] == '新增'}
                                <tr>
                                    <td>发送给初审</td>
                                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                                </tr>
                                {/if}
                                <tr>
                                    <td></td>
                                    <td>
                                        {if $info['status'] == '新增' && $info['sendor_id'] == $userProfile['id']}
                                        <input type="submit" name="submit" class="btn btn-sm btn-orange" value="提交初审"/>
                                        {/if}
                                        {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                
                <script>
                    $(function(){
                    {if $message}
                        $.jBox.alert('{$message}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}