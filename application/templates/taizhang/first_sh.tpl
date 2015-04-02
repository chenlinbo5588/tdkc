{include file="common/main_header.tpl"}
            <div class="row-fluid taizhang_detail clearfix">
                {include file="{$tplDir}/side.tpl"}
                
                <div class="mainarea">
                    <form action="{url_path($tplDir,'first_sh')}" method="post" name="infoform">
                        <input type="hidden" name="id" value="{$info['id']}"/>
                        <input type="hidden" name="workflow" value=""/>
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
                                    {if $info['status'] == '已提交初审'}
                                    {include file="taizhang/fault_standard.tpl"}
                                    {/if}
                                </tbody>
                         </table>
                            
                         <table class="maintain">
                             <caption>操作区域</caption>
                             <colgroup>
                                    <col width="100"/>
                                    <col width="500"/>
                                </colgroup>
                             <tbody>
                                {if $info['status'] == '已提交初审' && $info['can_revocation'] == 0}
                                <tr>
                                    <td>发送给复审</td>
                                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                                </tr>
                                {/if}
                                <tr>
                                    <td></td>
                                    <td>
                                        {if $info['status'] == '已提交初审' && $info['sendor_id'] == $userProfile['id']}
                                            {if $info['can_revocation'] == 1}
                                            <input type="submit" name="submit" class="btn btn-sm btn-orange"  value="受理"/>
                                            {else}
                                            <input type="submit" name="submit" class="btn btn-sm btn-orange" style="font-size:13px;" value="通过并提交复审"/>
                                            <input type="submit" name="submit" class="btn btn-sm btn-gray"  value="退回"/>
                                            {/if}
                                        {/if}
                                        
                                        {if $info['status'] == '已提交复审' && $info['cs_name'] == $userProfile['name'] && $info['can_revocation'] == 1}
                                        <input type="submit" name="submit" class="btn btn-sm btn-orange" value="撤销"/>
                                        {/if}
                                        
                                        <span id="loading" style="display: none;"><img src="/img/loading.gif"/></span>
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
                {include file="taizhang/btn_submit.tpl"}
            </div>
{include file="common/main_footer.tpl"}