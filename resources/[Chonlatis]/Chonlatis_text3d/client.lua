local letSleep = true

RegisterNUICallback('HideUI', function()
    letSleep = true
end)

function SendNUIMessageTextUI(msg)
    if not IsPauseMenuActive() then
        if msg then
           letSleep = false

           msg = msg:gsub("~r~", "<span style=color:red;>")
           msg = msg:gsub("~b~", "<span style='color:rgb(0, 213, 255);'>")
           msg = msg:gsub("~g~", "<span style='color:rgb(0, 255, 68);'>")
           msg = msg:gsub("~y~", "<span style=color:yellow;>")
           msg = msg:gsub("~p~", "<span style='color:rgb(220, 0, 255);'>")
           msg = msg:gsub("~f~", "<span style=color:grey;>")
           msg = msg:gsub("~m~", "<span style=color:darkgrey;>")
           msg = msg:gsub("~u~", "<span style=color:black;>")
           msg = msg:gsub("~o~", "<span style=color:gold;>")
           msg = msg:gsub("~s~", "</span>")
           msg = msg:gsub("~w~", "</span>")
           msg = msg:gsub("~b~", "<b>")
           msg = msg:gsub("~n~", "<br>")
           msg = msg:gsub("\n", "<br>")
           msg = msg:gsub("~input~", "<span class = 'INPUT_CONTEXT'>")
           msg = msg:gsub("~INPUT_CONTEXT~", "<span class = 'INPUT_CONTEXT'>E</span>")
           msg = msg:gsub("~INPUT_DETONATE~", "<span class = 'INPUT_CONTEXT'>G</span>")
           msg = msg:gsub("~INPUT_VEH_EXIT~", "<span class = 'INPUT_CONTEXT'>F</span>")
           msg = msg:gsub("~INPUT_ARREST~", "<span class = 'INPUT_CONTEXT'>F</span>")
           msg = msg:gsub("~INPUT_RELOAD~", "<span class = 'INPUT_CONTEXT'>R</span>")
           msg = msg:gsub("~INPUT_CONTEXT_SECONDARY~", "<span class = 'INPUT_CONTEXT'>Q</span>")
           msg = msg:gsub("~INPUT_COVER~", "<span class = 'INPUT_CONTEXT'>Q</span>")
           msg = msg:gsub("~INPUT_DIVE~", "<span class = 'INPUT_CONTEXT'>SPACEBAR</span>")
           msg = msg:gsub("~INPUT_VEH_HANDBRAKE~", "<span class = 'INPUT_CONTEXT'>SPACEBAR</span>")
           msg = msg:gsub("~INPUT_REPLAY_START_STOP_RECORDING~", "<span class = 'INPUT_CONTEXT'>F1</span>")
           msg = msg:gsub("~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~", "<span class = 'INPUT_CONTEXT'>F2</span>")
           msg = msg:gsub("~INPUT_SAVE_REPLAY_CLIP~", "<span class = 'INPUT_CONTEXT'>F3</span>")
           msg = msg:gsub("~INPUT_REPLAY_SAVE~", "<span class = 'INPUT_CONTEXT'>F5</span>")
           msg = msg:gsub("~INPUT_REPLAY_TIMELINE_SAVE~", "<span class = 'INPUT_CONTEXT'>F5</span>")
           msg = msg:gsub("~INPUT_SELECT_CHARACTER_MICHAEL~", "<span class = 'INPUT_CONTEXT'>F5</span>")
           msg = msg:gsub("~INPUT_SELECT_CHARACTER_FRANKLIN~", "<span class = 'INPUT_CONTEXT'>F6</span>")
           msg = msg:gsub("~INPUT_SELECT_CHARACTER_TREVOR~", "<span class = 'INPUT_CONTEXT'>F7</span>")
           msg = "<span style=color:currentColor>" .. msg .. "</span>"
   
           SendNUIMessage({ 
               message = msg;
           })

        end

        if not letSleep then
            Citizen.Wait(200)
         end
    end
end

exports("ShowHelpNotification", SendNUIMessageTextUI)