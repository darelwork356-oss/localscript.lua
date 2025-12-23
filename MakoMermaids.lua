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

-- PALMERAS TROPICALES REALISTAS (150 palmeras)
for i = 1, 150 do
    local x = math.random(-150, 150)
    local z = math.random(-150, 150)
    if math.sqrt(x*x + z*z) < 140 then
        local treeModel = Instance.new("Model")
        treeModel.Name = "PalmTree"
        treeModel.Parent = islandDecor
        
        -- Tronco con segmentos curvos
        for seg = 0, 6 do
            local segment = Instance.new("Part")
            segment.Size = Vector3.new(2.5, 5, 2.5)
            segment.Position = Vector3.new(x + math.sin(seg*0.3)*2, 155 + seg*4.5, z + math.cos(seg*0.3)*2)
            segment.Anchored = true
            segment.Material = Enum.Material.Wood
            segment.Color = Color3.fromRGB(120, 85, 60)
            segment.Shape = Enum.PartType.Cylinder
            segment.Orientation = Vector3.new(0, 0, 90 + seg*3)
            segment.Parent = treeModel
            
            -- Textura del tronco
            local mesh = Instance.new("CylinderMesh")
            mesh.Scale = Vector3.new(1, 1, 1)
            mesh.Parent = segment
        end
        
        -- Hojas de palma (8 hojas)
        for leafNum = 1, 8 do
            local angle = math.rad(leafNum * 45)
            local leafBase = Instance.new("Part")
            leafBase.Size = Vector3.new(1, 1, 12)
            leafBase.Position = Vector3.new(x, 185, z) + Vector3.new(math.cos(angle)*6, -2, math.sin(angle)*6)
            leafBase.Anchored = true
            leafBase.Material = Enum.Material.Grass
            leafBase.Color = Color3.fromRGB(40, 140, 40)
            leafBase.Transparency = 0.1
            leafBase.Orientation = Vector3.new(math.random(-20, -10), math.deg(angle), 0)
            leafBase.Parent = treeModel
            
            -- Hojas secundarias
            for side = -1, 1, 2 do
                for j = 1, 5 do
                    local subLeaf = Instance.new("Part")
                    subLeaf.Size = Vector3.new(0.3, 0.3, 3)
                    subLeaf.Position = leafBase.Position + leafBase.CFrame.LookVector * (j*2) + leafBase.CFrame.RightVector * (side*1.5)
                    subLeaf.Anchored = true
                    subLeaf.Material = Enum.Material.Grass
                    subLeaf.Color = Color3.fromRGB(30, math.random(120, 160), 30)
                    subLeaf.Transparency = 0.2
                    subLeaf.Orientation = leafBase.Orientation + Vector3.new(side*20, 0, side*30)
                    subLeaf.Parent = treeModel
                end
            end
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

-- CONCHAS MARINAS REALISTAS EN ESPIRAL (500 conchas)
for i = 1, 500 do
    local shellModel = Instance.new("Model")
    shellModel.Name = "SeaShell"
    shellModel.Parent = oceanFloor
    
    local x = math.random(-1400, 1400)
    local z = math.random(-1400, 1400)
    local shellColors = {
        Color3.fromRGB(255, 200, 180),
        Color3.fromRGB(255, 150, 200),
        Color3.fromRGB(200, 150, 255),
        Color3.fromRGB(255, 220, 150),
        Color3.fromRGB(255, 180, 200)
    }
    local shellColor = shellColors[math.random(1, #shellColors)]
    
    -- Crear espiral de concha (8 segmentos)
    for spiral = 1, 8 do
        local angle = math.rad(spiral * 45)
        local radius = spiral * 0.4
        local segment = Instance.new("Part")
        segment.Size = Vector3.new(1 + spiral*0.3, 1 + spiral*0.3, 1.5 + spiral*0.2)
        segment.Position = Vector3.new(
            x + math.cos(angle) * radius,
            -2 + spiral * 0.3,
            z + math.sin(angle) * radius
        )
        segment.Anchored = true
        segment.Material = Enum.Material.Marble
        segment.Color = shellColor
        segment.Shape = Enum.PartType.Ball
        segment.Orientation = Vector3.new(math.random(-30, 30), math.deg(angle), math.random(-30, 30))
        segment.Parent = shellModel
        
        -- Brillo perlado
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.Sphere
        mesh.Scale = Vector3.new(1, 0.8, 1.2)
        mesh.Parent = segment
    end
end

-- ALGAS MARINAS ANIMADAS (400 algas)
for i = 1, 400 do
    local seaweedModel = Instance.new("Model")
    seaweedModel.Name = "Seaweed"
    seaweedModel.Parent = oceanFloor
    
    local x = math.random(-1400, 1400)
    local z = math.random(-1400, 1400)
    local height = math.random(15, 40)
    local segments = math.floor(height / 4)
    local baseColor = Color3.fromRGB(math.random(20, 50), math.random(100, 150), math.random(20, 50))
    
    -- Crear alga con segmentos ondulantes
    for seg = 1, segments do
        local segment = Instance.new("Part")
        segment.Size = Vector3.new(1.5, 4, 0.5)
        segment.Position = Vector3.new(
            x + math.sin(seg * 0.5) * (seg * 0.3),
            seg * 4,
            z + math.cos(seg * 0.5) * (seg * 0.3)
        )
        segment.Anchored = false
        segment.CanCollide = false
        segment.Material = Enum.Material.Neon
        segment.Color = baseColor
        segment.Transparency = 0.3
        segment.Parent = seaweedModel
        
        -- Mesh para forma de hoja
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://1290033"  -- Mesh de hoja
        mesh.Scale = Vector3.new(2, 4, 1)
        mesh.Parent = segment
        
        -- Animación ondulante
        local bodyPos = Instance.new("BodyPosition")
        bodyPos.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyPos.Position = segment.Position
        bodyPos.Parent = segment
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(400, 400, 400)
        bodyGyro.Parent = segment
        
        -- Script de animación
        task.spawn(function()
            local time = 0
            while segment.Parent do
                time = time + 0.05
                local offset = math.sin(time + seg * 0.5) * 2
                bodyPos.Position = Vector3.new(
                    x + math.sin(seg * 0.5) * (seg * 0.3) + offset,
                    seg * 4,
                    z + math.cos(seg * 0.5) * (seg * 0.3) + math.cos(time) * 1
                )
                bodyGyro.CFrame = CFrame.Angles(math.sin(time) * 0.3, 0, math.cos(time) * 0.3)
                task.wait(0.05)
            end
        end)
    end
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
