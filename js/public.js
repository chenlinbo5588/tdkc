// 加载谈层
$.loadingbar = function(settings) {
    var defaults = {
        autoHide:true,
        replaceText:"正在刷新,请稍后...",
        container: 'body',
        showClose: true,
        wrapperClass:'',
        text:'数据加载中，请稍候…'
    };
    var xhr;
    var cfg = $.extend({},defaults,settings);
    var postext;


    if(cfg.container==='body'){
        postext = 'fixed';
    }else{
        postext = 'absolute';
        $(cfg.container).css({position:'relative'});
    }

    var content_tpl = '<div class="loading_box '+cfg.wrapperClass+'"><div class="lightbox-content">\
                        <span class="loading_close">×</span>\
                        <i class="loading_icon">&nbsp;</i><span class="loading_text">'+cfg.text+'</span>\
                        </div></div>';


    var spin_wrap  = $('<div class="lightbox" style="display:none;position:'+postext+'">\
        <table cellspacing="0" class="ct"><tbody><tr><td class="ct_content"></td></tr></tbody></table>\
        </div>');

    spin_wrap.find(".ct_content").html(content_tpl);

    if(!cfg.showClose){
        spin_wrap.find(".loading_close").hide();
    }

    if(0 == $(cfg.container).find("> .lightbox").length){
        $(cfg.container).append(spin_wrap);
    }else{
        spin_wrap = $("> .lightbox",$(cfg.container));
    }

    $(document).ajaxSend(function(event, jqxhr, settings) {
        var surl = settings.url;
        var state = false;
        if(typeof cfg.urls != 'undefined'){
            $.each(cfg.urls,function(i,item){
                if($.type(item) === 'regexp'){
                    if(item.exec(surl)) {
                        state = true;
                        return false;
                    }
                }else if($.type(item) === 'string'){
                    if(item === surl) {
                        state = true;
                        return false;
                    }
                }else{
                    throw new Error('[urls] type error,string or regexp required');
                }
            });
        } else {
            spin_wrap.show();
        }

        if(state){
            spin_wrap.show();
        }

        if(cfg.showClose){
            $('.loading_close').on('click',function(e){
                jqxhr.abort();
                $.active = 0;
                spin_wrap.hide();
                $(this).off('click');
            });
        }
    });

    $(document).ajaxStop(function(e) {
        if(cfg.autoHide){
            spin_wrap.hide();
        }else{
            spin_wrap.find(".loading_text").html(cfg.replaceText);
        }
    });

    return spin_wrap;
};

function pageJs(num) {
	var url = location.href;
	url = url.replace(/#/, '');
	re = /(\?|&)page=[0-9]*/;
	
	if(url.match(re)) {
		url = url.replace(/page=[0-9]*/, 'page=' + num);
	}
	else if(-1 == url.indexOf('?')) {
		url += '?page=' + num;
	}
	else {
		url += '&page=' + num;
	}
	location.href = url;
}


/**
 * 公共删除逻辑
 */
$(function(){
    $.loadingbar({
        'url' : [new RegExp("\&m=delete")]
    });

    $(".delete").bind("click",function(){
        var s = $(this).attr('data-title');
        var that = $(this);
        if(!s){
            s = '';
        }
        var text = "确定要删除 " + s + " 吗";
        
        /*
         *$("#replaceTxt").html(text);
		var dialog = $("#dialog-confirm" ).dialog({
			resizable: false,
			
			modal: true,
			buttons: {
				"确定" : function() {
                    dialog.dialog( "close" );
                    $.ajax({
                        type :"POST",
                        dataType:"json",
                        url: that.attr('data-href'),
                        data : {
                            isajax:"1",
                            id:that.attr('data-id')
                        },
                        success:function(data){
                            dialog.dialog( "close" );
                            $( "#dialog p" ).html(data.body.text);
                            $( "#dialog").dialog({
                                modal: true
                            });
            
                            if(data.code == 'success'){
                                var ids = data.body.id.split(',');
                                for(var i = 0, j = ids.length; i < j; i++ ){
                                    $("#row_" + ids[i]).remove();
                                }
                            }
                            
                            if(data.redirectUrl){
                                location.href = redirectUrl;
                            }
                        },
                        error:function(xhr, textStatus, errorThrown){
                            $( "#dialog p" ).html("请求错误");
                            $( "#dialog").dialog({
                                modal: true
                            });
                        }
                    });
				},
				"取消": function() {
					$( this ).dialog( "close" );
				}
			}
		});
        */
    
    
        if(confirm(text)){
            $.ajax({
                type :"POST",
                dataType:"json",
                url: that.attr('data-href'),
                data : {
                    isajax:"1",
                    id:that.attr('data-id')
                },
                success:function(data){
                    alert(data.body.text);
                    
                    if(data.code == 'success'){
                        var ids = data.body.id.split(',');
                        for(var i = 0, j = ids.length; i < j; i++ ){
                            $("#row_" + ids[i]).remove();
                        }
                    }

                    if(data.redirectUrl){
                        location.href = redirectUrl;
                    }
                },
                error:function(xhr, textStatus, errorThrown){
                    alert("请求发生错误," + textStatus);
                }
            });
        }
    });
});