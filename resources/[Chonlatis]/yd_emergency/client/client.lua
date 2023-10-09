--[[
 *
 * DIPSCode FiveM | Agency Notification
 * dst_agency_noty
 * version 1.0
 *
]]

ESX = nil
QueueNoty = {{}, {}, {}, {}, {}}
QueueActive = { false, false, false, false, false }
IsPressLeftShift = false

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print("^3[DST Agency Noty] ^2Status Is ready!")
        print("^3Created by DIPSCode - FiveM")
        print("^3Version 1.0")
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('dst_agency_noty:showAccepted')
AddEventHandler('dst_agency_noty:showAccepted', function(caseId, job, playerName)
    local myJobName = ESX.GetPlayerData().job.name

    if job == myJobName then
        SendNUIMessage({
            type = 'accepted',
            message = playerName .. ' รับเคสที่&nbsp;<strong>' .. caseId .. '</strong>&nbsp;แล้ว',
            timeout = Config.Timeout
        })
    end
end)    

RegisterNetEvent('dst_agency_noty:client:alert')
AddEventHandler('dst_agency_noty:client:alert', function(job, title, message, coords, imageLink)
    local myJobName = ESX.GetPlayerData().job.name

    -- local zone = GetNameOfZone(pedCoords.x, pedCoords.y, pedCoords.z)
    -- local labelZone = GetLabelText(zone)

    if imageLink == nil then imageLink = 'https://www.freeiconspng.com/uploads/alert-icon-red-11.png' end

    if job == myJobName then
        local canUseId = nil
        local allActive = true
        for k, v in pairs(QueueActive) do
            if not v then
                allActive = false
                break
            end
        end

        for k, v in pairs(QueueActive) do
            if not v then
                canUseId = k
                break
            end
        end

        if allActive then
            Wait(Config.Timeout + 500)
            local unactiveId = nil
            for k, v in pairs(QueueActive) do
                if not v then
                    unactiveId = k
                    break
                end
            end

            QueueNoty[unactiveId] = coords
            QueueActive[unactiveId] = true

            TriggerServerEvent('InteractSound_SV:PlayOnOne', GetPlayerServerId(PlayerId()), 'long-pop.mp3', 0.5)

            SendNUIMessage({
                type = 'noty',
                title = title,
                message = message,
                number = unactiveId,
                timeout = Config.Timeout,
                image = imageLink
            })
        else
            QueueNoty[canUseId] = coords
            QueueActive[canUseId] = true

            TriggerServerEvent('InteractSound_SV:PlayOnOne', GetPlayerServerId(PlayerId()), 'long-pop.mp3', 0.5)

            SendNUIMessage({
                type = 'noty',
                title = title,
                message = message,
                number = canUseId,
                timeout = Config.Timeout,
                image = imageLink
            })
        end
    end
end)

RegisterNUICallback('removeQueue', function(data, cb)
    QueueActive[data.caseId] = false
    cb('ok')
end)

RegisterCommand('test_noty', function()
    TriggerServerEvent('dst_agency_noty:sendAlert', 'ambulance', 'แจ้งซ่อม 1-1-1', 'มีเคสซ่อมเข้า ด่วนเลย!!!', {
        x = -49.23,
        y = 16.34
    })
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 19) then
            IsPressLeftShift = true
        else
            IsPressLeftShift = false
        end
    end
end)

AddEventHandler('dst_agency_noty:client:triggered', function(key)
    if key and IsPressLeftShift then
        AcceptCase(key)
    end
end)

function AcceptCase(caseId)
    if QueueActive[caseId] == true then
        local dataCoords = QueueNoty[caseId]
        SetNewWaypoint(dataCoords.x, dataCoords.y)
        TriggerServerEvent('dst_agency_noty:sendAcceptCase', caseId, ESX.GetPlayerData().job.name)

        Config.OnAcceptCase(caseId, dataCoords)
    end
end