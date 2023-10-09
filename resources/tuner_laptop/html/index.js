var max_point = 0
var used_point = 0
var can_save = true
var toolc = false

function sliderUpdated() {

    // used_point = $("#boost").slider("value")  + $("#fuelmix").slider("value")  +  $("#gearchange").slider("value") + $("#braking").slider("value") + $("#drivetrain").slider("value") + $("#brakeforce").slider("value")
    // $('#point').html(max_point - used_point)
    // if (max_point - used_point < 0) {
    // can_save = false
    // $('#savebtn').removeClass('btn-success')
    // $('#savebtn').addClass('btn-danger')
    // } else {
    // can_save = true
    // $('#savebtn').addClass('btn-success')
    // $('#savebtn').removeClass('btn-danger')
    // }

    used_point = $("#boost").slider("value") * 10 + $("#fuelmix").slider("value") * 10 + $("#gearchange").slider("value") * 10 + $("#braking").slider("value") * 10 + $("#drivetrain").slider("value") * 10 + $("#brakeforce").slider("value") * 10 + $("#handbrake").slider("value") * 10 

    $('#point').html(parseInt(parseInt(max_point) - used_point))
    if (parseInt(parseInt(max_point) - used_point) == 0) {
        can_save = true
        $('#savebtn').addClass('btn-success')
        $('#savebtn').removeClass('btn-danger')
    } else {
        can_save = false
        $('#savebtn').removeClass('btn-success')
        $('#savebtn').addClass('btn-danger')
    }
}

function getSliderValues() {
    return { boost: $("#boost").slider("value"), fuelmix: $("#fuelmix").slider("value"), gearchange: $("#gearchange").slider("value"), braking: $("#braking").slider("value"), drivetrain: $("#drivetrain").slider("value"), brakeforce: $("#brakeforce").slider("value"), handbrake: $("#handbrake").slider("value") };
}

function setSliderValues(values) {
	max_point = 0
    $(".slider").each(function() {
        if (values[this.id] != null) {
            $(this).slider("value", values[this.id].toFixed(1));
            max_point = max_point + ((values[this.id].toFixed(1)) * 10)
        }
    });

    // defaultboots = 0
    // defaultfuelmix = 0
    // defaultgearchange = 0
    // defaultbraking = 0
    // defaulttrain = 0
    // defaultforce = 0

    sliderUpdated();
}

function menuToggle(bool, send = false) {
    if (bool) {
        $("body").show();
       
    } else {
        $("body").hide();
    }
    if (send) {
        $.post('http://tuner_laptop/togglemenu', JSON.stringify({ state: false }));
    }
}

$(function() {
    $("body").hide();

    $("#appName").text(Config.appName);
    // $("#boost").slider({min:0.1,value:0.25,step:0.01,max:0.75,change:sliderUpdated});
    // $("#fuelmix").slider({min:1,value:1.3,step:0.01,max:2,change:sliderUpdated});
    // $("#gearchange").slider({min:1,value:9,max:50,change:sliderUpdated});
    // $("#braking").slider({value:0.5,max:1,step:0.05,change:sliderUpdated});
    // $("#drivetrain").slider({value:0.5,max:1,step:0.05,change:sliderUpdated});
    // $("#brakeforce").slider({value:1.4,max:2,step:0.05,change:sliderUpdated});

    $("#boost").slider({ min: 0.0, value: 0.0, step: 0.1, max: 1.0, change: sliderUpdated });
    $("#fuelmix").slider({ min: 0.0, value: 0.0, step: 0.1, max: 1.0, change: sliderUpdated });
    $("#gearchange").slider({ min: 0.0, value: 0.0, step: 0.1, max: 1.0, change: sliderUpdated });
    $("#braking").slider({ min: 0.0, value: 0, step: 0.1, max: 1.0, change: sliderUpdated });
    $("#drivetrain").slider({ min: 0.0, value: 0.0, step: 0.1, max: 1.0, change: sliderUpdated });
    $("#brakeforce").slider({ min: 0.0, value: 0.0, step: 0.1, max: 3.0, change: sliderUpdated });
    $("#handbrake").slider({ min: 0.0, value: 0.0, step: 0.1, max: 3.0, change: sliderUpdated });


    // $('#point').html(max_point)	

    // $("#boost").slider({min:0,value:0,step:0.1,max:1,change:sliderUpdated});
    // $("#fuelmix").slider({min:0,value:0,step:0.1,max:1,change:sliderUpdated});
    // $("#gearchange").slider({min:0,value:0,step:0.1,max:1,change:sliderUpdated});
    // $("#braking").slider({min:0,value:0,step:0.1,max:1,change:sliderUpdated});
    // $("#drivetrain").slider({min:0,value:0,step:0.1,max:1,change:sliderUpdated});
    // $("#brakeforce").slider({min:0,value:0,step:0.1,max:1,change:sliderUpdated});

    $("#defaultbtn").click(function() {
        sendData('ButtonClick', 'Default')
		setSliderValues({gearchange:0});
    });
	




    $("#savebtn").click(function() {
        if (can_save)
            $.post('http://tuner_laptop/save', JSON.stringify(getSliderValues()));
    });

    $("#darktoggle").click(function() {
        $(this).toggleClass("fa");
        $(this).toggleClass("far");
        $(".program").toggleClass("programwhite");
        $(".program").toggleClass("programblack");
    });

    $("#tool").click(function() {
        $(this).toggleClass("fa");
        $(this).toggleClass("far");
        $("#leftbarr").toggle();
    });

    $("#exitProgram").click(function() {
        sendData('ButtonClick', 'exit')
    });
	
    $("#shutDown").click(function() {
		sendData('ButtonClick', 'shutDown')
    });
	
    setInterval(() => {
        var today = new Date();
        var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        var time = days[today.getDay()] + " " + today.getHours() + ":" + (today.getMinutes().toString().length == 1 ? "0" + today.getMinutes() : today.getMinutes());
        $("#toptime").text(time);
    }, 1000);
    document.onkeyup = function(data) {
        if (data.which == 27) {
            sendData('ButtonClick', 'exit')
        }
    };
    window.addEventListener('message', function(event) {
        if (event.data.type == "togglemenu") {
            menuToggle(event.data.state, false);
            if (event.data.data != null) {
                setSliderValues(event.data.data);

            }
        }
    });
});

function sendData(name, data) {
    $.post("http://tuner_laptop/" + name, JSON.stringify(data), function(datab) {
        if (datab != "ok") {
            console.log(datab);
        }
    });
}