--[[
🧜♀️ MAKO MERMAIDS - OCÉANO REAL
Colocar en: ServerScriptService
]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

print("🌊 Creando océano REAL de Mako Mermaids...")

local terrain = workspace.Terrain

-- ========================================
-- LIMPIAR TERRAIN
-- ========================================
terrain:Clear()

-- ========================================
-- CREAR AGUA REAL CON TERRAIN
-- ========================================
local function createRealWater()
    print("💧 Generando agua REAL con Terrain...")
    
    -- Región de agua (200x200x60 studs)
    local waterRegion = Region3.new(
        Vector3.new(-100, -60, -100),
        Vector3.new(100, 0, 100)
    ):ExpandToGrid(4)
    
    terrain:FillRegion(waterRegion, 4, Enum.Material.Water)
    
    -- Configurar propiedades del agua
    terrain.WaterWaveSize = 0.3
    terrain.WaterWaveSpeed = 15
    terrain.WaterReflectance = 0.8
    terrain.WaterTransparency = 0.3
    
    print("✅ Agua real creada")
end

-- ========================================
-- CREAR SUELO MARINO CON TERRAIN
-- ========================================
local function createOceanFloor()
    print("🏖️ Generando suelo marino...")
    
    -- Suelo de arena
    local floorRegion = Region3.new(
        Vector3.new(-100, -65, -100),
        Vector3.new(100, -60, 100)
    ):ExpandToGrid(4)
    
    terrain:FillRegion(floorRegion, 4, Enum.Material.Sand)
    
    -- Rocas en el suelo
    for i = 1, 30 do
        local rockPos = Vector3.new(
            math.random(-90, 90),
            -60,
            math.random(-90, 90)
        )
        local rockSize = Vector3.new(
            math.random(3, 8),
            math.random(2, 5),
            math.random(3, 8)
        )
        local rockRegion = Region3.new(
            rockPos - rockSize/2,
            rockPos + rockSize/2
        ):ExpandToGrid(4)
        
        terrain:FillRegion(rockRegion, 4, Enum.Material.Rock)
    end
    
    print("✅ Suelo marino creado")
end

-- ========================================
-- CONFIGURAR ILUMINACIÓN
-- ========================================
local function setupLighting()
    print("💡 Configurando iluminación...")
    
    Lighting.Ambient = Color3.fromRGB(70, 140, 200)
    Lighting.Brightness = 2.5
    Lighting.ColorShift_Top = Color3.fromRGB(120, 180, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(80, 150, 210)
    Lighting.FogEnd = 250
    Lighting.FogColor = Color3.fromRGB(40, 120, 180)
    Lighting.ClockTime = 14
    
    -- Atmósfera
    local atmos = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere")
    atmos.Density = 0.35
    atmos.Offset = 0.25
    atmos.Color = Color3.fromRGB(120, 180, 255)
    atmos.Decay = Color3.fromRGB(100, 160, 220)
    atmos.Glare = 0.4
    atmos.Haze = 1.8
    atmos.Parent = Lighting
    
    -- Rayos de sol
    local sun = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect")
    sun.Intensity = 0.12
    sun.Spread = 0.08
    sun.Parent = Lighting
    
    print("✅ Iluminación configurada")
end

-- ========================================
-- CREAR CORALES DETALLADOS
-- ========================================
local function createCoral(position, color)
    local coral = Instance.new("Model")
    coral.Name = "Coral"
    
    -- Base del coral
    local base = Instance.new("Part")
    base.Size = Vector3.new(2, 3, 2)
    base.Position = position
    base.Anchored = true
    base.Material = Enum.Material.Cobblestone
    base.Color = color
    base.Parent = coral
    
    -- Ramas
    for i = 1, 5 do
        local branch = Instance.new("Part")
        branch.Size = Vector3.new(0.8, 2, 0.8)
        branch.Position = base.Position + Vector3.new(
            math.random(-10, 10) / 10,
            1.5,
            math.random(-10, 10) / 10
        )
        branch.Anchored = true
        branch.Material = Enum.Material.Cobblestone
        branch.Color = color
        branch.Orientation = Vector3.new(
            math.random(-20, 20),
            math.random(0, 360),
            math.random(-20, 20)
        )
        branch.Parent = coral
    end
    
    -- Luz
    local light = Instance.new("PointLight")
    light.Brightness = 0.8
    light.Range = 12
    light.Color = color
    light.Parent = base
    
    coral.Parent = workspace
    return coral
end

local function createCorals()
    print("🪸 Creando corales...")
    
    local colors = {
        Color3.fromRGB(255, 120, 180),
        Color3.fromRGB(180, 120, 255),
        Color3.fromRGB(255, 180, 120),
        Color3.fromRGB(120, 255, 220),
        Color3.fromRGB(255, 220, 120)
    }
    
    for i = 1, 25 do
        local pos = Vector3.new(
            math.random(-85, 85),
            -58,
            math.random(-85, 85)
        )
        createCoral(pos, colors[math.random(1, #colors)])
    end
    
    print("✅ Corales creados")
end

-- ========================================
-- CREAR PLANTAS MARINAS
-- ========================================
local function createSeaweed(position)
    local seaweed = Instance.new("Part")
    seaweed.Size = Vector3.new(0.5, 6, 0.5)
    seaweed.Position = position
    seaweed.Anchored = true
    seaweed.Material = Enum.Material.Grass
    seaweed.Color = Color3.fromRGB(60, 180, 100)
    seaweed.Parent = workspace
    
    -- Animación
    task.spawn(function()
        while seaweed.Parent do
            local tween = TweenService:Create(
                seaweed,
                TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Orientation = Vector3.new(math.random(-15, 15), 0, math.random(-15, 15))}
            )
            tween:Play()
            wait(3)
        end
    end)
    
    return seaweed
end

local function createSeaweeds()
    print("🌿 Creando plantas marinas...")
    
    for i = 1, 40 do
        local pos = Vector3.new(
            math.random(-85, 85),
            -58,
            math.random(-85, 85)
        )
        createSeaweed(pos)
    end
    
    print("✅ Plantas creadas")
end

-- ========================================
-- CREAR PLATAFORMA DE SPAWN
-- ========================================
local function createSpawnPlatform()
    print("🏊 Creando plataforma de spawn...")
    
    local platform = Instance.new("Part")
    platform.Name = "SpawnPlatform"
    platform.Size = Vector3.new(25, 2, 25)
    platform.Position = Vector3.new(0, 5, 0)
    platform.Anchored = true
    platform.Material = Enum.Material.Wood
    platform.Color = Color3.fromRGB(160, 130, 90)
    platform.Parent = workspace
    
    -- Borde
    local border = Instance.new("Part")
    border.Size = Vector3.new(26, 0.5, 26)
    border.Position = platform.Position + Vector3.new(0, -0.8, 0)
    border.Anchored = true
    border.Material = Enum.Material.Neon
    border.Color = Color3.fromRGB(120, 200, 255)
    border.Transparency = 0.2
    border.Parent = platform
    
    print("✅ Plataforma creada")
    return platform
end

-- ========================================
-- SPAWN DE JUGADORES
-- ========================================
local spawnPlatform = nil

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(0.5)
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp and spawnPlatform then
            hrp.CFrame = CFrame.new(spawnPlatform.Position + Vector3.new(0, 4, 0))
        end
    end)
end)

-- ========================================
-- INICIALIZAR
-- ========================================
createRealWater()
createOceanFloor()
setupLighting()
createCorals()
createSeaweeds()
spawnPlatform = createSpawnPlatform()

print("✅ Océano REAL de Mako Mermaids completado!")
