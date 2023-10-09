-- Exports function
function GFI(nameOfFont) -- get font by key name
    return fontId[nameOfFont];
end

function GF() -- get all array of font
    return fontId;
end

AddEventHandler('monster_font:GetFontId', function(nameOfFont, taeratto)
    taeratto(fontId[nameOfFont]);
end)
AddEventHandler('monster_font:GetFont', function(taeratto)
    taeratto(fontId);
end)

exports('GetFontId', GFI)
exports('GetFont', GF)
-- End Exports function