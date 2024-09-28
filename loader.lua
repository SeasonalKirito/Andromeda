repeat
    task.wait()
until game:IsLoaded()

local placeID = game.PlaceId
local github = "https://raw.githubusercontent.com/SeasonalKirito/Andromeda/main/"
local supported = game:HttpGet(github.."supported.lua")
local games = loadstring(supported)()

for _, v in pairs(games) do
    if v == placeID then
        loadstring(game:HttpGet(github.."places/"..placeID..".lua", true))()
        break
    else
        loadstring(game:HttpGet(github.."universal.lua", true))()
    end
end
