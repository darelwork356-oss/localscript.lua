-- 🇨🇺 FIESTA CUBANA 🇨🇺
-- Juego social estilo La Habana
-- ServerScriptService

print("🇨🇺 Iniciando Fiesta Cubana...")

-- Limpiar
workspace:ClearAllChildren()

-- SUELO BASE
local ground = Instance.new("Part", workspace)
ground.Size = Vector3.new(500, 1, 500)
ground.Position = Vector3.new(0, -0.5, 0)
ground.Anchored = true
ground.Material = Enum.Material.Cobblestone
ground.Color = Color3.fromRGB(120, 110, 100)
ground.Name = "Ground"

-- SPAWN
local spawn = Instance.new("SpawnLocation", workspace)
spawn.Size = Vector3.new(10, 1, 10)
spawn.Position = Vector3.new(0, 1, -80)
spawn.Anchored = true
spawn.Transparency = 1
spawn.CanCollide = false
spawn.Duration = 0

-- CALLE COLONIAL
for i = 1, 20 do
    local tile = Instance.new("Part", workspace)
    tile.Size = Vector3.new(40, 0.2, 8)
    tile.Position = Vector3.new(0, 0.1, -100 + i * 8)
    tile.Anchored = true
    tile.Material = Enum.Material.Slate
    tile.Color = Color3.fromRGB(180, 170, 160)
    tile.CanCollide = false
end

-- EDIFICIOS COLONIALES COLORIDOS
local colors = {
    {255, 180, 120}, -- Naranja
    {120, 200, 255}, -- Azul
    {255, 220, 120}, -- Amarillo
    {255, 150, 180}, -- Rosa
    {180, 255, 200}, -- Verde
    {200, 180, 255}  -- Lila
}

for i = 1, 6 do
    local building = Instance.new("Part", workspace)
    building.Size = Vector3.new(25, 30, 20)
    building.Position = Vector3.new(-50, 15, -90 + i * 30)
    building.Anchored = true
    building.Material = Enum.Material.SmoothPlastic
    building.Color = Color3.fromRGB(colors[i][1], colors[i][2], colors[i][3])
    building.CanCollide = false
    
    -- Balcón
    local balcony = Instance.new("Part", workspace)
    balcony.Size = Vector3.new(15, 0.5, 4)
    balcony.Position = Vector3.new(-37.5, 20, building.Position.Z)
    balcony.Anchored = true
    balcony.Material = Enum.Material.Wood
    balcony.Color = Color3.fromRGB(80, 50, 30)
    balcony.CanCollide = false
    
    -- Ventanas
    for j = 1, 4 do
        local window = Instance.new("Part", workspace)
        window.Size = Vector3.new(0.2, 5, 4)
        window.Position = Vector3.new(-37.4, 10 + (j % 2) * 12, building.Position.Z + (math.floor((j-1)/2) - 0.5) * 8)
        window.Anchored = true
        window.Material = Enum.Material.Glass
        window.Color = Color3.fromRGB(200, 230, 255)
        window.Transparency = 0.5
        window.CanCollide = false
    end
end

-- FAROLES CUBANOS
for i = 1, 10 do
    local pole = Instance.new("Part", workspace)
    pole.Size = Vector3.new(0.5, 12, 0.5)
    pole.Position = Vector3.new(-25, 6, -95 + i * 20)
    pole.Anchored = true
    pole.Material = Enum.Material.Metal
    pole.Color = Color3.fromRGB(30, 30, 30)
    pole.CanCollide = false
    
    local lamp = Instance.new("Part", workspace)
    lamp.Size = Vector3.new(2, 2, 2)
    lamp.Position = Vector3.new(-25, 12.5, -95 + i * 20)
    lamp.Anchored = true
    lamp.Material = Enum.Material.Neon
    lamp.Color = Color3.fromRGB(255, 230, 180)
    lamp.Shape = Enum.PartType.Ball
    lamp.CanCollide = false
    
    local light = Instance.new("PointLight", lamp)
    light.Brightness = 5
    light.Range = 40
    light.Color = Color3.fromRGB(255, 230, 180)
end

-- PALMERAS
for i = 1, 12 do
    local trunk = Instance.new("Part", workspace)
    trunk.Size = Vector3.new(1.5, 15, 1.5)
    trunk.Position = Vector3.new(25 + (i % 2) * 10, 7.5, -90 + math.floor((i-1)/2) * 20)
    trunk.Anchored = true
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(101, 67, 33)
    trunk.CanCollide = false
    
    for j = 1, 8 do
        local leaf = Instance.new("Part", workspace)
        leaf.Size = Vector3.new(0.3, 0.3, 10)
        local angle = (j - 1) * 45
        local rad = math.rad(angle)
        leaf.Position = trunk.Position + Vector3.new(math.cos(rad) * 3, 7.5, math.sin(rad) * 3)
        leaf.Anchored = true
        leaf.Material = Enum.Material.Leaf
        leaf.Color = Color3.fromRGB(34, 139, 34)
        leaf.Orientation = Vector3.new(20, angle, 0)
        leaf.CanCollide = false
    end
end

print("✅ Calle colonial cubana")

-- DISCOTECA
local club = Instance.new("Model", workspace)
club.Name = "Discoteca"

-- Paredes exteriores
local walls = {
    {Vector3.new(80, 40, 2), Vector3.new(0, 20, 30)},
    {Vector3.new(80, 40, 2), Vector3.new(0, 20, 130)},
    {Vector3.new(2, 40, 100), Vector3.new(-40, 20, 80)},
    {Vector3.new(2, 40, 100), Vector3.new(40, 20, 80)},
}

for _, w in pairs(walls) do
    local wall = Instance.new("Part", club)
    wall.Size = w[1]
    wall.Position = w[2]
    wall.Anchored = true
    wall.Material = Enum.Material.Concrete
    wall.Color = Color3.fromRGB(255, 200, 150)
    wall.CanCollide = false
end

-- PUERTAS MODERNAS
local doorLeft = Instance.new("Part", club)
doorLeft.Size = Vector3.new(7, 12, 0.5)
doorLeft.Position = Vector3.new(-4, 6, 30)
doorLeft.Anchored = true
doorLeft.Material = Enum.Material.Glass
doorLeft.Color = Color3.fromRGB(0, 200, 255)
doorLeft.Transparency = 0.3
doorLeft.CanCollide = false

local doorRight = Instance.new("Part", club)
doorRight.Size = Vector3.new(7, 12, 0.5)
doorRight.Position = Vector3.new(4, 6, 30)
doorRight.Anchored = true
doorRight.Material = Enum.Material.Glass
doorRight.Color = Color3.fromRGB(0, 200, 255)
doorRight.Transparency = 0.3
doorRight.CanCollide = false

-- Letrero
local sign = Instance.new("Part", club)
sign.Size = Vector3.new(40, 5, 0.5)
sign.Position = Vector3.new(0, 15, 29.5)
sign.Anchored = true
sign.Material = Enum.Material.Neon
sign.Color = Color3.fromRGB(255, 50, 100)
sign.CanCollide = false

-- LEDs entrada
for i = 1, 15 do
    local led = Instance.new("Part", club)
    led.Size = Vector3.new(1, 1, 1)
    led.Position = Vector3.new(-7 + i * 1, 14, 29.5)
    led.Anchored = true
    led.Material = Enum.Material.Neon
    led.Color = Color3.fromRGB(255, 0, 150)
    led.Shape = Enum.PartType.Ball
    led.CanCollide = false
    
    task.spawn(function()
        while led.Parent do
            led.Color = Color3.fromRGB(math.random(150,255), math.random(0,100), math.random(100,255))
            wait(0.4)
        end
    end)
end

-- SUELO INTERIOR
local floor = Instance.new("Part", club)
floor.Size = Vector3.new(76, 0.5, 96)
floor.Position = Vector3.new(0, 0.25, 80)
floor.Anchored = true
floor.Material = Enum.Material.Marble
floor.Color = Color3.fromRGB(50, 50, 60)
floor.Reflectance = 0.3
floor.CanCollide = true

-- MESAS CON SILLAS
for i = 1, 10 do
    local table = Instance.new("Part", club)
    table.Size = Vector3.new(5, 2.5, 5)
    table.Position = Vector3.new(-30 + (i % 5) * 15, 1.25, 45 + math.floor((i-1)/5) * 20)
    table.Anchored = true
    table.Material = Enum.Material.Wood
    table.Color = Color3.fromRGB(80, 50, 30)
    table.Shape = Enum.PartType.Cylinder
    table.Orientation = Vector3.new(0, 0, 90)
    table.CanCollide = false
    
    for j = 1, 4 do
        local angle = (j - 1) * 90
        local rad = math.rad(angle)
        local offsetX = math.cos(rad) * 4.5
        local offsetZ = math.sin(rad) * 4.5
        
        local seat = Instance.new("Seat", club)
        seat.Size = Vector3.new(3, 0.8, 3)
        seat.Position = table.Position + Vector3.new(offsetX, 0, offsetZ)
        seat.Anchored = true
        seat.Material = Enum.Material.Fabric
        seat.Color = Color3.fromRGB(200, 50, 50)
        
        local back = Instance.new("Part", club)
        back.Size = Vector3.new(3, 3, 0.5)
        back.Position = seat.Position + Vector3.new(offsetX * 0.2, 1.5, offsetZ * 0.2)
        back.Anchored = true
        back.Material = Enum.Material.Wood
        back.Color = Color3.fromRGB(80, 50, 30)
        back.CanCollide = false
    end
end

-- ESCENARIO
local stage = Instance.new("Part", club)
stage.Size = Vector3.new(35, 4, 20)
stage.Position = Vector3.new(0, 2, 110)
stage.Anchored = true
stage.Material = Enum.Material.Wood
stage.Color = Color3.fromRGB(40, 40, 50)
stage.CanCollide = true

-- Escaleras
for side = 1, 2 do
    for i = 1, 6 do
        local step = Instance.new("Part", club)
        step.Size = Vector3.new(6, 0.5, 2.5)
        step.Position = Vector3.new((side == 1 and -20 or 20), 0.25 + i * 0.6, 100 + i * 1.2)
        step.Anchored = true
        step.Material = Enum.Material.Metal
        step.Color = Color3.fromRGB(60, 60, 70)
        step.CanCollide = true
    end
end

-- PANTALLA GIGANTE
local screen = Instance.new("Part", club)
screen.Size = Vector3.new(45, 25, 1)
screen.Position = Vector3.new(0, 20, 115)
screen.Anchored = true
screen.Material = Enum.Material.Neon
screen.Color = Color3.fromRGB(0, 150, 255)
screen.Orientation = Vector3.new(-10, 0, 0)
screen.CanCollide = false

local screenLight = Instance.new("SurfaceLight", screen)
screenLight.Face = Enum.NormalId.Front
screenLight.Brightness = 15
screenLight.Range = 80

task.spawn(function()
    while screen.Parent do
        screen.Color = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
        screenLight.Color = screen.Color
        wait(0.6)
    end
end)

-- PISTA DE BAILE RGB
for x = 1, 8 do
    for z = 1, 10 do
        local tile = Instance.new("Part", club)
        tile.Size = Vector3.new(4.5, 0.4, 4.5)
        tile.Position = Vector3.new(-16 + x * 5, 0.7, 65 + z * 4.5)
        tile.Anchored = true
        tile.Material = Enum.Material.Neon
        tile.Color = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
        tile.Transparency = 0.3
        tile.CanCollide = false
        
        task.spawn(function()
            while tile.Parent do
                wait(math.random(8,15)/10)
                tile.Color = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
            end
        end)
    end
end

-- BOLAS DISCO
for i = 1, 4 do
    local disco = Instance.new("Part", club)
    disco.Size = Vector3.new(5, 5, 5)
    disco.Position = Vector3.new(-15 + i * 10, 35, 80)
    disco.Anchored = true
    disco.Material = Enum.Material.Neon
    disco.Color = Color3.fromRGB(255, 255, 255)
    disco.Shape = Enum.PartType.Ball
    disco.Reflectance = 1
    disco.CanCollide = false
    
    local light = Instance.new("PointLight", disco)
    light.Brightness = 10
    light.Range = 60
    
    task.spawn(function()
        while disco.Parent do
            disco.Orientation = disco.Orientation + Vector3.new(0.5, 1, 0.3)
            wait(0.03)
        end
    end)
end

-- DECORACIÓN CUBANA
for i = 1, 8 do
    local poster = Instance.new("Part", club)
    poster.Size = Vector3.new(0.1, 8, 10)
    poster.Position = Vector3.new(-39.9, 10, 40 + i * 10)
    poster.Anchored = true
    poster.Material = Enum.Material.Neon
    poster.Color = Color3.fromRGB(255, 100, 100)
    poster.Transparency = 0.4
    poster.CanCollide = false
end

print("✅ Discoteca cubana")

-- MÚSICA
local sound = Instance.new("Sound", screen)
sound.SoundId = "rbxassetid://1848354536"
sound.Volume = 0.7
sound.Looped = true
sound:Play()

-- JUGADORES
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(0.5)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end)
end)

-- ILUMINACIÓN
local Lighting = game:GetService("Lighting")
Lighting.ClockTime = 21
Lighting.Brightness = 0.8
Lighting.Ambient = Color3.fromRGB(80, 80, 120)
Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 100)
Lighting.FogEnd = 400

local bloom = Instance.new("BloomEffect", Lighting)
bloom.Intensity = 1
bloom.Size = 24

local color = Instance.new("ColorCorrectionEffect", Lighting)
color.Saturation = 0.4
color.Brightness = 0.1

task.spawn(function()
    while true do
        wait(3)
        Lighting.Ambient = Color3.fromRGB(math.random(60,100), math.random(60,100), math.random(100,140))
    end
end)

print("")
print("🇨🇺 ═══════════════════════════════")
print("✅ FIESTA CUBANA LISTA")
print("═══════════════════════════════")
print("🏛️ Arquitectura colonial colorida")
print("🚪 Puertas modernas de vidrio")
print("🪑 Mesas con sillas funcionales")
print("🎭 Escenario con pantalla gigante")
print("💃 Pista de baile RGB")
print("🌴 Palmeras y decoración cubana")
print("🎵 Música sonando")
print("═══════════════════════════════")
print("")
