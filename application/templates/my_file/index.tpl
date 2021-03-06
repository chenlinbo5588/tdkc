{include file="common/main_header.tpl"}

            <div class="filebar" >
                <a href="javascript:void(0);" id="upload" class="btn"><img src="/img/wp/upload_file_icon.gif" align="absmiddle"/>上传文件</a>
                <a href="javascript:void(0);" id="delete_oper" data-href="{url_path('my_file','delete')}" class="btn"><img src="/img/wp/delete_icon.gif" align="absmiddle"/>删除</a>
                <a href="javascript:void(0);" id="add_folder" class="btn"><img src="/img/wp/new_folder.gif" align="absmiddle"/>新建文件夹</a>
                <a href="javascript:void(0);" id="move_oper" class="btn"><img src="/img/wp/folder.gif" align="absmiddle"/>移动</a>
                {if $pid == 0}
                <a href="javascript:void(0);" id="share_oper" class="btn"><img src="/img/wp/share_folder.gif" align="absmiddle"/>共享</a>
                <a href="javascript:void(0);" id="unshare_oper" class="btn"><img src="/img/wp/share_folder.gif" align="absmiddle"/>取消共享</a>
                {/if}
                <span class="notice">只有最上层目录和文件才能共享</span>
            </div>
            <div class="span12">
                <form name="filelist" action="{url_path('my_file')}" method="post">
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
                                 <a href="{url_path('my_file')}&pid={$parents[count($parents) - 1]['pid']}">返回上一级</a>
                                {/if}
                                
                                <a href="{url_path('my_file')}">根目录</a>&gt;
                                {foreach name="filenav" from=$parents item=item}
                                <a href="{url_path('my_file')}&pid={$item['id']}">{$item['file_name']|escape}</a>{if !$smarty.foreach.filenav.last}&gt;{/if}
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
                           <th><input type="checkbox" name="file_id[]" value="{$item['id']}"/></th>
                           <td>
                               <div class="filerow{if $item['is_dir']} isdir{/if}">
                               {if $item['is_dir']}<div class="file_icon dir_icon16"></div><a class="filename" href="{url_path('my_file','index','pid=')}{$item['id']}">{$item['file_name']|escape}</a>
                               {else}<img src="{filetype_url($item['file_extension'])}"/><span class="filename"><a href="{url_path('my_file','download','id=')}{$item['id']}">{$item['file_name']|escape}</a></span>{/if}
                               {if $item['in_share']}<strong>【已共享】</strong>{/if}
                                </div>
                            </td>
                           <td>{byte_format($item['file_size'])}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if !$item['is_dir']}<a href="{url_path('my_file','download','id=')}{$item['id']}">下载</a>{/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="5">没有文件</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                </form>
                {*{include file="pagination.tpl"}*}
             </div>
             

             <div id="newfolder_dlg" style="display: none;">
                 <div class="pd20">
                    <form name="folder_form" action="{url_path('my_file','addfolder')}" method="post">
                        <input type="hidden" name="pid" value="{$pid}"/>
                        <label><span>文件夹名称:</span><input type="text" style="width:200px;" name="folder_name" placeholder="请输入文件夹名称"/></label>{*<input type="submit" name="submit" value="确定"/>*}
                    </form>
                 </div>
             </div>
                        

            <form id="delete_form" name="delete_form" action="{url_path('my_file','delete')}" method="post">
                <input type="hidden" name="pid" value="{$pid}"/>
                <div class="inputlist">
                </div>
            </form>
                
            <form id="share_form" name="share_form" action="{url_path('my_file','share')}" method="post">
                <input type="hidden" name="pid" value="{$pid}"/>
                <div class="inputlist">
                </div>
            </form>
                
            <form id="unshare_form" name="unshare_form" action="{url_path('my_file','unshare')}" method="post">
                <input type="hidden" name="pid" value="{$pid}"/>
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
                    
                    $("#upload").bind("click",function(e){
                        $.jBox.open("iframe:{url_path('file')}&folder_id={$pid}&uid={$userProfile['id']}", "上传文件", 650, 450, { top:'10%', buttons: { },closed:function(){
                             location.reload();
                         }});
                    });
                    
                    $("#share_oper").bind("click",function(e){
                        var checked = false;
                        $("#share_form .inputlist").html('');
                        $("input[name='file_id[]']").each(function(index){
                            if($(this).prop("checked")){
                                checked = true;
                                $('<input type="hidden" name="id[]" value="' + $(this).val() + '"/>').appendTo("#share_form .inputlist");
                            }
                        });
                        
                        if(!checked){
                            $.jBox.error('至少选择一个文件或者目录', '提示');
                        }else{
                            
                            var submit = function (v, h, f) {
                                if (v == true){
                                    $("#share_form").submit();
                                }
                                return true;
                            };
                            
                            $.jBox.confirm("确定要共享吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                        }
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
                    
                    
                    
                    $("#delete_oper").bind("click",function(e){
                        var checked = false;
                        $("#delete_form .inputlist").html('');
                        $("input[name='file_id[]']").each(function(index){
                            if($(this).prop("checked")){
                                checked = true;
                                $('<input type="hidden" name="delete_id[]" value="' + $(this).val() + '"/>').appendTo("#delete_form .inputlist");
                            }
                        });
                        
                        if(!checked){
                            $.jBox.error('至少选择一个文件或者目录', '提示');
                        }else{
                            
                            var submit = function (v, h, f) {
                                if (v == true){
                                    $("#delete_form").submit();
                                }
                                return true;
                            };
                            
                            $.jBox.confirm("确定要删除吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                        }
                    });
                    
                    $("#move_oper").bind("click",function(e){
                        var checked = false;
                        $("input[name='file_id[]']").each(function(index){
                            if($(this).prop("checked")){
                                checked = true;
                                return false;
                            }
                        });
                        
                        if(!checked){
                            $.jBox.error('至少选择一个文件或者目录', '提示');
                        }else{
                            $.jBox("get:{url_path('my_file','list_dir')}&isajax=1&" + $("form[name=filelist]").serialize() ,{
                                 title:"移动",
                                 buttons: { '确定':true, '关闭': false },
                                 submit: function (v, h, f) {
                                    if(v){
                                        if(!$("input[name=move_id]").val()){
                                            $.jBox.tip('请选择一个文件夹。');
                                            return false;
                                        }else{
                                            $.ajax({
                                                type:"POST",
                                                url: "{url_path('my_file','move')}",
                                                data:$("form[name=filelist]").serialize() + '&isajax=1&move_id=' + $("input[name=move_id]").val() + "&from_id={$pid}",
                                                dataType:"json",
                                                success:ajax_success,
                                                error:ajax_error
                                            });
                                        }
                                    }
                                    
                                    return true;
                                 }
                            });
                        }
                    });
                 
                    $("#add_folder").bind("click",function(e){
                        $.jBox('id:newfolder_dlg', { 
                            title:"添加文件夹",
                            submit:function(v, h, f){
                                if($.trim(f.folder_name) == ''){
                                    $.jBox.tip('请输入文件夹名称。');
                                    return false;
                                }
                                
                                $("form[name=folder_form]").submit();
                                return true;
                            }
                        });
                    });
                 });
            </script>
{include file="common/main_footer.tpl"}