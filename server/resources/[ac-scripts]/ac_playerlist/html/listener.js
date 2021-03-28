$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#wrap');
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
		document.getElementById("ptbl").innerHTML = "<tr class=\"logo\"><td colspan=\"5\"><center><img src=\"https://cdn.discordapp.com/attachments/629259596816580628/773589062333366272/Untitled-1.png\"></center></td></tr>" +  item.text;
        $('#wrap').show();
    }, false);
});