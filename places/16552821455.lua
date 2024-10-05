
--<< Services >>--
local plrs = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--<< Directory >>--
local lplr = plrs.LocalPlayer

--<< Script >>--
local Script = {
    Variables = {
        tpwalking = false,
    },
    Functions = {},
}

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

function Script.Functions.teleportWalk(speed)
    Script.Variables.tpwalking = true
    local chr = lplr.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    while Script.Variables.tpwalking and chr and hum and hum.Parent do
        local delta = RunService.Heartbeat:Wait()
        if hum.MoveDirection.Magnitude > 0 then
            if speed and tonumber(speed) then
                chr:TranslateBy(hum.MoveDirection * tonumber(speed) * delta * 10)
            else
                chr:TranslateBy(hum.MoveDirection * delta * 10)
            end
        end
    end
end

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

main:Slider({
	Label = "Speed Bypass",
	Format = "%.d/%s", 
	Value = 50,
	MinValue = 0,
	MaxValue = 50,

	Callback = function(self, Value)
        Script.Variables.tpwalking = false
        Script.Functions.teleportWalk(Value)
	end,
})



--<< Main >>--
