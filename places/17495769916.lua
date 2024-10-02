
--<< Services >>--
local plrs = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

--<< Directory >>--
local lplr = plrs.LocalPlayer
local RoundEndTotem = workspace.Island.Items:FindFirstChild("Round End Totem")

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

--<< Main >>--

--<< Loops >>--

--<< >>--
Script.Functions.Log(console, "LOADED", "Script Loaded", "rgb(96, 96, 96)", true)