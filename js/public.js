// 加载谈层
$.loadingbar = function(settings) {
    var defaults = {
        id : "loading",
        urls : [],
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


    /*
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
    
    */


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
            //spin_wrap.show();
        }

        if(state){
            //$.jBox.tip(defaults.text, 'loading');
        }
    });

    $(document).ajaxStop(function(e) {
        //setTimeout(function () { $.jBox.tip('操作完成。', 'success'); }, 0);
    });

    ///return spin_wrap;
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
        if(confirm(text)){
            $.ajax({
                type :"POST",
                dataType:"json",
                url: that.attr('data-href'),
                data : {
                    isajax:"1",
                    id:that.attr('data-id')
                },
                success:ajax_success,
                error:ajax_error
            });
        }
        */
       
       var submit = function (v, h, f) {
            if (v == true){
                $.ajax({
                    type :"POST",
                    dataType:"json",
                    url: that.attr('data-href'),
                    data : {
                        isajax:"1",
                        id:that.attr('data-id')
                    },
                    success:ajax_success,
                    error:ajax_error
                });
            }
            return true;
        };
        // 自定义按钮
        $.jBox.confirm(text, "提示", submit, { buttons: { '确定': true, '取消': false} });
    });
});


function ajax_success(data){
    $.jBox.tip(data.body.text);
    //alert(data.body.text);
    if(data.code == 'success' && data.body.operation == 'delete'){
        var ids = data.body.id.split(',');
        for(var i = 0, j = ids.length; i < j; i++ ){
            $("#row_" + ids[i]).remove();
        }
    }
    
    var runafter = function(){
        if(data.redirectUrl){
            location.href = data.redirectUrl;
        }

        if(data.redirectInfo){
            if(data.redirectInfo.jsReload){
                location.reload();
            }else{
                location.href = data.redirectInfo.url;
            }
        }
    }
    
    if(typeof(data.body.wait) != "undefined"){
        setTimeout(function(){
            runafter();
        },data.body.wait * 1000);
    }else{
        runafter();
    }

}

function ajax_error(xhr, textStatus, errorThrown){
    $.jBox.tip("请求发生错误," + textStatus + "," + errorThrown);
}


function abox(url,title,width,height){
	$.jBox.open("iframe:"+url, title, width, height, {top:'10%', buttons: {}});
}