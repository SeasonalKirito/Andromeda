repeat
    task.wait()
until game:IsLoaded()

local placeID = game.PlaceId
local github = "https://raw.githubusercontent.com/SeasonalKirito/Andromeda/main/"

if placeID == 6516141723 then
    loadstring(game:HttpGet(github .. "places/6516141723.lua"))()
elseif placeID == 1 or placeID == 2 then
    loadstring(game:HttpGet(github .. "places/"..tostring(placeID)..".lua"))()
else
    print("Place not supported.")
end