          <h1 class="page-header">{$sideMenuName}</h1>
          <div class="row placeholders">
            <ul class="nav nav-pills">
                <li><a href="javascript:history.go(-1);">返回</a></li>
             </ul>
          </div>

          <div class="table-responsive">
            {if $message['feedback'] }
            <div id="feedback" class="alert alert-{$message['className']}">{$message['feedback']}</div>
            <script>
                $(function(){
                    setTimeout(function(){
                        $("#feedback").fadeOut(function(){
                            $(this).remove();
                        });
                    },3000);
                });
            </script>
            {/if}
            <form role="form" name="addForm" action="{url_path('shop','save',array(),true)}" method="post">
                <div class="form-group">
                    {if $action == 'edit' }
                    <input type="hidden" id="shop_id" name="shop_id" value="{$shopInfo['shop_id']}" />
                    {/if}
                    <label for="shop_name">店铺名称</label>
                    <input type="text" class="form-control" name="shop_name" value="{$shopInfo['shop_name']}" id="shop_name" data-required style="width:400px;" placeholder="请输入店铺名称，最多100个汉字"/>
                </div>
                <div class="form-group">
                    <label for="address">店铺地址</label>
                    <input type="text" class="form-control" name="address" value="{$shopInfo['address']}" style="width:400px;" data-required id="address" placeholder="店铺地址，最多100个汉字"/>
                </div>
                <div class="form-group">
                    <label for="manager">负责人</label>
                    <input type="text" class="form-control" name="manager" value="{$shopInfo['address']}" style="width:400px;" id="manager" placeholder="请填写负责人名称"/>
                    {*<p class="help-block">Example block-level help text here.</p>*}
                </div>
                <div class="form-group">
                    <label for="mobile">手机号码</label>
                    <input type="text" class="form-control" name="mobile" value="{$shopInfo['mobile']}" style="width:400px;" id="mobile"  placeholder="请填写手机号码"/>
                </div>
                <div class="form-group">
                    <label for="tel">固定电话</label>
                    <input type="text" class="form-control" name="tel" style="width:400px;" id="tel" placeholder="请填写固定电话"/>
                    {*<p class="help-block">Example block-level help text here.</p>*}
                </div>
                <div class="form-group">
                    <label>店铺图片</label>
                    <p class="help-block" style="color:red">请上传JPG或者JPEG图片，单张上传图片最大500K.</p>
                    <em class="Uploader" allowSize="500KB" allowFile="*.jpg;*.jpeg;"></em>
                    <a class="upload-button" href="javascript:void(0);"><span id="UploaderPlaceholder_1"></span></a>
                    <div id="UploaderProgress_1"></div>
                    <div id="UploaderFeedBack_1"></div>
                </div>
                <button type="submit" class="btn btn-primary">保存</button>
                <div class="row" id="picList">
                    {foreach from=$shopInfo['images'] item=pic}
                    <div class="col-xs-6 col-md-3">';
                        <input type="hidden" name="file_id[]" value="{$pic['aid']}"/>
                        <a href="javascript:void(0);" class="thumbnail"><img src="/img/Files/{$pic['path']}" alt="点击图片删除"></a>
                     </div>';
                    {/foreach}
                </div>
                </form>
          </div>
          
          <script src="/js/jquery-validate.js"></script>
        {include file="common_upload.tpl"}
		<script>
            var action = '{$action}';
            $.loadingbar({
                urls:[new RegExp("deleteShopImg")],text:"操作进行中，请稍等"
            });
			$('form[name=addForm]').validate({
				onKeyup : true,
				eachValidField : function() {
					$(this).closest('div').removeClass('has-error').addClass('has-success');
				},
				eachInvalidField : function() {
					$(this).closest('div').removeClass('has-success').addClass('has-error');
				}
			});
            
            $("#picList").delegate("a","click",function(e){
                var target = $(e.target);
                
                if(confirm("确定要删除该图片吗")){
                    if(action == 'add'){
                        target.closest("div").remove();
                    }else{
                        $.ajax({
                            type:"POST",
                            url:'{url_path('shop','deleteShopImg',array(),true)}',
                            data: {
                                id:$("#shop_id").val(),file_id:target.closest("div").find("input").val()
                            },
                            dataType:"json",
                            success:function(resp){
                                if(resp.code == 200){
                                    target.closest("div").remove();
                                }else{
                                    alert("删除失败,请重新尝试");
                                }
                            }
                        });
                    }
                }
            });
		
            $(function(){
                var fileSuccess = function(file, serverData){
                    var response = $.parseJSON(serverData);
                    console.log(serverData);
                    if(0 == response.error){
                        var html = '<div class="col-xs-6 col-md-3">';
                        html += '<input type="hidden" name="file_id[]" value="' + response.id + '"/>';
                        html += '<a href="javascript:void(0);" class="thumbnail"><img src="' + response.url  + '" alt="点击图片删除"></a>'
                        html += '</div>';
                        $("#picList").append(html);
                    }
                    
                    try {
                        var progress = new FileProgress(file, this.customSettings.progressTarget);
                        progress.setComplete();
                        progress.setStatus("Complete.");
                        progress.toggleCancel(false);

                        if(typeof(this.customSettings.callback) != "undefined"){
                            this.customSettings.callback(file,serverData);
                        }
                        
                    } catch (ex) {
                        this.debug(ex);
                    }
    
                }
            
                $(".Uploader").each(function(index){
                    createSwfUpload(index + 1,$(this).attr("allowSize"),$(this).attr("allowFile"),fileSuccess);
                });
            });
        </script>
        