                {if $info['status'] == '' || $info['status'] == '新增' || $userProfile['id'] == 1 }
                {include file="common/upload.tpl"}
                    <script>
                        $(function(){
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
                    {/if}