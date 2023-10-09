Config = {}

Config['Key'] = 'E'
Config['Version'] = '1.1'

Notify = function(Text)
    -- TriggerEvent("pNotify:SendNotification", {
    --     text = Text,
    --     type = "success",
    --     timeout = 3000,
    --     layout = "bottomCenter",
    --     queue = "global"
    -- })
    
    exports['Chonlatis_notify']:MsgNotification(2, Text, 3)
end

Config['Jobs'] = {
    ['Pig'] = {
        coords = vector3(1448.13, 1068.2, 114.33),
        textui = "Press ~INPUT_CONTEXT~ To pickup pig.",
        text = "Pickup Pig",
        Blips = {
            sprite = 473,
            scale = 1.0,
            color = 1,
            text = "Pig farm",
        },
        Radius = 5,  
        SpawnModel  = true,
        SpawnObject = {
            "a_c_pig"
        },

        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "joblicense",
        
        item = {
            ItemName = "pig",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },

    ['Miner'] = {
        coords = vector3(2961.83 , 2790.36 , 40.3),
        textui = "Press ~INPUT_CONTEXT~ To pickup stone.",
        text = "Pickup Stone",
        Blips = {
            sprite = 318,
            scale = 1.0,
            color = 46,
            text = "Miner",
        },
        Radius = 5,  
        SpawnModel  = false,
        SpawnObject = {
            "prop_rock_4_a"
        },

        animDict = 'melee@large_wpn@streamed_core',
        anim = 'ground_attack_on_spot',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "driller",
        
        item = {
            ItemName = "stone",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },

    ['Cabbage'] = {
        coords = vector3(2311.26, 5126.31, 49.74),
        textui = "Press ~INPUT_CONTEXT~ To pickup Cabbage",
        text = "Cabbage",
        Blips = {
            sprite = 514,
            scale = 1.0,
            color = 2,
            text = "Cabbage farm",
        },
        Radius = 10,  
        SpawnModel  = false,
        SpawnObject = {
            "prop_veg_crop_03_cab"
        },

        animDict = 'melee@large_wpn@streamed_core',
        anim = 'ground_attack_on_spot',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "joblicense",
        
        item = {
            ItemName = "cabbage",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },

    ['Wood'] = {
        coords = vector3(-843.83, 5659.61, 19.01),
        textui = "Press ~INPUT_CONTEXT~ To pickup Wood.",
        text = "Wood",
        Blips = {
            sprite = 238,
            scale = 1.0,
            color = 44,
            text = "Wood farm",
        },
        Radius = 10,  
        SpawnModel  = false,
        SpawnObject = {
            "prop_log_01"
        },

        animDict = 'melee@large_wpn@streamed_core',
        anim = 'ground_attack_on_spot',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "joblicense",
        
        item = {
            ItemName = "cabbage",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },

    ['Crab'] = {
        coords = vector3(-2101.17, 2621.74, 17.33),
        textui = "Press ~INPUT_CONTEXT~ To pickup Crab.",
        text = "Crab",
        Blips = {
            sprite = 468,
            scale = 1.0,
            color = 17,
            text = "Crab farm",
        },
        Radius = 10,  
        SpawnModel  = false,
        SpawnObject = {
            "prop_beach_sandcas_05"
        },

        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "trowel",
        
        item = {
            ItemName = "crab",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },

    ['Shell'] = {
        coords = vector4(1890.469, 332.5602, 162.7479, 120.538),
        textui = "Press ~INPUT_CONTEXT~ To pickup Shell.",
        text = "Shell",
        Blips = {
            sprite = 484,
            scale = 1.0,
            color = 1,
            text = "Shell farm",
        },
        Radius = 10,  
        SpawnModel  = false,
        SpawnObject = {
            "prop_rock_5_c"
        },

        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "trowel",
        
        item = {
            ItemName = "shell",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },

    ['Rice'] = {
        coords = vector3(260.76, 6461.17, 31.2 ),
        textui = "Press ~INPUT_CONTEXT~ To pickup Rice.",
        text = "Rice",
        Blips = {
            sprite = 514,
            scale = 1.0,
            color = 46,
            text = "Rice farm",
        },
        Radius = 10,  
        SpawnModel  = false,
        SpawnObject = {
            "prop_veg_grass_01_c"
        },

        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',

        TimePickup = 3,
        PropCount = 12,
        ItemWork = "sickle",
        
        item = {
            ItemName = "rice",
            ItemCount = {1,3},
            ItemBonus = {

            }
        },
    },
}

Config['settingProcess'] = {
    {
        name = 'Miner',
        coords = vector3(1460.802, 1044.836, 114.3341),
        timeprocess = 3000,
        item = {
            item_needs = {
                {name = 'diamond', amount = 1}
            },
            item_get = {
                {name = 'gold', amount = 1}
            }
        }
    }
}