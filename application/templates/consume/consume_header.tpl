        <div class="filebar" >
            <a href="{url_path('consume','index')}" class="btn {if $action == 'index'}active{/if}">当前库存</a>
            <a href="{url_path('consume','in')}" class="btn {if $action == 'in'}active{/if}">进库管理</a>
            <a href="{url_path('consume','out')}" class="btn {if $action == 'out'}active{/if}">出库管理</a>
        </div>