{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('inst','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('inst','add')}" method="post" name="infoform">
                {/if}
                    <input type="hidden" name="file_id" value="{$info['file_id']}"/>
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>制度名称</strong></label></td><td><input type="text" style="width:500px" name="title" id="title" value="{$info['title']}" placeholder="请输入标题"/>{form_error('file_id')}{form_error('title')}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <div>
                                    <span class="uploader"></span>
                                    <a class="upload-button" href="javascript:void(0);"><span id="UploaderPlaceholder_1"></span></a>
                                    <span class="Uploader" data-url="{url_path('attachment','upload')}"  data-queue="1" data-allowsize="20Mb" data-allowfile="*.*" ><storeng class="notice">请选择文件,单文件大小20Mb以下</strong></span>
                                </div>
                                <div class="field-box">
                                    <div id="UploaderProgress_1"></div>
                                    <div id="UploaderFeedBack_1"></div>
                                </div>
                            </td>
                        </tr>    
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                                <input type="reset" name="rst" class="btn btn-sm btn-default" value="重置"/>
                                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                            </td>
                        </tr>
                        </tbody>
                     </table>
                </form>
                {include file="common/upload.tpl"}
                <script>
                    $(".Uploader").each(function(index){
                        var handler = {
                            success:function(file,serverData){
                                try {
                                    var progress = new FileProgress(file, this.customSettings.progressTarget);
                                    progress.setComplete();
                                    progress.setStatus("Complete.");
                                    progress.toggleCancel(false);

                                    if(typeof(this.customSettings.callback) != "undefined"){
                                        this.customSettings.callback(file,serverData);
                                    }
                                    var response = $.parseJSON(serverData);
                                    $("input[name=file_id]").val(response.id);
                                    $("#title").val(response.title);
                                    
                                } catch (ex) {
                                    this.debug(ex);
                                }
                            }
                        };

                        createSwfUpload(index + 1,$(this).attr("data-url"),{},$(this).attr("data-allowsize"),$(this).attr("data-allowfile"),handler);
                    });
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('inst','add')}";
                        }else{
                            location.href = "{url_path('inst')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}