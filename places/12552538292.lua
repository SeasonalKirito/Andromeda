
--<< Services >>--
local plrs = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

--<< Directory >>--
local lplr = plrs.LocalPlayer

--<< Script >>--
local Script = {
    Entities = {"Angler", "Froger"},
    Functions = {},
}

--<< UI >>--
local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
local Window = ImGui:CreateWindow({
	Title = "Andromeda | "..game.PlaceId,
	Size = UDim2.fromOffset(350, 500),
	Position = UDim2.new(0.45, 0, 0.5, 0),
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
workspace.ChildAdded:Connect(function(child)
    task.delay(0.1, function()
        if table.find(Script.Entities, child.Name) then
            task.spawn(function()
                Script.Functions.Log(console, "WARNING", "Entity "..child.Name.." Spawned at "..os.date("%X"), "rgb(255, 51, 51)", true)
            end)
        end
    end)
end)

workspace.ChildRemoved:Connect(function(child)
    task.delay(0.1, function()
        if table.find(Script.Entities, child.Name) then
            task.spawn(function()
                Script.Functions.Log(console, "WARNING", "Entity "..child.Name.." Despawned at "..os.date("%X"), "rgb(255, 51, 51)", true)
            end)
        end
    end)
end)
