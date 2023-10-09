local targetPlayer
local targetPlayerName

Citizen.CreateThread(
    function()
        TriggerEvent(
            "chat:addSuggestion",
            "/openinventory",
            _U("openinv_help"),
            {
                {name = _U("openinv_id"), help = _U("openinv_help")}
            }
        )
    end
)

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            TriggerEvent("chat:removeSuggestion", "/openinventory")
        end
    end
)

RegisterNetEvent("esx_inventoryhud:openPlayerInventory")
AddEventHandler("esx_inventoryhud:openPlayerInventory", function(target, inventory, accounts, money, loadout)
        targetPlayer = target
        setPlayerInventoryData(inventory, accounts, money, loadout)
        openPlayerInventory()
    end
)

RegisterNetEvent("esx_inventoryhud:refreshPlayerInventory")
AddEventHandler("esx_inventoryhud:refreshPlayerInventory",function(target, inventory, accounts, money, loadout)
	targetPlayer = target
	setPlayerInventoryData(inventory, accounts, money, loadout)
end)

function refreshPlayerInventory()
    TriggerServerEvent("esx_inventoryhud:refreshPlayerInventorySv", targetPlayer)
end

function setPlayerInventoryData(inventory, accounts, money, weapons)
    items = {}

    if Config.IncludeCash and money ~= nil and money > 0 then
        for key, value in pairs(accounts) do
            moneyData = {
                label = _U("cash"),
                name = "cash",
                type = "item_money",
                count = money,
                usable = false,
                rare = false,
                limit = -1,
                canRemove = true
            }

            table.insert(items, moneyData)
        end
    end
    
    if Config.IncludeAccounts and accounts ~= nil then
        for key, value in pairs(accounts) do
            if not shouldSkipAccount(accounts[key].name) then
                local canDrop = accounts[key].name ~= "bank"

                if accounts[key].money > 0 then
                    accountData = {
                        label = accounts[key].label,
                        count = accounts[key].money,
                        type = "item_account",
                        name = accounts[key].name,
                        usable = false,
                        rare = false,
                        limit = -1,
                        canRemove = canDrop
                    }
                    table.insert(items, accountData)
                end
            end
        end
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            if weapons[key].name ~= "WEAPON_UNARMED" then
                local ammo = weapons[key].ammo
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = true
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

function openPlayerInventory()
    loadPlayerInventory(false)
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "player"
        }
    )

    SetNuiFocus(true, true)
	
	TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen',0.1)
end

RegisterNUICallback(
    "PutIntoPlayer",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_inventoryhud:tradePlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count)
        end

        Wait(150)
		refreshPlayerInventory()
		Wait(150)
        loadPlayerInventory(false)

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromPlayer",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_inventoryhud:tradePlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count)
        end

        Wait(150)
		refreshPlayerInventory()
		Wait(150)
        loadPlayerInventory(false)

        cb("ok")
    end
)
