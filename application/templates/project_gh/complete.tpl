<div class="pd20">
    
    <form name="saveForm" action="{url_path('project_gh','complete')}" method="post" target="post_iframe">
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
                    <td>自查主要意见</td>
                    <td>
                        <textarea style="width: 500px; height: 100px;" name="zc_yj">{if $info['zc_yj']}{$info['zc_yj']|escape}{else}外业数据正确。{/if}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>自查修改和处理意见、说明</td>
                    <td>
                        <textarea style="width: 500px; height: 100px;" name="zc_remark">{$info['zc_remark']|escape}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>图件文档</td>
                    <td>
                        <div>
                            <span class="uploader"></span>
                            <a class="upload-button" href="javascript:void(0);"><span id="UploaderPlaceholder_1"></span></a>
                            <span class="Uploader" data-url="{url_path('attachment','upload')}&uid={$userProfile['id']}"  data-allowsize="30Mb" data-allowfile="*.*" ></span>
                            <strong>请上传完成时必要的图件文档,单文件最大<span class="notice">30M</span></strong>
                        </div>
                        <div class="field-box">
                            <div id="UploaderProgress_1"></div>
                            <div id="UploaderFeedBack_1"></div>
                        </div>
                        <ul id="filelist" class="tj_list">
                            {foreach from=$files item=item}
                                <li style="color:blue;"><div class="fname"><a title="点击下载" href="{url_path('attachment','download','id=')}{$item['id']}">{$item['file_name']}</a></div><div class="fsize">{byte_format($item['file_size'])}</div><input type="hidden" name="file_id[]" value="{$item['id']}"/><a class="df" href="javascript:void(0);">删除</a></li>
                            {/foreach}
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>发送给初审</td>
                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="完成"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
                
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
    {include file="common/upload.tpl"}
    <script>
        $(function(){
        
            $("#filelist").delegate("a.df","click",function(e){
                if(confirm("确定要删除吗")){
                    $(this).closest("li").remove();
                }
            });
            
            
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

                            var html = '';
                            if(response.error){
                                html += '<li style="color:red;">';
                            }else{
                                html += '<li style="color:blue;">';
                            }
                            html += '<div class="fname"><a title="点击下载" href="{url_path('attachment','download')}' + '&id=' + response.id + '">' + file.name  + '</a></div><div class="fsize">&nbsp;</div><a class="df" href="javascript:void(0);">删除</a>';
                            html += '<input type="hidden" name="file_id[]" value="' + response.id + '"/>';
                            html += '</li>';
                            $("#filelist").append(html);

                        } catch (ex) {
                            this.debug(ex);
                        }
                    }
                };

                createSwfUpload(index + 1,$(this).attr("data-url"),{},$(this).attr("data-allowsize"),$(this).attr("data-allowfile"),handler);
            });
        });
    </script>
</div>