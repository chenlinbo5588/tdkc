<!DOCTYPE html>
<html>
    <head>
        <title>规划数据转换程序</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        {include file="zb_trans_gh/trans_header.tpl"}
    </head>
    <body>
        <h1 class="title">数据转换 最后一步 (Step3)</h1>
        <div class="info">
            <div>{$message}</div>
            <div>请复制下面的文字</div>
       </div>
       
       {if $warning}
       <div class="warning">
            {foreach from=$warning item=item}
                <div>{$item}</div>
            {/foreach}
       </div>
       {/if}
       
        <div class="example">
        <textarea style="width:800px;height:600px;">
[属性描述]
格式版本号=
数据产生单位=慈溪市国土资源局
数据产生日期={$smarty.now|date_format:"Y-n-j"}
坐标系=80国家大地坐标系
几度分带=3
投影类型=高斯克吕格
计量单位=米
带号=40
精度=0.001
转换参数=,,,,,,
[地块坐标]
{foreach from=$txt item=item}
{$item}
{foreachelse}找不到数据{/foreach}</textarea>
        </div>
    </body>
</html>