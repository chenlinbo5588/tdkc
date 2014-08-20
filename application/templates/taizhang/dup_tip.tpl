{if $dupTips}
<script>
$(function(){

    var submit = function (v, h, f) {
        if (v == 'ok') {
            $("input[name=submit]").trigger("click");
        }
        
        return true;
    };

    $.jBox.confirm( "{$dupTips}","温馨提示",submit);
});
</script>
{/if}