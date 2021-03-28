var type = "normal";
var disabled = false;
var disabledFunction = null;
var plyText = "";
window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        type = event.data.type
        disabled = false;
        // 
        $("#search").bind('input', function () {
            searchFor = $("#search").val().toLowerCase();
            $(".slot").each(function (index, value) {
              label = $(this).text().toLowerCase();
              if (label.indexOf(searchFor) < 0) {
                $(this).hide();
              } else {
                $(this).show();
              }
            });
          });

          $(document).on('keydown', function (event) {
            // $("#search").focus();
          });
            // 
  
     

        if (type === "normal") {
            $(".info-div").hide();
            $(".trunk-info-div").hide();
            $(".second-weight").hide();
            // $(".ply-info").show();
            // $(".ply-weight").show();
            // InventoryLog('Succesfully loaded | ply-inv');
            // $("#noSecondInventoryMessage").hide();
            $("#otherInventory").hide();

            // $(".inventory").width(1075);

            // $(".inventory").delay(800).animate(1075);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "trunk") {
            $(".trunk-info-div").show();
            $(".second-weight").show();

            // InventoryLog('Succesfully loaded Trunk-inv');
            $("#noSecondInventoryMessage").hide();
            $("#otherInventory").show();
            // $('.con').hide();
            $(".info-div").hide();
            // $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "property") {
            $(".info-div").hide();
            //$("#noSecondInventoryMessage").show();
            $("#otherInventory").show();
            $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "vault") {
            $(".info-div").show();
           // $("#noSecondInventoryMessage").show();
            $("#otherInventory").show();
            $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "glovebox") {
            $(".info-div").show();
            //$("#noSecondInventoryMessage").show();
            $("#otherInventory").show();

            $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "player") {
            $(".info-div").show();
            $(".trunk-info-div").hide();
            $(".second-weight").hide();
            $("#noSecondInventoryMessage").show();
            $("#otherInventory").show();
            $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "shop") {
            $(".info-div").show();
            $(".ply-info").show();
            $(".ply-weight").show();
            $(".trunk-info-div").hide();
            $(".second-weight").hide();

            // InventoryLog('Succesfully loaded Shop');
            //$("#noSecondInventoryMessage").show();
            $("#otherInventory").show();

            $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type === "admin") {
            $(".info-div").show();
            $(".ply-info").show();
            $(".ply-weight").show();
            $(".trunk-info-div").hide();
            $(".second-weight").hide();

            // InventoryLog('Succesfully loaded AdminShop');
            //$("#noSecondInventoryMessage").show();
            $("#otherInventory").show();
            $(".inventory").width(1550);
            // $(".inventory").css({"border-radius":"25px"});
        } else if (type == "addInventoryItem") {
            var itemdata = event.data.addItemData;
            var element = $("<div class='added-item-slot' id='added-item-image'><div class='item-bg' style ='background-image: url(img/items/" + itemdata.name + ".png')'><div class='label'><p><span id='iLabel'>" + itemdata.label + "</span></p></div></div></div>");
            $("#added-item").html("");
            $("#added-item").append(element).hide().fadeIn(100);
            setTimeout(function () {
                $(element).fadeOut(100, function () { $(this).remove(); });
            }, 2500);
        } else if (type == "useHBItem") {
            var itemdata = event.data.itemData;

            var element = $("<div class='used-item-slot' id='used-item-image'><div class='item' style ='background-image: url(\'img/items/'" + itemdata.name + ".png\')'><div class='label'><p><span id='iLabel'>" + itemdata.label + "</span></p></div></div></div>");
            $("#used-item").html("");
            $("#used-item").append(element).hide().fadeIn(100);
            setTimeout(function () {
                $(element).fadeOut(100, function () { $(this).remove(); });
            }, 4500);
        }
        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $("#dialog").dialog("close");
        $(".ui").fadeOut();
        $(".item").remove();
        //$("#otherInventory").html("<div id=\"noSecondInventoryMessage\"></div>");
        //$("#noSecondInventoryMessage").html(invLocale.secondInventoryNotAvailable);
    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
                if (disabled) {
                    return false;
                }

                $(this).css('background-image', 'none');
                itemData = $(this).data("item");
                itemInventory = $(this).data("inventory");

                if (itemInventory == "second" || !itemData.canRemove) {
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                }

                if (itemInventory == "second" || !itemData.usable) {
                    $("#use").addClass("disabled");
                }
            },
            stop: function () {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);

        
        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
                if (disabled) {
                    return false;
                }

                $(this).css('background-image', 'none');
                itemData = $(this).data("item");
                itemInventory = $(this).data("inventory");

                if (itemInventory == "second" || !itemData.canRemove) {
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                }

                if (itemInventory == "second" || !itemData.usable) {
                    $("#use").addClass("disabled");
                }
            },
            stop: function () {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });
    } 
    else if (event.data.action == "setShopInventoryItems") {
        shopInventorySetup(event.data.itemList, event.data.zone)
    } else if (event.data.action == "setAdminInventoryItems") {
        adminInventorySetup(event.data.itemList)
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
        plyText = $(".info-div").html(event.data.text);
    } else if (event.data.action == "setTrunkInfoText") {
        $(".trunk-info-div").html(event.data.text);
    } else if (event.data.action == "setplyInfoText") {
        $(".ply-info").html(event.data.text);
    } else if (event.data.action == "setplyWeight") {
        $(".ply-weight").html(event.data.text);
    } else if (event.data.action == "setSecondWeight") {
        $(".second-weight").html(event.data.text);
    }
});

function closeInventory() {
    $.post("http://fg-inventory/NUIFocusOff", JSON.stringify({}));
}

function addZeroes(num) {
    return num.toFixed(Math.max(((num+'').split(".")[1]||"").length, 2));
 } 


 function itemDescriptionOn(obj) {
    itemData = $(obj).data("item");
    if (itemData !== undefined && itemData.name !== undefined) {
        var element = $("<div class='item-desc-info'><h1>"+ itemData.label +"</h1></br><hr class='item-hr'><p>Beskrivelse: <span id='item-desc'>" + itemData.desc + "</br></span>Antal: <span id='item-desc'>" + itemData.count + "</br></span>Vægt: <span id='item-desc'>" +  addZeroes(itemData.weight/itemData.count) + " kg</span></p></div>") .fadeIn(200);
        $("#item-information").html("");
        $("#item-information").append(element);
        setTimeout(function () {
            $(element).fadeOut(100, function () { $(this).remove(); });
        }, 4500);
    }
}

 function itemShopDescriptionOn(obj) {
    itemData = $(obj).data("item");
    if (itemData !== undefined && itemData.name !== undefined) {
        var element = $("<div class='item-desc-info'><h1>"+ itemData.label +"</h1></br><hr class='item-hr'><p>Beskrivelse: <span id='item-desc'>" + itemData.desc + "</br></span>Vægt: <span id='item-desc'>" +  addZeroes(itemData.weight) + " kg</span></p></div>") .fadeIn(200);
        $("#item-information").html("");
        $("#item-information").append(element);
        setTimeout(function () {
            $(element).fadeOut(100, function () { $(this).remove(); });
        }, 4500);
    }
}

function inventorySetup(items) {
    $("#playerInventory").html("");
    var space = 0
    $.each(items, function (index, item) {
        count = setCount(item);

        $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" onmouseover="itemDescriptionOn(this)" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-amount-weight"> ' + count + ' ' + '(' + addZeroes(item.weight) + ')' + ' </div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
        space = space + 1
    });
    for (var i = 0; i < (35 - space); i++) {
        $("#playerInventory").append('<div class="slot">' +
            '<div class="item-name"> </div> </div>');
    }
}

function secondInventorySetup(items) {
    $("#otherInventory").html("");
    var space = 0
    $.each(items, function (index, item) {
        count = setCount(item);

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" onmouseover="itemDescriptionOn(this)" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
        '<div class="item-amount-weight"> ' + count + ' ' + '(' + addZeroes(item.weight) + ')' + ' </div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
        space = space + 1
    });

    for (var i = 0; i < (35 - space); i++) {
        $("#otherInventory").append('<div class="slot">' +
            '<div class="item-name"> </div> </div>');
        // $('#item-' + index).data('item', item);
        // $('#item-' + index).data('inventory', "main");
    }
}

function shopInventorySetup(items, zone) {
    $("#otherInventory").html("");
    var space = 0
    $.each(items, function (index, item) {
        cost = setCost(item);

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" onmouseover="itemShopDescriptionOn(this)" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-price">' + cost + ' DKK' + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
        $('#itemOther-' + index).data('zone', zone);

        space = space + 1
    });

    for (var i = 0; i < (35 - space); i++) {
        $("#otherInventory").append('<div class="slot">' +
            '<div class="item-name"> </div> </div>');
        // $('#item-' + index).data('item', item);
        // $('#item-' + index).data('inventory', "main");
    }
}

function adminInventorySetup(items, zone) {
    $("#otherInventory").html("");
    var space = 0
    $.each(items, function (index, item) {
        cost = setCost(item);

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" onmouseover="itemShopDescriptionOn(this)" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' + '<div class="item-name">' + item.label + '</div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
        $('#itemOther-' + index).data('zone', zone);

        space = space + 1
    });

    for (var i = 0; i < (35 - space); i++) {
        $("#otherInventory").append('<div class="slot">' +
            '<div class="item-name"> </div> </div>');
        // $('#item-' + index).data('item', item);
        // $('#item-' + index).data('inventory', "main");
    }
}

function Interval(time) {
    var timer = false;
    this.start = function () {
        if (this.isRunning()) {
            clearInterval(timer);
            timer = false;
        }

        timer = setInterval(function () {
            disabled = false;
        }, time);
    };
    this.stop = function () {
        clearInterval(timer);
        timer = false;
    };
    this.isRunning = function () {
        return timer !== false;
    };
}

function disableInventory(ms) {
    disabled = true;

    if (disabledFunction === null) {
        disabledFunction = new Interval(ms);
        disabledFunction.start();
    } else {
        if (disabledFunction.isRunning()) {
            disabledFunction.stop();
        }

        disabledFunction.start();
    }
}

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count + " / " + item.limit
    }

    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "";
        } else {
            count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.count;
        }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }

    return count;
}

function setCost(item) {
    cost = item.price

    if (item.limit > 0) {
        cost = item.price + " / " + item.limit
    }

    return cost;
}

function sendData(resource, name, data)
{
    $.post("http://" + resource + "/" + name, JSON.stringify(data), function(datab) {
        console.log(datab);
    });
}

function playSound(sound) {
  sendData("fg-inventory", "playsound", {name: sound});
}

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};

$(document).ready(function () {
    $("#count").focus(function () {
        $(this).val("")
    }).blur(function () {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function (key) {
        if (key.which == 27) {
            closeInventory();
        }
    });

    $('#use').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined || itemData.usable == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }

            if (itemData.usable) {
                disableInventory(300);
                $.post("http://fg-inventory/UseItem", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                // InventoryLog('Used: 1 ' + itemData.label);
            }
        }
    });

    $('#give').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined || itemData.canRemove == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }

            if (itemData.canRemove) {
                disableInventory(300);
                $.post("http://fg-inventory/GiveItem", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });

    $('#drop').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined || itemData.canRemove == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }

            if (itemData.canRemove) {
                disableInventory(300);
                $.post("http://fg-inventory/DropItem", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                // InventoryLog('Dropped: ' + parseInt($("#count").val()) + ' ' + itemData.label);
            }
        }
    });

    $('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://fg-inventory/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://fg-inventory/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "glovebox" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://fg-inventory/TakeFromGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://fg-inventory/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "shop" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://fg-inventory/TakeFromShop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val()),
                    zone: ui.draggable.data("zone")
                }));
                playSound("SELECT");
            } else if (type === "admin" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://fg-inventory/TakeFromAdmin", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val()),
                    zone: ui.draggable.data("zone")
                }));
                playSound("SELECT");
            }
        }
    });

    $('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://fg-inventory/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://fg-inventory/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "glovebox" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://fg-inventory/PutIntoGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://fg-inventory/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                playSound("SELECT");
            }
        }
    });

    $("#count").on("keypress keyup blur", function (event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

function InventoryLog(log) {
    var currentLog = $('.inv-log').html();
    $('.inv-log').html(log + "<br>" + currentLog);
}

$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening
        clickOutsideTrigger: ''
    },
    open: function () {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function (event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function () {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method
        this._super();
    },
});
