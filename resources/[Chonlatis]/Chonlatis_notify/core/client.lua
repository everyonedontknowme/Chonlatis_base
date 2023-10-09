MsgNotification = function(type1, msg, wait)
    print(type1, msg, wait)
    SendNUIMessage({
        type = type1,
        msg = msg,
        wait = wait * 1000
    })
end

RegisterCommand('notify-success', function() 
    MsgNotification(1, 'อย่าเสือกไอสัส', 5)
end)

RegisterCommand('notify-error', function() 
    MsgNotification(2, 'กดเพื่อไร', 5)
end)