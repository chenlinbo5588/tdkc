<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="{$KEYWORDS}">
<meta name="description" content="{$DESCRIPTION}">
<meta name="author" content="linbo.chen">
<link rel="shortcut icon" href="/favicon.ico">
<title>{$TITLE}</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/layoutit.css" rel="stylesheet">
<link href="/css/redmond/jquery-ui-1.10.4.custom.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
<![endif]-->

<!-- Fav and touch icons -->
<link rel="shortcut icon" href="/img/favicon.png">
<script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/js/jquery-ui-1.10.4.custom.js"></script>
<script src="/js/json2.js"></script>
<script src="/js/public.js"></script>
    
<!--[if lte IE 9]>
<script src="/js/jquery.placeholder.1.3.{$js_compress}js"></script>
<script>
    $(function(){
        $.Placeholder.init();
    });
</script>
<![endif]-->
</head>
<body>
<div id="dialog" title="操作提示" style="display:none;">
	<p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>
</div>
    
<div id="dialog-confirm" title="确认提示?" style="display:none;">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><span id="replaceTxt"></span></p>
</div>
    
{include file="common/menu.tpl"}