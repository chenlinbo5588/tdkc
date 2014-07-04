{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('doc','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('doc','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                            <tr>
                                <td><label class="required"><em>*</em><strong>项目名称</strong></label></td><td><input type="text" style="width:500px" name="title" id="title" value="{$info['title']}" placeholder="请输入项目名称"/>{form_error('title')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>合同签订日期</strong></label></td><td><input type="text"  name="sign_time"  class="Wdate" readonly onclick="WdatePicker()"  value="{$info['sign_time']|date_format:"Y-m-d"}" placeholder="请输入签订日期"/>{form_error('sign_time')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>合同金额</strong></label></td><td><input type="text"  name="amount"  value="{$info['amount']}" placeholder="请输入合同金额"/>{form_error('amount')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>联系人</strong></label></td><td><input type="text"  name="linkman"  value="{$info['linkman']}" placeholder="请输入联系人名称"/>{form_error('linkman')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>是否完成</strong></label></td>
                                <td>
                                    <select name="is_comp">
                                        <option value="0" {if $info['is_comp'] == 0}selected{/if}>未完成</option>
                                        <option value="1" {if $info['is_comp'] == 1}selected{/if}>已完成</option>
                                    </select>
                                    {form_error('is_comp')}
                                </td>
                            </tr>    
                            <tr>
                                <td><label class="optional"><em></em><strong>电子档</strong></label></td>
                                <td>
                                    <div>
                                        <input type="hidden" name="file_id" value="{$info['file_id']}"/>
                                        <input type="text" name="file_name" readonly value="{$info['file_name']}"/>
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
                                    $("input[name=file_name]").val(response.title);
                                    
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
                            location.href = "{url_path('doc','add')}";
                        }else{
                            location.href = "{url_path('doc')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}