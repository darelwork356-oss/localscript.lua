-- 50 NOCHES EN LA ESCUELA
-- Colocar en: ServerScriptService
-- Juego de supervivencia completo

print("🏫 Iniciando 50 Noches en la Escuela...")
wait(1)

-- Limpiar
for _, obj in pairs(workspace:GetChildren()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
        obj:Destroy()
    end
end

-- CONFIGURACIÓN
local NIGHT_DURATION = 300
local DAY_DURATION = 120
local MAX_NIGHTS = 50

-- ESCUELA
local school = Instance.new("Model", workspace)
school.Name = "School"

-- Suelo base
local floor = Instance.new("Part", school)
floor.Size = Vector3.new(300, 1, 300)
floor.Position = Vector3.new(0, 0, 0)
floor.Anchored = true
floor.Material = Enum.Material.Concrete
floor.Color = Color3.fromRGB(80, 80, 80)

-- Entrada Principal
local entrance = Instance.new("Model", school)
entrance.Name = "Entrance"

local entranceFloor = Instance.new("Part", entrance)
entranceFloor.Size = Vector3.new(40, 0.5, 30)
entranceFloor.Position = Vector3.new(0, 0.25, -120)
entranceFloor.Anchored = true
entranceFloor.Material = Enum.Material.Marble
entranceFloor.Color = Color3.fromRGB(200, 200, 200)

local reception = Instance.new("Part", entrance)
reception.Size = Vector3.new(15, 4, 6)
reception.Position = Vector3.new(0, 2, -110)
reception.Anchored = true
reception.Material = Enum.Material.Wood
reception.Color = Color3.fromRGB(101, 67, 33)

-- Spawn
local spawn = Instance.new("SpawnLocation", entrance)
spawn.Size = Vector3.new(10, 1, 10)
spawn.Position = Vector3.new(0, 1, -125)
spawn.Anchored = true
spawn.Transparency = 0.5
spawn.BrickColor = BrickColor.new("Bright green")
spawn.Duration = 0

-- Pasillos
local hallways = Instance.new("Folder", school)
hallways.Name = "Hallways"

for i = 1, 4 do
    local hall = Instance.new("Part", hallways)
    hall.Size = Vector3.new(10, 8, 100)
    hall.Position = Vector3.new(-50 + i * 30, 4, 0)
    hall.Anchored = true
    hall.Material = Enum.Material.Concrete
    hall.Color = Color3.fromRGB(120, 120, 120)
    
    -- Luces parpadeantes
    local light = Instance.new("PointLight", hall)
    light.Brightness = 2
    light.Range = 40
    light.Color = Color3.fromRGB(255, 240, 200)
    
    task.spawn(function()
        while hall.Parent do
            wait(math.random(2, 8))
            light.Enabled = false
            wait(math.random(1, 3) / 10)
            light.Enabled = true
        end
    end)
end

-- Aulas
local classrooms = Instance.new("Folder", school)
classrooms.Name = "Classrooms"

for i = 1, 12 do
    local room = Instance.new("Model", classrooms)
    room.Name = "Classroom" .. i
    
    local roomFloor = Instance.new("Part", room)
    roomFloor.Size = Vector3.new(20, 0.5, 20)
    local x = (i % 2 == 0) and 60 or -60
    local z = -80 + math.floor((i - 1) / 2) * 35
    roomFloor.Position = Vector3.new(x, 0.25, z)
    roomFloor.Anchored = true
    roomFloor.Material = Enum.Material.Tile
    roomFloor.Color = Color3.fromRGB(180, 180, 160)
    
    -- Escritorios
    for j = 1, 6 do
        local desk = Instance.new("Part", room)
        desk.Size = Vector3.new(4, 3, 2.5)
        desk.Position = Vector3.new(x + (j % 3 - 1) * 6, 1.5, z + math.floor((j - 1) / 3) * 8 - 4)
        desk.Anchored = true
        desk.Material = Enum.Material.Wood
        desk.Color = Color3.fromRGB(139, 90, 43)
    end
end

-- Cafetería
local cafeteria = Instance.new("Model", school)
cafeteria.Name = "Cafeteria"

local cafFloor = Instance.new("Part", cafeteria)
cafFloor.Size = Vector3.new(50, 0.5, 40)
cafFloor.Position = Vector3.new(0, 0.25, 60)
cafFloor.Anchored = true
cafFloor.Material = Enum.Material.Tile
cafFloor.Color = Color3.fromRGB(200, 200, 180)

-- Mesas
for i = 1, 10 do
    local table = Instance.new("Part", cafeteria)
    table.Size = Vector3.new(8, 3, 3)
    table.Position = Vector3.new(-20 + (i % 5) * 10, 1.5, 50 + math.floor((i - 1) / 5) * 15)
    table.Anchored = true
    table.Material = Enum.Material.SmoothPlastic
    table.Color = Color3.fromRGB(100, 100, 100)
end

-- Biblioteca
local library = Instance.new("Model", school)
library.Name = "Library"

local libFloor = Instance.new("Part", library)
libFloor.Size = Vector3.new(35, 0.5, 35)
libFloor.Position = Vector3.new(-80, 0.25, 60)
libFloor.Anchored = true
libFloor.Material = Enum.Material.Wood
libFloor.Color = Color3.fromRGB(101, 67, 33)

-- Estanterías
for i = 1, 8 do
    local shelf = Instance.new("Part", library)
    shelf.Size = Vector3.new(10, 8, 1.5)
    shelf.Position = Vector3.new(-85 + (i % 4) * 12, 4, 50 + math.floor((i - 1) / 4) * 20)
    shelf.Anchored = true
    shelf.Material = Enum.Material.Wood
    shelf.Color = Color3.fromRGB(70, 40, 20)
end

-- Baños
local bathrooms = Instance.new("Model", school)
bathrooms.Name = "Bathrooms"

local bathFloor = Instance.new("Part", bathrooms)
bathFloor.Size = Vector3.new(25, 0.5, 20)
bathFloor.Position = Vector3.new(80, 0.25, -50)
bathFloor.Anchored = true
bathFloor.Material = Enum.Material.Tile
bathFloor.Color = Color3.fromRGB(220, 220, 220)

-- Enfermería
local infirmary = Instance.new("Model", school)
infirmary.Name = "Infirmary"

local infFloor = Instance.new("Part", infirmary)
infFloor.Size = Vector3.new(20, 0.5, 20)
infFloor.Position = Vector3.new(80, 0.25, 20)
infFloor.Anchored = true
infFloor.Material = Enum.Material.Tile
infFloor.Color = Color3.fromRGB(240, 240, 255)

-- Camillas
for i = 1, 3 do
    local bed = Instance.new("Part", infirmary)
    bed.Size = Vector3.new(3, 2, 6)
    bed.Position = Vector3.new(75 + i * 5, 1, 20)
    bed.Anchored = true
    bed.Material = Enum.Material.Fabric
    bed.Color = Color3.fromRGB(255, 255, 255)
end

-- Oficina del Director
local office = Instance.new("Model", school)
office.Name = "DirectorOffice"

local offFloor = Instance.new("Part", office)
offFloor.Size = Vector3.new(18, 0.5, 18)
offFloor.Position = Vector3.new(0, 0.25, -80)
offFloor.Anchored = true
offFloor.Material = Enum.Material.Carpet
offFloor.Color = Color3.fromRGB(100, 50, 50)

local desk = Instance.new("Part", office)
desk.Size = Vector3.new(8, 3, 4)
desk.Position = Vector3.new(0, 1.5, -75)
desk.Anchored = true
desk.Material = Enum.Material.Wood
desk.Color = Color3.fromRGB(50, 30, 20)

print("✅ Escuela construida")

-- SISTEMA DE COMIDA
local foodFolder = Instance.new("Folder", workspace)
foodFolder.Name = "Food"

local foodSpawns = {
    {pos = Vector3.new(0, 2, 60), type = "Pan"},
    {pos = Vector3.new(10, 2, 65), type = "Snack"},
    {pos = Vector3.new(-10, 2, 55), type = "Comida"},
    {pos = Vector3.new(15, 2, 70), type = "Pan"},
    {pos = Vector3.new(-15, 2, 60), type = "Snack"},
}

for _, data in pairs(foodSpawns) do
    local food = Instance.new("Part", foodFolder)
    food.Name = data.type
    food.Size = Vector3.new(2, 2, 2)
    food.Position = data.pos
    food.Anchored = true
    food.Material = Enum.Material.Neon
    food.Color = Color3.fromRGB(255, 200, 100)
    
    local prompt = Instance.new("ProximityPrompt", food)
    prompt.ActionText = "Comer"
    prompt.ObjectText = "🍞 " .. data.type
    prompt.HoldDuration = 1
    prompt.MaxActivationDistance = 8
end

-- SISTEMA DE BOTIQUINES
local medkits = Instance.new("Folder", workspace)
medkits.Name = "Medkits"

for i = 1, 5 do
    local kit = Instance.new("Part", medkits)
    kit.Name = "Medkit"
    kit.Size = Vector3.new(2, 2, 2)
    kit.Position = Vector3.new(80, 2, 15 + i * 3)
    kit.Anchored = true
    kit.Material = Enum.Material.Neon
    kit.Color = Color3.fromRGB(255, 50, 50)
    
    local prompt = Instance.new("ProximityPrompt", kit)
    prompt.ActionText = "Recoger"
    prompt.ObjectText = "🩹 Botiquín"
    prompt.HoldDuration = 0.5
    prompt.MaxActivationDistance = 8
end

print("✅ Recursos creados")

-- SISTEMA DE JUGADORES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables globales
local currentDay = 1
local currentNight = 1
local isNight = false
local timeRemaining = DAY_DURATION

-- GUI remota
local updateGui = Instance.new("RemoteEvent", ReplicatedStorage)
updateGui.Name = "UpdateGui"

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(0.5)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.MaxHealth = 100
            hum.Health = 100
        end
        
        -- Stats
        local stats = Instance.new("Folder", player)
        stats.Name = "Stats"
        
        local hunger = Instance.new("IntValue", stats)
        hunger.Name = "Hunger"
        hunger.Value = 100
        
        local fear = Instance.new("IntValue", stats)
        fear.Name = "Fear"
        fear.Value = 0
        
        local energy = Instance.new("IntValue", stats)
        energy.Name = "Energy"
        energy.Value = 100
        
        -- Leaderboard
        local leader = Instance.new("Folder", player)
        leader.Name = "leaderstats"
        
        local nightsSurvived = Instance.new("IntValue", leader)
        nightsSurvived.Name = "Noches"
        nightsSurvived.Value = 0
        
        -- Sistema de hambre
        task.spawn(function()
            while player.Parent and char.Parent do
                wait(10)
                if hunger.Value > 0 then
                    hunger.Value = hunger.Value - 2
                else
                    if hum and hum.Health > 0 then
                        hum.Health = hum.Health - 5
                    end
                end
            end
        end)
        
        -- Sistema de energía
        task.spawn(function()
            while player.Parent and char.Parent do
                wait(15)
                if energy.Value > 0 then
                    energy.Value = energy.Value - 3
                end
            end
        end)
    end)
end)

-- Interacciones de comida
for _, food in pairs(foodFolder:GetChildren()) do
    local prompt = food:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        prompt.Triggered:Connect(function(player)
            local stats = player:FindFirstChild("Stats")
            if stats then
                local hunger = stats:FindFirstChild("Hunger")
                if hunger then
                    if food.Name == "Pan" then
                        hunger.Value = math.min(100, hunger.Value + 15)
                    elseif food.Name == "Snack" then
                        hunger.Value = math.min(100, hunger.Value + 25)
                    elseif food.Name == "Comida" then
                        hunger.Value = math.min(100, hunger.Value + 40)
                    end
                end
            end
            food:Destroy()
        end)
    end
end

-- Interacciones de botiquines
for _, kit in pairs(medkits:GetChildren()) do
    local prompt = kit:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        prompt.Triggered:Connect(function(player)
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Health = math.min(hum.MaxHealth, hum.Health + 30)
                end
            end
            kit:Destroy()
        end)
    end
end

print("✅ Sistema de jugadores listo")

-- ENEMIGOS
local enemies = Instance.new("Folder", workspace)
enemies.Name = "Enemies"

local function spawnEnemy(night)
    local enemy = Instance.new("Part", enemies)
    enemy.Name = "Enemy"
    enemy.Size = Vector3.new(4, 6, 2)
    enemy.Position = Vector3.new(math.random(-100, 100), 3, math.random(-100, 100))
    enemy.Anchored = false
    enemy.Material = Enum.Material.Neon
    enemy.Color = Color3.fromRGB(150, 0, 0)
    enemy.CanCollide = true
    
    local hum = Instance.new("Humanoid", enemy)
    hum.WalkSpeed = 12 + night * 0.5
    hum.MaxHealth = 100
    hum.Health = 100
    
    local light = Instance.new("PointLight", enemy)
    light.Color = Color3.fromRGB(255, 0, 0)
    light.Brightness = 3
    light.Range = 20
    
    -- IA básica
    task.spawn(function()
        while enemy.Parent and hum.Health > 0 do
            wait(2)
            local target = nil
            local closest = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (hrp.Position - enemy.Position).Magnitude
                        if dist < closest and dist < 100 then
                            closest = dist
                            target = hrp
                        end
                    end
                end
            end
            
            if target then
                hum:MoveTo(target.Position)
            else
                hum:MoveTo(enemy.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20)))
            end
        end
    end)
    
    -- Daño al contacto
    enemy.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChildOfClass("Humanoid") then
            local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                hum.Health = hum.Health - 20
            end
        end
    end)
end

-- CICLO DÍA/NOCHE
local Lighting = game:GetService("Lighting")

task.spawn(function()
    while true do
        -- DÍA
        isNight = false
        timeRemaining = DAY_DURATION
        Lighting.ClockTime = 12
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(150, 150, 150)
        
        -- Limpiar enemigos
        for _, enemy in pairs(enemies:GetChildren()) do
            enemy:Destroy()
        end
        
        print("☀️ DÍA " .. currentDay)
        
        for i = DAY_DURATION, 0, -1 do
            timeRemaining = i
            wait(1)
        end
        
        -- NOCHE
        isNight = true
        currentNight = currentNight + 1
        timeRemaining = NIGHT_DURATION
        Lighting.ClockTime = 0
        Lighting.Brightness = 0.5
        Lighting.Ambient = Color3.fromRGB(20, 20, 40)
        
        -- Actualizar noches sobrevividas
        for _, player in pairs(Players:GetPlayers()) do
            local leader = player:FindFirstChild("leaderstats")
            if leader then
                local nights = leader:FindFirstChild("Noches")
                if nights then
                    nights.Value = currentNight - 1
                end
            end
        end
        
        print("🌙 NOCHE " .. currentNight)
        
        -- Spawn enemigos
        local enemyCount = math.min(currentNight, 20)
        for i = 1, enemyCount do
            wait(0.5)
            spawnEnemy(currentNight)
        end
        
        for i = NIGHT_DURATION, 0, -1 do
            timeRemaining = i
            wait(1)
        end
        
        currentDay = currentDay + 1
        
        if currentNight >= MAX_NIGHTS then
            print("🏆 ¡JUEGO COMPLETADO! 50 NOCHES SOBREVIVIDAS")
            break
        end
    end
end)

-- Iluminación
Lighting.Ambient = Color3.fromRGB(150, 150, 150)
Lighting.Brightness = 2
Lighting.ClockTime = 12
Lighting.FogEnd = 200
Lighting.FogColor = Color3.fromRGB(100, 100, 100)

local atmos = Instance.new("Atmosphere", Lighting)
atmos.Density = 0.4
atmos.Color = Color3.fromRGB(150, 150, 150)

print("")
print("🎉 ═══════════════════════════════")
print("✅ 50 NOCHES EN LA ESCUELA - LISTO")
print("═══════════════════════════════")
print("🏫 Escuela completa con zonas")
print("🍞 Sistema de comida y hambre")
print("❤️ Sistema de vida y supervivencia")
print("👹 Enemigos con IA que aumentan cada noche")
print("🌙 Ciclo día/noche automático")
print("🎯 Objetivo: Sobrevivir 50 noches")
print("═══════════════════════════════")
print("")
