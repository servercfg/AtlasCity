var user_id = null;
var language = null;
var config = null;

$(document).ready(function () {
  getLanguage();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
    }
    if (item.show == false) {
      close();
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://kasperr_car_trader/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://kasperr_car_trader/close', JSON.stringify({}));
  });
  $("#add-vehicle").click(function () {
    Swal.mixin({
      input: 'text',
      confirmButtonText: config.Language.AddVehicle.Next + ' &rarr;',
      showCancelButton: true,
      cancelButtonText: config.Language.CloseBtn,
      progressSteps: ['1', '2']
    }).queue([
      config.Language.AddVehicle.Title,
      config.Language.AddVehicle.ImageURL
    ]).then((result) => {
      if (result.value) {
        if(result.value[0].length < 1 || result.value[0].length > 100) {
          Swal.fire(config.Language.AddVehicle.TitleTooShort);
        } else {
          if(result.value[1].includes("http") && result.value[1].includes("png") || result.value[1].includes("http") && result.value[1].includes("jpg")) {
            Swal.fire({
              title: config.Language.AddVehicle.UploadingTitle,
              html: config.Language.AddVehicle.UploadingDescription,
              confirmButtonText: config.Language.CloseBtn,
              allowOutsideClick: false,
              onBeforeOpen: () => {
                Swal.showLoading()
                $.post('http://kasperr_car_trader/add-vehicle', JSON.stringify({
                  values: result.value
                }), function (response) {
                  if (response == true) {
                    Swal.hideLoading();
                    Swal.fire({
                      title: config.Language.AddVehicle.CompletedTitle,
                      html: config.Language.AddVehicle.CompletedDescription,
                      confirmButtonText: config.Language.CloseBtn
                    });
                    open();
                  } else {
                    Swal.hideLoading();
                    Swal.fire(config.Language.SomethingWentWrong);
                  }
                });
              }
            })
          } else {
            Swal.fire(config.Language.AddVehicle.ImageError);
          }
        }
      }
    })
  });
});

function open() {
  $(".container").fadeIn();
  $("#main").css("display", "none");
  $("#loadingscreen").css("display", "block");
  $.post('http://kasperr_car_trader/get-vehicles', JSON.stringify({}), function (response) {
    if (response.user_id && response.data) {
      user_id = response.user_id;
      $("#vehicles").empty();
      response.data.forEach(element => {
        $("#vehicles").append(`
          <div class="vehicle" onclick="showVehicle(this)" data-vehicleid="${element.id}" data-userid="${element.user_id}" data-title="${element.title}" data-image="${element.image}" data-name="${element.author_name}" data-phone="${element.author_phone}">
            <img class="car-preview" src="${element.image}">
            <p class="car-title">${element.title}</p>
            <p class="car-author">${element.author_name}</p>
            <p class="car-phone">${config.Language.PhoneDisplay}<span class="data">${element.author_phone}</span></p>
          </div>
        `);
      });
      setTimeout(() => {
        $("#main").css("display", "block");
        $("#loadingscreen").css("display", "none");
      }, 1000);
    } else {
      Swal.fire(config.Language.SomethingWentWrong);
    }
  });
}

function close() {
  $(".container").fadeOut();
}

function showVehicle(element) {
  if($(element).attr("data-userid") == user_id) {
    Swal.fire({
      title: $(element).attr("data-title"),
      html: $(element).attr("data-name") + " - " + $(element).attr("data-phone") + `<hr><button id="delete-vehicle" data-vehicleid="` + $(element).attr("data-vehicleid") + `">${config.Language.DeleteVehicleBtn}</button><button id="close-vehicle-preview">${config.Language.CloseBtn}</button>`, 
      imageUrl: $(element).attr("data-image"),
      imageAlt: 'Vehicle image',
      showConfirmButton: false
    })
  } else {
    Swal.fire({
      title: $(element).attr("data-title"),
      html: $(element).attr("data-name") + " - " + $(element).attr("data-phone") + `<hr><button id="close-vehicle-preview">${config.Language.CloseBtn}</button>`, 
      imageUrl: $(element).attr("data-image"),
      imageAlt: 'Vehicle image',
      showConfirmButton: false
    })
  }
}

function getLanguage() {
  $.post('http://kasperr_car_trader/get-language', JSON.stringify({}), function (response) {
    if (response) {
      config = response;
      for (var item in response.Language) {
        $("[data-lang='" + item + "']").html(response.Language[item]);
      }
    }
  });
}

$(document).on('click', "#delete-vehicle", function() {
  if($(this).attr("data-vehicleid")) {
    Swal.fire({
      title: config.Language.DeletedVehicle.Title,
      html: config.Language.DeletedVehicle.Description,
      confirmButtonText: config.Language.CloseBtn,
      allowOutsideClick: false,
      onBeforeOpen: () => {
        Swal.showLoading()
        $.post('http://kasperr_car_trader/delete-vehicle', JSON.stringify({
          vehicleid: $(this).attr("data-vehicleid")
        }), function (response) {
          if (response == true) {
            Swal.hideLoading();
            Swal.fire({
              title: config.Language.DeletedVehicle.CompletedTitle,
              html: config.Language.DeletedVehicle.CompletedDescription,
              confirmButtonText: config.Language.CloseBtn
            });
            open();
          } else {
            Swal.hideLoading();
            Swal.fire(config.Language.SomethingWentWrong);
          }
        });
      }
    })
  }
});

$(document).on('click', "#close-vehicle-preview", function() {
  Swal.close();
});