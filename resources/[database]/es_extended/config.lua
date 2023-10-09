Config = {}
Config.Locale = 'en'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.StartingAccountMoney = {bank = 3000, money = 1000} -- default money on first create character -- เงินเริ่มต้น ตอนสร้างตัว ครั้งแรก

Config.EnableSocietyPayouts = false -- pay from the society account that the player is employed at? Requirement: monster_society
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.MaxWeight            = 30000   -- the max inventory weight without backpack
Config.PaycheckInterval     = 10 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug          = false


Config.SetGameType = '| Backend By Chonlatis ™|'
Config.SetMapName = '| Chonlatis Base |'

Config.ItemDropExpire = 15 -- second

Monster_UseIdentifier = 'steam' -- steam or license


-- don't touch
identifier = {
	['steam'] = 0,
	['license'] = 9
}

-- don't touch
Config.Identifier = {
	identifier = Monster_UseIdentifier .. ':',
	startAtIndex = identifier[Monster_UseIdentifier]
}
