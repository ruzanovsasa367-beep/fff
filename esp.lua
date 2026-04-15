-- Создать окно UI
local Window = Library.CreateLib("ESP + Aimbot Menu", "RJTheme3")

-- Вкладка ESP
local ESPTab = Window:NewTab("ESP")

-- Секция ESP
local ESPsection = ESPTab:NewSection("Настройки ESP")

-- Переключатель ESP
local espEnabled = false
local espData = {}

ESPsection:NewToggle("Включить ESP", "Подсветка игроков и отображение имён", function(state)
    espEnabled = state
    if espEnabled then
        enableESP()
    else
        disableESP()
    end
end)

-- Настройки цвета ESP
local colors = {
    Red = Color3.fromRGB(255, 0, 0),
    Green = Color3.fromRGB(0, 255, 0),
    Blue = Color3.fromRGB(0, 0, 255),
    Yellow = Color3.fromRGB(255, 255, 0),
    Purple = Color3.fromRGB(255, 0, 255),
    Cyan = Color3.fromRGB(0, 255, 255),
    White = Color3.fromRGB(255, 255, 255)
}

local selectedColor = colors.Red

ESPsection:NewDropdown("Цвет подсветки", "Выберите цвет ESP", {"Red", "Green", "Blue", "Yellow", "Purple", "Cyan", "White"}, function(currentOption)
    selectedColor = colors[currentOption]
    if espEnabled then
        -- Обновляем цвета для всех активных ESP
        for player, data in pairs(espData) do
            if data.highlight then
                data.highlight.FillColor = selectedColor
            end
        end
    end
end)

-- Прозрачность подсветки
local fillTransparency = 0.6
ESPsection:NewSlider("Прозрачность подсветки", "Настройка прозрачности ESP", 100, 0, function(s)
    fillTransparency = s / 100
    if espEnabled then
        for player, data in pairs(espData) do
            if data.highlight then
                data.highlight.FillTransparency = fillTransparency
            end
        end
    end
end)

-- Вкладка Aimbot
local AimbotTab = Window:NewTab("Aimbot")

-- Секция Aimbot
local AimbotSection = AimbotTab:NewSection("Настройки Aimbot")

-- Переключатель Aimbot
local aimbotEnabled = false
local aimbotSettings = {
    smoothness = 5,
    fov = 100,
    hitChance = 100,
    targetPart = "Head"
}

AimbotSection:NewToggle("Включить Aimbot", "Автоматическое прицеливание в противников", function(state)
    aimbotEnabled = state
end)

-- Настройка плавности
AimbotSection:NewSlider("Плавность прицеливания", "Чем выше значение, тем плавнее", 20, 1, function(s)
    aimbotSettings.smoothness = s
end)

-- Настройка FOV
AimbotSection:NewSlider("Радиус FOV", "Зона поиска цели (30-200)", 200, 30, function(s)
    aimbotSettings.fov = s
end)

-- Настройка шанса попадания
AimbotSection:NewSlider("Шанс попадания", "Вероятность попадания в цель (0-100%)", 100, 0, function(s)
    aimbotSettings.hitChance = s
end)

-- Выбор части тела
AimbotSection:NewDropdown("Часть тела для цели", "Куда будет целиться аимбот", {"Head", "Torso", "HumanoidRootPart"}, function(currentOption)
    aimbotSettings.targetPart = currentOption
end)

-- Вкладка Настройки
local SettingsTab = Window:NewTab("Настройки")

-- Секция информации
local InfoSection = SettingsTab:NewSection("Информация")

InfoSection:NewLabel("ESP + Aimbot Menu v2.0")
InfoSection:NewLabel("Разработчик: Your Name")
InfoSection:NewLabel("Функции:")
InfoSection:NewLabel("• ESP (Подсветка игроков)")
InfoSection:NewLabel("• Отображение имён над головами")
InfoSection:NewLabel("• Aimbot с настройками")
InfoSection:NewLabel("• Настройка цвета и прозрачности")
InfoSection:NewLabel("• Плавность прицеливания")
InfoSection:NewLabel("• Регулировка FOV")

-- Кнопка для телепортации
local TeleportSection = SettingsTab:NewSection("Телепортация")

TeleportSection:NewButton("Телепорт к игроку", "Телепортироваться к выбранному игроку", function()
    local players = {}
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    
    -- Простой выбор через ввод
    local playerName = game:GetService("Players").LocalPlayer:GetMouse().Target
    -- Здесь можно добавить более продвинутый выбор игрока
    print("Функция телепортации (требует доработки)")
end)

-- Вкладка О программе
local AboutTab = Window:NewTab("О программе")
local AboutSection = AboutTab:NewSection("О программе")

AboutSection:NewLabel("ESP + Aimbot Чит Меню")
AboutSection:NewLabel("Версия: 2.0")
AboutSection:NewLabel("")
AboutSection:NewLabel("Описание:")
AboutSection:NewLabel("Мощный чит с функциями ESP и Aimbot")
AboutSection:NewLabel("Поддерживает настройку цветов и прозрачности")
AboutSection:NewLabel("Aimbot с регулируемой плавностью и FOV")
AboutSection:NewLabel("")
AboutSection:NewLabel("Управление:")
AboutSection:NewLabel("• ВКЛ/ВЫКЛ ESP - вкладка ESP")
AboutSection:NewLabel("• ВКЛ/ВЫКЛ Aimbot - вкладка Aimbot")
AboutSection:NewLabel("• Настройки цветов - вкладка ESP")

-- ===== ESP ЛОГИКА =====
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Функция для создания ESP для игрока
local function addESP(player)
    if player == LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.FillColor = selectedColor
    highlight.FillTransparency = fillTransparency
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
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Parent = billboard
        distanceLabel.Size = UDim2.new(1, 0, 0, 20)
        distanceLabel.Position = UDim2.new(0, 0, 1, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = ""
        distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distanceLabel.TextSize = 12
        distanceLabel.Font = Enum.Font.Gotham
        distanceLabel.TextStrokeTransparency = 0.3
        
        espData[player] = {
            highlight = highlight,
            billboard = billboard,
            distanceLabel = distanceLabel
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

-- Обновление расстояния и проверка персонажей
RunService.RenderStepped:Connect(function()
    if espEnabled then
        local localChar = LocalPlayer.Character
        local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character and not espData[player] then
                    addESP(player)
                elseif not player.Character and espData[player] then
                    removeESP(player)
                elseif espData[player] and player.Character and localHRP then
                    -- Обновление расстояния
                    local charHRP = player.Character:FindFirstChild("HumanoidRootPart")
                    if charHRP and espData[player].distanceLabel then
                        local distance = (localHRP.Position - charHRP.Position).Magnitude
                        local formattedDistance = string.format("%.1f", distance)
                        espData[player].distanceLabel.Text = formattedDistance .. " м"
                        
                        -- Меняем цвет в зависимости от расстояния
                        if distance < 20 then
                            espData[player].distanceLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                        elseif distance < 50 then
                            espData[player].distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                        else
                            espData[player].distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        end
                    end
                end
            end
        end
    end
end)

-- ===== AIMBOT ЛОГИКА =====
local camera = workspace.CurrentCamera
local mouse = LocalPlayer:GetMouse()

-- Функция для получения ближайшего игрока в FOV
local function getClosestPlayer()
    if not aimbotEnabled then return nil end
    
    local closestPlayer = nil
    local closestDistance = aimbotSettings.fov
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild(aimbotSettings.targetPart)
            if targetPart then
                local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local distance = (mousePos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if distance < closestDistance then
                        -- Проверка шанса попадания
                        if math.random(1, 100) <= aimbotSettings.hitChance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

-- Простая реализация aimbot (для демонстрации)
-- В реальном чите потребуется более сложная логика
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(aimbotSettings.targetPart)
            if targetPart then
                -- Здесь можно добавить плавное прицеливание
                -- Для полной функциональности требуется использование mousemoverel или других методов
                -- Эта часть требует дополнительной реализации в зависимости от игры
            end
        end
    end
end)

-- Вывод сообщения о загрузке
print("ESP + Aimbot Menu загружен!")
print("Используйте UI для настройки функций")
