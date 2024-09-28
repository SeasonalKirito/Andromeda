local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()

local Window = ImGui:CreateWindow({
	Title = "Andromeda | "..tostring(game.Name),
	Size = UDim2.fromOffset(350, 500),
	Position = UDim2.new(0.45, 0, 0.5, 0),

	--// Styles
	Colors = {
		Window = {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.05,
			ResizeGrip = {
				TextColor3 = Color3.fromRGB(0, 0, 0)
			},
			
			TitleBar = {
				BackgroundColor3 = Color3.fromRGB(115,100,157),
				[{
					Recursive = true,
					Name = "ToggleButton"
				}] = {
					BackgroundColor3 = Color3.fromRGB(115,100,157)
				}
			},
		},
	}
})


local debug = Window:CreateTab({
	Name = "Debug",
	Visible = true
})