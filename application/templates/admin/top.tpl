<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$TITLE}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="keywords" content="{$KEYWORDS}">
<meta name="description" content="{$DESCRIPTION}">
<link href="/css/base.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
<script>
var preFrameW = '206,*';
var FrameHide = 0;
var curStyle = 1;
var totalItem = 9;
function ChangeMenu(way){
	var addwidth = 10;
	var fcol = top.document.all.btFrame.cols;
	if(way==1) addwidth = 10;
	else if(way==-1) addwidth = -10;
	else if(way==0){
		if(FrameHide == 0){
			preFrameW = top.document.all.btFrame.cols;
			top.document.all.btFrame.cols = '0,*';
			FrameHide = 1;
			return;
		}else{
			top.document.all.btFrame.cols = preFrameW;
			FrameHide = 0;
			return;
		}
	}
	fcols = fcol.split(',');
	fcols[0] = parseInt(fcols[0]) + addwidth;
	top.document.all.btFrame.cols = fcols[0]+',*';
}


function mv(selobj,moveout,itemnum)
{
   if(itemnum==curStyle) return false;
   if(moveout=='m') selobj.className = 'itemsel';
   if(moveout=='o') selobj.className = 'item';
   return true;
}

function changeSel(itemnum)
{
  curStyle = itemnum;
  for(i=1;i<=totalItem;i++)
  {
     if(document.getElementById('item'+i)) document.getElementById('item'+i).className='item';
  }
  document.getElementById('item'+itemnum).className='itemsel';
}

</script>
<style>
#tpa {
	color: #009933;
	margin:4px 0 0;
	padding:0px;
	float:right;
	padding-right:10px;
}

#tpa dd {
	margin:0px;
	padding:0px;
	float:left;
	margin-right:2px;
}

#tpa dd.ditem {
	margin-right:8px;
}

#tpa dd.img {
  padding-top:6px;
}

div.item
{
  text-align:center;
	background:url(/img/frame/topitembg.gif) 0px 3px no-repeat;
	width:82px;
	height:26px;
	line-height:28px;
}

.itemsel {
  width:80px;
  text-align:center;
  background:#226411;
	border-left:1px solid #c5f097;
	border-right:1px solid #c5f097;
	border-top:1px solid #c5f097;
	height:26px;
	line-height:28px;
}

*html .itemsel {
	height:26px;
	line-height:26px;
}

a:link,a:visited {
 text-decoration: underline;
}

.item a:link, .item a:visited {
	font-size: 12px;
	color: #ffffff;
	text-decoration: none;
	font-weight: bold;
}

.itemsel a:hover {
	color: #ffffff;
	border-bottom:2px solid #E9FC65;
}

.itemsel a:link, .itemsel a:visited {
	font-size: 12px;
	color: #ffffff;
	text-decoration: none;
	font-weight: bold;
}

.rmain {
  padding-left:10px;
  /* background:url(/img/frame/toprightbg.gif) no-repeat; */
}

.logotext {
    padding:5px;
}
</style>
</head>
<body bgColor='#ffffff'>
<div style="position: relative;">
    {if $notice}
    <div style="position:absolute;width:400px;top:30px;">
        <marquee scrollamount="2" scrolldelay="10" align="top">{$notice['title']|escape}</marquee>
    </div>
    {/if}
    <table width="100%" border="0" cellpadding="0" cellspacing="0" background="/img/frame/topbg.gif">
    <tr>
        <td width='20%' height="60">{*<img src="/img/frame/logo.gif" />*}<h1 class="logotext">{$TITLE|escape}</h1></td>
        <td width='80%' align="right" valign="bottom">
            <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td align="right" height="26" style="padding-right:10px;line-height:26px;">
                您好：<span class="username">{$userProfile['name']}</span>，
                [<a style="color:#f00;" href="{url_path('pm','receive')}" target="main"><span id="newmsg">新消息({$messageCount})</span></a>]
                [<a href="{url_path('admin','change_password')}" target="main">修改密码</a>]
                [<a href="{url_path('logout')}" target="_top">注销退出</a>]&nbsp;
        </td>
        </tr>
        <tr>
            <td align="right" height="34" class="rmain">
            <dl id="tpa">
            {*<dd class='img'><a href="javascript:ChangeMenu(-1);"><img vspace="5" src="/img/frame/arrl.gif" border="0" width="5" height="8" alt="缩小左框架"  title="缩小左框架" /></a></dd>*}
            <dd class='img' style="margin-right:10px;"><a href="javascript:ChangeMenu(0);"><img vspace="3" src="/img/frame/arrfc.gif" border="0" width="12" height="12" alt="显示/隐藏左框架" title="显示/隐藏左框架" /></a></dd>
            {*<dd class='img' style="margin-right:10px;"><a href="javascript:ChangeMenu(1);"><img vspace="5" src="/img/frame/arrr.gif" border="0" width="5" height="8" alt="增大左框架" title="增大左框架" /></a></dd>*}
            <dd><div class="itemsel" id="item1"><a href="{url_path('admin')}" onclick="changeSel(1)" target="_top">首页</a></div></dd>
            {auth name="personal"}<dd><div class="item" id="item2"><a href="{url_path('personal')}" onclick="changeSel(2)" target="menu">个人办公</a></div></dd>{/auth}
            {auth name="project"}<dd><div class="item" id="item3"><a href="{url_path('project')}" onclick="changeSel(3)" target="menu">测绘项目</a></div></dd>{/auth}
            {auth name="project+guihua"}<dd><div class="item" id="item4"><a href="{url_path('project','guihua')}" onclick="changeSel(4)" target="menu">规划项目</a></div></dd>{/auth}
            {auth name="office"}<dd><div class="item" id="item5"><a href="{url_path('office')}" onclick="changeSel(5)" target="menu">办公室</a></div></dd>{/auth}
            {auth name="info"}<dd><div class="item" id="item6"><a href="{url_path('info')}" onclick="changeSel(6)" target="menu">信息中心</a></div></dd>{/auth}
            {auth name="system"}<dd><div class="item" id="item7"><a href="{url_path('system')}" onclick="changeSel(7)" target="menu">系统管理</a></div></dd>{/auth}
            </dl>
            </td>
        </tr>
        </table></td>
    </tr>
    </table>
</div>
<script>
    var rotate = 0;
    var shakTitle = null;
    var reqList = [];
    function checkNewMsg(){
        if(reqList.length){
            return;
        }
    
        var ajax = $.ajax({
            type:"GET",
            url:"{url_path('search','getNewMsg')}",
            data : {
                uid : "{$userProfile['id']}"
            },
            dataType:"json",
            success:function(sd){
                $("#newmsg").html("新消息(" + sd.newcount + ")");
                if(sd.newcount){
                    if(shakTitle){
                        clearInterval(shakTitle);
                    }
                    shakTitle = setInterval(function(){
                        if(rotate % 2){
                            top.document.title = "【　　　】";
                        }else{
                            top.document.title = "【新消息】"
                        }
                        rotate++;

                        if(rotate > 100000){
                            rotate = 0;
                        }
                    },1000);
                }else{
                    if(shakTitle){
                        clearInterval(shakTitle);
                    }
                    top.document.title = "{$TITLE}";
                }
            },
            complete:function(){
                rotate = 0;
                reqList.pop();
            },
            error:function(){
                rotate = 0;
                reqList.pop();
            }
        });
        
        reqList.push(ajax);
    }

    {if $messageCount}
    checkNewMsg();
    {/if}

    $(function(){
        setInterval(function(){
            checkNewMsg();
        },1000 * 60);
    });
</script>            
</body>
</html>