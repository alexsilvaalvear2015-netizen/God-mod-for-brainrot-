-- Noclip + God Mode con Menu
-- Opcion 1

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclip = false
local god = false
local char, humanoid

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 150)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Noclip / God"
title.BackgroundColor3 = Color3.fromRGB(60,60,60)
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

local function makeButton(text, y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9,0,0,35)
    b.Position = UDim2.new(0.05,0,0,y)
    b.BackgroundColor3 = Color3.fromRGB(90,90,90)
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Text = text
    return b
end

local noclipBtn = makeButton("Noclip: OFF", 40)
local godBtn = makeButton("God Mode: OFF", 85)

-- Funciones
local function setupCharacter(character)
    char = character
    humanoid = char:WaitForChild("Humanoid")

    if god then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end

noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)

godBtn.MouseButton1Click:Connect(function()
    god = not god
    godBtn.Text = "God Mode: " .. (god and "ON" or "OFF")

    if humanoid and god then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end)

RunService.Stepped:Connect(function()
    if noclip and char then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end

    if god and humanoid then
        if humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)

-- Character
if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(c)
    wait(1)
    setupCharacter(c)
end)
