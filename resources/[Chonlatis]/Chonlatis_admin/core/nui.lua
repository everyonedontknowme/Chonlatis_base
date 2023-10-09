RegisterNUICallback('CloseUI', function()
    CloseUI()
end)

function OpenUI()
    SendNUIMessage({
        action = 'show'
    })
    SetNuiFocus(true, true)
end

function CloseUI()
    SendNUIMessage({
        action = 'close'
    })
    SetNuiFocus(false, false)
end