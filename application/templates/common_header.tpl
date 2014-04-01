<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{$TITLE}</title>
    <meta name="keywords" content="{$KEYWORDS}">
    <meta name="description" content="{$DESCRIPTION}">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    {foreach from=$cssFiles item=cssItem}<link href="css/{$cssItem}.css" rel='stylesheet' type='text/css'>
    {/foreach}<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
    <header>
        <div id="top_bar">
            <div class="content-wrapper">
                <nav>
                    <ul class="menu clearfix">
                        <li class="first"><a id="logo"></a></li>
                        <li><a {if $top_menu == '首页'}class="active"{/if} href="{url_path('index','index',array(),true)}">首页</a></li>
                        <li><a {if $top_menu == '品牌形象'}class="active"{/if} href="{url_path('index','brand',array(),true)}">品牌形象</a></li>
                        <li><a {if $top_menu == '联系我们'}class="active"{/if} href="{url_path('index','contact_us',array(),true)}">联系我们</a></li>
                        <li><a {if $top_menu == '人才招聘'}class="active"{/if} href="{url_path('index','advertise',array(),true)}">人才招聘</a></li>
                        <li class="last"><a href="javascript:void(0)">IR&nbsp;|&nbsp;English</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
    <section>
        <div class="main-body">
            <div class="logo-bg">
                <div class="content-wrapper">