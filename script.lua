-- Teleport Forward GUI Script

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportUI"
pcall(function()
    ScreenGui.Parent = game.CoreGui
end)

-- Button
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 120, 0, 50)
Button.Position = UDim2.new(0.5, -60, 0.5, -25)
Button.Text = "Forward"
Button.BackgroundColor3 = Color3.fromRGB(25,25,25)
Button.TextColor3 = Color3.fromRGB(255,255,255)
Button.Parent = ScreenGui

-- Drag System
local dragging, dragInput, mousePos, framePos

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = Button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        Button.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Teleport
Button.MouseButton1Click:Connect(function()
    if humanoidRootPart then
        local forward = humanoidRootPart.CFrame.LookVector
        local distance = 12
        humanoidRootPart.CFrame = humanoidRootPart.CFrame + (forward * distance)
    end
end)
