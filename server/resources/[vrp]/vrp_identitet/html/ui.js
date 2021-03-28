$(function () {
    window.addEventListener('message', function (event) {
        var ui = event.data
        if (ui.show == true) {
            $("#money").html(ui.money);
            $("#bank").html(ui.bank);
            $("#id").html(ui.id);
            $("#job").html(ui.job);
            $(".container").css("display","block");
        } else if (ui.show == false) {
            $(".container").css("display","none");
        }
    })
})