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

-- Agua REAL de Roblox (500x500 studs, 80 de profundidad)
terrain:FillRegion(
    Region3.new(Vector3.new(-250, -80, -250), Vector3.new(250, 0, 250)):ExpandToGrid(4),
    4,
    Enum.Material.Water
)

-- Suelo del océano (arena)
terrain:FillRegion(
    Region3.new(Vector3.new(-250, -85, -250), Vector3.new(250, -80, 250)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)

print("✅ Océano creado: 500x500 studs")

-- ========================================
-- CREAR ISLA DE MAKO
-- ========================================
print("🏝️ Construyendo Isla de Mako...")

-- Base de la isla (roca submarina)
terrain:FillRegion(
    Region3.new(Vector3.new(-60, -20, -60), Vector3.new(60, 0, 60)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Superficie de la isla (tierra y pasto)
terrain:FillRegion(
    Region3.new(Vector3.new(-50, 0, -50), Vector3.new(50, 15, 50)):ExpandToGrid(4),
    4,
    Enum.Material.Grass
)

-- Montaña central
terrain:FillRegion(
    Region3.new(Vector3.new(-30, 15, -30), Vector3.new(30, 40, 30)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Playa de arena
terrain:FillRegion(
    Region3.new(Vector3.new(-50, 0, -50), Vector3.new(-35, 3, 50)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)
terrain:FillRegion(
    Region3.new(Vector3.new(35, 0, -50), Vector3.new(50, 3, 50)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)

print("✅ Isla de Mako creada")

-- ========================================
-- CREAR CUEVA DE MAKO (ENTRADA)
-- ========================================
print("🕳️ Creando entrada a la cueva...")

local caveEntrance = Instance.new("Part")
caveEntrance.Name = "CaveEntrance"
caveEntrance.Size = Vector3.new(15, 20, 15)
caveEntrance.Position = Vector3.new(0, 10, 0)
caveEntrance.Anchored = true
caveEntrance.Material = Enum.Material.Rock
caveEntrance.Color = Color3.fromRGB(60, 60, 70)
caveEntrance.Parent = workspace

-- Agujero de entrada
local hole = Instance.new("Part")
hole.Size = Vector3.new(8, 12, 8)
hole.Position = Vector3.new(0, 10, 0)
hole.Anchored = true
hole.Transparency = 1
hole.CanCollide = false
hole.Parent = caveEntrance

print("✅ Entrada de cueva creada")

-- ========================================
-- DECORACIÓN DE LA ISLA
-- ========================================
print("🌴 Decorando isla...")

-- Palmeras
for i = 1, 15 do
    local trunk = Instance.new("Part")
    trunk.Size = Vector3.new(1.5, 12, 1.5)
    trunk.Position = Vector3.new(
        math.random(-45, 45),
        6,
        math.random(-45, 45)
    )
    trunk.Anchored = true
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(120, 80, 50)
    trunk.Parent = workspace
    
    -- Hojas
    local leaves = Instance.new("Part")
    leaves.Size = Vector3.new(8, 2, 8)
    leaves.Position = trunk.Position + Vector3.new(0, 7, 0)
    leaves.Anchored = true
    leaves.Material = Enum.Material.Grass
    leaves.Color = Color3.fromRGB(50, 150, 50)
    leaves.Shape = Enum.PartType.Ball
    leaves.Parent = trunk
end

-- Rocas decorativas
for i = 1, 30 do
    local rock = Instance.new("Part")
    rock.Size = Vector3.new(
        math.random(2, 6),
        math.random(2, 5),
        math.random(2, 6)
    )
    rock.Position = Vector3.new(
        math.random(-48, 48),
        2,
        math.random(-48, 48)
    )
    rock.Anchored = true
    rock.Material = Enum.Material.Rock
    rock.Color = Color3.fromRGB(
        math.random(80, 120),
        math.random(80, 120),
        math.random(80, 120)
    )
    rock.Parent = workspace
end

print("✅ Isla decorada")

-- ========================================
-- PLATAFORMA DE SPAWN
-- ========================================
print("🏊 Creando spawn...")

local spawn = Instance.new("SpawnLocation")
spawn.Size = Vector3.new(10, 1, 10)
spawn.Position = Vector3.new(0, 16, 0)
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
print("📍 Spawn en la cima de la isla")
print("🌊 Océano de 500x500 studs")
print("🏝️ Isla de Mako con cueva")
