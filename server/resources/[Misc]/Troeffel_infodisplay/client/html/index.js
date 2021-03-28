/*
────────────────────────────────────────────────────────────────────────────────
─██████──██████─████████───██████──────────██████─████████████───██████████████─
─██░░██──██░░██─██░░░░██───██░░██████████──██░░██─██░░░░░░░░████─██░░░░░░░░░░██─
─██░░██──██░░██─████░░██───██░░░░░░░░░░██──██░░██─██░░████░░░░██─██░░██████████─
─██░░██──██░░██───██░░██───██░░██████░░██──██░░██─██░░██──██░░██─██░░██─────────
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██░░██████████─
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██─
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██████████░░██─
─██░░░░██░░░░██───██░░██───██░░██──██░░██████░░██─██░░██──██░░██─────────██░░██─
─████░░░░░░████─████░░████─██░░██──██░░░░░░░░░░██─██░░████░░░░██─██████████░░██─
───████░░████───██░░░░░░██─██░░██──██████████░░██─██░░░░░░░░████─██░░░░░░░░░░██─
─────██████─────██████████─██████──────────██████─████████████───██████████████─
────────────────────────────────────────────────────────────────────────────────
Discord: V1NDs#0977
Steam: http://steamcommunity.com/id/V1NDs
Youtube: https://www.youtube.com/channel/UCaBZGvYryg09IS-uaSHyfPw
Github: https://github.com/V1NDs
*/

$(document).ready(function() {

    function display(bool) {
        if (bool) {
            $('.bars-container').show();
        } else {
            $('.bars-container').hide();
        }
    }

    display(false)

    $(function () {
        window.addEventListener('message', function (event) {
            var item = event.data;
            if (item.type === 'ui') {
                if (item.status == true) {
                    display(true)
                    $('.bars-container > .wallet-bar > h3').text(`${item.walletAmount} DKK`);
                    $('.bars-container > .bank-bar > h3').text(`${item.bankAmount} DKK`);
                    $('.bars-container > .dirtymoney-bar > h3').text(`${item.dirtymoneyAmount} DKK`);
                    $('.bars-container > .identity-bar > h3').text(item.userIdentityen);
                }
                if (item.status == false) {
                    display(false)
                }
            }
        })
    });
    
});