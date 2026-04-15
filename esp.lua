-- Создаем GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.Parent = mainFrame
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "ESP"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = mainFrame
toggleBtn.Size = UDim2.new(0, 160, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -80, 0.5, 15)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleBtn.Text = "ВЫКЛ"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 16
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.BorderSizePixel = 0

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = toggleBtn
btnCorner.CornerRadius = UDim.new(0, 8)

local espEnabled = false
local espData = {}

-- Функция для создания ESP для игрока
local function addESP(player)
    if player == LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.6
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0.2
    
    local head = character:FindFirstChild("Head")
    if head then
        local billboard = Instance.new("BillboardGui")
        billboard.Parent = head
        billboard.Size = UDim2.new(0, 150, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 1.5, 0)
        billboard.AlwaysOnTop = true
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = billboard
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextStrokeTransparency = 0.3
        nameLabel.TextScaled = true
        
        espData[player] = {
            highlight = highlight,
            billboard = billboard
        }
    end
end

-- Функция для удаления ESP
local function removeESP(player)
    if espData[player] then
        if espData[player].highlight then
            espData[player].highlight:Destroy()
        end
        if espData[player].billboard then
            espData[player].billboard:Destroy()
        end
        espData[player] = nil
    end
end

-- Включение ESP для всех игроков
local function enableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            addESP(player)
        end
    end
end

-- Выключение ESP для всех игроков
local function disableESP()
    for player, _ in pairs(espData) do
        removeESP(player)
    end
end

-- Обработчик кнопки
toggleBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    
    if espEnabled then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        toggleBtn.Text = "ВКЛ"
        enableESP()
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        toggleBtn.Text = "ВЫКЛ"
        disableESP()
    end
end)

-- Обработка новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled and player ~= LocalPlayer then
            addESP(player)
        end
    end)
end)

-- Обработка выхода игроков
Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Обновление при появлении персонажа у локального игрока
LocalPlayer.CharacterAdded:Connect(function()
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                addESP(player)
            end
        end
    end
end)

-- Проверка на исчезновение персонажа
RunService.RenderStepped:Connect(function()
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character and not espData[player] then
                    addESP(player)
                elseif not player.Character and espData[player] then
                    removeESP(player)
                end
            end
        end
    end
end)
