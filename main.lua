-- HUMBLE HUB (NEON ZOMBIE THEME)

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Http = game:GetService("HttpService")

-- SETTINGS
local Settings = {
    ESP = false,
    Loot = false,
    Aim = false,
    AutoTap = false,
    AutoLoot = false,
    AutoHeal = false,
    FOV = 120
}

if isfile and isfile("humble_settings.json") then
    Settings = Http:JSONDecode(readfile("humble_settings.json"))
end

local function Save()
    if writefile then
        writefile("humble_settings.json", Http:JSONEncode(Settings))
    end
end

-- STATES
local espOn = Settings.ESP
local lootOn = Settings.Loot
local aimOn = Settings.Aim
local autoTap = Settings.AutoTap
local autoLoot = Settings.AutoLoot
local autoHeal = Settings.AutoHeal
local fovSize = Settings.FOV

-- GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "HumbleHub"

-- OPEN BUTTON
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0,100,0,40)
OpenBtn.Position = UDim2.new(0,10,0,200)
OpenBtn.Text = "OPEN HUB"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0,100,0)
OpenBtn.TextColor3 = Color3.fromRGB(0,255,0)

-- MAIN FRAME
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 380)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(10,25,10)
Frame.Active = true
Frame.Draggable = true

-- GLOW
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Color = Color3.fromRGB(0,255,0)
UIStroke.Thickness = 2

-- CLOSE
local Close = Instance.new("TextButton", Frame)
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(50,0,0)
Close.TextColor3 = Color3.fromRGB(0,255,0)

Close.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

OpenBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "HUMBLE HUB"
Title.BackgroundColor3 = Color3.fromRGB(0,80,0)
Title.TextColor3 = Color3.fromRGB(0,255,0)

-- SCROLL
local Scroll = Instance.new("ScrollingFrame", Frame)
Scroll.Size = UDim2.new(1,0,1,-40)
Scroll.Position = UDim2.new(0,0,0,40)
Scroll.CanvasSize = UDim2.new(0,0,0,800)
Scroll.ScrollBarThickness = 6
Scroll.BackgroundColor3 = Color3.fromRGB(10,20,10)

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0,5)

-- TOGGLE
function createToggle(name, state, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1,-10,0,40)
    btn.Text = name..": "..(state and "ON" or "OFF")
    btn.BackgroundColor3 = Color3.fromRGB(20,40,20)
    btn.TextColor3 = Color3.fromRGB(0,255,0)

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name..": "..(state and "ON" or "OFF")
        callback(state)
        Save()
    end)
end

-- SPEED TOGGLE
local speedOn = false
local speedValue = Settings.SpeedValue or 50

createToggle("Speed Boost", speedOn, function(v)
    speedOn = v
        Settings.Speed = v

            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                        if speedOn then
                                    hum.WalkSpeed = speedValue
                                            else
                                                        hum.WalkSpeed = 16 -- default speed
                                                                end
                                                                    end
                                                                    end)

                                                                        -- SPEED VALUE BUTTON
                                                                        local speedValueBtn = Instance.new("TextButton", Scroll)
                                                                        speedValueBtn.Size = UDim2.new(1,-10,0,40)
                                                                        speedValueBtn.Text = "Speed: "..speedValue
                                                                        speedValueBtn.BackgroundColor3 = Color3.fromRGB(20,40,20)
                                                                        speedValueBtn.TextColor3 = Color3.fromRGB(0,255,0)

                                                                        speedValueBtn.MouseButton1Click:Connect(function()
                                                                            speedValue = speedValue + 10
                                                                                if speedValue > 200 then
                                                                                        speedValue = 10
                                                                                            end

                                                                                                Settings.SpeedValue = speedValue
                                                                                                    speedValueBtn.Text = "Speed: "..speedValue

                                                                                                        if speedOn then
                                                                                                                local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                                                                                                                        if hum then
                                                                                                                                    hum.WalkSpeed = speedValue
                                                                                                                                            end
                                                                                                                                                end

                                                                                                                                                    Save()
                                                                                                                                                    end)

                                                                                                                                                    -- AUTO APPLY (ANTI RESET)
                                                                                                                                                    RS.RenderStepped:Connect(function()
                                                                                                                                                        if speedOn then
                                                                                                                                                                local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                                                                                                                                                                        if hum then
                                                                                                                                                                                    hum.WalkSpeed = speedValue
                                                                                                                                                                                            end
                                                                                                                                                                                                end
                                                                                                                                                                                                end)                                                                  

-- TOGGLES
createToggle("Zombie ESP", espOn, function(v) espOn=v Settings.ESP=v end)
createToggle("Loot ESP", lootOn, function(v) lootOn=v Settings.Loot=v end)
createToggle("Aim Assist", aimOn, function(v) aimOn=v circle.Visible=v Settings.Aim=v end)
createToggle("Auto Tap", autoTap, function(v) autoTap=v Settings.AutoTap=v end)
createToggle("Auto Loot", autoLoot, function(v) autoLoot=v Settings.AutoLoot=v end)
createToggle("Auto Heal", autoHeal, function(v) autoHeal=v Settings.AutoHeal=v end)

-- FOV
local circle = Drawing.new("Circle")
circle.Radius = fovSize
circle.Thickness = 2
circle.Color = Color3.fromRGB(0,255,0)
circle.Filled = false
circle.Visible = aimOn

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseWheel then
        fovSize = math.clamp(fovSize + (input.Position.Z * 10), 50, 400)
        circle.Radius = fovSize
        Settings.FOV = fovSize
        Save()
    end
end)

print("HUMBLE HUB LOADED SUCCESSFULLY 💀🔥")
