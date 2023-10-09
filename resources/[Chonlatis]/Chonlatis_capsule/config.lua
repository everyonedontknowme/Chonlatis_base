Config = {}

Config['router_base'] = {
    getSharedObject = 'esx:getSharedObject'
}

Config['mainSetting'] = {
    keypress = 38,
    fontCustom = 'kanit'
}

Config['capsuleSetting'] = {
    {
        coords = vector3(-895.6171, -196.2715, 38.20163),
        name = 'Capsule steeling',
        timepickup = 1000,
        cooldown = 3000,
        distance = 4,
        textpickup = "Press [~b~E~w~] to pickup ~y~capsule.",
        textcooldown = "Capsule is cooldown.",
        item_get = {
            [1] = {name = 'bread', amount = 1, rate = 20},
            [2] = {name = 'water', amount = 1, rate = 30},
            [3] = {name = 'aed', amount = 1, rate = 40},
            [4] = {name = 'painkiller', amount = 1, rate = 100},
        },
    }
}

Config['CustomFunction'] = {
    ["progressbar"] = function(msg, duration)
        exports['mythic_progbar']:Progress({
            name = "unique_action_name",
            duration = duration,
            label = msg,
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            },
        })
    end
}