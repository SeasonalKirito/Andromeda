
--<< Services >>--
local plrs = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

--<< Directory >>--
local lplr = plrs.LocalPlayer
local Balls = workspace:WaitForChild("Balls")

--<< Script >>--
local Script = {
    Functions = {},
}

--<< UI >>--
local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
local Window = ImGui:CreateWindow({
	Title = "Andromeda | "..tostring(game.Name),
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

local auto_parry = main:Checkbox({
	Label = "Auto Parry",
	Value = false,
})

local detect_distance = main:Slider({
	Label = "Detect Distance",
	Format = "%.d/%s", 
	Value = 15,
	MinValue = 0,
	MaxValue = 30,
})

--<< Shop >>--
local shop = Window:CreateTab({
	Name = "Shop",
	Visible = false
})

shop:Button({
	Text = "Buy Sword Crate",
	Callback = function(self)
		rs.Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalSwordCrate)
        Script.Functions.Log(console, "SUCCESS", "Bought Sword Crate", "rgb(0, 204, 102)", true)
	end,
})

shop:Button({
	Text = "Buy Explosion Crate",
	Callback = function(self)
		rs.Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalExplosionCrate)
        Script.Functions.Log(console, "SUCCESS", "Bought Explosive Crate", "rgb(0, 204, 102)", true)
	end,
})

local sword_crate = shop:Checkbox({
	Label = "Auto Buy Sword Crate",
	Value = false,
})

local explosive_crate = shop:Checkbox({
	Label = "Auto Buy Explosion Crate",
	Value = false,
})

local auto_spin = shop:Checkbox({
	Label = "Auto Spin Wheel",
	Value = false,
})



--<< Functions >>--
function Script.Functions.IsTarget()
    return (lplr.Character and lplr.Character:FindFirstChild("Highlight"))
end

function Script.Functions.VerifyBall(Ball)
    if typeof(Ball) == "Instance" and Ball:IsA("BasePart") and Ball:IsDescendantOf(Balls) and Ball:GetAttribute("realBall") == true then
        return true
    end
end

function Script.Functions.Parry()
    vim:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
    wait(0.005)
    vim:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
end

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
Balls.ChildAdded:Connect(function(Ball)
    if not Script.Functions.VerifyBall(Ball) then
        return
    end
    Script.Functions.Log(console, "INFO", "Ball Spawned: "..tostring(Ball), "rgb(0, 102, 204)", true)

    local OldPosition = Ball.Position
    local OldTick = tick()
    Ball:GetPropertyChangedSignal("Position"):Connect(function()
        if Script.Functions.IsTarget() then
            if auto_parry.Value then
                local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude
                local Velocity = (OldPosition - Ball.Position).Magnitude

                -- Script.Functions.Log(console, "INFO", `Distance: {Distance}\nVelocity: {Velocity}\nTime: {Distance / Velocity}`, "rgb(40, 10, 240)", true)

                if (Distance / Velocity) <= detect_distance.Value then
                    Script.Functions.Parry()
                    Script.Functions.Log(console, "INFO", `Parried Ball | {Distance}`, "rgb(153, 51, 255)", true)
                end
            else
                return
            end
        end
        
        if (tick() - OldTick >= 1/60) then
            OldTick = tick()
            OldPosition = Ball.Position
        end
    end)
end)

--<< Loops >>--
RunService.RenderStepped:Connect(function()
    task.wait(1)
    if sword_crate.Value then
        rs.Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalSwordCrate)
    end
    if explosive_crate.Value then
        rs.Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalExplosionCrate)
    end
    if auto_spin.Value then
        local args = {[1] = "SpinWheel"}
        game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(unpack(args))
    end
end)

lplr.Character.Humanoid.Died:Connect(function()
    Script.Functions.Log(console, "WARNING", "You Died at "..os.date("%X"), "rgb(255, 51, 51)", true)
end)

--<< >>--
Script.Functions.Log(console, "LOADED", "Script Loaded", "rgb(96, 96, 96)", true)