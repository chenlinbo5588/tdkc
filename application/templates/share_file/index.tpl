{include file="common/main_header.tpl"}

            <div class="filebar" >
                {if $pid == 0}<a href="javascript:void(0);" id="unshare_oper" class="btn"><img src="/img/wp/share_folder.gif" align="absmiddle"/>取消共享</a>{/if}
            </div>
            <div class="span12">
                <form name="filelist" action="{url_path('share_file')}" method="post">
                <table class="table files">
                    <colgroup>
                        <col style="width:25px;"/>
                        <col style="width:600px;"/>
                        <col style="width:100px;"/>
                        <col style="width:200px;"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th colspan="6">
                                {if $smarty.get.pid }
                                 <a href="{url_path('share_file')}&pid={$parents[count($parents) - 1]['pid']}">返回上一级</a>
                                {/if}
                                
                                <a href="{url_path('share_file')}">根目录</a>&gt;
                                {foreach name="filenav" from=$parents item=item}
                                <a href="{url_path('share_file')}&pid={$item['id']}">{$item['file_name']|escape}</a>{if !$smarty.foreach.filenav.last}&gt;{/if}
                                {/foreach}
                                <span class="notice" style="margin:0 0 0 20px">当前目录大小 {byte_format($sizeInfo['file_size'])}</span>
                            </th>
                        </tr>
                        <tr>
                            <th><input type="checkbox" name="checkall"/></th>
                            <th>文件名称</th>
                            <th>大小</th>
                            <th>时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <th>{if $item['user_id'] == $userProfile['id']}<input type="checkbox" name="file_id[]" value="{$item['id']}"/>{/if}</th>
                           <td>
                               <div class="filerow{if $item['is_dir']} isdir{/if}">
                               {if $item['is_dir']}<div class="file_icon dir_icon16"></div><a class="filename" href="{url_path('share_file','index','pid=')}{$item['id']}">{$item['file_name']|escape}</a>
                               {else}<img src="{filetype_url($item['file_extension'])}"/><span class="filename"><a href="{url_path('share_file','download','id=')}{$item['id']}">{$item['file_name']|escape}</a></span>{/if}
                                </div>
                            </td>
                           <td>{byte_format($item['file_size'])}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if !$item['is_dir']}<a href="{url_path('share_file','download','id=')}{$item['id']}">下载</a>{/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="5">没有文件</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                </form>
             </div>
             
             
            <form id="unshare_form" name="unshare_form" action="{url_path('my_file','unshare')}" method="post">
                <input type="hidden" name="pid" value="{$pid}"/>
                <input type="hidden" name="redirectUrl" value="{url_path('share_file','index','pid=')}{$pid}"/>
                <div class="inputlist">
                </div>
            </form>
                
            
             <script>
                 var current_pid = "{$pid}";
                 $(function(){
                    {if $message}
                        $.jBox.tip('{$message}');
                    {/if}
                        
                    $("input[name=checkall]").bind("click",function(){
                        var checkboxs = $(".table tbody input[type=checkbox]");
                        var allchecked = $(this).prop("checked");
                        
                        checkboxs.each(function(){
                            if($(this).prop("checked") && !allchecked){
                                $(this).prop("checked",false)
                            }
                            
                            if(!$(this).prop("checked") && allchecked){
                                $(this).prop("checked",true);
                            }
                            
                        });
                    });
                    
                    $("#unshare_oper").bind("click",function(e){
                        var checked = false;
                        $("#unshare_form .inputlist").html('');
                        $("input[name='file_id[]']").each(function(index){
                            if($(this).prop("checked")){
                                checked = true;
                                $('<input type="hidden" name="id[]" value="' + $(this).val() + '"/>').appendTo("#unshare_form .inputlist");
                            }
                        });
                        
                        if(!checked){
                            $.jBox.error('至少选择一个文件或者目录', '提示');
                        }else{
                            
                            var submit = function (v, h, f) {
                                if (v == true){
                                    $("#unshare_form").submit();
                                }
                                return true;
                            };
                            
                            $.jBox.confirm("确定要取消共享吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                        }
                    });
                    
                 });
            </script>
{include file="common/main_footer.tpl"}