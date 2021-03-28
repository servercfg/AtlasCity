$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var $debug = $("#debug");
        var $heal = $("#voice");
        var data = event.data;
        
        $(".container").css("display",data.show? "none":"block");
        $("#boxVoice").css("width",data.heal + "%");
        
        if (event.data.action == "close") {
            updateClose();
        }
        else if (event.data.action == "open") {
            updateOpen();
        }

        if (event.data.talking == true) 
            { $("#boxVoice").css("background", "#bd5eff") }
        else if (event.data.talking == false)
            { $("#boxVoice").css("background", "#deafff") }
    })
})


function updateClose(){
     $('#boxVoice').css('display', 'none')
     $('#voice').css('display', 'none')
}

function updateOpen(){
     $('#boxVoice').css('display', 'block')
     $('#voice').css('display', 'block')
}