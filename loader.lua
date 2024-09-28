repeat
    task.wait()
until game:IsLoaded()

--<< Services >>--
local plrs = game:GetService("Players")

--<< Directory >>--
local lplr = plrs.LocalPlayer
local placeID = game.PlaceId

local github = "https://raw.githubusercontent.com/SeasonalKirito/Andromeda/main/"
local places = loadstring(game:HttpGet(github.."supported.lua"))()

--<< Script >>--
local Script = {
    Functions = {},
}

--<< UI >>--
local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
local Loader = ImGui:CreateWindow({
	Title = "Andromeda | "..tostring(placeID),
	TabsBar = false,
	AutoSize = "Y",
	NoCollapse = true,
	NoResize = true,
	NoClose = true,
	Position = UDim2.new(0.45, 0, 0.5, 0),
    Colors = {
		Window = {
			BackgroundColor3 = Color3.fromRGB(10, 10, 10),
			BackgroundTransparency = 0.1,
            TitleBar = {
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            },
        },
    }
})

local content = Loader:CreateTab({
	Visible = true
})

local console = content:Console({
	ReadOnly = true,
	Border = true,
	Fill = false,
	RichText = true,
	Enabled = true,
	AutoScroll = true,
	MaxLines = 10
})

local options = content:Row()

--<< Functions >>--
function Script.Functions.Log(object: any, title: string, description: string, color: string, full: boolean)
	if full then
		object:AppendText("<font color='"..tostring(color).."'>["..tostring(title).."] "..tostring(description).."</font>")
		return
	else
		object:AppendText("<font color='"..tostring(color).."'>["..tostring(title).."]</font>"..tostring(description))
		return
	end
end

function Script.Functions.IsSupported(gameID: number)
    for i,v in pairs(places) do
        if v == gameID then
            return true
        end
    end
    return false
end

Script.Functions.Log(console, "LOADED", "Loader Loaded", "rgb(0, 204, 102)", true)
task.wait(0.5)
Script.Functions.Log(console, "CHECKING", "Checking Game Support...", "rgb(153, 51, 255)", true)
task.wait(2)

--<< Loader >>--
if not Script.Functions.IsSupported(placeID) then
    Script.Functions.Log(console, "ERROR", "Unsupported Game: "..placeID, "rgb(255, 51, 51)", true)
    options:Button({
        Text = "Universal",
        Callback = function(self)
            Script.Functions.Log(console, "INFO", "Loading Universal...", "rgb(0, 102, 204)", true)
            task.wait(1)
            loadstring(game:HttpGet(github.."universal.lua", true))()
            Loader:Close()
        end,
    })
else
    Script.Functions.Log(console, "SUCCESS", "Game Supported: "..placeID, "rgb(0, 204, 102)", true)

    options:Button({
        Text = "Load",
        Callback = function(self)
            Script.Functions.Log(console, "INFO", "Loading Script...", "rgb(0, 102, 204)", true)
            task.wait(1)
            loadstring(game:HttpGet(github.."places/"..placeID..".lua", true))()
            Loader:Close()
        end,
    })
    options:Button({
        Text = "Universal",
        Callback = function(self)
            Script.Functions.Log(console, "INFO", "Loading Universal...", "rgb(0, 102, 204)", true)
            task.wait(1)
            loadstring(game:HttpGet(github.."universal.lua", true))()
            Loader:Close()
        end,
    })
end