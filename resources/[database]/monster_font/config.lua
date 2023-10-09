--  Create By TaerAttO
Config = {}

--[[ Citizen.CreateThread(function()
  while fontId == nil do
    Citizen.Wait(5000)
    RegisterFontFile('THSarabunNew') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('THSarabunNew') -- the name from the .xml
  end
end) ]]

Config.RegisterFont = {
    srbn = {
        registerFontFile = 'THSarabunNew', -- the name of your .gfx, without .gfx
        registerFontId = 'THSarabunNew' -- the name from the .xml
    },

    srbn2 = {
      registerFontFile = 'Sarabun', -- the name of your .gfx, without .gfx
      registerFontId = 'Sarabun' -- the name from the .xml
    },

    kanit = {
      registerFontFile = 'Kanit', -- the name of your .gfx, without .gfx
      registerFontId = 'Kanit' -- the name from the .xml
    },

    --[[ You can add more font and don't forgot add file into stream folder Create By TaerAttO ]]

    --[[ ['srbntest1'] = {
        registerFontFile = 'THSarabunNew', -- the name of your .gfx, without .gfx
        registerFontId = 'THSarabunNew' -- the name from the .xml
    }, ]]
}