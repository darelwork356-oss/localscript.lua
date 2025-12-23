-- 50 NOCHES EN LA ESCUELA
-- Juego de supervivencia y terror
-- Colocar en: ServerScriptService

print("🏫 Iniciando: 50 NOCHES EN LA ESCUELA")
wait(1)

workspace:ClearAllChildren()
game.Lighting:ClearAllChildren()

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Variables globales
_G.CurrentNight = 1
_G.IsNight = true
_G.TimeRemaining = 480 -- 8 minutos por noche

-- Eventos
local updateUI = Instance.new("RemoteEvent", RS)
updateUI.Name = "UpdateUI"

local eatFood = Instance.new("RemoteEvent", RS)
eatFood.Name = "EatFood"

-- CONSTRUCCIÓN DE LA ESCUELA
local school = Instance.new("Model", workspace)
school.Name = "School"

-- Suelo base
local floor = Instance.new("Part", school)
floor.Size = Vector3.new(300, 1, 300)
floor.Position = Vector3.new(0, 0, 0)
floor.Anchored = true
floor.Material = Enum.Material.Concrete
floor.Color = Color3.fromRGB(80, 80, 80)

-- 1. ENTRADA PRINCIPAL
local entrance = Instance.new("Model", school)
entrance.Name = "Entrance"

local entranceFloor = Instance.new("Part", entrance)
entranceFloor.Size = Vector3.new(40, 0.5, 30)
entranceFloor.Position = Vector3.new(0, 0.5, -120)
entranceFloor.Anchored = true
entranceFloor.Material = Enum.Material.Marble
entranceFloor.Color = Color3.fromRGB(200, 200, 200)

-- Puertas de entrada
for i = 1, 2 do
    local door = Instance.new("Part", entrance)
    door.Size = Vector3.new(8, 12, 0.5)
    door.Position = Vector3.new(-5 + i*10, 6, -135)
    door.Anchored = true
    door.Material = Enum.Material.Glass
    door.Color = Color3.fromRGB(100, 150, 200)
    door.Transparency = 0.3
end

-- Mostrador de recepción
local desk = Instance.new("Part", entrance)
desk.Size = Vector3.new(15, 4, 3)
desk.Position = Vector3.new(0, 2, -115)
desk.Anchored = true
desk.Material = Enum.Material.Wood
desk.Color = Color3.fromRGB(101, 67, 33)

-- Cartel de la escuela
local sign = Instance.new("Part", entrance)
sign.Size = Vector3.new(20, 5, 0.5)
sign.Position = Vector3.new(0, 10, -105)
sign.Anchored = true
sign.Material = Enum.Material.SmoothPlastic
sign.Color = Color3.fromRGB(50, 50, 50)

local signText = Instance.new("SurfaceGui", sign)
signText.Face = Enum.NormalId.Front
local label = Instance.new("TextLabel", signText)
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "ESCUELA ABANDONADA"
label.TextColor3 = Color3.fromRGB(255, 0, 0)
label.TextSize = 48
label.Font = Enum.Font.GothamBold

-- Spawn
local spawn = Instance.new("SpawnLocation", entrance)
spawn.Size = Vector3.new(10, 1, 10)
spawn.Position = Vector3.new(0, 1, -120)
spawn.Anchored = true
spawn.Transparency = 0.5
spawn.CanCollide = false
spawn.Duration = 0

print("✅ Entrada creada")

-- 2. PASILLOS
local hallways = Instance.new("Model", school)
hallways.Name = "Hallways"

-- Pasillo principal (largo)
for i = 1, 10 do
    local wall1 = Instance.new("Part", hallways)
    wall1.Size = Vector3.new(1, 15, 20)
    wall1.Position = Vector3.new(-20, 7.5, -100 + i*20)
    wall1.Anchored = true
    wall1.Material = Enum.Material.Brick
    wall1.Color = Color3.fromRGB(150, 150, 150)
    
    local wall2 = Instance.new("Part", hallways)
    wall2.Size = Vector3.new(1, 15, 20)
    wall2.Position = Vector3.new(20, 7.5, -100 + i*20)
    wall2.Anchored = true
    wall2.Material = Enum.Material.Brick
    wall2.Color = Color3.fromRGB(150, 150, 150)
    
    -- Luces parpadeantes
    if i % 2 == 0 then
        local light = Instance.new("Part", hallways)
        light.Size = Vector3.new(2, 0.5, 2)
        light.Position = Vector3.new(0, 14, -100 + i*20)
        light.Anchored = true
        light.Material = Enum.Material.Neon
        light.Color = Color3.fromRGB(255, 255, 200)
        
        local pointLight = Instance.new("PointLight", light)
        pointLight.Brightness = 2
        pointLight.Range = 30
        
        task.spawn(function()
            while light.Parent do
                pointLight.Enabled = math.random() > 0.3
                wait(math.random(1, 5))
            end
        end)
    end
    
    -- Casilleros
    for j = 1, 5 do
        local locker = Instance.new("Part", hallways)
        locker.Size = Vector3.new(2, 8, 2)
        locker.Position = Vector3.new(-19, 4, -105 + i*20 + j*3)
        locker.Anchored = true
        locker.Material = Enum.Material.Metal
        locker.Color = Color3.fromRGB(100, 100, 120)
        
        local prompt = Instance.new("ProximityPrompt", locker)
        prompt.ActionText = "Abrir"
        prompt.ObjectText = "Casillero"
        prompt.HoldDuration = 1
        prompt.MaxActivationDistance = 5
    end
end

print("✅ Pasillos creados")

-- 3. AULAS (6 aulas)
local classrooms = Instance.new("Model", school)
classrooms.Name = "Classrooms"

for room = 1, 6 do
    local classroom = Instance.new("Model", classrooms)
    classroom.Name = "Classroom"..room
    
    local xPos = room <= 3 and -40 or 40
    local zPos = -80 + (room % 3) * 40
    
    -- Paredes del aula
    for _, wall in pairs({
        {Vector3.new(15, 12, 1), Vector3.new(xPos, 6, zPos - 10)},
        {Vector3.new(15, 12, 1), Vector3.new(xPos, 6, zPos + 10)},
        {Vector3.new(1, 12, 20), Vector3.new(xPos - 7.5, 6, zPos)},
        {Vector3.new(1, 12, 20), Vector3.new(xPos + 7.5, 6, zPos)}
    }) do
        local w = Instance.new("Part", classroom)
        w.Size = wall[1]
        w.Position = wall[2]
        w.Anchored = true
        w.Material = Enum.Material.Concrete
        w.Color = Color3.fromRGB(180, 180, 180)
    end
    
    -- Escritorios (12 por aula)
    for i = 1, 12 do
        local desk = Instance.new("Part", classroom)
        desk.Size = Vector3.new(3, 3, 2)
        desk.Position = Vector3.new(xPos - 5 + (i % 4) * 3, 1.5, zPos - 6 + math.floor(i / 4) * 4)
        desk.Anchored = true
        desk.Material = Enum.Material.Wood
        desk.Color = Color3.fromRGB(139, 90, 43)
    end
    
    -- Pizarra
    local board = Instance.new("Part", classroom)
    board.Size = Vector3.new(10, 5, 0.5)
    board.Position = Vector3.new(xPos, 7, zPos - 9.5)
    board.Anchored = true
    board.Material = Enum.Material.SmoothPlastic
    board.Color = Color3.fromRGB(20, 50, 20)
    
    -- Mochilas con comida
    for i = 1, 3 do
        local backpack = Instance.new("Part", classroom)
        backpack.Size = Vector3.new(2, 2, 2)
        backpack.Position = Vector3.new(xPos + math.random(-5, 5), 1, zPos + math.random(-5, 5))
        backpack.Anchored = true
        backpack.Material = Enum.Material.Fabric
        backpack.Color = Color3.fromRGB(math.random(100, 200), math.random(100, 200), math.random(100, 200))
        
        local prompt = Instance.new("ProximityPrompt", backpack)
        prompt.ActionText = "Revisar"
        prompt.ObjectText = "🎒 Mochila"
        prompt.HoldDuration = 2
        prompt.MaxActivationDistance = 5
    end
end

print("✅ 6 aulas creadas")

-- 4. CAFETERÍA
local cafeteria = Instance.new("Model", school)
cafeteria.Name = "Cafeteria"

local cafFloor = Instance.new("Part", cafeteria)
cafFloor.Size = Vector3.new(50, 0.5, 40)
cafFloor.Position = Vector3.new(0, 0.5, 50)
cafFloor.Anchored = true
cafFloor.Material = Enum.Material.Tile
cafFloor.Color = Color3.fromRGB(220, 220, 220)

-- Mesas (20 mesas)
for i = 1, 20 do
    local table = Instance.new("Part", cafeteria)
    table.Size = Vector3.new(8, 3, 3)
    table.Position = Vector3.new(-20 + (i % 5) * 10, 1.5, 35 + math.floor(i / 5) * 8)
    table.Anchored = true
    table.Material = Enum.Material.Wood
    table.Color = Color3.fromRGB(139, 90, 43)
end

-- Cocina
local kitchen = Instance.new("Part", cafeteria)
kitchen.Size = Vector3.new(20, 10, 15)
kitchen.Position = Vector3.new(0, 5, 65)
kitchen.Anchored = true
kitchen.Material = Enum.Material.Metal
kitchen.Color = Color3.fromRGB(150, 150, 150)

-- Neveras con comida
for i = 1, 3 do
    local fridge = Instance.new("Part", cafeteria)
    fridge.Size = Vector3.new(4, 8, 3)
    fridge.Position = Vector3.new(-8 + i*8, 4, 68)
    fridge.Anchored = true
    fridge.Material = Enum.Material.Metal
    fridge.Color = Color3.fromRGB(200, 200, 200)
    
    local prompt = Instance.new("ProximityPrompt", fridge)
    prompt.ActionText = "Abrir"
    prompt.ObjectText = "🍞 Nevera"
    prompt.HoldDuration = 1
    prompt.MaxActivationDistance = 5
end

print("✅ Cafetería creada")

-- 5. BIBLIOTECA
local library = Instance.new("Model", school)
library.Name = "Library"

local libFloor = Instance.new("Part", library)
libFloor.Size = Vector3.new(40, 0.5, 30)
libFloor.Position = Vector3.new(-80, 0.5, 0)
libFloor.Anchored = true
libFloor.Material = Enum.Material.Wood
libFloor.Color = Color3.fromRGB(101, 67, 33)

-- Estanterías (15 estanterías)
for i = 1, 15 do
    local shelf = Instance.new("Part", library)
    shelf.Size = Vector3.new(8, 10, 2)
    shelf.Position = Vector3.new(-90 + (i % 5) * 10, 5, -10 + math.floor(i / 5) * 10)
    shelf.Anchored = true
    shelf.Material = Enum.Material.Wood
    shelf.Color = Color3.fromRGB(80, 50, 30)
    
    -- Libros
    for j = 1, 5 do
        local book = Instance.new("Part", shelf)
        book.Size = Vector3.new(1, 2, 0.5)
        book.Position = shelf.Position + Vector3.new(-3 + j*1.5, math.random(-3, 3), 1)
        book.Anchored = true
        book.Material = Enum.Material.SmoothPlastic
        book.Color = Color3.fromRGB(math.random(100, 255), math.random(100, 255), math.random(100, 255))
    end
end

print("✅ Biblioteca creada")

-- 6. BAÑOS
local bathrooms = Instance.new("Model", school)
bathrooms.Name = "Bathrooms"

for b = 1, 2 do
    local bathroom = Instance.new("Model", bathrooms)
    bathroom.Name = b == 1 and "BoysRoom" or "GirlsRoom"
    
    local xPos = 80
    local zPos = b == 1 and -20 or 20
    
    local floor = Instance.new("Part", bathroom)
    floor.Size = Vector3.new(20, 0.5, 15)
    floor.Position = Vector3.new(xPos, 0.5, zPos)
    floor.Anchored = true
    floor.Material = Enum.Material.Tile
    floor.Color = Color3.fromRGB(200, 200, 200)
    
    -- Espejos rotos
    for i = 1, 3 do
        local mirror = Instance.new("Part", bathroom)
        mirror.Size = Vector3.new(3, 4, 0.2)
        mirror.Position = Vector3.new(xPos - 8, 6, zPos - 5 + i*5)
        mirror.Anchored = true
        mirror.Material = Enum.Material.Glass
        mirror.Color = Color3.fromRGB(150, 150, 150)
        mirror.Transparency = 0.3
    end
end

print("✅ Baños creados")

-- 7. ENFERMERÍA
local infirmary = Instance.new("Model", school)
infirmary.Name = "Infirmary"

local infFloor = Instance.new("Part", infirmary)
infFloor.Size = Vector3.new(25, 0.5, 20)
infFloor.Position = Vector3.new(80, 0.5, 80)
infFloor.Anchored = true
infFloor.Material = Enum.Material.Tile
infFloor.Color = Color3.fromRGB(255, 255, 255)

-- Camillas (4 camillas)
for i = 1, 4 do
    local bed = Instance.new("Part", infirmary)
    bed.Size = Vector3.new(6, 2, 3)
    bed.Position = Vector3.new(75 + (i % 2) * 10, 1, 75 + math.floor(i / 2) * 10)
    bed.Anchored = true
    bed.Material = Enum.Material.Fabric
    bed.Color = Color3.fromRGB(255, 255, 255)
end

-- Gabinetes médicos
for i = 1, 3 do
    local cabinet = Instance.new("Part", infirmary)
    cabinet.Size = Vector3.new(4, 8, 2)
    cabinet.Position = Vector3.new(90, 4, 75 + i*5)
    cabinet.Anchored = true
    cabinet.Material = Enum.Material.Metal
    cabinet.Color = Color3.fromRGB(200, 200, 200)
    
    local prompt = Instance.new("ProximityPrompt", cabinet)
    prompt.ActionText = "Abrir"
    prompt.ObjectText = "🩹 Botiquín"
    prompt.HoldDuration = 1
    prompt.MaxActivationDistance = 5
end

print("✅ Enfermería creada")

-- 8. OFICINA DEL DIRECTOR
local office = Instance.new("Model", school)
office.Name = "DirectorOffice"

local offFloor = Instance.new("Part", office)
offFloor.Size = Vector3.new(20, 0.5, 15)
offFloor.Position = Vector3.new(-80, 0.5, -80)
offFloor.Anchored = true
offFloor.Material = Enum.Material.Wood
offFloor.Color = Color3.fromRGB(80, 50, 30)

-- Escritorio del director
local dirDesk = Instance.new("Part", office)
dirDesk.Size = Vector3.new(8, 4, 4)
dirDesk.Position = Vector3.new(-80, 2, -85)
dirDesk.Anchored = true
dirDesk.Material = Enum.Material.Wood
dirDesk.Color = Color3.fromRGB(60, 40, 20)

-- Puerta cerrada
local door = Instance.new("Part", office)
door.Size = Vector3.new(5, 10, 0.5)
door.Position = Vector3.new(-80, 5, -72)
door.Anchored = true
door.Material = Enum.Material.Wood
door.Color = Color3.fromRGB(100, 60, 30)

local doorPrompt = Instance.new("ProximityPrompt", door)
doorPrompt.ActionText = "Abrir"
doorPrompt.ObjectText = "🔒 Puerta cerrada"
doorPrompt.Enabled = false

print("✅ Oficina del director creada")

-- SISTEMA DE COMIDA
local foodItems = Instance.new("Folder", workspace)
foodItems.Name = "FoodItems"

local foodTypes = {
    {name = "Pan", hunger = 20, model = "🍞"},
    {name = "Snack", hunger = 35, model = "🍪"},
    {name = "Comida", hunger = 50, model = "🍗"},
    {name = "Leche", hunger = 15, model = "🥛"}
}

-- Generar comida en la escuela (50 items)
for i = 1, 50 do
    local foodType = foodTypes[math.random(1, #foodTypes)]
    local food = Instance.new("Part", foodItems)
    food.Size = Vector3.new(2, 2, 2)
    food.Position = Vector3.new(math.random(-100, 100), 2, math.random(-100, 100))
    food.Anchored = true
    food.Material = Enum.Material.SmoothPlastic
    food.Color = Color3.fromRGB(255, 200, 100)
    food.Shape = Enum.PartType.Ball
    
    food:SetAttribute("FoodType", foodType.name)
    food:SetAttribute("HungerRestore", foodType.hunger)
    
    local prompt = Instance.new("ProximityPrompt", food)
    prompt.ActionText = "Recoger"
    prompt.ObjectText = foodType.model.." "..foodType.name
    prompt.HoldDuration = 0.5
    prompt.MaxActivationDistance = 8
end

print("✅ 50 items de comida generados")

-- SISTEMA DE JUGADORES
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(0.5)
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.MaxHealth = 100
            hum.Health = 100
        end
        
        -- Stats del jugador
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
        
        -- Reducir hambre con el tiempo
        task.spawn(function()
            while player.Parent and stats.Parent do
                wait(30)
                if hunger.Value > 0 then
                    hunger.Value = hunger.Value - 5
                end
                
                if hunger.Value <= 0 and hum then
                    hum:TakeDamage(10)
                end
                
                updateUI:FireClient(player)
            end
        end)
    end)
end)

-- Conectar comida
for _, food in pairs(foodItems:GetChildren()) do
    local prompt = food:FindFirstChild("ProximityPrompt")
    if prompt then
        prompt.Triggered:Connect(function(player)
            local stats = player:FindFirstChild("Stats")
            if stats then
                local hunger = stats:FindFirstChild("Hunger")
                if hunger then
                    local restore = food:GetAttribute("HungerRestore") or 20
                    hunger.Value = math.min(100, hunger.Value + restore)
                    updateUI:FireClient(player)
                end
            end
            food:Destroy()
        end)
    end
end

print("✅ Sistema de comida conectado")

-- ILUMINACIÓN OSCURA
local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(10, 10, 15)
Lighting.Brightness = 0.5
Lighting.ClockTime = 0
Lighting.FogEnd = 100
Lighting.FogColor = Color3.fromRGB(20, 20, 30)

local atmos = Instance.new("Atmosphere", Lighting)
atmos.Density = 0.7
atmos.Color = Color3.fromRGB(50, 50, 70)
atmos.Glare = 0
atmos.Haze = 3

print("✅ Iluminación oscura configurada")

print("")
print("🎉 ═══════════════════════════════════")
print("🏫 50 NOCHES EN LA ESCUELA")
print("═══════════════════════════════════")
print("✅ Escuela completa generada")
print("✅ 8 zonas explorables")
print("✅ Sistema de hambre activo")
print("✅ 50 items de comida")
print("═══════════════════════════════════")
print("Presiona F5 para jugar")
print("")
