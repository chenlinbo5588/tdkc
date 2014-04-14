{include file="common/main_header.tpl"}
            <div>
                <span class="uploader"></span>
                <a class="upload-button" href="javascript:void(0);"><span id="UploaderPlaceholder_1"></span></a>
                <span class="Uploader" allowSize="2Mb" allowFile="*.*" ><storeng class="notice">请选择文件,单文件大小2Mb以下</strong></span>
                
                {*<input type="button" name="upload" id="beginUpload" value="开始上传"/>*}
            </div>
            <div class="field-box">
                <div id="UploaderProgress_1"></div>
                <div id="UploaderFeedBack_1"></div>
            </div>
            
            <ul id="filelist">
                {*<li><a href="javascript:void(0)">删除</a><input type="hidden" name="file_id[]"/><span>文件名称</span><li>*}
            </ul>
            {include file="common/upload.tpl"}
            <style>
            #filelist {
               margin: 10px 0 0 0;
            }
            
            #filelist li {
                 border:1px solid #D1D36B;
                 padding: 6px 3px;
                 margin: 4px 0;
            }
            #filelist li a {
                width:50px;
                margin: 0 10px 0 0;
           }
            </style>
            <script>
            $(function(){
                /*
                $("#filelist").delegate("a","click",function(e){
                    var obj = $(e.target);
                    obj.closest("li").remove();
                });
                */
            
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
                                if(0 == response.error){
                                    var html = '<li>';
                                    html += '<input type="hidden" name="file_id[]" value="' + response.id + '"/>';
                                    html += '<span>' + file.name  + '</span>';
                                    html += '</div>';
                                    $("#filelist").append(html);
                                }
                            
                            } catch (ex) {
                                this.debug(ex);
                            }
                        }
                    };
                    
                    createSwfUpload(index + 1,$(this).attr("allowSize"),$(this).attr("allowFile"),handler);
                });
            });
            </script>
            
{include file="common/main_footer.tpl"}