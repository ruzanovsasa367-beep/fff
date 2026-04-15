-- Создаем GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = false -- Отключаем встроенное перетаскивание, используем свое

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 12)

-- Панель заголовка для перетаскивания
local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.Parent = titleBar
titleBarCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Parent = titleBar
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ESP Чит Меню"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = titleBar
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0

-- Левая панель с секциями
local leftPanel = Instance.new("Frame")
leftPanel.Parent = mainFrame
leftPanel.Size = UDim2.new(0, 100, 1, -35)
leftPanel.Position = UDim2.new(0, 0, 0, 35)
leftPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
leftPanel.BackgroundTransparency = 0.2
leftPanel.BorderSizePixel = 0

local leftCorner = Instance.new("UICorner")
leftCorner.Parent = leftPanel
leftCorner.CornerRadius = UDim.new(0, 0)

-- Правая панель (контент)
local rightPanel = Instance.new("Frame")
rightPanel.Parent = mainFrame
rightPanel.Size = UDim2.new(1, -100, 1, -35)
rightPanel.Position = UDim2.new(0, 100, 0, 35)
rightPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
rightPanel.BackgroundTransparency = 0.15
rightPanel.BorderSizePixel = 0

local rightCorner = Instance.new("UICorner")
rightCorner.Parent = rightPanel
rightCorner.CornerRadius = UDim.new(0, 0)

-- Функция для создания секции
local function createSection(name, yPosition)
    local sectionBtn = Instance.new("TextButton")
    sectionBtn.Parent = leftPanel
    sectionBtn.Size = UDim2.new(1, 0, 0, 40)
    sectionBtn.Position = UDim2.new(0, 0, 0, yPosition)
    sectionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    sectionBtn.BackgroundTransparency = 0.5
    sectionBtn.Text = name
    sectionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionBtn.TextSize = 14
    sectionBtn.Font = Enum.Font.GothamSemibold
    sectionBtn.BorderSizePixel = 0
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.Parent = sectionBtn
    sectionCorner.CornerRadius = UDim.new(0, 6)
    
    return sectionBtn
end

-- Контент для разных секций
local sections = {}
local currentSection = nil

-- Секция ESP
local espFrame = Instance.new("Frame")
espFrame.Parent = rightPanel
espFrame.Size = UDim2.new(1, -20, 1, -20)
espFrame.Position = UDim2.new(0, 10, 0, 10)
espFrame.BackgroundTransparency = 1
espFrame.Visible = false

local espTitle = Instance.new("TextLabel")
espTitle.Parent = espFrame
espTitle.Size = UDim2.new(1, 0, 0, 30)
espTitle.Position = UDim2.new(0, 0, 0, 0)
espTitle.BackgroundTransparency = 1
espTitle.Text = "Настройки ESP"
espTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
espTitle.TextSize = 18
espTitle.Font = Enum.Font.GothamBold

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = espFrame
toggleBtn.Size = UDim2.new(0, 180, 0, 45)
toggleBtn.Position = UDim2.new(0.5, -90, 0, 50)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleBtn.Text = "ВЫКЛЮЧИТЬ ESP"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 14
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.BorderSizePixel = 0

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = toggleBtn
btnCorner.CornerRadius = UDim.new(0, 8)

-- Секция Настройки
local settingsFrame = Instance.new("Frame")
settingsFrame.Parent = rightPanel
settingsFrame.Size = UDim2.new(1, -20, 1, -20)
settingsFrame.Position = UDim2.new(0, 10, 0, 10)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Parent = settingsFrame
settingsTitle.Size = UDim2.new(1, 0, 0, 30)
settingsTitle.Position = UDim2.new(0, 0, 0, 0)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Настройки"
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.TextSize = 18
settingsTitle.Font = Enum.Font.GothamBold

local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = settingsFrame
infoLabel.Size = UDim2.new(1, 0, 0, 60)
infoLabel.Position = UDim2.new(0, 0, 0, 50)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Здесь будут другие настройки\nСделано с любовью <3"
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.TextSize = 14
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextYAlignment = Enum.TextYAlignment.Top

-- Секция О программе
local aboutFrame = Instance.new("Frame")
aboutFrame.Parent = rightPanel
aboutFrame.Size = UDim2.new(1, -20, 1, -20)
aboutFrame.Position = UDim2.new(0, 10, 0, 10)
aboutFrame.BackgroundTransparency = 1
aboutFrame.Visible = false

local aboutTitle = Instance.new("TextLabel")
aboutTitle.Parent = aboutFrame
aboutTitle.Size = UDim2.new(1, 0, 0, 30)
aboutTitle.Position = UDim2.new(0, 0, 0, 0)
aboutTitle.BackgroundTransparency = 1
aboutTitle.Text = "О программе"
aboutTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
aboutTitle.TextSize = 18
aboutTitle.Font = Enum.Font.GothamBold

local aboutText = Instance.new("TextLabel")
aboutText.Parent = aboutFrame
aboutText.Size = UDim2.new(1, 0, 0, 120)
aboutText.Position = UDim2.new(0, 0, 0, 50)
aboutText.BackgroundTransparency = 1
aboutText.Text = "ESP Чит Меню v1.0\n\nРазработчик: Ваше Имя\n\nФункции:\n• Подсветка игроков\n• Отображение имён\n• И многое другое..."
aboutText.TextColor3 = Color3.fromRGB(200, 200, 200)
aboutText.TextSize = 14
aboutText.Font = Enum.Font.Gotham
aboutText.TextYAlignment = Enum.TextYAlignment.Top
aboutText.TextXAlignment = Enum.TextXAlignment.Left

-- Создаем секции
local espSection = createSection("ESP", 10)
local settingsSection = createSection("Настройки", 60)
local aboutSection = createSection("О программе", 110)

-- Функция переключения секций
local function switchToSection(sectionName)
    espFrame.Visible = (sectionName == "ESP")
    settingsFrame.Visible = (sectionName == "Настройки")
    aboutFrame.Visible = (sectionName == "О программе")
    
    -- Обновляем стиль кнопок секций
    local sections = {espSection, settingsSection, aboutSection}
    for _, btn in ipairs(sections) do
        if (btn == espSection and sectionName == "ESP") or
           (btn == settingsSection and sectionName == "Настройки") or
           (btn == aboutSection and sectionName == "О программе") then
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
            btn.BackgroundTransparency = 0.2
        else
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            btn.BackgroundTransparency = 0.5
        end
    end
end

-- Назначаем обработчики секций
espSection.MouseButton1Click:Connect(function() switchToSection("ESP") end)
settingsSection.MouseButton1Click:Connect(function() switchToSection("Настройки") end)
aboutSection.MouseButton1Click:Connect(function() switchToSection("О программе") end)

-- Показываем первую секцию
switchToSection("ESP")

-- Закрытие GUI
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = not screenGui.Enabled
end)

-- Перетаскивание GUI
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ESP логика
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

-- Обработчик кнопки ESP
toggleBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    
    if espEnabled then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        toggleBtn.Text = "ВКЛЮЧИТЬ ESP"
        enableESP()
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        toggleBtn.Text = "ВЫКЛЮЧИТЬ ESP"
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
