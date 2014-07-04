{include file="common/main_header.tpl"}
        <form name="sendorForm" action="{url_path('sendor','edit')}" method="post" target="post_iframe">
            <div class="searchform row-fluid">
                {auth name="sendor+edit"}<input type="submit" name="save" value="保存设置" />{/auth} 
                {auth name="sendor+add"}<a class="addlink" href="{url_path('sendor','add')}">设置发送人</a>{/auth}
            </div>
            
            <div class="span12">
                <table class="table wauto">
                    <colgroup>
                        <col width="60"/>
                        <col width="100"/>
                        <col width="500"/>
                        <col width="150"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>显示顺序</th>
                            <th>名称</th>
                            <th>初复审设置</th>
                            <th>创建时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td><input type="text" style="width:40px;" name="displayorder_{$item['id']}" value="{$item['displayorder']}"/></td>
                           <td><input type="hidden" name="id[]" value="{$item['id']}"/>{$item['sendor']|escape}</td>
                           {*<td>{if $item['isdefault'] == 1}是{else}否{/if}</td>*}
                           <td>
                               <table>
                                   <tr>
                                       <td>测绘项目</td>
                                       <td>规划项目</td>
                                   </tr>
                                   <tr>
                                       <td>
                                            <label><input type="checkbox" name="ch_{$item['id']}[]" value="workflow" {if $item['ch_workflow'] == 'y'}checked{/if}/>作业</label>
                                            <label><input type="checkbox" name="ch_{$item['id']}[]" value="cs" {if $item['ch_cs'] == 'y'}checked{/if}/>初审</label>
                                            <label><input type="checkbox" name="ch_{$item['id']}[]" value="fs" {if $item['ch_fs'] == 'y'}checked{/if}/>复审</label>
                                            <label><input type="checkbox" name="ch_{$item['id']}[]" value="fee" {if $item['ch_fee'] == 'y'}checked{/if}/>收费</label>
                                            <label><input type="checkbox" name="ch_{$item['id']}[]" value="archive" {if $item['ch_archive'] == 'y'}checked{/if}/>归档</label>
                                       </td>
                                       <td>
                                            <label><input type="checkbox" name="gh_{$item['id']}[]" value="workflow" {if $item['gh_workflow'] == 'y'}checked{/if}/>作业</label>
                                            <label><input type="checkbox" name="gh_{$item['id']}[]" value="cs" {if $item['gh_cs'] == 'y'}checked{/if}/>初审</label>
                                            <label><input type="checkbox" name="gh_{$item['id']}[]" value="fs" {if $item['gh_fs'] == 'y'}checked{/if}/>复审</label>
                                            <label><input type="checkbox" name="gh_{$item['id']}[]" value="fee" {if $item['gh_fee'] == 'y'}checked{/if}/>收费</label>
                                            <label><input type="checkbox" name="gh_{$item['id']}[]" value="archive" {if $item['gh_archive'] == 'y'}checked{/if}/>归档</label>
                                       </td>
                                   </tr>
                               </table>
                           </td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i"}</td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="4">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
             </div>
          </form>          
          <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
{include file="common/main_footer.tpl"}