Config = {}

-- เวลาในการแสดงผล
Config.Timeout = 8000

-- เมื่อรับเคส
Config.OnAcceptCase = function(caseId, casePosition) -- Client Side
    --[[ TriggerClientEvent('pNotify:SendNotification', {
        text = 'Accepted Case Notification',
        type = 'success',
        queue = 'bottomCenter',
        timeout = 2000,
        layout = 'bottomCenter'
    }) ]]
end