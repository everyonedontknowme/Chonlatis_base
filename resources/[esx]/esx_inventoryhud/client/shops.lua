local zone = nil

AddEventHandler("esx_inventoryhud:openShopsInventory",function(data, value)
	zone = value
	setShopsInventoryData(data)
	openShopsInventory()
end)

AddEventHandler("esx_inventoryhud:refreshShopsInventory",function(data)
        setShopsInventoryData(data)
end)


function setShopsInventoryData(data)
    items = {}

    local blackMoney = data.blackMoney
    local ShopsItems = data.items
    local ShopsWeapons = data.weapons

    if blackMoney ~= nil and blackMoney > 0 then
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

	if ShopsItems ~= nil then
		for i = 1, #ShopsItems, 1 do
			local item = ShopsItems[i]

			if item.count > 0 then
				item.type = "item_standard"
				item.usable = false
				item.rare = false
				item.limit = -1
				item.canRemove = false

				table.insert(items, item)
			end
		end
	end

	if ShopsWeapons ~= nil then
		for i = 1, #ShopsWeapons, 1 do
			local weapon = ShopsWeapons[i]

			if ShopsWeapons[i].name ~= "WEAPON_UNARMED" then
				table.insert(
					items,
					{
						label = ESX.GetWeaponLabel(weapon.name),
						count = weapon.ammo,
						limit = -1,
						type = "item_weapon",
						name = weapon.name,
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
            itemList = items
        }
    )
end

function openShopsInventory()
    loadPlayerInventory(false)
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Shops"
        }
    )

    SetNuiFocus(true, true)
	
	TriggerEvent('InteractSound_CL:PlayOnOne','Shop',0.1)
end

RegisterNUICallback(
    "TakeFromShops",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			TriggerServerEvent('esx_shops:buyItem', data.item.name, tonumber(data.number), zone)
        end

        Wait(250)
        loadPlayerInventory(false)

        cb("ok")
    end
)


