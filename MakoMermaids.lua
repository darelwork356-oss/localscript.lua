--[[
🧜♀️ MAKO MERMAIDS - OCÉANO + ISLA DE MAKO
Colocar en: ServerScriptService
]]

print("🌊 Iniciando Mako Mermaids...")

local terrain = workspace.Terrain
terrain:Clear()

-- ========================================
-- CREAR OCÉANO REAL CON TERRAIN
-- ========================================
print("💧 Creando océano REAL...")

-- Agua REAL de Roblox (1000x1000 studs, ARRIBA del terreno base)
terrain:FillRegion(
    Region3.new(Vector3.new(-500, 0, -500), Vector3.new(500, 60, 500)):ExpandToGrid(4),
    4,
    Enum.Material.Water
)

-- Suelo del océano (arena) ABAJO del agua
terrain:FillRegion(
    Region3.new(Vector3.new(-500, -10, -500), Vector3.new(500, 0, 500)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)

print("✅ Océano creado: 1000x1000 studs, altura 60")

-- ========================================
-- CREAR ISLA DE MAKO GRANDE
-- ========================================
print("🏝️ Construyendo Isla de Mako GRANDE...")

-- Base submarina de la isla (GRANDE: 200x200)
terrain:FillRegion(
    Region3.new(Vector3.new(-100, -10, -100), Vector3.new(100, 50, 100)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Superficie principal de la isla (pasto)
terrain:FillRegion(
    Region3.new(Vector3.new(-90, 50, -90), Vector3.new(90, 65, 90)):ExpandToGrid(4),
    4,
    Enum.Material.Grass
)

-- Montaña central ALTA
terrain:FillRegion(
    Region3.new(Vector3.new(-50, 65, -50), Vector3.new(50, 100, 50)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Pico de la montaña
terrain:FillRegion(
    Region3.new(Vector3.new(-25, 100, -25), Vector3.new(25, 120, 25)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Playas de arena (4 lados)
-- Norte
terrain:FillRegion(
    Region3.new(Vector3.new(-90, 50, -90), Vector3.new(90, 55, -70)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)
-- Sur
terrain:FillRegion(
    Region3.new(Vector3.new(-90, 50, 70), Vector3.new(90, 55, 90)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)
-- Este
terrain:FillRegion(
    Region3.new(Vector3.new(70, 50, -90), Vector3.new(90, 55, 90)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)
-- Oeste
terrain:FillRegion(
    Region3.new(Vector3.new(-90, 50, -90), Vector3.new(-70, 55, 90)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)

print("✅ Isla de Mako GRANDE creada: 200x200 studs")

-- ========================================
-- CREAR CUEVA DE MAKO (ENTRADA GRANDE)
-- ========================================
print("🕳️ Creando entrada a la cueva...")

local caveEntrance = Instance.new("Part")
caveEntrance.Name = "CaveEntrance"
caveEntrance.Size = Vector3.new(25, 30, 25)
caveEntrance.Position = Vector3.new(0, 85, 0)
caveEntrance.Anchored = true
caveEntrance.Material = Enum.Material.Rock
caveEntrance.Color = Color3.fromRGB(50, 50, 60)
caveEntrance.Parent = workspace

-- Arco de entrada
local arch = Instance.new("Part")
arch.Size = Vector3.new(15, 20, 3)
arch.Position = Vector3.new(0, 85, -12)
arch.Anchored = true
arch.Material = Enum.Material.Rock
arch.Color = Color3.fromRGB(40, 40, 50)
arch.Parent = caveEntrance

print("✅ Entrada de cueva GRANDE creada")

-- ========================================
-- DECORACIÓN DE LA ISLA
-- ========================================
print("🌴 Decorando isla...")

-- Palmeras (50 palmeras)
for i = 1, 50 do
    local trunk = Instance.new("Part")
    trunk.Size = Vector3.new(2, 15, 2)
    trunk.Position = Vector3.new(
        math.random(-85, 85),
        58,
        math.random(-85, 85)
    )
    trunk.Anchored = true
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(120, 80, 50)
    trunk.Parent = workspace
    
    -- Hojas
    local leaves = Instance.new("Part")
    leaves.Size = Vector3.new(10, 3, 10)
    leaves.Position = trunk.Position + Vector3.new(0, 9, 0)
    leaves.Anchored = true
    leaves.Material = Enum.Material.Grass
    leaves.Color = Color3.fromRGB(50, 150, 50)
    leaves.Shape = Enum.PartType.Ball
    leaves.Parent = trunk
end

-- Rocas decorativas (60 rocas)
for i = 1, 60 do
    local rock = Instance.new("Part")
    rock.Size = Vector3.new(
        math.random(3, 10),
        math.random(3, 8),
        math.random(3, 10)
    )
    rock.Position = Vector3.new(
        math.random(-85, 85),
        53,
        math.random(-85, 85)
    )
    rock.Anchored = true
    rock.Material = Enum.Material.Rock
    rock.Color = Color3.fromRGB(
        math.random(70, 110),
        math.random(70, 110),
        math.random(70, 110)
    )
    rock.Orientation = Vector3.new(
        math.random(-15, 15),
        math.random(0, 360),
        math.random(-15, 15)
    )
    rock.Parent = workspace
end

print("✅ Isla decorada: 50 palmeras, 60 rocas")

-- ========================================
-- PLATAFORMA DE SPAWN
-- ========================================
print("🏊 Creando spawn...")

local spawn = Instance.new("SpawnLocation")
spawn.Size = Vector3.new(15, 1, 15)
spawn.Position = Vector3.new(0, 121, 0)  -- EN LA CIMA
spawn.Anchored = true
spawn.Material = Enum.Material.Wood
spawn.Color = Color3.fromRGB(150, 120, 80)
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.TopSurface = Enum.SurfaceType.Smooth
spawn.Parent = workspace

print("✅ Spawn creado")

-- ========================================
-- ILUMINACIÓN
-- ========================================
print("💡 Configurando iluminación...")

local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(100, 150, 200)
Lighting.Brightness = 2
Lighting.ColorShift_Top = Color3.fromRGB(150, 200, 255)
Lighting.OutdoorAmbient = Color3.fromRGB(120, 170, 220)
Lighting.FogEnd = 500
Lighting.FogColor = Color3.fromRGB(100, 180, 230)
Lighting.ClockTime = 14

-- Atmósfera
local atmos = Instance.new("Atmosphere")
atmos.Density = 0.3
atmos.Offset = 0.5
atmos.Color = Color3.fromRGB(150, 200, 255)
atmos.Decay = Color3.fromRGB(120, 180, 230)
atmos.Glare = 0.5
atmos.Haze = 1.5
atmos.Parent = Lighting

-- Sol
local sun = Instance.new("SunRaysEffect")
sun.Intensity = 0.15
sun.Spread = 0.1
sun.Parent = Lighting

print("✅ Iluminación configurada")

print("🎉 ¡Mako Mermaids completado!")
print("📍 Spawn en la cima: Y=121")
print("🌊 Océano: 1000x1000 studs, altura 60")
print("🏝️ Isla: 200x200 studs, altura 120")
print("🌴 50 palmeras, 60 rocas")
