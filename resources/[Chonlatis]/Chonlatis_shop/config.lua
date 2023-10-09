Config = {}

Config['router_base'] = {
    ['getSharedObject'] = 'esx:getSharedObject'
}

Config['mainSetting'] = {
    esx_version = 'limit',
    key_press = 38,
    path_img = 'nui://esx_inventoryhud/html/img/items',
    header = "Chonlatis Shop",
}

Config['CatagoryItem'] = {
    ['work'] = {
        'aed',
    },
    ['electronic'] = {
        'painkiller',
    },
    ['food'] = {
        'bread',
    },
}

Config['CustomFunction'] = {
    ["notification"] = function(msg, type) 
        --[[ 
            สามารถเพิ่ม code การแจ้งเตือน Notification ได้ที่นี่
        ]]
        TriggerEvent("pNotify:SendNotification", {
            text = msg,
            type = type,
            timeout = 3000
        })
    end
}

Config['settingShops'] = {
    {
		pos = {
			{x = 373.875,   y = 325.896,  z = 102.566},
			{x = 2557.458,  y = 382.282,  z = 107.622},
			{x = -3038.939, y = 585.954,  z = 6.908},
			{x = -3241.927, y = 1001.462, z = 11.830},
			{x = 547.431,   y = 2671.710, z = 41.156},
			{x = 1961.464,  y = 3740.672, z = 31.343},
			{x = 26.16,  y = -1347.17, z = 28.55},
			{x = 2678.916,  y = 3280.671, z = 54.241},
			{x = 1729.216,  y = 6414.131, z = 34.037},
            {x = 1135.808,  y = -982.281,  z = 45.415},
			{x = -1222.915, y = -906.983,  z = 11.326},
			{x = -1487.553, y = -379.107,  z = 39.163},
			{x = -2968.243, y = 390.910,   z = 14.043},
			{x = 1166.024,  y = 2708.930,  z = 37.157},
			{x = 1392.562,  y = 3604.684,  z = 33.980},
			{x = 127.830,   y = -1284.796, z = 28.280},
			{x = -1393.409, y = -606.624,  z = 29.319},
			{x = -559.906,  y = 287.093,   z = 81.176}
		},
		blip = {
            enable = true, -- (เปิด / ปิด) Blip
            sprite = 52, -- ลักษณะของ Blip
            scale = 0.5,  -- ขนาดของ Blip
            color = 2, -- สีของ Blip
            text = 'Shop' -- ชื่อของ Blip
        },
        marker = {
            enable = true, -- (เปิด / ปิด) Marker
            type = 2, -- ลักษณะของ Marker
            color = { r = 105, g = 45, b = 255, a = 100 },
            size = 0.4,
            ur = false,
            posz = 1.0 -- ปรับระยะสูงต่ำของ Marker สามารถใส่ติดลดได้ เช่น (-0.8)
        },
        item_sell = {
            {name = 'aed', price = 10},
            {name = 'bread', price = 10},
            {name = 'water', price = 15},
        },
    },
}