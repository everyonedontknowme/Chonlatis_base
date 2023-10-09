if not Config.DiscordAppID or not Config.DiscordAppLogo then return;end

Citizen.CreateThread(function()
	while true do
     
		SetDiscordAppId(Config.DiscordAppID)
  
		SetDiscordRichPresenceAsset(Config.DiscordAppLogo)

        SetDiscordRichPresenceAssetText(Config.DiscordAppLogo)
 
        -- SetDiscordRichPresenceAssetSmall(Config.DiscordAppLogo)

        -- SetDiscordRichPresenceAssetSmallText(Config.DiscordAppLogo)

		Citizen.Wait(60000)
	end
end)