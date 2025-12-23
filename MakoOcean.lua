--[[
🧜♀️ MAKO MERMAIDS - OCÉANO
Colocar en: ServerScriptService
]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

print("🌊 Iniciando creación del océano de Mako...")

-- Carpeta principal
local oceanFolder = Instance.new("Folder")
oceanFolder.Name = "MakoOcean"
oceanFolder.Parent = workspace

-- ========================================
-- CONFIGURAR ILUMINACIÓN SUBMARINA
-- ========================================
local function setupLighting()
    print("💡 Configurando iluminación submarina...")
    
    Lighting.Ambient = Color3.fromRGB(50, 120, 180)
    Lighting.Brightness = 2
    Lighting.ColorShift_Top = Color3.fromRGB(100, 180, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 140, 200)
    Lighting.FogEnd = 300
    Lighting.FogColor = Color3.fromRGB(30, 100, 150)
    
    -- Atmósfera submarina
    local atmosphere = Instance.new("Atmosphere")
    atmosphere.Density = 0.4
    atmosphere.Offset = 0.3
    atmosphere.Color = Color3.fromRGB(100, 180, 255)
    atmosphere.Decay = Color3.fromRGB(100, 150, 200)
    atmosphere.Glare = 0.5
    atmosphere.Haze = 2
    atmosphere.Parent = Lighting
    
    -- Sol para rayos de luz
    local sun = Instance.new("SunRaysEffect")
    sun.Intensity = 0.15
    sun.Spread = 0.1
    sun.Parent = Lighting
end

-- ========================================
-- CREAR SUELO MARINO
-- ========================================
local function createOceanFloor()
    print("🏖️ Creando suelo marino...")
    
    -- Suelo principal de arena
    local floor = Instance.new("Part")
    floor.Name = "OceanFloor"
    floor.Size = Vector3.new(500, 5, 500)
    floor.Position = Vector3.new(0, -50, 0)
    floor.Anchored = true
    floor.Material = Enum.Material.Sand
    floor.Color = Color3.fromRGB(220, 200, 160)
    floor.Parent = oceanFolder
    
    -- Capas de arena con diferentes tonos
    for i = 1, 30 do
        local sandPatch = Instance.new("Part")
        sandPatch.Size = Vector3.new(
            math.random(20, 50),
            0.5,
            math.random(20, 50)
        )
        sandPatch.Position = Vector3.new(
            math.random(-240, 240),
            -47,
            math.random(-240, 240)
        )
        sandPatch.Anchored = true
        sandPatch.Material = Enum.Material.Sand
        sandPatch.Color = Color3.fromRGB(
            math.random(200, 230),
            math.random(180, 210),
            math.random(140, 170)
        )
        sandPatch.Parent = floor
    end
    
    -- Rocas en el suelo
    for i = 1, 50 do
        local rock = Instance.new("Part")
        rock.Size = Vector3.new(
            math.random(3, 8),
            math.random(2, 6),
            math.random(3, 8)
        )
        rock.Position = Vector3.new(
            math.random(-230, 230),
            -46,
            math.random(-230, 230)
        )
        rock.Anchored = true
        rock.Material = Enum.Material.Rock
        rock.Color = Color3.fromRGB(
            math.random(80, 120),
            math.random(80, 120),
            math.random(80, 120)
        )
        rock.Orientation = Vector3.new(
            math.random(-15, 15),
            math.random(0, 360),
            math.random(-15, 15)
        )
        rock.Parent = floor
    end
    
    return floor
end

-- ========================================
-- CREAR AGUA DEL OCÉANO
-- ========================================
local function createWater()
    print("💧 Creando agua del océano...")
    
    -- Agua principal
    local water = Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(500, 80, 500)
    water.Position = Vector3.new(0, -10, 0)
    water.Anchored = true
    water.CanCollide = false
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(50, 150, 200)
    water.Transparency = 0.4
    water.Reflectance = 0.3
    water.Parent = oceanFolder
    
    -- Partículas de burbujas
    for i = 1, 20 do
        local bubbleEmitter = Instance.new("Part")
        bubbleEmitter.Size = Vector3.new(1, 1, 1)
        bubbleEmitter.Position = Vector3.new(
            math.random(-200, 200),
            -45,
            math.random(-200, 200)
        )
        bubbleEmitter.Anchored = true
        bubbleEmitter.Transparency = 1
        bubbleEmitter.CanCollide = false
        bubbleEmitter.Parent = water
        
        local bubbles = Instance.new("ParticleEmitter")
        bubbles.Texture = "rbxasset://textures/particles/smoke_main.dds"
        bubbles.Rate = 5
        bubbles.Lifetime = NumberRange.new(3, 5)
        bubbles.Speed = NumberRange.new(2, 4)
        bubbles.SpreadAngle = Vector2.new(30, 30)
        bubbles.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
        bubbles.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(1, 1)
        })
        bubbles.Color = ColorSequence.new(Color3.fromRGB(200, 230, 255))
        bubbles.LightEmission = 0.5
        bubbles.Parent = bubbleEmitter
    end
    
    return water
end

-- ========================================
-- CREAR CORALES
-- ========================================
local function createCorals()
    print("🪸 Creando corales...")
    
    local coralColors = {
        Color3.fromRGB(255, 100, 150),  -- Rosa
        Color3.fromRGB(150, 100, 255),  -- Morado
        Color3.fromRGB(255, 150, 100),  -- Naranja
        Color3.fromRGB(100, 255, 200),  -- Turquesa
        Color3.fromRGB(255, 200, 100)   -- Amarillo
    }
    
    for i = 1, 40 do
        local coralBase = Instance.new("Part")
        coralBase.Size = Vector3.new(
            math.random(2, 4),
            math.random(3, 6),
            math.random(2, 4)
        )
        coralBase.Position = Vector3.new(
            math.random(-220, 220),
            -45,
            math.random(-220, 220)
        )
        coralBase.Anchored = true
        coralBase.Material = Enum.Material.Cobblestone
        coralBase.Color = coralColors[math.random(1, #coralColors)]
        coralBase.Parent = oceanFolder
        
        -- Ramas del coral
        for j = 1, math.random(3, 6) do
            local branch = Instance.new("Part")
            branch.Size = Vector3.new(
                math.random(5, 15) / 10,
                math.random(10, 25) / 10,
                math.random(5, 15) / 10
            )
            branch.Position = coralBase.Position + Vector3.new(
                math.random(-15, 15) / 10,
                math.random(10, 30) / 10,
                math.random(-15, 15) / 10
            )
            branch.Anchored = true
            branch.Material = Enum.Material.Cobblestone
            branch.Color = coralBase.Color
            branch.Orientation = Vector3.new(
                math.random(-30, 30),
                math.random(0, 360),
                math.random(-30, 30)
            )
            branch.Parent = coralBase
        end
        
        -- Luz del coral
        local coralLight = Instance.new("PointLight")
        coralLight.Brightness = 1
        coralLight.Range = 10
        coralLight.Color = coralBase.Color
        coralLight.Parent = coralBase
    end
end

-- ========================================
-- CREAR PLANTAS MARINAS
-- ========================================
local function createSeaPlants()
    print("🌿 Creando plantas marinas...")
    
    for i = 1, 60 do
        local plant = Instance.new("Part")
        plant.Size = Vector3.new(
            math.random(3, 8) / 10,
            math.random(4, 10),
            math.random(3, 8) / 10
        )
        plant.Position = Vector3.new(
            math.random(-230, 230),
            -45,
            math.random(-230, 230)
        )
        plant.Anchored = true
        plant.Material = Enum.Material.Grass
        plant.Color = Color3.fromRGB(
            math.random(50, 100),
            math.random(150, 200),
            math.random(80, 130)
        )
        plant.Orientation = Vector3.new(
            math.random(-10, 10),
            math.random(0, 360),
            math.random(-10, 10)
        )
        plant.Parent = oceanFolder
        
        -- Animación de movimiento
        local tween = TweenService:Create(
            plant,
            TweenInfo.new(
                math.random(20, 40) / 10,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut,
                -1,
                true
            ),
            {
                Orientation = plant.Orientation + Vector3.new(
                    math.random(-15, 15),
                    0,
                    math.random(-15, 15)
                )
            }
        )
        tween:Play()
    end
end

-- ========================================
-- CREAR RAYOS DE LUZ SUBMARINOS
-- ========================================
local function createLightRays()
    print("☀️ Creando rayos de luz...")
    
    for i = 1, 15 do
        local lightRay = Instance.new("Part")
        lightRay.Size = Vector3.new(
            math.random(5, 15),
            60,
            math.random(5, 15)
        )
        lightRay.Position = Vector3.new(
            math.random(-200, 200),
            -20,
            math.random(-200, 200)
        )
        lightRay.Anchored = true
        lightRay.CanCollide = false
        lightRay.Material = Enum.Material.Neon
        lightRay.Color = Color3.fromRGB(150, 200, 255)
        lightRay.Transparency = 0.7
        lightRay.Orientation = Vector3.new(
            math.random(-10, 10),
            math.random(0, 360),
            math.random(-10, 10)
        )
        lightRay.Parent = oceanFolder
        
        -- Animación de brillo
        local tween = TweenService:Create(
            lightRay,
            TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Transparency = 0.9}
        )
        tween:Play()
    end
end

-- ========================================
-- CREAR PECES DECORATIVOS
-- ========================================
local function createFish()
    print("🐠 Creando peces...")
    
    local fishColors = {
        Color3.fromRGB(255, 150, 0),    -- Naranja
        Color3.fromRGB(255, 255, 0),    -- Amarillo
        Color3.fromRGB(0, 200, 255),    -- Azul
        Color3.fromRGB(255, 100, 200),  -- Rosa
        Color3.fromRGB(150, 255, 150)   -- Verde
    }
    
    for i = 1, 30 do
        local fish = Instance.new("Part")
        fish.Size = Vector3.new(1.5, 0.8, 0.5)
        fish.Position = Vector3.new(
            math.random(-200, 200),
            math.random(-40, -10),
            math.random(-200, 200)
        )
        fish.Anchored = false
        fish.Material = Enum.Material.SmoothPlastic
        fish.Color = fishColors[math.random(1, #fishColors)]
        fish.Shape = Enum.PartType.Ball
        fish.Parent = oceanFolder
        
        -- BodyVelocity para movimiento
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Velocity = Vector3.new(
            math.random(-5, 5),
            math.random(-2, 2),
            math.random(-5, 5)
        )
        bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVel.Parent = fish
        
        -- Cambiar dirección aleatoriamente
        task.spawn(function()
            while fish.Parent do
                wait(math.random(3, 8))
                if bodyVel and bodyVel.Parent then
                    bodyVel.Velocity = Vector3.new(
                        math.random(-5, 5),
                        math.random(-2, 2),
                        math.random(-5, 5)
                    )
                end
            end
        end)
    end
end

-- ========================================
-- CREAR ZONA DE SPAWN
-- ========================================
local function createSpawnZone()
    print("🏊 Creando zona de spawn...")
    
    local spawnPlatform = Instance.new("Part")
    spawnPlatform.Name = "SpawnPlatform"
    spawnPlatform.Size = Vector3.new(30, 1, 30)
    spawnPlatform.Position = Vector3.new(0, 5, 0)
    spawnPlatform.Anchored = true
    spawnPlatform.Material = Enum.Material.Wood
    spawnPlatform.Color = Color3.fromRGB(150, 120, 80)
    spawnPlatform.Parent = oceanFolder
    
    -- Borde brillante
    local border = Instance.new("Part")
    border.Size = Vector3.new(31, 0.5, 31)
    border.Position = spawnPlatform.Position + Vector3.new(0, -0.3, 0)
    border.Anchored = true
    border.Material = Enum.Material.Neon
    border.Color = Color3.fromRGB(100, 200, 255)
    border.Transparency = 0.3
    border.Parent = spawnPlatform
    
    return spawnPlatform
end

-- ========================================
-- SPAWN DE JUGADORES
-- ========================================
local spawnPlatform = nil

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(0.5)
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and spawnPlatform then
            humanoidRootPart.CFrame = CFrame.new(spawnPlatform.Position + Vector3.new(0, 3, 0))
        end
    end)
end)

-- ========================================
-- INICIALIZAR OCÉANO
-- ========================================
setupLighting()
createOceanFloor()
createWater()
createCorals()
createSeaPlants()
createLightRays()
createFish()
spawnPlatform = createSpawnZone()

print("✅ Océano de Mako creado completamente!")
