<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录-{$TITLE|escape}</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <style type="text/css">
    <!--
    body {
        margin-left: 0px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
        overflow:hidden;
    }
    .STYLE3 { color: #528311; font-size: 12px; }
    .STYLE4 {
        color: #42870a;
        font-size: 12px;
    }
    -->
    </style>
    {*
    <!--[if IE 6]>
    <script type="text/javascript" src="/js/DD_belatedPNG.js"></script>
    <script>DD_belatedPNG.fix(".pngfix");</script>
    <![endif]-->
    *}
</head>
<body>
    <form class="form-signin" role="form" name="login-form" action="{url_path('login','submit','',true)}" method="post">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#e5f6cf">&nbsp;</td>
  </tr>
  <tr>
    <td height="608" background="/img/login/login_03.gif"><table width="862" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="266" background="/img/login/login_04.gif">&nbsp;</td>
      </tr>
      <tr>
        <td height="95"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="424" height="95" background="/img/login/login_06.gif">&nbsp;</td>
            <td width="183" background="/img/login/login_07.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="21%" height="30"><div align="center"><span class="STYLE3">用户</span></div></td>
                <td width="79%" height="30"><input type="text" name="username" value="{$smarty.post.username}" style="height:18px; width:130px; border:solid 1px #cadcb2; font-size:12px; color:#81b432;"></td>
              </tr>
              <tr>
                <td height="30"><div align="center"><span class="STYLE3">密码</span></div></td>
                <td height="30"><input type="password" name="password"  style="height:18px; width:130px; border:solid 1px #cadcb2; font-size:12px; color:#81b432;"></td>
              </tr>
              <tr>
                <td height="30">&nbsp;</td>
                <td height="30"><button class="btn btn-lg btn-primary btn-block" type="submit">登录</button></td>
              </tr>
            </table></td>
            <td width="255" background="/img/login/login_08.gif">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="247" valign="top" background="/img/login/login_09.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="22%" height="30">&nbsp;</td>
            <td width="56%">&nbsp;</td>
            <td width="22%">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="44%" height="20">&nbsp;</td>
                <td width="56%" class="STYLE4">版本 2014 V1.0 </td>
              </tr>
            </table></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td bgcolor="#a2d962">&nbsp;</td>
  </tr>
</table>
</form>
    <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
    <script>
    {if (!empty($errorMsg)) }
        $(function(){
            alert("{$errorMsg['message']}");
         });
    {/if}
    </script>    
    <!--[if lte IE 9]>
    <script src="/js/jquery.placeholder.1.3.js"></script>
    <script>
        $(function(){
            $.Placeholder.init();
        });
    </script>
    <![endif]-->
</body>
</html>