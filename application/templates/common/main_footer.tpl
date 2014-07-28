    {if $eventCount != 0 }
        <script>
            $(function(){
                $("body").append($("#eventTemplate").html());
                
                var $daiban = "{$eventCount}个待办事宜", $daibanEle = $('<a id="daiban" href="{url_path('my_event')}&status={urlencode('未处理')}"></a>').appendTo($("body"))
                    .text($daiban).attr("title", $daiban).click(function() {
                        $("html, body").animate({ scrollTop: 0 }, 120);
                }),$backToTopFun = function() {
                    var st = $(document).scrollTop(), winh = $(window).height();
                    //IE6下的定位
                    $daibanEle.show();
                    if (!window.XMLHttpRequest) {
                        $daibanEle.css("top", st + winh - 166);    
                    }
                };
                $(window).bind("scroll", $backToTopFun);
                $(function() { $backToTopFun(); });
                /**
                setTimeout(function(){
                    $.jBox.messager($("#eventTemplate").html(), '待办提醒',10000);
                },2000);
                */
            });
        </script>    
    {/if}
    </div>
</body>
</html>