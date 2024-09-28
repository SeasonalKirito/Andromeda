repeat
    task.wait()
until game:IsLoaded()

local github = "https://raw.githubusercontent.com/SeasonalKirito/Andromeda/main/"
local supported = github.."supported.lua"
local games = loadstring(game:HttpGet(supported))()

for _, v in pairs(games) do
    if v == game.PlaceId then
        loadstring(game:HttpGet(github.."games/"..game.PlaceId..".lua", true))()
        break
    else
        loadstring(game:HttpGet(github.."universal.lua", true))()
    end
end