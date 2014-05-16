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
    
     $("input[name=jumpPage]").keydown(function(event){
　　　　 // 注意此处不要用keypress方法，否则不能禁用　Ctrl+V 与　Ctrl+V,具体原因请自行查找keyPress与keyDown区分，十分重要，请细查
        if ($.browser.msie) {  // 判断浏览器
            if ( ((event.keyCode > 47) && (event.keyCode < 58)) || ((event.keyCode >= 96) && (event.keyCode <= 105)) || (event.keyCode == 8) ) { 　// 判断键值  
                return true;  
            } else { 
                return false;  
            }
        } else {  
            if ( ((event.which > 47) && (event.which < 58)) || ((event.keyCode >= 96) && (event.keyCode <= 105)) || (event.which == 8) || (event.keyCode == 17) ) {  
                    return true;  
            } else {  
                    return false;  
            }  
        }}).focus(function() {
        
        
        this.style.imeMode='disabled';   // 禁用输入法,禁止输入中文字符
    });
    
    $("input.jumpBtn").bind("click",function(e){
       pageJs($(e.target).closest("strong").find("input[name=jumpPage]").val());
    });

    $(".delete").bind("click",function(){
        var s = $(this).attr('data-title');
        var that = $(this);
        if(!s){
            s = '';
        }
        var text = "确定要删除 " + s + " 吗";
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


function selAll(name){
    $("input[name='" +  name + "']").each(function(){
       if(!$(this).prop("checked")){
           $(this).prop("checked",true);
       }
    });
}

function noSelAll(name){
    $("input[name='" +  name + "']").each(function(){
       if($(this).prop("checked")){
           $(this).prop("checked",false);
       }
    });
}



function refresh(reload,sec){
    if(reload){
        if(!sec){
            sec = 3;
        }
        setTimeout(function(){
            location.reload();
        },sec * 1000)
        
    }
}

function showConfirm(message,reload,sec,title,width,height){
    title = title ? title : '提示';
    width = width ? width : 'auto';
    height = height ? height : 'auto';
    
    $.jBox.open(message,"提示",'auto','auto',{buttons: {} , closed:function(){
         if(reload){
             location.reload();
         }
    }});
    
    refresh(reload,sec);
}

function showInfo(message,reload,sec){
    $.jBox.info(message,"提示");
    refresh(reload,sec);
}

function showSuccess(message,reload,sec){
    $.jBox.success(message,"提示");
    refresh(reload,sec);
}

function showError(message,reload,sec){
    $.jBox.error(message,"提示");
    refresh(reload,sec);
}



$(function() {
    var $backToTopTxt = "返回顶部", $backToTopEle = $('<div class="backToTop"></div>').appendTo($("body"))
        .text($backToTopTxt).attr("title", $backToTopTxt).click(function() {
            $("html, body").animate({ scrollTop: 0 }, 120);
    }), $backToTopFun = function() {
        var st = $(document).scrollTop(), winh = $(window).height();
        (st > 0)? $backToTopEle.show(): $backToTopEle.hide();    
        //IE6下的定位
        if (!window.XMLHttpRequest) {
            $backToTopEle.css("top", st + winh - 166);    
        }
    };
    $(window).bind("scroll", $backToTopFun);
    $(function() { $backToTopFun(); });
    
    
    $("body").delegate(".toggle","click",function(){
        var that = $(this),
            t = that,
            textFilter = t, 
            temp,
            i,j,
            noslide,
            tags = ['th','tr','td','table','tbody','thead','tfooter'];

        if(that.attr("data-toggle")){
            o = $.parseJSON(that.attr("data-toggle"));
        }else{
            o = $.parseJSON(that.attr("toggle"));
        }

        if(o.filer){
            t = $(o.filter,that);
        }

        if(o.textFilter) {
            textFilter = $(o.textFilter,that); 
        }

        temp = $(o.target).get(0);
        noslide = false;

        for(i = 0, j = tags.length; i < j; i++){
            if(temp && (temp.tagName.toLowerCase() == tags[i])){
                noslide = true;
                break;
            }
        }

        if(noslide){
            if(o.wrapper){
                $(o.target,that.closest(o.wrapper)).toggle();
            }else{
                $(o.target).toggle();
            }

        }else{
            if(o.wrapper){
                $(o.target,that.closest(o.wrapper)).slideToggle("normal");
            }else{
                $(o.target).slideToggle("normal");
            }
        }

        /* 折叠 toggle_trigger */
        if(o.toggleSelfClass){
            if(typeof(o.toggleSelfClass) == "string"){
                that.toggleClass(o.toggleSelfClass);
            }else{
                if(that.hasClass(o.toggleSelfClass[0])){
                    that.removeClass(o.toggleSelfClass[0]).addClass(o.toggleSelfClass[1]);
                }else{
                    that.removeClass(o.toggleSelfClass[1]).addClass(o.toggleSelfClass[0]);
                }
            }
        }

        if(o.toggleParentClass){

        }

        /* 折叠触发者 */
        if(o.toggleClass){
            if(typeof(o.toggleClass) == "string"){
                t.toggleClass(o.toggleClass);
            }else{
                if(t.hasClass(o.toggleClass[0])){
                    t.removeClass(o.toggleClass[0]).addClass(o.toggleClass[1]);
                }else{
                    t.removeClass(o.toggleClass[1]).addClass(o.toggleClass[0]);
                }
            }
        }

        /* 切换触发者文本 */
        if(o.toggleText){
            if(textFilter.html() == o.toggleText[0]){
                textFilter.html(o.toggleText[1]);
            }else{
                textFilter.html(o.toggleText[0]);
            }
        }
    });
    
    
});
