-- 1. Загружаем библиотеку интерфейса
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. Показываем уведомление о начале загрузки
Rayfield:Notify({
   Title = "Загрузка...",
   Content = "Пожалуйста, подождите, основной скрипт загружается",
   Duration = 3,
   Image = 4483362458,
})

-- 3. Загружаем и запускаем ваш основной скрипт
-- Замените 'ССЫЛКА_НА_ВАШ_СКРИПТ' на прямую ссылку (raw)
task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet('https://githubusercontent.com'))()
    end)

    if not success then
        warn("Ошибка загрузки основного скрипта: " .. err)
    end
end)

