    {if $eventCount != 0 }
        <script type="x-my-template" id="eventTemplate">
            <div>
                <p>您有{$eventCount}的个待办事宜</p>
                <p><a href="{url_path('my_event')}&status={urlencode('未处理')}">去处理</a></p>
            </div>
        </script>
        <script>
            $(function(){
                setTimeout(function(){
                    $.jBox.messager($("#eventTemplate").html(), '待办提醒',10000);
                },2000);
            });
        </script>    
    {/if}
    </div>
</body>
</html>