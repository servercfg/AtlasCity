window.addEventListener('message', function (event) {

	switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            $("#boxSetHealth").css("width", event.data.health + "%");
            $("#boxSetArmour").css("width", event.data.armour + "%");

            widthHeightSplit(event.data.hunger, $("#boxSetHunger"));
            widthHeightSplit(event.data.thirst, $("#boxSetThirst"));
            widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
            widthHeightSplit(event.data.stress, $("#boxSetStress"));
            widthHeightSplit(event.data.stamina, $("#boxSetStamina"));
        case 'set-voice':
            widthHeightSplitvoice(event.data.value, $("#boxSetVoice"));
            break;
        case 'voice-color':
            if (event.data.isTalking) {
                $('#boxSetVoice').addClass('active');
            } else {
                $('#boxSetVoice').removeClass('active');
            }
        break;
        case 'hidecar':
            $('.car').fadeOut();
            $(".car").css("display", "none");
            break;
        case 'showcar':
            $('.car').fadeIn();
            $(".car").css("display", "block");
            break;
        case 'tick':
            if (event.data.speed < 10) {
                $('.speed-val').html('00' + event.data.speed);
            } else if (event.data.speed < 100 && event.data.speed >= 10) {
                $('.speed-val').html('0' + event.data.speed);
            } else {
                $('.speed-val').html(event.data.speed);
            }

            $('.measurement-val').html(event.data.sign);

            if (event.data.speed >= 100) {
                $('.speed-val').addClass('fast');
            } else {
                $('.speed-val').removeClass('fast');
            }

            $('.clock').html(event.data.time + ' <span class="ampm">' + event.data.ampm + '</span>');

            if (event.data.street2 !== '') {
                $('.position').html(event.data.direction + ' <span class="seperator">|</span> ' + event.data.street1 + ' <span class="seperator2">-</span> ' + event.data.street2 + ' <span class="seperator">|</span> ' + event.data.area);
            } else {
                $('.position').html(event.data.direction + ' <span class="seperator">|</span> ' + event.data.street1 + ' <span class="seperator">|</span> ' + event.data.area);
            }
            break;
    }
});

function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};
function widthHeightSplitvoice(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
    if(eleHeight == 30){
        ele.css("background", "#fcf8f3");
    }else if(eleHeight >30 && eleHeight<40){
        ele.css("background", "transparent");
    }else{
        ele.css("background", "#fcf8f3");
    }
};