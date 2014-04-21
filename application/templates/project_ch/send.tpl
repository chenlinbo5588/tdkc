<div class="sendorList">
     <form action="{url_path('project_ch','send')}" method="post" name="sf">
        <input type="hidden" value=""/>
        <div><label>请输入接受人姓名:<input type="text" name="name" value="" /></label></div>
        <ul>
            {foreach from=$sendorList item=item}
            <li><label><input type="radio" name="default_sendor" value="1"/>设为默认</label></li>
            {foreachelse}
            <li>还没有设置发送人，请点击 <a href="{url_path('sendor','add')}">这里</a>进行添加</a></li>
            {/foreach}
        </ul>
        <input type="submit" name="submit" class="btn btn-sm btn-primary" value="发送"/>
     </form>
         
</div>