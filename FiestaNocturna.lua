-- 🇨🇺 FIESTA NOCTURNA CUBANA 🇨🇺
-- Juego social con estilo colonial cubano y discoteca moderna
-- Colocar en: ServerScriptService

print("🇨🇺 Iniciando Fiesta Nocturna Cubana...")
wait(1)

-- Limpiar
for _, obj in pairs(workspace:GetChildren()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
        obj:Destroy()
    end
end

-- CALLE COLONIAL CUBANA
local street = Instance.new("Model", workspace)
street.Name = "CalleHabana"

-- Adoquines coloniales
local road = Instance.new("Part", street)
road.Size = Vector3.new(60, 0.5, 180)
road.Position = Vector3.new(0, 0.25, -40)
road.Anchored = true
road.Material = Enum.Material.Cobblestone
road.Color = Color3.fromRGB(120, 110, 100)

-- Aceras coloniales
for i = 1, 2 do
    local sidewalk = Instance.new("Part", street)
    sidewalk.Size = Vector3.new(12, 0.8, 180)
    sidewalk.Position = Vector3.new((i == 1 and -36 or 36), 0.4, -40)
    sidewalk.Anchored = true
    sidewalk.Material = Enum.Material.Slate
    sidewalk.Color = Color3.fromRGB(180, 170, 160)
end

-- Faroles coloniales cubanos
for i = 1, 8 do
    local pole = Instance.new("Part", street)
    pole.Size = Vector3.new(0.8, 10, 0.8)
    pole.Position = Vector3.new(-38, 5, -110 + i * 28)
    pole.Anchored = true
    pole.Material = Enum.Material.Metal
    pole.Color = Color3.fromRGB(30, 30, 30)
    
    local lamp = Instance.new("Part", street)
    lamp.Size = Vector3.new(2.5, 2.5, 2.5)
    lamp.Position = Vector3.new(-38, 10.5, -110 + i * 28)
    lamp.Anchored = true
    lamp.Material = Enum.Material.Neon
    lamp.Color = Color3.fromRGB(255, 230, 180)
    lamp.Shape = Enum.PartType.Ball
    
    local light = Instance.new("PointLight", lamp)
    light.Brightness = 4
    light.Range = 35
    light.Color = Color3.fromRGB(255, 230, 180)
end

-- Edificios coloniales coloridos (estilo La Habana)
local colors = {
    Color3.fromRGB(255, 180, 120), -- Naranja pastel
    Color3.fromRGB(120, 200, 255), -- Azul cielo
    Color3.fromRGB(255, 220, 120), -- Amarillo
    Color3.fromRGB(255, 150, 180), -- Rosa
    Color3.fromRGB(180, 255, 200), -- Verde menta
    Color3.fromRGB(200, 180, 255)  -- Lila
}

for i = 1, 6 do
    local building = Instance.new("Part", street)
    building.Size = Vector3.new(18, 25, 22)
    building.Position = Vector3.new(-55, 12.5, -100 + i * 35)
    building.Anchored = true
    building.Material = Enum.Material.SmoothPlastic
    building.Color = colors[i]
    
    -- Balcones coloniales
    local balcony = Instance.new("Part", street)
    balcony.Size = Vector3.new(12, 0.5, 3)
    balcony.Position = Vector3.new(-49, 18, building.Position.Z)
    balcony.Anchored = true
    balcony.Material = Enum.Material.Wood
    balcony.Color = Color3.fromRGB(80, 50, 30)
    
    -- Barandas
    for j = 1, 6 do
        local rail = Instance.new("Part", street)
        rail.Size = Vector3.new(0.3, 2, 0.3)
        rail.Position = Vector3.new(-54 + j * 2, 19, building.Position.Z + 1.3)
        rail.Anchored = true
        rail.Material = Enum.Material.Metal
        rail.Color = Color3.fromRGB(40, 40, 40)
    end
    
    -- Ventanas coloniales
    for j = 1, 4 do
        local window = Instance.new("Part", street)
        window.Size = Vector3.new(0.2, 4, 3)
        window.Position = Vector3.new(-45.9, 8 + (j % 2) * 10, building.Position.Z + (math.floor((j-1)/2) - 0.5) * 8)
        window.Anchored = true
        window.Material = Enum.Material.Glass
        window.Color = Color3.fromRGB(200, 230, 255)
        window.Transparency = 0.4
        window.Reflectance = 0.3
    end
end

-- Banderas cubanas
for i = 1, 4 do
    local flag = Instance.new("Part", street)
    flag.Size = Vector3.new(0.1, 6, 10)
    flag.Position = Vector3.new(-45, 22, -90 + i * 50)
    flag.Anchored = true
    flag.Material = Enum.Material.Fabric
    flag.Color = Color3.fromRGB(0, 50, 160) -- Azul de bandera cubana
    
    local stripe = Instance.new("Part", street)
    stripe.Size = Vector3.new(0.15, 2, 10)
    stripe.Position = Vector3.new(-45, 22, -90 + i * 50)
    stripe.Anchored = true
    stripe.Material = Enum.Material.Fabric
    stripe.Color = Color3.fromRGB(200, 16, 46) -- Rojo cubano
end

-- Spawn inicial
local spawn = Instance.new("SpawnLocation", street)
spawn.Size = Vector3.new(12, 0.8, 12)
spawn.Position = Vector3.new(0, 1.4, -100)
spawn.Anchored = true
spawn.Transparency = 1
spawn.CanCollide = false
spawn.Duration = 0

print("✅ Calle colonial cubana creada")

-- DISCOTECA MODERNA CUBANA
local club = Instance.new("Model", workspace)
club.Name = "DiscotecaCubana"

-- Edificio exterior moderno
local exterior = Instance.new("Part", club)
exterior.Size = Vector3.new(90, 35, 70)
exterior.Position = Vector3.new(0, 17.5, 70)
exterior.Anchored = true
exterior.Material = Enum.Material.Glass
exterior.Color = Color3.fromRGB(20, 20, 30)
exterior.Transparency = 0.3
exterior.CanCollide = false

-- Paredes sólidas
for _, pos in pairs({{-45, 70}, {45, 70}, {0, 35}, {0, 105}}) do
    local wall = Instance.new("Part", club)
    wall.Size = pos[2] == 70 and Vector3.new(2, 35, 70) or Vector3.new(90, 35, 2)
    wall.Position = Vector3.new(pos[1], 17.5, pos[2])
    wall.Anchored = true
    wall.Material = Enum.Material.Concrete
    wall.Color = Color3.fromRGB(40, 40, 50)
end

-- PUERTAS AUTOMÁTICAS MODERNAS
local doorFrame = Instance.new("Part", club)
doorFrame.Size = Vector3.new(18, 12, 1)
doorFrame.Position = Vector3.new(0, 6, 34.5)
doorFrame.Anchored = true
doorFrame.Material = Enum.Material.Metal
doorFrame.Color = Color3.fromRGB(50, 50, 60)

local doorLeft = Instance.new("Part", club)
doorLeft.Size = Vector3.new(8, 10, 0.5)
doorLeft.Position = Vector3.new(-4.5, 5, 34.5)
doorLeft.Anchored = true
doorLeft.Material = Enum.Material.Glass
doorLeft.Color = Color3.fromRGB(0, 200, 255)
doorLeft.Transparency = 0.2
doorLeft.CanCollide = false

local doorRight = Instance.new("Part", club)
doorRight.Size = Vector3.new(8, 10, 0.5)
doorRight.Position = Vector3.new(4.5, 5, 34.5)
doorRight.Anchored = true
doorRight.Material = Enum.Material.Glass
doorRight.Color = Color3.fromRGB(0, 200, 255)
doorRight.Transparency = 0.2
doorRight.CanCollide = false

-- Letrero "DISCOTECA CUBANA"
local sign = Instance.new("Part", club)
sign.Size = Vector3.new(30, 4, 0.5)
sign.Position = Vector3.new(0, 13, 34)
sign.Anchored = true
sign.Material = Enum.Material.Neon
sign.Color = Color3.fromRGB(255, 50, 100)

-- Luces LED entrada
for i = 1, 12 do
    local led = Instance.new("Part", club)
    led.Size = Vector3.new(1.5, 1.5, 1.5)
    led.Position = Vector3.new(-8 + i * 1.5, 12, 34)
    led.Anchored = true
    led.Material = Enum.Material.Neon
    led.Color = Color3.fromRGB(255, 0, 150)
    led.Shape = Enum.PartType.Ball
    
    task.spawn(function()
        while led.Parent do
            led.Color = Color3.fromRGB(math.random(150,255), math.random(0,100), math.random(100,255))
            wait(0.3)
        end
    end)
end

-- Suelo interior
local floor = Instance.new("Part", club)
floor.Size = Vector3.new(86, 0.5, 66)
floor.Position = Vector3.new(0, 0.25, 70)
floor.Anchored = true
floor.Material = Enum.Material.Marble
floor.Color = Color3.fromRGB(40, 40, 45)
floor.Reflectance = 0.4

-- ESCENARIO PRINCIPAL
local stage = Instance.new("Model", club)
stage.Name = "Stage"

local stageBase = Instance.new("Part", stage)
stageBase.Size = Vector3.new(40, 3, 25)
stageBase.Position = Vector3.new(0, 1.5, 100)
stageBase.Anchored = true
stageBase.Material = Enum.Material.Wood
stageBase.Color = Color3.fromRGB(40, 40, 50)

-- Escaleras laterales
for side = 1, 2 do
    for i = 1, 5 do
        local step = Instance.new("Part", stage)
        step.Size = Vector3.new(8, 0.5, 3)
        step.Position = Vector3.new((side == 1 and -24 or 24), 0.25 + i * 0.5, 88 + i * 1.5)
        step.Anchored = true
        step.Material = Enum.Material.Metal
        step.Color = Color3.fromRGB(60, 60, 70)
    end
end

-- Luces del escenario
for i = 1, 8 do
    local stageLight = Instance.new("Part", stage)
    stageLight.Size = Vector3.new(2, 2, 2)
    stageLight.Position = Vector3.new(-18 + i * 5, 5, 100)
    stageLight.Anchored = true
    stageLight.Material = Enum.Material.Neon
    stageLight.Color = Color3.fromRGB(255, 0, 100)
    stageLight.Shape = Enum.PartType.Ball
    
    local light = Instance.new("PointLight", stageLight)
    light.Brightness = 5
    light.Range = 30
    light.Color = Color3.fromRGB(255, 0, 100)
end

-- PANTALLA GIGANTE 3D
local screen = Instance.new("Part", stage)
screen.Size = Vector3.new(50, 30, 2)
screen.Position = Vector3.new(0, 25, 105)
screen.Anchored = true
screen.Material = Enum.Material.Neon
screen.Color = Color3.fromRGB(0, 150, 255)
screen.Orientation = Vector3.new(-15, 0, 0)

local screenLight = Instance.new("SurfaceLight", screen)
screenLight.Face = Enum.NormalId.Front
screenLight.Brightness = 10
screenLight.Range = 60
screenLight.Color = Color3.fromRGB(0, 150, 255)

-- Animación de pantalla
task.spawn(function()
    while screen.Parent do
        screen.Color = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
        screenLight.Color = screen.Color
        wait(0.5)
    end
end)

-- PISTA DE BAILE
local danceFloor = Instance.new("Part", club)
danceFloor.Size = Vector3.new(50, 0.6, 40)
danceFloor.Position = Vector3.new(0, 0.3, 65)
danceFloor.Anchored = true
danceFloor.Material = Enum.Material.Neon
danceFloor.Color = Color3.fromRGB(100, 0, 200)
danceFloor.Transparency = 0.3

-- Baldosas de pista con luces
for x = 1, 10 do
    for z = 1, 8 do
        local tile = Instance.new("Part", club)
        tile.Size = Vector3.new(4.5, 0.5, 4.5)
        tile.Position = Vector3.new(-22.5 + x * 5, 0.55, 47 + z * 5)
        tile.Anchored = true
        tile.Material = Enum.Material.Neon
        tile.Color = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
        tile.Transparency = 0.4
        
        task.spawn(function()
            while tile.Parent do
                wait(math.random(5,15)/10)
                tile.Color = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
            end
        end)
    end
end

-- Bolas de disco
for i = 1, 3 do
    local disco = Instance.new("Part", club)
    disco.Size = Vector3.new(6, 6, 6)
    disco.Position = Vector3.new(-20 + i * 20, 30, 70)
    disco.Anchored = true
    disco.Material = Enum.Material.Neon
    disco.Color = Color3.fromRGB(255, 255, 255)
    disco.Shape = Enum.PartType.Ball
    disco.Reflectance = 1
    
    local discoLight = Instance.new("PointLight", disco)
    discoLight.Brightness = 8
    discoLight.Range = 50
    discoLight.Color = Color3.fromRGB(255, 255, 255)
    
    task.spawn(function()
        while disco.Parent do
            disco.Orientation = disco.Orientation + Vector3.new(0.5, 1, 0.3)
            wait(0.03)
        end
    end)
end

-- Láseres
for i = 1, 6 do
    local laser = Instance.new("Part", club)
    laser.Size = Vector3.new(0.5, 0.5, 80)
    laser.Position = Vector3.new(-25 + i * 10, 25, 80)
    laser.Anchored = true
    laser.Material = Enum.Material.Neon
    laser.Color = Color3.fromRGB(0, 255, 0)
    laser.Transparency = 0.5
    laser.CanCollide = false
    
    task.spawn(function()
        while laser.Parent do
            laser.Orientation = Vector3.new(math.random(-30,30), math.random(0,360), 0)
            laser.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
            wait(0.2)
        end
    end)
end

-- Humo/Niebla
for i = 1, 15 do
    local smoke = Instance.new("Part", club)
    smoke.Size = Vector3.new(8, 8, 8)
    smoke.Position = Vector3.new(math.random(-40,40), 2, math.random(50,110))
    smoke.Anchored = true
    smoke.Material = Enum.Material.Neon
    smoke.Color = Color3.fromRGB(150, 150, 200)
    smoke.Transparency = 0.8
    smoke.CanCollide = false
    smoke.Shape = Enum.PartType.Ball
    
    task.spawn(function()
        while smoke.Parent do
            smoke.Position = smoke.Position + Vector3.new(math.random(-1,1)/10, math.random(0,2)/10, math.random(-1,1)/10)
            smoke.Transparency = 0.7 + math.random(0,20)/100
            wait(0.1)
        end
    end)
end

-- MESAS Y SILLAS CON ASIENTOS FUNCIONALES
local tables = Instance.new("Folder", club)
tables.Name = "Tables"

for i = 1, 12 do
    local table = Instance.new("Part", tables)
    table.Size = Vector3.new(6, 3, 6)
    table.Position = Vector3.new(-35 + (i % 4) * 20, 1.5, 50 + math.floor((i-1)/4) * 15)
    table.Anchored = true
    table.Material = Enum.Material.Wood
    table.Color = Color3.fromRGB(80, 50, 30)
    table.Shape = Enum.PartType.Cylinder
    table.Orientation = Vector3.new(0, 0, 90)
    
    for j = 1, 4 do
        local angle = (j - 1) * 90
        local rad = math.rad(angle)
        local offsetX = math.cos(rad) * 5
        local offsetZ = math.sin(rad) * 5
        
        local seat = Instance.new("Seat", tables)
        seat.Size = Vector3.new(3, 1, 3)
        seat.Position = table.Position + Vector3.new(offsetX, 0.5, offsetZ)
        seat.Anchored = true
        seat.Material = Enum.Material.Fabric
        seat.Color = Color3.fromRGB(200, 50, 50)
        
        local back = Instance.new("Part", tables)
        back.Size = Vector3.new(3, 4, 0.5)
        back.Position = seat.Position + Vector3.new(offsetX * 0.3, 2, offsetZ * 0.3)
        back.Anchored = true
        back.Material = Enum.Material.Wood
        back.Color = Color3.fromRGB(80, 50, 30)
    end
end

-- DECORACIONES CUBANAS
for i = 1, 8 do
    local trunk = Instance.new("Part", club)
    trunk.Size = Vector3.new(1.5, 12, 1.5)
    trunk.Position = Vector3.new(-40 + i * 11, 6, 45)
    trunk.Anchored = true
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(101, 67, 33)
    
    for j = 1, 6 do
        local leaf = Instance.new("Part", club)
        leaf.Size = Vector3.new(0.5, 0.5, 8)
        local angle = (j - 1) * 60
        local rad = math.rad(angle)
        leaf.Position = trunk.Position + Vector3.new(math.cos(rad) * 2, 6, math.sin(rad) * 2)
        leaf.Anchored = true
        leaf.Material = Enum.Material.Leaf
        leaf.Color = Color3.fromRGB(34, 139, 34)
        leaf.Orientation = Vector3.new(30, angle, 0)
    end
end

local instruments = {
    {pos = Vector3.new(-38, 2, 95), size = Vector3.new(2, 3, 3)},
    {pos = Vector3.new(38, 2, 95), size = Vector3.new(1, 4, 1)},
    {pos = Vector3.new(-35, 2, 90), size = Vector3.new(2.5, 5, 2.5)},
}

for _, inst in pairs(instruments) do
    local item = Instance.new("Part", club)
    item.Size = inst.size
    item.Position = inst.pos
    item.Anchored = true
    item.Material = Enum.Material.Wood
    item.Color = Color3.fromRGB(139, 90, 43)
    item.Shape = Enum.PartType.Cylinder
end

for i = 1, 6 do
    local poster = Instance.new("Part", club)
    poster.Size = Vector3.new(0.1, 6, 8)
    poster.Position = Vector3.new(-44.9, 8, 50 + i * 10)
    poster.Anchored = true
    poster.Material = Enum.Material.Neon
    poster.Color = Color3.fromRGB(255, 100, 100)
    poster.Transparency = 0.3
end

print("✅ Salón con mesas y decoraciones cubanas creado")

-- SISTEMA DE MÚSICA
local sound = Instance.new("Sound", screen)
sound.SoundId = "rbxassetid://1848354536" -- Música electrónica
sound.Volume = 0.8
sound.Looped = true
sound.RollOffMaxDistance = 200
sound.RollOffMinDistance = 20
sound:Play()

print("✅ Música iniciada")

-- SISTEMA DE JUGADORES
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(0.5)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
        
        -- Emotes disponibles
        local humanoidDescription = hum:FindFirstChildOfClass("HumanoidDescription")
        if humanoidDescription then
            humanoidDescription.EmotesEnabled = true
        end
    end)
end)

-- ILUMINACIÓN NOCTURNA ÉPICA
local Lighting = game:GetService("Lighting")
Lighting.ClockTime = 22
Lighting.Brightness = 0.5
Lighting.Ambient = Color3.fromRGB(50, 50, 80)
Lighting.OutdoorAmbient = Color3.fromRGB(30, 30, 50)
Lighting.FogEnd = 300
Lighting.FogColor = Color3.fromRGB(20, 20, 40)

local bloom = Instance.new("BloomEffect", Lighting)
bloom.Intensity = 0.8
bloom.Size = 24
bloom.Threshold = 0.5

local colorCorrection = Instance.new("ColorCorrectionEffect", Lighting)
colorCorrection.Brightness = 0.05
colorCorrection.Contrast = 0.2
colorCorrection.Saturation = 0.3
colorCorrection.TintColor = Color3.fromRGB(255, 240, 255)

local atmosphere = Instance.new("Atmosphere", Lighting)
atmosphere.Density = 0.4
atmosphere.Offset = 0.5
atmosphere.Color = Color3.fromRGB(100, 100, 150)
atmosphere.Glare = 0.5
atmosphere.Haze = 1.5

-- Cambio dinámico de luces
task.spawn(function()
    while true do
        wait(2)
        Lighting.Ambient = Color3.fromRGB(math.random(30,80), math.random(30,80), math.random(60,120))
    end
end)

print("✅ Iluminación épica configurada")

print("")
print("🎉 ═══════════════════════════════")
print("✅ FIESTA NOCTURNA - LISTO")
print("═══════════════════════════════")
print("🌃 Calle nocturna con faroles y edificios")
print("🏢 Salón de fiestas con escenario")
print("📺 Pantalla gigante 3D animada")
print("💃 Pista de baile con luces RGB")
print("🎵 Música electrónica sonando")
print("✨ Efectos: láseres, humo, bolas disco")
print("🎭 Emotes y baile disponibles")
print("═══════════════════════════════")
print("¡Disfruta la fiesta!")
print("")
