                                        {if $info['status'] == '' || $info['status'] == '新增' || $userProfile['id'] == 1}
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
                                        {/if}
                                        <div>{form_error('file_id[]')}</div>
                                        <ul id="filelist" class="tj_list">
                                            {foreach from=$files item=item}
                                                <li style="color:blue;"><div class="fname"><a title="点击下载" href="{url_path('attachment','download','id=')}{$item['id']}">{$item['file_name']}</a></div><div class="fsize">{byte_format($item['file_size'])}</div><input type="hidden" name="file_id[]" value="{$item['id']}"/><a class="df" href="javascript:void(0);">删除</a></li>
                                            {/foreach}
                                        </ul>