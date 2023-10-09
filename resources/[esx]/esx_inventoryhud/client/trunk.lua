local trunkData = nil
local isInInventorytruck = false

RegisterNetEvent("esx_inventoryhud:openTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:openTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
        openTrunkInventory()
    end
)

RegisterNetEvent("esx_inventoryhud:refreshTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:refreshTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
    end
)

function setTrunkInventoryData(data, blackMoney, inventory, weapons)

    trunkData = data
    print(json.encode(data))


    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items,
            weight = data.weight,
            max = data.max
        }
    )
end

function openTrunkInventory()
    loadPlayerInventory(true)
	
	LoadInventoryState = false
    isInInventory = true
    isInInventorytruck = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)

end

RegisterNUICallback(
    "PutIntoTrunk",
    function(data, cb)
        print(data.item.name)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		
		if Config.disableTrunk and Config.disableTrunk[data.item.name] then
			exports.pNotify:SendNotification(
				{
					text = "This item cannot be stored.",
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "inventoryhud"
				})
			return
		end
		
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
			--TriggerEvent('stepinwlogs:addtocar_cl', trunkData.plate, data.item.type, data.item.name, count)
        end
        Wait(250)
        loadPlayerInventory(false)
        closeInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
  
        if type(data.number) == "number" and math.floor(data.number) == data.number then
			 local count = tonumber(data.number)
            TriggerServerEvent("esx_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
			--TriggerEvent('stepinwlogs:removeitemcar_cl', trunkData.plate, data.item.type, data.item.name, count)
        end

        Wait(250)
        loadPlayerInventory(false)
        closeInventory()

        cb("ok")
    end
)

RegisterNetEvent("esx_inventoryhud:inventoryTrunkclose")
AddEventHandler("esx_inventoryhud:inventoryTrunkclose", function()
		closeTrunkInventory()
end)

function closeTrunkInventory()
	if isInInventorytruck then
		local playerPed = GetPlayerPed(-1)
		isInInventorytruck = false
		isInInventory = false
		SendNUIMessage(
			{
				action = "hide",
				type = "trunk"
			}
		)
		SetNuiFocus(false, false)
		FreezeEntityPosition(playerPed, false)
	end
end