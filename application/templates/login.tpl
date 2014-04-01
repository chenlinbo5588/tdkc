<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/css/bootstrap.min.css" rel='stylesheet' type='text/css'>
    <link href="/css/login.css" rel='stylesheet' type='text/css'>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
    <div class="container">
        <form class="form-signin" role="form" name="login-form" action="{url_path('login','submit',array(),true)}" method="post">
            <h2 class="form-signin-heading">万达奴后台系统登录</h2>

            {if (!empty($errorMsg)) }
            <div class="alert alert-warning">{$errorMsg['message']}</div>
            {/if}
            <div class="form-group">
                <label>用户名</label>
                <input type="text" name="username" class="form-control"  value="{$remember_account}" placeholder="用户名">
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" class="form-control"  placeholder="密码">
            </div>
            {*
            <label class="checkbox">
                <input type="checkbox" name="remember-me" value="remember-me" checked="checked"> 记住用户名
            </label>
            *}
            <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
        </form>
    </div>
    {include file="section_footer.tpl"}
</body>
</html>