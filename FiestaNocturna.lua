-- 🎉 FIESTA NOCTURNA 🎉
-- Juego social multijugador con música, baile y ambiente épico
-- Colocar en: ServerScriptService

print("🎉 Iniciando Fiesta Nocturna...")
wait(1)

-- Limpiar
for _, obj in pairs(workspace:GetChildren()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
        obj:Destroy()
    end
end

-- CALLE NOCTURNA
local street = Instance.new("Model", workspace)
street.Name = "Street"

-- Asfalto mojado
local road = Instance.new("Part", street)
road.Size = Vector3.new(80, 0.5, 200)
road.Position = Vector3.new(0, 0, -50)
road.Anchored = true
road.Material = Enum.Material.Asphalt
road.Color = Color3.fromRGB(40, 40, 45)
road.Reflectance = 0.3

-- Aceras
for i = 1, 2 do
    local sidewalk = Instance.new("Part", street)
    sidewalk.Size = Vector3.new(15, 0.6, 200)
    sidewalk.Position = Vector3.new((i == 1 and -47.5 or 47.5), 0.3, -50)
    sidewalk.Anchored = true
    sidewalk.Material = Enum.Material.Concrete
    sidewalk.Color = Color3.fromRGB(150, 150, 150)
end

-- Faroles
for i = 1, 10 do
    local pole = Instance.new("Part", street)
    pole.Size = Vector3.new(1, 12, 1)
    pole.Position = Vector3.new(-45, 6, -140 + i * 30)
    pole.Anchored = true
    pole.Material = Enum.Material.Metal
    pole.Color = Color3.fromRGB(60, 60, 60)
    
    local lamp = Instance.new("Part", street)
    lamp.Size = Vector3.new(3, 1, 3)
    lamp.Position = Vector3.new(-45, 12, -140 + i * 30)
    lamp.Anchored = true
    lamp.Material = Enum.Material.Neon
    lamp.Color = Color3.fromRGB(255, 220, 150)
    lamp.Shape = Enum.PartType.Ball
    
    local light = Instance.new("PointLight", lamp)
    light.Brightness = 3
    light.Range = 40
    light.Color = Color3.fromRGB(255, 220, 150)
end

-- Edificios laterales
for i = 1, 6 do
    local building = Instance.new("Part", street)
    building.Size = Vector3.new(20, 30, 25)
    building.Position = Vector3.new(-70, 15, -130 + i * 40)
    building.Anchored = true
    building.Material = Enum.Material.Brick
    building.Color = Color3.fromRGB(80, 70, 60)
    
    -- Ventanas
    for j = 1, 8 do
        local window = Instance.new("Part", street)
        window.Size = Vector3.new(0.2, 3, 3)
        window.Position = Vector3.new(-59.9, 8 + (j % 4) * 6, building.Position.Z + (math.floor((j-1)/4) - 0.5) * 8)
        window.Anchored = true
        window.Material = Enum.Material.Neon
        window.Color = Color3.fromRGB(255, 200, 100)
        window.Transparency = 0.3
    end
end

-- Grafitis
for i = 1, 5 do
    local graffiti = Instance.new("Part", street)
    graffiti.Size = Vector3.new(0.1, 8, 12)
    graffiti.Position = Vector3.new(-59.9, 4, -120 + i * 35)
    graffiti.Anchored = true
    graffiti.Material = Enum.Material.Neon
    graffiti.Color = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
    graffiti.Transparency = 0.2
end

-- Spawn inicial
local spawn = Instance.new("SpawnLocation", street)
spawn.Size = Vector3.new(15, 1, 15)
spawn.Position = Vector3.new(0, 1, -130)
spawn.Anchored = true
spawn.Transparency = 0.8
spawn.CanCollide = false
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.Duration = 0

print("✅ Calle nocturna creada")

-- SALÓN DE FIESTAS
local club = Instance.new("Model", workspace)
club.Name = "Club"

-- Edificio exterior
local exterior = Instance.new("Part", club)
exterior.Size = Vector3.new(100, 40, 80)
exterior.Position = Vector3.new(0, 20, 80)
exterior.Anchored = true
exterior.Material = Enum.Material.Concrete
exterior.Color = Color3.fromRGB(20, 20, 25)

-- Entrada con luces LED
local entrance = Instance.new("Part", club)
entrance.Size = Vector3.new(20, 15, 2)
entrance.Position = Vector3.new(0, 7.5, 39)
entrance.Anchored = true
entrance.Material = Enum.Material.Neon
entrance.Color = Color3.fromRGB(0, 200, 255)
entrance.Transparency = 0.3

-- Reflectores al cielo
for i = 1, 4 do
    local spotlight = Instance.new("Part", club)
    spotlight.Size = Vector3.new(3, 3, 3)
    spotlight.Position = Vector3.new(-30 + i * 20, 41, 80)
    spotlight.Anchored = true
    spotlight.Material = Enum.Material.Neon
    spotlight.Color = Color3.fromRGB(255, 0, 200)
    spotlight.Shape = Enum.PartType.Ball
    
    local beam = Instance.new("SpotLight", spotlight)
    beam.Brightness = 10
    beam.Range = 100
    beam.Angle = 30
    beam.Face = Enum.NormalId.Top
    beam.Color = Color3.fromRGB(255, 0, 200)
end

-- Interior del salón
local floor = Instance.new("Part", club)
floor.Size = Vector3.new(90, 0.5, 70)
floor.Position = Vector3.new(0, 0.25, 80)
floor.Anchored = true
floor.Material = Enum.Material.Marble
floor.Color = Color3.fromRGB(30, 30, 35)
floor.Reflectance = 0.5

-- Techo
local ceiling = Instance.new("Part", club)
ceiling.Size = Vector3.new(90, 1, 70)
ceiling.Position = Vector3.new(0, 35, 80)
ceiling.Anchored = true
ceiling.Material = Enum.Material.Metal
ceiling.Color = Color3.fromRGB(10, 10, 15)

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

print("✅ Salón de fiestas creado")

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
