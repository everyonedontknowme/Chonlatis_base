fontId = {}

--[[ Citizen.CreateThread(function()
  while fontId == nil do
    Citizen.Wait(5000)
    RegisterFontFile('THSarabunNew') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('THSarabunNew') -- the name from the .xml
  end
end) ]]

registerFont = function()
    Citizen.Wait(100)
    for k,v in pairs(Config.RegisterFont) do
        RegisterFontFile(v.registerFontFile)
        fontId[k] = RegisterFontId(v.registerFontId)
        print('key: ' .. k)
        Citizen.Wait(150)
    end
end

Citizen.CreateThread(registerFont)