{include file="common/main_header.tpl"}

            <div class="filebar" >
                <a href="javascript:void(0);" onclick="abox('{url_path('file')}&folder_id={$pid}&uid={$userProfile['id']}','上传文件',650,450);" clas="btn"><img src="/img/wp/upload_file_icon.gif" align="absmiddle"/>上传文件</a>
                <a href="javascript:void(0);" class="btn"><img src="/img/wp/delete_icon.gif" align="absmiddle"/>删除</a>
                <a href="javascript:void(0);" id="add_folder" clas="btn"><img src="/img/wp/new_folder.gif" align="absmiddle"/>新建文件夹</a>
                <a href="javascript:void(0);" id="move" clas="btn"><img src="/img/wp/folder.gif" align="absmiddle"/>移动</a>
            </div>
            <div class="span12">
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
                                 <a href="javascript:void(0);">返回上一级</a>
                                {/if}
                                <a href="{url_path('my_file')}">根目录</a>&gt;
                                {if $smarty.get.pid }
                                <a href="javascript:void(0);">我的文件</a>
                                {/if}
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
                           <th><input type="checkbox" name="file_id[]"/></th>
                           <td>{if $item['is_dir']}<div class="file_icon dir_icon16"></div><a class="filename" href="{url_path('my_file','index','pid=')}{$item['id']}">{$item['file_name']|escape}</a>{else}<img src="{filetype_url($item['file_extension'])}"/><span class="filename">{$item['file_name']|escape}</span>{/if}</td>
                           <td>{byte_format($item['file_size'])}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if !$item['is_dir']}<a href="{url_path('my_file','download','id=')}{$item['id']}">下载</a>{/if}
                               <a href="{url_path('my_file','delete','id=')}{$item['id']}">删除</a>
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="5">没有文件</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

             
             <div id="newfolder_dlg" style="display: none;">
                 <form name="folder_form" action="{url_path('my_file','addfolder')}" method="post">
                     <input type="hidden" name="pid" value="{$pid}"/>
                     <label><span>文件夹名称</span><input type="text" style="width:200px;" name="folder_name" placeholder="请输入文件夹名称"/></label>{*<input type="submit" name="submit" value="确定"/>*}
                 
                 </form>
             </div>
             <script>
                 $(function(){
                    $("#add_folder").bind("click",function(e){
                        $.jBox('id:newfolder_dlg', { 
                            title:"添加文件夹",
                            submit:function(v, h, f){
                                if($.trim(f.folder_name) == ''){
                                    $.jBox.tip('请输入文件夹名称。');
                                    return false;
                                }
                                
                                $.ajax({
                                    type:"POST",
                                    url: $("form[name=folder_form]").attr("action"),
                                    data:$("form[name=folder_form]").serialize(),
                                    dataType:"json",
                                    success:ajax_success,
                                    error:ajax_error
                                });
                                return false;
                            }
                        });
                    });
                 });
            </script>
{include file="common/main_footer.tpl"}