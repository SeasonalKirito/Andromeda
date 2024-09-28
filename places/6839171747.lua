-- TODO --
-- Make debug and optional loadstring
-- Maybe make this script a own project not in the Darko project

local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotesFolder = ReplicatedStorage:WaitForChild("RemotesFolder")

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local playerGui = lp.PlayerGui

local mainUI = playerGui:WaitForChild("MainUI")
local mainGame = mainUI:WaitForChild("Initiator"):WaitForChild("Main_Game")
local mainGameSrc = require(mainGame)

local entities = {"RushMoving", "Eyes"}
local currentRoom = 0
local nextRoom = 0
local auto_replay_wait = false

local Script = {
    Functions = {},
}



local window = engine.new({
    text = "Andromeda | "..game.PlaceId,
    size = Vector2.new(450, 200),
    color = Color3.fromRGB(115,100,157),
})
window.open()

local main = window.new({
    text = "Main",
})
local exploits = window.new({
    text = "Exploits",
})
local esp = window.new({
    text = "ESP",
})
local visuals = window.new({
    text = "Visuals",
})
local misc = window.new({
    text = "Misc",
})
local credits = window.new({
    text = "Credits",
})
local debug = window.new({
    text = "Debug",
})
main.show()

-- << ESP >> --

local objectiveESP = esp.new("switch", {
    text = "Objective ESP",
})

-- << VISUALS >> --

local field_of_view = visuals.new("slider", {
    text = "FOV",
    color = Color3.new(0, 0, 0),
    min = 70,
    max = 120,
    value = 70,
    rounding = 10,
})

-- << MISC >> --

local auto_replay = misc.new("switch", {
    text = "Auto Replay",
})

local speed_boost = misc.new("slider", {
    text = "Speed Boost",
    color = Color3.new(0, 0, 1.5),
    min = 0,
    max = 7,
    value = 0,
    rounding = 1,
})

-- << EXPLOITS >> --

local anti_folder = exploits.new("folder", {
    text = "Anti's",
})

local anti_eyes = anti_folder.new("switch", {
    text = "Anti-Eyes",
})

local anti_dupe = anti_folder.new("switch", {
    text = "Anti-Dupe",
})

-- << DEBUG >> --

local is_entity = debug.new("label", {
    text = "Is Entity: false | nil",
    color = Color3.new(1, 0, 0),
})

local lp_health = debug.new("label", {
    text = "Health: "..lp.Character.Humanoid.Health,
    color = Color3.new(0, 1, 0),
})

local lp_position = debug.new("label", {
    text = "Position: "..tostring(lp.Character.HumanoidRootPart.Position),
    color = Color3.new(0.5, 0.5, 0.5),
})

local current_room = debug.new("label", {
    text = "Current Room: 0",
    color = Color3.fromRGB(115,100,157),
})

-- << FUNCTIONS >> --

function Script.Functions.ESP(args)
    if not args.Object then return end

    return "ESPManager"
end

function Script.Functions.ObjectiveESP(child)
    if child.Name == "KeyObtain" then
        Script.Functions.ESP({
            Type = "Objective",
            Object = child,
            Text = "Key",
        })
    end
end

workspace.ChildAdded:Connect(function(child)
    if table.find(entities, tostring(child.Name)) then
        is_entity.setText("Is Entity: true | ".. tostring(child.Name))
        is_entity.setColor(Color3.new(0, 1, 0))
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Workspace";
            Text = tostring(child.Name).." has been added to the workspace.";
            Duration = 5;
        })
    end
end)

workspace.ChildRemoved:Connect(function(child)
    if table.find(entities, tostring(child.Name)) then
        is_entity.setText("Is Entity: false | nil")
        is_entity.setColor(Color3.new(1, 0, 0))
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Workspace";
            Text = tostring(child.Name).." has been removed from the workspace.";
            Duration = 5;
        })
    end
end)

lp.Character.Humanoid.HealthChanged:Connect(function(health)
    if health > 75 then
        lp_health.setColor(Color3.new(0, 1, 0))
    elseif health > 25 then
        lp_health.setColor(Color3.new(1, 1, 0))
    else
        lp_health.setColor(Color3.new(1, 0, 0))
    end
    lp_health.setText("Health: "..health)
end)

-- Might slow down the game

-- lp.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
--     task.wait(0.1)
--     lp_position.setText("Position: "..tostring(lp.Character.HumanoidRootPart.Position))
-- end)

lp:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    currentRoom = lp:GetAttribute("CurrentRoom")
    nextRoom = currentRoom + 1

    local currentRoomModel = workspace.CurrentRooms:FindFirstChild(currentRoom)
    local nextRoomModel = workspace.CurrentRooms:FindFirstChild(nextRoom)

    current_room.setText("Current Room: "..tostring(currentRoom))

    -- if objectiveESP.on then
    --     for _, objectiveEsp in pairs(Script.ESPTable.Objective) do
    --         objectiveEsp.Destroy()
    --     end
    -- end

    if currentRoomModel then
        for _, asset in pairs(currentRoomModel:GetDescendants()) do
            if anti_dupe.on then
                task.spawn(Script.Functions.ObjectiveESP, asset)
            end
            --...
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = 15 + speed_boost.value end
    if field_of_view.value > 70 then
        mainGameSrc.fovtarget = field_of_view.value
    end
    if auto_replay.on then
        if lp.Character.Humanoid.Health == 0 then
            task.wait(4.5)
            game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("PlayAgain"):FireServer()
        end
    end
    if anti_eyes.on then
        remotesFolder.MotorReplication:FireServer(-649)
    end
end)