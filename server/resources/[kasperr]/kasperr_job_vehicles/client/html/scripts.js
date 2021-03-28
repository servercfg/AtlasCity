/*
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
*/

var garageID = null;
var vehicleID = null;

$(document).ready(function () {
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
      openHome(item.garage);
    }
    if (item.show == false) {
      close();
    }
    if (item.garageID) {
      garageID = item.garageID;
    }
    if (item.garage) {
      $("#vehicles").empty();
      item.garage.vehicles.forEach(function (element, index) {
        $("#vehicles").append(`<button onclick="setVehicle(this, ${index + 1})">${element.displayname}</button>`);
      });
    }
    if (item.details) {
      $("#details").css("display", "block");
      $("#details .displayname").html(item.displayname);
      $("#details .model").html(item.model);
      $("#details .maxspeed").html(item.maxspeed);
      $("#details .billed").attr("src", item.billed);
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://kasperr_job_vehicles/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://kasperr_job_vehicles/close', JSON.stringify({}));
  });
});

function open() {
  $(".container").fadeIn();
}
function close() {
  $(".container").fadeOut();
  $("#home").css("display", "none");
  $("#details").css("display", "none");
  $("#vehicles button").css("background-color", "rgb(20, 20, 20)");
  garageID = null;
  vehicleID = null;
}
function openHome() {
  $("#home").css("display", "block");
  $("#keybinds").css("display", "none");
  $("#rules").css("display", "none");
  $("#info").css("display", "none");
  $(".nav-item").attr("class", "nav-item");
  $("#btnHome").attr("class", "nav-item active");
}
function setVehicle(element, vehID) {
  vehicleID = vehID;
  $("#vehicles button").css("background-color", "rgb(20, 20, 20)");
  $(element).css("background-color", "#45a5ef");
}
function spawnVehicle() {
  if (vehicleID && garageID) {
    $.post('http://kasperr_job_vehicles/getVehicle', JSON.stringify({
      vehicleID: vehicleID,
      garageID: garageID
    }));
  }
}
function vehicleDetails() {
  if (vehicleID && garageID) {
    $.post('http://kasperr_job_vehicles/vehicleDetails', JSON.stringify({
      vehicleID: vehicleID,
      garageID: garageID
    }))
  }
}