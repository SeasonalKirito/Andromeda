repeat
    task.wait()
until game:IsLoaded()

local placeID = game.PlaceId
local github = "https://raw.githubusercontent.com/SeasonalKirito/Andromeda/main/"

if placeID == 6516141723 then
    loadstring(game:HttpGet(github .. "places/lobby.lua"))()
elseif placeID == 6839171747 or placeID == 2 then
    loadstring(game:HttpGet(github .. "places/main.lua"))()
else
    print("Place not supported.")
end