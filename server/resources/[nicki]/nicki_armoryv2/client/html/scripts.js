$(document).ready(function () {
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
      openHome();
    }
    if (item.show == false) {
      close()
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://nicki_armoryv2/close', JSON.stringify({}));
    }
  };
  $(".pistol").click(function () {
    $.post('http://nicki_armoryv2/pistol', JSON.stringify({}));
  });
  $(".smg").click(function () {
    $.post('http://nicki_armoryv2/smg', JSON.stringify({}));
  });
  $(".carbine").click(function () {
    $.post('http://nicki_armoryv2/carbine', JSON.stringify({}));
  });
  $(".tazer").click(function () {
    $.post('http://nicki_armoryv2/tazer', JSON.stringify({}));
  });
  $(".stav").click(function () {
    $.post('http://nicki_armoryv2/stav', JSON.stringify({}));
  });
});

function open() {
  $(".container").fadeIn();
}

function close() {
  $(".container").css("display", "none");
  $("#buttons").css("display", "none");
}

function openHome() {
  $(".container").fadeIn();
  $("#buttons").css("display", "block");
}