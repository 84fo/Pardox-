--// Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local savedPosition = nil

--// GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 170)
frame.Position = UDim2.new(0.5, -110, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

--// Save Button
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(1, -20, 0, 40)
saveBtn.Position = UDim2.new(0, 10, 0, 10)
saveBtn.Text = "Save Position"
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
saveBtn.TextColor3 = Color3.new(1,1,1)
saveBtn.Parent = frame

--// Teleport Button
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, -20, 0, 40)
tpBtn.Position = UDim2.new(0, 10, 0, 60)
tpBtn.Text = "Teleport"
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.Parent = frame

--// Forward Button (الجديد 🔥)
local forwardBtn = Instance.new("TextButton")
forwardBtn.Size = UDim2.new(1, -20, 0, 40)
forwardBtn.Position = UDim2.new(0, 10, 0, 110)
forwardBtn.Text = "Forward"
forwardBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
forwardBtn.TextColor3 = Color3.new(1,1,1)
forwardBtn.Parent = frame

--// Save Position
saveBtn.MouseButton1Click:Connect(function()
    if character and character:FindFirstChild("HumanoidRootPart") then
        savedPosition = character.HumanoidRootPart.CFrame
        saveBtn.Text = "Saved!"
        task.wait(1)
        saveBtn.Text = "Save Position"
    end
end)

--// Teleport to Saved
tpBtn.MouseButton1Click:Connect(function()
    if savedPosition then
        character.HumanoidRootPart.CFrame = savedPosition
    else
        tpBtn.Text = "No Position!"
        task.wait(1)
        tpBtn.Text = "Teleport"
    end
end)

--// Forward Teleport
forwardBtn.MouseButton1Click:Connect(function()
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local forward = hrp.CFrame.LookVector
        local distance = 12
        hrp.CFrame = hrp.CFrame + (forward * distance)
    end
end)

--// Update character after respawn
player.CharacterAdded:Connect(function(char)
    character = char
end)
