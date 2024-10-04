
--<< Services >>--
local plrs = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

--<< Directory >>--
local lplr = plrs.LocalPlayer

--<< Script >>--
local Script = {
    Functions = {},
}

--<< UI >>--
local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
local Window = ImGui:CreateWindow({
	Title = "Andromeda | "..game.PlaceId,
	Size = UDim2.fromOffset(350, 500),
	Position = UDim2.new(0.45, 0, 0.5, 0),
    NoResize = true,
    Colors = {
		Window = {
			BackgroundColor3 = Color3.fromRGB(10, 10, 10),
			BackgroundTransparency = 0.1,
            TitleBar = {
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            },
        },
    },
})

--<< Main >>--
local main = Window:CreateTab({
	Name = "Main",
	Visible = true
})

local console = main:Console({
	Text = "Logs",
	ReadOnly = true,
	Border = true,
	Fill = false,
	RichText = true,
	Enabled = true,
	AutoScroll = true,
})

main:Separator({
	Text = "Infinite"
})

local Infinite = main:Row()
Infinite:Button({
	Text = "Cash",
	Callback = function(self)
		Script.Functions.InfMoney("Cash")
	end,
})
Infinite:Button({
	Text = "Tix",
	Callback = function(self)
		Script.Functions.InfMoney("Tix")
	end,
})

main:Separator({
	Text = "Badges"
})

local claim_badge = main:Combo({
	Placeholder = "Claim Badge",
	Label = "Badge",
    Items = {"test"},
	Callback = function(self, Value)
		local args = {[1] = Value}
        game:GetService("ReplicatedStorage"):WaitForChild("AwardBadge"):FireServer(unpack(args))
	end,
})

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

function Script.Functions.InfMoney(type)
    local args = {[1] = 1000000000000000000}
    if type == "Cash" then
        game:GetService("ReplicatedStorage"):WaitForChild("AddCash"):FireServer(unpack(args))
    elseif type == "Tix" then
        game:GetService("ReplicatedStorage"):WaitForChild("AddTix"):FireServer(unpack(args))
    else
        Script.Functions.Log(console, "ERROR", "Invalid Type", "rgb(255, 0, 0)", true)
    end
end

--<< Main >>--
Script.Functions.Log(console, "LOADED", "Script Loaded", "rgb(96, 96, 96)", true)

local badges = loadstring(game:HttpGet("https://badges.roblox.com/v1/universes/445448798/badges?limit=10&sortOrder=Asc"))()
print(badges)

--<< Loops >>--

--<< >>--
--Script.Functions.Log(console, "LOADED", "Script Loaded", "rgb(96, 96, 96)", true)