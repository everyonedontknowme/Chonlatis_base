local handsup = false
RegisterCommand('handsup', function()
 --   print('999999999')
    local player = PlayerPedId()
    local incarkeyx = IsPedInAnyVehicle(player, true)
    if not incarkeyx then             
        if not handsup then
            handsup = true
            local dict = "missminuteman_1ig_2"    
            RequestAnimDict(dict)
            if not HasAnimDictLoaded(dict) then
                Citizen.Wait(100)
            end       
            TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
        else
            ClearPedTasks(GetPlayerPed(-1))                    
            handsup = false                                     
        end

    end
end, false)

RegisterKeyMapping('handsup', 'Hands Up', 'keyboard', 'X')