var type = "normal";
var disabled = false;
var openMenu = false;
var PutGetitem = false;
var disabledFunction = null;

var slot_per_row = 5; // ปรับ slot item ต่อแถวในโหมดช่องเก็บของเดี่ยว

var slot_css = "";
var ii = 1;
for (ii = 1; ii <= slot_per_row; ii++) {
    slot_css += "0fr ";
}
var isShowDialog = false

window.addEventListener("message", function(event) {
    if (event.data.action == "display") {
        type = event.data.type

        if (type === "normal") {
            $(".ui").fadeIn();
            $("#playerInventoryFastItems").show();
            $("#col-other").hide();
            $("#col-inventory").removeClass();
            $("#playerInventory").animate({ width: '690px' }, 1500);
        } else if (type === "trunk") {
            $(".ui").fadeIn();
            $("#col-other").fadeIn();
			$("#other-header").html('Vehicle');
            $("#playerInventoryFastItems").hide();
            $("#playerInventory").animate({ width: '690px' }, 1500);
            $("#otherInventory").animate({ width: '690px' }, 1500);
        } else if (type === "player") {
            $(".ui").fadeIn();
            $("#col-other").fadeIn();
			$("#other-header").html('Other inventory');
            $("#playerInventoryFastItems").hide();
            $("#playerInventory").animate({ width: '690px' }, 1500);
            $("#otherInventory").animate({ width: '690px' }, 1500);
        } else if (type === "vault") {
            $(".ui").fadeIn();
            $("#col-other").fadeIn();
			$("#other-header").html('Vault');
            $("#playerInventoryFastItems").hide();
            $("#playerInventory").animate({ width: '690px' }, 1500);
            $("#otherInventory").animate({ width: '690px' }, 1500);
        } else if (type === "Shops") {
            $(".ui").fadeIn();
            $("#col-other").fadeIn();
			$("#other-header").html('Shop');
            $("#playerInventoryFastItems").hide();
            $("#playerInventory").animate({ width: '690px' }, 1500);
            $("#otherInventory").animate({ width: '690px' }, 1500);
        }



    } else if (event.data.action == "hide") {

        $(".ui").fadeOut(200, function() {
            $(".item").remove();
        });
		
		removeopclass();
        $("#col-other").hide();
        $("#col-inventory").removeClass();
        $("#col-inventory").removeClass('opClass');

        $("#give_id").fadeOut();

        FadeOutCountItem()

    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList, event.data.fastItems, event.data.myid);
        $(".info-div2").html(event.data.text);
		var pc = Math.floor((event.data.weight*100)/event.data.max);
		var mt = 400-((400*pc)/100);
		$('.weight_bar').css("margin-top", mt + "px");
        $("#fWeight").html(event.data.weight / 1000);
        $("#fMaxWeight").html(event.data.max / 1000);

        $('.item').draggable({

            appendTo: 'body',
            zIndex: 99999,
            disabled: false,
            drag: function(event, ui) {
                ui.position.left = ui.position.left + 5;
                ui.position.top = ui.position.top + 5;



            },
            helper: function(e) {
                var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
                return original.clone().css({
                    width: original.width(),
                    height: original.height(),
                });
            },
            stop: function() {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    //////////////////////////////////


                    if (type === "trunk" && itemInventory === "second") {
                        return;
                    }

                }
            }
        });
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
        //$('.weight_bar_other').css("width", event.data.weight / 1000 + "%");
        $("#sWeight").html(event.data.weight / 1000);
        $("#sMaxWeight").html(event.data.max / 1000);
    } else if (event.data.action == "setShopInventoryItems") {
        shopInventorySetup(event.data.itemList, event.data.zone)
    } else if (event.data.action == "setInfoText") {
        if (event.data.plate !== undefined)
            $("#sInfo").html(event.data.plate);
    } else if (event.data.action == "nearPlayers") {
        $("#give_id").html('');
        $("#col-inventory").addClass('opClass');
        $("#give_id").append('<div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;" id="OKKOKKOK"><input type="number" class="form-control text-center" id="give_id_player" min="1" placeholder="กรุณาใส่ไอดี"></div> <div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_id" style="width: 90%;margin-top: 15px;">CONFIRM</button></div>');
        $("#give_id").fadeIn();
        isShowDialog = true
        document.getElementById("give_id_player").focus()

        $("#confirm_id").click(function(e) {
			e.preventDefault();
            var player = $('#give_id_player').val()
            var count = parseInt($("#count").val())
            console.log(count)
            $.post("http://esx_inventoryhud/GiveItem", JSON.stringify({
                player: player,
                item: event.data.item,
                number: parseInt($("#count").val())
            }));
            $("#give_id").fadeOut();
            closeInventory()
        });

        $("#OKKOKKOK").on("keyup", function(key) {
            if (key.keyCode == 13) {
               if (parseInt($("#count").val()) >= 1) {
                    var player = $('#give_id_player').val()
                    var count = parseInt($("#count").val())
                    console.log(count)
                    $.post("http://esx_inventoryhud/GiveItem", JSON.stringify({
                        player: player,
                        item: event.data.item,
                        number: parseInt($("#count").val())
                    }));
                    $("#give_id").fadeOut();
                    closeInventory()
               }
            }
        });
    }
});

function OnDrug() {
    sendData("Drug", "OnDrug")
}

function OnSell() {
    sendData("Drug", "OnSell")
}

function sendData(name, data) {
    $.post("http://esx_inventoryhud/" + name, JSON.stringify(data), function(datab) {
        if (datab != "ok") {
            console.log(datab);
        }
    });
}

function closeInventory() {
    $.TaerAttOContext()
    if (isShowDialog) {
        isShowDialog = false
        removeopclass()
        FadeOutCountItem()
    } else {
        isShowDialog = false
        $.post("http://esx_inventoryhud/NUIFocusOff", JSON.stringify({}));
    }
        
}

function inventorySetup(items, fastItems, myid) {
    $("#playerInventory").html("");
    itemcount = items
    $.each(items, function(index, item) {
        count = setCount(item);
		
		if (Number.isInteger(item.weight) && item.weight > 0 ) {
			weight = item.weight / 1000 + ' kg';
		} else {
			weight = '';
		}
		
        var app = $('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div><div class="item-weight"> ' + weight + '</div> </div ><div class="item-name">' + item.label + '</div></div>');

        var data = [];

        var i


        $("#playerInventoryFastItems").html("");
			$("#playerInventoryFastItems").append('<div class="col"><div id="playersource">#' + myid +'</div></div>');

        for (i = 1; i < 8; i++) {
            $("#playerInventoryFastItems").append('<div class="col"><div class="slotFast"><div id="itemFast-' + i + '" class="itemfast item" >' +
                '<div class="keybind">' + i + '</div><div class="item-count"></div>  </div ></div></div>');
        }


        coisas = [false, false, false, false, false]

        $.each(fastItems, function(index, item) {
            count = setCount(item);
            coisas[index] = true
            $('#itemFast-' + item.slot).css("width", "100%");
            $('#itemFast-' + item.slot).css("height", "100%");
            $('#itemFast-' + item.slot).css("background-image", 'url(\'img/items/' + item.name + '.png\')');
            $('#itemFast-' + item.slot).html('<div class="item-count">' + count + '</div>');
            $('#itemFast-' + item.slot).data('item', item);
            $('#itemFast-' + item.slot).data('inventory', "fast");
        });

        makeDraggables(item)
		
		if (item.sell) {
            data.push({
                "title": "ขาย",
                "func": function () {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.usable == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }

       
					$.post("http://esx_inventoryhud/SellItem", JSON.stringify({
						item: item
					}));
              
                },
            });
        }
	
		
		
        if (item.canRemove) {
            data.push({
                "title": "มอบ",
                "func": function() {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.canRemove == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }
                    

                    $("#count_give").html('');
                    $("#col-inventory").addClass('opClass');
                    $("#count_give").append('<div class="count_id_class" id="loloasdasd"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');

                    FadeInCountItem()
                    
                    document.getElementById("count").focus()
                    isShowDialog = true
                    $("#confirm_count").click(function(e) {
						e.preventDefault();
                        if (itemData.canRemove) {
                            disableInventory(300);
                            $.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
                                item: itemData
                            }));
                            removeopclass();
                            FadeOutCountItem()
                            isShowDialog = false
                        }
                    });

                    $("#loloasdasd").on("keyup", function(key) {
                        if (key.keyCode == 13) {
                           if (parseInt($("#count").val()) >= 1) {
                                if (itemData.canRemove) {
                                    disableInventory(300);
                                    $.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
                                        item: itemData
                                    }));
                                    removeopclass();
                                    FadeOutCountItem()
                                    isShowDialog = false
                                }
                           }
                        }
                    });

                    $("#confirm_count_max").click(function() {
                        $("#count_input").html('');
                        $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                        document.getElementById("count").focus()
                    });




                },
            });
			
	
            data.push({
                "title": "ทิ้ง",
                "func": function () {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.canRemove == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }

                    if (itemData.canRemove) {
              
						$("#count_give").html('');
						$("#col-inventory").addClass('opClass');
						$("#count_give").append('<div class="count_id_class" id="loloasdasd"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
						FadeInCountItem()
                        document.getElementById("count").focus()
                        isShowDialog = true
						$("#confirm_count").click(function(e) {
							e.preventDefault();
							if (itemData.canRemove) {
								disableInventory(300);
								$.post("http://esx_inventoryhud/DropItem", JSON.stringify({
									item: item,
									number: parseInt($("#count").val())
								}));
                                removeopclass();
								FadeOutCountItem()
                                isShowDialog = false
							}
						});

                        $("#loloasdasd").on("keyup", function(key) {
                            if (key.keyCode == 13) {
                               if (parseInt($("#count").val()) >= 1) {
                                    if (itemData.canRemove) {
                                        disableInventory(300);
                                        $.post("http://esx_inventoryhud/DropItem", JSON.stringify({
                                            item: item,
                                            number: parseInt($("#count").val())
                                        }));
                                        removeopclass();
                                        FadeOutCountItem()
                                        isShowDialog = false
                                    }
                               }
                            }
                        });


						$("#confirm_count_max").click(function() {
							$("#count_input").html('');
							$("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                            document.getElementById("count").focus()
						});
                    }
                },
            });

        }

        $.createRMenu(app, data);

        $("#playerInventory").append(app);
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");

    });
}

function shopInventorySetup(items, zone) {
    $("#otherInventory").html("");
    var space = 0;
    $.each(items, function (index, item) {
        //count = setCount(item)
        cost = setCost(item);

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
        '<div class="item-count">' + cost + '</div><div class="item-weight"> ' + weight + '</div> </div ><div class="item-name">' + item.label + '</div></div>');
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

function opclass() {
    $("#col-inventory").addClass('opClass');
    $("#col-other").addClass('opClass');
}

function removeopclass() {
    $("#col-inventory").removeClass('opClass');
    $("#col-other").removeClass('opClass');
}

function itemDescriptionOn(obj) {
    $(".bgDescription").fadeIn();
    itemData = $(obj).data("item");
    if (itemData.label !== undefined) {
        var element = $(" <div ><p> <span> ชื่อไอเทม: " + itemData.label + " </span></p></div> <div><p> <span> น้ำหนักไอเทม : " + (itemData.weight / 1000) + " </span></p></div> <div><p> จำนวนไอเทม : " + itemData.count + " </p></div>").fadeIn(200);
        $("#itemDescription").html("");
        $("#itemDescription").append(element);
        setTimeout(function() {
            $(element).fadeOut(100, function() { $(this).remove(); });
            $(".bgDescription").fadeOut();
        }, 3500);
    }
}

function makeDraggables(itemm) {
	
    $('#itemFast-1').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");
            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1,
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
	$('#itemFast-6').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 6
                }));
            }
        }
    });
	$('#itemFast-7').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("http://esx_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 7
                }));
            }
        }
    });
}

function secondInventorySetup(items) {

	
    $("#otherInventory").html("");

    $.each(items, function(index, item) {
        count = setCount(item);
		if (Number.isInteger(item.weight) && item.weight > 0 ) {
			weight = item.weight / 1000 + ' kg';
		} else {
			weight = '';
		}
		
        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div><div class="item-weight"> ' + weight + '</div> </div ><div class="item-name">' + item.label + '</div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
    });

    $("#otherInventory").fadeIn();
}


function Interval(time) {
    var timer = false;
    this.start = function() {
        if (this.isRunning()) {
            clearInterval(timer);
            timer = false;
        }

        timer = setInterval(function() {
            disabled = false;
        }, time);
    };
    this.stop = function() {
        clearInterval(timer);
        timer = false;
    };
    this.isRunning = function() {
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

function setCost(item) {
    cost = item.price

    if (item.price == 0){
        cost = '<span class="item-count-box">' + item.price + "</span>"
    }
    if (item.price > 0) {
        cost = '<span class="item-count-box">' + item.price + "</span>"
    }
    return cost;
}

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count
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


function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};



$(document).ready(function() {

    $("#count").focus(function() {
        $(this).val("")
    }).blur(function() {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function(key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        }
    });



    $('#playerInventory').droppable({
        drop: function(event, ui) {


            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" id="count" min="1" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            FadeOutCountItem()
                            isShowDialog = false
                            removeopclass();
                       }
                    }
                });

                $("#confirm_count").click(function(e) {
					e.preventDefault();

                    $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    FadeOutCountItem()
                    isShowDialog = false
                    removeopclass();
                });

                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });

            } else if (type === "player" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/TakeFromPlayer", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            FadeOutCountItem()
                            isShowDialog = false
                            removeopclass();
                       }
                    }
                });
                $("#confirm_count").click(function(e) {
					e.preventDefault();

                    $.post("http://esx_inventoryhud/TakeFromPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    FadeOutCountItem()
                    isShowDialog = false
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });

            } else if (type === "vault" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/TakeFromVault", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            FadeOutCountItem()
                            isShowDialog = false
                            removeopclass();
                       }
                    }
                });

                $("#confirm_count").click(function(e) {
					e.preventDefault();
      
                    $.post("http://esx_inventoryhud/TakeFromVault", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    FadeOutCountItem()
                    isShowDialog = false
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });
            } else if (type === "Shops" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/TakeFromShops", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            FadeOutCountItem()
                            isShowDialog = false
                            removeopclass();
                       }
                    }
                });

                $("#confirm_count").click(function(e) {
					e.preventDefault();

                    $.post("http://esx_inventoryhud/TakeFromShops", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val()),
                        zone: ui.draggable.data("zone")
                    }));
                    FadeOutCountItem()
                    isShowDialog = false
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });


            } else if (type === "normal" && itemInventory === "fast") {
                coisas[itemData.slot - 1] = false;
                $.post("http://esx_inventoryhud/TakeFromFast", JSON.stringify({
                    item: itemData
                }));
            }


        }
    });

    $('#otherInventory').droppable({
        drop: function(event, ui) {


            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");


            if (type === "trunk" && itemInventory === "main") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            removeopclass();
                            FadeOutCountItem()
                            isShowDialog = false
                       }
                    }
                });

                $("#confirm_count").click(function(e) {
					e.preventDefault();
    
                    $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    FadeOutCountItem()
                    isShowDialog = false
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });


            } else if (type === "vault" && itemInventory === "main") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/PutIntoVault", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            removeopclass();
                            FadeOutCountItem()
                            isShowDialog = false
                       }
                    }
                });

                $("#confirm_count").click(function(e) {
					e.preventDefault();
         
                    $.post("http://esx_inventoryhud/PutIntoVault", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    FadeOutCountItem()
                    isShowDialog = false
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });

            } else if (type === "player" && itemInventory === "main") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class" id="AAAAAA"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 15px;">MAX</button></div>');
                FadeInCountItem()

                document.getElementById("count").focus()
                isShowDialog = true

                $("#AAAAAA").on("keyup", function(key) {
                    if (key.keyCode == 13) {
                       if (parseInt($("#count").val()) >= 1) {
                            isShowDialog = false
                            $.post("http://esx_inventoryhud/PutIntoPlayer", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                            removeopclass();
                            FadeOutCountItem()
                            isShowDialog = false
                       }
                    }
                });

                $("#confirm_count").click(function(e) {
					e.preventDefault();

                    $.post("http://esx_inventoryhud/PutIntoPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    FadeOutCountItem()
                    isShowDialog = false
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    document.getElementById("count").focus()
                });


            }
        }
    });

    $("#count").on("keypress keyup blur", function(event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function() {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function(event) {
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
    close: function() {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});

function FadeInCountItem(){
    $("#count_give").css('opacity','0');
    $("#count_give").show()
    setTimeout(() => {
        $("#count_give").css('opacity','1');
    }, 300);
}

function FadeOutCountItem(){
    setTimeout(() => {
        $("#count_give").css('opacity','0');
    }, 300);
    $("#count_give").hide()
}