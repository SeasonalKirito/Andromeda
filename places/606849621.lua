local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SeasonalKirito/Andromeda/main/Elerium/source.lua"))()
local window = library:AddWindow("Andromeda | "..game.PlaceId)

local tab = window:AddTab("tab")
local console = tab:AddConsole("Console")
tab:Show()
library:FormatWindows()