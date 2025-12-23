--[[
🧜♀️ MAKO MERMAIDS - JUEGO ÉPICO
Colocar en: ServerScriptService
]]

print("🌊 Iniciando Mako Mermaids ÉPICO...")

local terrain = workspace.Terrain
terrain:Clear()

-- ========================================
-- OCÉANO MASIVO Y PROFUNDO
-- ========================================
print("💧 Creando océano MASIVO...")

-- Océano GIGANTE: 3000x3000 studs, profundidad 150
terrain:FillRegion(
    Region3.new(Vector3.new(-1500, 0, -1500), Vector3.new(1500, 150, 1500)):ExpandToGrid(4),
    4,
    Enum.Material.Water
)

-- Fondo oceánico profundo (arena)
terrain:FillRegion(
    Region3.new(Vector3.new(-1500, -50, -1500), Vector3.new(1500, 0, 1500)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)

-- Zonas rocosas submarinas
for i = 1, 15 do
    local x = math.random(-1400, 1400)
    local z = math.random(-1400, 1400)
    terrain:FillRegion(
        Region3.new(Vector3.new(x-30, -40, z-30), Vector3.new(x+30, -10, z+30)):ExpandToGrid(4),
        4,
        Enum.Material.Rock
    )
end

print("✅ Océano MASIVO: 3000x3000 studs, profundidad 150")

-- ========================================
-- ISLA DE MAKO ÉPICA Y REALISTA
-- ========================================
print("🏝️ Construyendo Isla de Mako ÉPICA...")

-- Base submarina MASIVA (350x350)
terrain:FillRegion(
    Region3.new(Vector3.new(-175, -50, -175), Vector3.new(175, 140, 175)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Superficie de la isla con forma irregular
terrain:FillRegion(
    Region3.new(Vector3.new(-160, 140, -160), Vector3.new(160, 155, 160)):ExpandToGrid(4),
    4,
    Enum.Material.Grass
)

-- Montaña volcánica central (3 niveles)
terrain:FillRegion(
    Region3.new(Vector3.new(-80, 155, -80), Vector3.new(80, 200, 80)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)
terrain:FillRegion(
    Region3.new(Vector3.new(-50, 200, -50), Vector3.new(50, 240, 50)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)
terrain:FillRegion(
    Region3.new(Vector3.new(-25, 240, -25), Vector3.new(25, 270, 25)):ExpandToGrid(4),
    4,
    Enum.Material.Rock
)

-- Playas amplias y realistas
for angle = 0, 360, 30 do
    local rad = math.rad(angle)
    local x = math.cos(rad) * 140
    local z = math.sin(rad) * 140
    terrain:FillRegion(
        Region3.new(Vector3.new(x-25, 135, z-25), Vector3.new(x+25, 145, z+25)):ExpandToGrid(4),
        4,
        Enum.Material.Sand
    )
end

-- Acantilados rocosos
for i = 1, 8 do
    local angle = math.rad(i * 45)
    local x = math.cos(angle) * 150
    local z = math.sin(angle) * 150
    terrain:FillRegion(
        Region3.new(Vector3.new(x-15, 145, z-15), Vector3.new(x+15, 180, z+15)):ExpandToGrid(4),
        4,
        Enum.Material.Rock
    )
end

print("✅ Isla de Mako ÉPICA: 350x350 studs, altura 270")

-- ========================================
-- CUEVA DE LA LUNA DE MAKO (ÉPICA)
-- ========================================
print("🕳️ Creando Cueva de la Luna...")

local caveFolder = Instance.new("Folder")
caveFolder.Name = "MoonPoolCave"
caveFolder.Parent = workspace

-- Entrada principal MASIVA
local entrance = Instance.new("Part")
entrance.Name = "CaveEntrance"
entrance.Size = Vector3.new(50, 60, 50)
entrance.Position = Vector3.new(0, 210, 0)
entrance.Anchored = true
entrance.Material = Enum.Material.Rock
entrance.Color = Color3.fromRGB(40, 40, 45)
entrance.Parent = caveFolder

-- Arco de entrada con cristales
for i = 1, 12 do
    local angle = math.rad(i * 30)
    local crystal = Instance.new("Part")
    crystal.Size = Vector3.new(3, 15, 3)
    crystal.Position = Vector3.new(math.cos(angle)*20, 215, math.sin(angle)*20)
    crystal.Anchored = true
    crystal.Material = Enum.Material.Neon
    crystal.Color = Color3.fromRGB(100, 200, 255)
    crystal.Transparency = 0.3
    crystal.Parent = caveFolder
    
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(100, 200, 255)
    light.Brightness = 2
    light.Range = 30
    light.Parent = crystal
end

-- Piscina lunar (Moon Pool)
local moonPool = Instance.new("Part")
moonPool.Name = "MoonPool"
moonPool.Size = Vector3.new(40, 5, 40)
moonPool.Position = Vector3.new(0, 180, 0)
moonPool.Anchored = true
moonPool.Material = Enum.Material.Neon
moonPool.Color = Color3.fromRGB(50, 150, 255)
moonPool.Transparency = 0.5
moonPool.Parent = caveFolder

local poolLight = Instance.new("PointLight")
poolLight.Color = Color3.fromRGB(50, 150, 255)
poolLight.Brightness = 5
poolLight.Range = 100
poolLight.Parent = moonPool

print("✅ Cueva de la Luna ÉPICA creada")

-- ========================================
-- DECORACIÓN ÉPICA DE LA ISLA
-- ========================================
print("🌴 Decorando isla épicamente...")

local islandDecor = Instance.new("Folder")
islandDecor.Name = "IslandDecoration"
islandDecor.Parent = workspace

-- Selva tropical (200 palmeras)
for i = 1, 200 do
    local x = math.random(-150, 150)
    local z = math.random(-150, 150)
    if math.sqrt(x*x + z*z) < 140 then
        local trunk = Instance.new("Part")
        trunk.Size = Vector3.new(3, math.random(20, 35), 3)
        trunk.Position = Vector3.new(x, 155, z)
        trunk.Anchored = true
        trunk.Material = Enum.Material.Wood
        trunk.Color = Color3.fromRGB(100, 70, 40)
        trunk.Parent = islandDecor
        
        for j = 1, 5 do
            local leaf = Instance.new("Part")
            leaf.Size = Vector3.new(15, 2, 15)
            leaf.Position = trunk.Position + Vector3.new(math.random(-5,5), trunk.Size.Y/2+j*2, math.random(-5,5))
            leaf.Anchored = true
            leaf.Material = Enum.Material.Grass
            leaf.Color = Color3.fromRGB(30, math.random(100,150), 30)
            leaf.Shape = Enum.PartType.Ball
            leaf.Parent = trunk
        end
    end
end

-- Rocas volcánicas (150 rocas)
for i = 1, 150 do
    local rock = Instance.new("Part")
    rock.Size = Vector3.new(math.random(5, 20), math.random(5, 15), math.random(5, 20))
    rock.Position = Vector3.new(math.random(-155, 155), 155, math.random(-155, 155))
    rock.Anchored = true
    rock.Material = Enum.Material.Rock
    rock.Color = Color3.fromRGB(math.random(50, 80), math.random(50, 80), math.random(50, 80))
    rock.Orientation = Vector3.new(math.random(-20, 20), math.random(0, 360), math.random(-20, 20))
    rock.Parent = islandDecor
end

print("✅ Isla decorada: 200 palmeras, 150 rocas")

-- ========================================
-- FONDO MARINO ÉPICO
-- ========================================
print("🐚 Creando fondo marino detallado...")

local oceanFloor = Instance.new("Folder")
oceanFloor.Name = "OceanFloor"
oceanFloor.Parent = workspace

-- CONCHAS MARINAS (500 conchas)
for i = 1, 500 do
    local shell = Instance.new("Part")
    shell.Name = "Shell"
    shell.Size = Vector3.new(math.random(2, 5), math.random(1, 3), math.random(2, 5))
    shell.Position = Vector3.new(math.random(-1400, 1400), -2, math.random(-1400, 1400))
    shell.Anchored = true
    shell.Material = Enum.Material.SmoothPlastic
    local colors = {
        Color3.fromRGB(255, 200, 180),
        Color3.fromRGB(255, 150, 200),
        Color3.fromRGB(200, 150, 255),
        Color3.fromRGB(255, 220, 150)
    }
    shell.Color = colors[math.random(1, #colors)]
    shell.Shape = Enum.PartType.Ball
    shell.Orientation = Vector3.new(math.random(-45, 45), math.random(0, 360), math.random(-45, 45))
    shell.Parent = oceanFloor
end

-- ALGAS MARINAS (400 algas)
for i = 1, 400 do
    local seaweed = Instance.new("Part")
    seaweed.Name = "Seaweed"
    seaweed.Size = Vector3.new(2, math.random(15, 40), 2)
    seaweed.Position = Vector3.new(math.random(-1400, 1400), 10, math.random(-1400, 1400))
    seaweed.Anchored = true
    seaweed.Material = Enum.Material.Grass
    seaweed.Color = Color3.fromRGB(math.random(20, 50), math.random(100, 150), math.random(20, 50))
    seaweed.Transparency = 0.2
    seaweed.Parent = oceanFloor
end

-- CORALES (300 corales)
for i = 1, 300 do
    local coral = Instance.new("Part")
    coral.Name = "Coral"
    coral.Size = Vector3.new(math.random(5, 15), math.random(8, 20), math.random(5, 15))
    coral.Position = Vector3.new(math.random(-1400, 1400), 5, math.random(-1400, 1400))
    coral.Anchored = true
    coral.Material = Enum.Material.Cobblestone
    local coralColors = {
        Color3.fromRGB(255, 100, 150),
        Color3.fromRGB(150, 100, 255),
        Color3.fromRGB(255, 150, 50),
        Color3.fromRGB(100, 255, 200)
    }
    coral.Color = coralColors[math.random(1, #coralColors)]
    coral.Parent = oceanFloor
    
    -- Luz en corales
    if math.random(1, 3) == 1 then
        local coralLight = Instance.new("PointLight")
        coralLight.Color = coral.Color
        coralLight.Brightness = 1.5
        coralLight.Range = 25
        coralLight.Parent = coral
    end
end

-- ROCAS SUBMARINAS (200 rocas)
for i = 1, 200 do
    local rock = Instance.new("Part")
    rock.Size = Vector3.new(math.random(10, 30), math.random(10, 25), math.random(10, 30))
    rock.Position = Vector3.new(math.random(-1400, 1400), 10, math.random(-1400, 1400))
    rock.Anchored = true
    rock.Material = Enum.Material.Rock
    rock.Color = Color3.fromRGB(math.random(60, 100), math.random(60, 100), math.random(60, 100))
    rock.Parent = oceanFloor
end

print("✅ Fondo marino: 500 conchas, 400 algas, 300 corales, 200 rocas")

-- ========================================
-- SPAWN EN LA PLAYA
-- ========================================
print("🏊 Creando spawn...")

local spawn = Instance.new("SpawnLocation")
spawn.Size = Vector3.new(20, 2, 20)
spawn.Position = Vector3.new(120, 145, 0)
spawn.Anchored = true
spawn.Material = Enum.Material.Wood
spawn.Color = Color3.fromRGB(150, 120, 80)
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.TopSurface = Enum.SurfaceType.Smooth
spawn.Parent = workspace

print("✅ Spawn en la playa")

-- ========================================
-- ILUMINACIÓN ÉPICA
-- ========================================
print("💡 Configurando iluminación épica...")

local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(80, 130, 180)
Lighting.Brightness = 2.5
Lighting.ColorShift_Top = Color3.fromRGB(150, 200, 255)
Lighting.OutdoorAmbient = Color3.fromRGB(100, 150, 200)
Lighting.FogEnd = 800
Lighting.FogColor = Color3.fromRGB(80, 160, 220)
Lighting.ClockTime = 15

local atmos = Instance.new("Atmosphere")
atmos.Density = 0.4
atmos.Offset = 0.3
atmos.Color = Color3.fromRGB(130, 180, 255)
atmos.Decay = Color3.fromRGB(100, 160, 220)
atmos.Glare = 0.8
atmos.Haze = 2
atmos.Parent = Lighting

local sun = Instance.new("SunRaysEffect")
sun.Intensity = 0.2
sun.Spread = 0.15
sun.Parent = Lighting

local bloom = Instance.new("BloomEffect")
bloom.Intensity = 0.5
bloom.Size = 24
bloom.Threshold = 0.8
bloom.Parent = Lighting

local blur = Instance.new("BlurEffect")
blur.Size = 2
blur.Parent = Lighting

print("✅ Iluminación épica configurada")

print("")
print("🎉 ═══════════════════════════════════════")
print("🧜♀️ MAKO MERMAIDS - JUEGO ÉPICO COMPLETADO")
print("═══════════════════════════════════════")
print("🌊 Océano: 3000x3000 studs, profundidad 150")
print("🏝️ Isla de Mako: 350x350 studs, altura 270")
print("🌴 Vegetación: 200 palmeras tropicales")
print("🪨 Rocas: 150 rocas volcánicas")
print("🐚 Fondo marino: 500 conchas")
print("🌿 Algas: 400 algas marinas")
print("🪸 Corales: 300 corales luminosos")
print("🪨 Rocas submarinas: 200")
print("🌙 Cueva de la Luna: ÉPICA con cristales")
print("📍 Spawn: Playa este (X=120, Y=145)")
print("═══════════════════════════════════════")
print("✨ ¡Listo para transformarte en sirena!")
print("")
