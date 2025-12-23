--[[
🎮 LOBBY DE SUPERVIVENCIA - SERVER SCRIPT
Colocar en: ServerScriptService
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuración
local MAX_PLAYERS = 5
local COUNTDOWN_TIME = 20
local MIN_PLAYERS = 1

-- RemoteEvents para comunicación con clientes
local remoteFolder = Instance.new("Folder")
remoteFolder.Name = "LobbyRemotes"
remoteFolder.Parent = ReplicatedStorage

local updateTimerEvent = Instance.new("RemoteEvent")
updateTimerEvent.Name = "UpdateTimer"
updateTimerEvent.Parent = remoteFolder

local teleportEvent = Instance.new("RemoteEvent")
teleportEvent.Name = "TeleportToGame"
teleportEvent.Parent = remoteFolder

-- Variables del juego
local playersInLobby = {}
local playerCircles = {}
local gameStarted = false

-- Crear carpeta para el lobby
local lobbyFolder = Instance.new("Folder")
lobbyFolder.Name = "Lobby"
lobbyFolder.Parent = workspace

-- ========================================
-- CREAR MUELLE DE SUPERVIVENCIA DETALLADO
-- ========================================
local function createSurvivalDock()
    print("🏗️ Construyendo muelle de supervivencia...")
    
    -- Plataforma principal desgastada
    local mainDock = Instance.new("Part")
    mainDock.Name = "MainDock"
    mainDock.Size = Vector3.new(50, 1.2, 70)
    mainDock.Position = Vector3.new(0, 0.6, 0)
    mainDock.Anchored = true
    mainDock.Material = Enum.Material.Wood
    mainDock.Color = Color3.fromRGB(90, 65, 45)
    mainDock.Parent = lobbyFolder
    
    -- Tablas individuales desgastadas
    for z = -33, 33, 3.5 do
        for x = -23, 23, 46 do
            local plank = Instance.new("Part")
            plank.Size = Vector3.new(48, 0.4, 3)
            plank.Position = Vector3.new(0, 1.4, z)
            plank.Anchored = true
            plank.Material = Enum.Material.Wood
            plank.Color = Color3.fromRGB(math.random(70, 100), math.random(50, 70), math.random(35, 50))
            plank.Parent = mainDock
            
            -- Grietas en las tablas
            if math.random(1, 3) == 1 then
                local crack = Instance.new("Part")
                crack.Size = Vector3.new(math.random(5, 15) / 10, 0.1, 0.2)
                crack.Position = plank.Position + Vector3.new(math.random(-10, 10), 0.3, 0)
                crack.Anchored = true
                crack.Material = Enum.Material.SmoothPlastic
                crack.Color = Color3.fromRGB(40, 30, 20)
                crack.Parent = plank
            end
        end
    end
    
    -- Pilares de soporte con detalles
    for x = -20, 20, 20 do
        for z = -30, 30, 30 do
            local pillar = Instance.new("Part")
            pillar.Size = Vector3.new(1.8, 12, 1.8)
            pillar.Position = Vector3.new(x, -5.4, z)
            pillar.Anchored = true
            pillar.Material = Enum.Material.Wood
            pillar.Color = Color3.fromRGB(70, 50, 35)
            pillar.Parent = mainDock
            
            -- Algas y musgo
            local moss = Instance.new("Part")
            moss.Size = Vector3.new(2, 3, 2)
            moss.Position = pillar.Position + Vector3.new(0, -4, 0)
            moss.Anchored = true
            moss.Material = Enum.Material.Grass
            moss.Color = Color3.fromRGB(40, 60, 35)
            moss.Parent = pillar
            
            -- Cuerdas atadas
            local rope = Instance.new("Part")
            rope.Size = Vector3.new(0.2, 8, 0.2)
            rope.Position = pillar.Position + Vector3.new(0.8, 2, 0)
            rope.Anchored = true
            rope.Material = Enum.Material.Fabric
            rope.Color = Color3.fromRGB(100, 80, 50)
            rope.Parent = pillar
        end
    end
    
    -- Barandas rotas y desgastadas
    for z = -32, 32, 4 do
        if math.random(1, 3) ~= 1 then
            local railLeft = Instance.new("Part")
            railLeft.Size = Vector3.new(0.4, 2.5, 3.5)
            railLeft.Position = Vector3.new(-24, 2.5, z)
            railLeft.Anchored = true
            railLeft.Material = Enum.Material.Wood
            railLeft.Color = Color3.fromRGB(80, 60, 45)
            railLeft.Orientation = Vector3.new(0, 0, math.random(-5, 5))
            railLeft.Parent = mainDock
        end
        
        if math.random(1, 3) ~= 1 then
            local railRight = Instance.new("Part")
            railRight.Size = Vector3.new(0.4, 2.5, 3.5)
            railRight.Position = Vector3.new(24, 2.5, z)
            railRight.Anchored = true
            railRight.Material = Enum.Material.Wood
            railRight.Color = Color3.fromRGB(80, 60, 45)
            railRight.Orientation = Vector3.new(0, 0, math.random(-5, 5))
            railRight.Parent = mainDock
        end
    end
    
    -- Cajas de suministros
    local boxPositions = {
        Vector3.new(-20, 2, 25),
        Vector3.new(-18, 2, 28),
        Vector3.new(18, 2, 25),
        Vector3.new(20, 2, 28),
        Vector3.new(-20, 2, -28),
        Vector3.new(20, 2, -28)
    }
    
    for _, pos in ipairs(boxPositions) do
        local crate = Instance.new("Part")
        crate.Size = Vector3.new(3, 3, 3)
        crate.Position = pos
        crate.Anchored = true
        crate.Material = Enum.Material.Wood
        crate.Color = Color3.fromRGB(100, 75, 50)
        crate.Orientation = Vector3.new(0, math.random(0, 360), 0)
        crate.Parent = mainDock
        
        -- Marcas en las cajas
        for i = 1, 3 do
            local mark = Instance.new("Part")
            mark.Size = Vector3.new(2.5, 0.1, 0.3)
            mark.Position = crate.Position + Vector3.new(0, math.random(-1, 1), 1.6)
            mark.Anchored = true
            mark.Material = Enum.Material.SmoothPlastic
            mark.Color = Color3.fromRGB(40, 30, 20)
            mark.Parent = crate
        end
    end
    
    -- Linternas colgantes
    for z = -25, 25, 25 do
        for x = -15, 15, 30 do
            local lanternPost = Instance.new("Part")
            lanternPost.Size = Vector3.new(0.3, 4, 0.3)
            lanternPost.Position = Vector3.new(x, 4, z)
            lanternPost.Anchored = true
            lanternPost.Material = Enum.Material.Metal
            lanternPost.Color = Color3.fromRGB(60, 55, 50)
            lanternPost.Parent = mainDock
            
            local lantern = Instance.new("Part")
            lantern.Size = Vector3.new(1, 1.5, 1)
            lantern.Position = lanternPost.Position + Vector3.new(0, -2.5, 0)
            lantern.Anchored = true
            lantern.Material = Enum.Material.Glass
            lantern.Color = Color3.fromRGB(255, 200, 100)
            lantern.Transparency = 0.3
            lantern.Parent = lanternPost
            
            local light = Instance.new("PointLight")
            light.Brightness = 2
            light.Range = 20
            light.Color = Color3.fromRGB(255, 200, 100)
            light.Shadows = true
            light.Parent = lantern
        end
    end
    
    -- Agua oscura y profunda
    local water = Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(300, 1, 300)
    water.Position = Vector3.new(0, -11, 0)
    water.Anchored = true
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(30, 50, 60)
    water.Transparency = 0.4
    water.CanCollide = false
    water.Parent = lobbyFolder
    
    -- Niebla ambiental
    local fog = Instance.new("Atmosphere")
    fog.Density = 0.3
    fog.Offset = 0.5
    fog.Color = Color3.fromRGB(150, 150, 160)
    fog.Glare = 0.2
    fog.Haze = 1.5
    fog.Parent = game.Lighting
    
    return mainDock
end

-- ========================================
-- CREAR 5 CÍRCULOS EN EL PISO
-- ========================================
local spawnCircles = {}
local function createFloorCircles()
    print("✨ Creando círculos de spawn en el piso...")
    
    local positions = {
        Vector3.new(-15, 1.3, -10),
        Vector3.new(-7.5, 1.3, -10),
        Vector3.new(0, 1.3, -10),
        Vector3.new(7.5, 1.3, -10),
        Vector3.new(15, 1.3, -10)
    }
    
    for i, pos in ipairs(positions) do
        -- Círculo base EN EL PISO
        local circle = Instance.new("Part")
        circle.Name = "SpawnCircle" .. i
        circle.Size = Vector3.new(5, 0.3, 5)
        circle.Position = pos
        circle.Anchored = true
        circle.Shape = Enum.PartType.Cylinder
        circle.Material = Enum.Material.Neon
        circle.Color = Color3.fromRGB(50, 255, 150)
        circle.Orientation = Vector3.new(0, 0, 90)
        circle.Transparency = 0.2
        circle.CanCollide = false
        circle.Parent = lobbyFolder
        
        -- Anillo exterior brillante
        local ring = Instance.new("Part")
        ring.Size = Vector3.new(5.5, 0.25, 5.5)
        ring.Position = pos
        ring.Anchored = true
        ring.Shape = Enum.PartType.Cylinder
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(100, 255, 200)
        ring.Orientation = Vector3.new(0, 0, 90)
        ring.Transparency = 0.4
        ring.CanCollide = false
        ring.Parent = circle
        
        -- Partículas hacia arriba
        local particles = Instance.new("ParticleEmitter")
        particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particles.Rate = 30
        particles.Lifetime = NumberRange.new(2, 3)
        particles.Speed = NumberRange.new(3, 5)
        particles.SpreadAngle = Vector2.new(10, 10)
        particles.Size = NumberSequence.new(0.8, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.Color = ColorSequence.new(Color3.fromRGB(50, 255, 150))
        particles.LightEmission = 1
        particles.EmissionDirection = Enum.NormalDirection.Top
        particles.Parent = circle
        
        -- Luz brillante
        local light = Instance.new("PointLight")
        light.Brightness = 3
        light.Range = 18
        light.Color = Color3.fromRGB(50, 255, 150)
        light.Shadows = false
        light.Parent = circle
        
        -- Número grande en el piso
        local numberDecal = Instance.new("Decal")
        numberDecal.Texture = "rbxasset://textures/face.png"
        numberDecal.Face = Enum.NormalId.Top
        numberDecal.Color3 = Color3.fromRGB(255, 255, 255)
        numberDecal.Transparency = 0.3
        numberDecal.Parent = circle
        
        table.insert(spawnCircles, {
            circle = circle,
            position = pos + Vector3.new(0, 2, 0),
            occupied = false,
            number = i
        })
    end
end

-- ========================================
-- BOLSAS DE ARENA Y SUMINISTROS
-- ========================================
local function createSurvivalProps()
    print("🛡️ Colocando props de supervivencia...")
    
    -- Bolsas de arena apiladas
    local sandbagGroups = {
        {base = Vector3.new(-22, 1.5, 18), count = 6},
        {base = Vector3.new(22, 1.5, 18), count = 6},
        {base = Vector3.new(-22, 1.5, -30), count = 4},
        {base = Vector3.new(22, 1.5, -30), count = 4}
    }
    
    for _, group in ipairs(sandbagGroups) do
        for i = 1, group.count do
            local sandbag = Instance.new("Part")
            sandbag.Size = Vector3.new(2.8, 1.4, 1.8)
            sandbag.Position = group.base + Vector3.new(
                math.random(-2, 2),
                (i - 1) * 1.2,
                math.random(-2, 2)
            )
            sandbag.Anchored = true
            sandbag.Material = Enum.Material.Fabric
            sandbag.Color = Color3.fromRGB(120, 100, 70)
            sandbag.Orientation = Vector3.new(
                math.random(-5, 5),
                math.random(0, 360),
                math.random(-5, 5)
            )
            sandbag.Parent = lobbyFolder
            
            -- Cuerda
            local rope = Instance.new("Part")
            rope.Size = Vector3.new(2.5, 0.15, 0.15)
            rope.Position = sandbag.Position + Vector3.new(0, 0.4, 0)
            rope.Anchored = true
            rope.Material = Enum.Material.Fabric
            rope.Color = Color3.fromRGB(70, 50, 30)
            rope.Parent = sandbag
        end
    end
    
    -- Barriles oxidados
    for i = 1, 8 do
        local barrel = Instance.new("Part")
        barrel.Size = Vector3.new(2, 3, 2)
        barrel.Position = Vector3.new(
            math.random(-23, 23),
            2.5,
            math.random(20, 32)
        )
        barrel.Anchored = true
        barrel.Shape = Enum.PartType.Cylinder
        barrel.Material = Enum.Material.Metal
        barrel.Color = Color3.fromRGB(100, 80, 60)
        barrel.Orientation = Vector3.new(90, 0, math.random(0, 360))
        barrel.Parent = lobbyFolder
    end
end

-- ========================================
-- SISTEMA DE SPAWN
-- ========================================
local function getAvailableCircle()
    for _, circleData in ipairs(spawnCircles) do
        if not circleData.occupied then
            return circleData
        end
    end
    return nil
end

local function spawnPlayerInCircle(player)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local circleData = getAvailableCircle()
    if circleData then
        circleData.occupied = true
        playerCircles[player.UserId] = circleData
        humanoidRootPart.CFrame = CFrame.new(circleData.position)
        table.insert(playersInLobby, player)
        
        print("✅ " .. player.Name .. " spawneado en círculo " .. circleData.number)
        return true
    end
    return false
end

-- ========================================
-- SISTEMA DE COUNTDOWN
-- ========================================
local function startCountdown()
    if gameStarted then return end
    gameStarted = true
    
    print("⏱️ Iniciando countdown de " .. COUNTDOWN_TIME .. " segundos...")
    
    for i = COUNTDOWN_TIME, 0, -1 do
        -- Enviar tiempo a todos los jugadores
        for _, player in ipairs(playersInLobby) do
            updateTimerEvent:FireClient(player, i)
        end
        wait(1)
    end
    
    print("🎮 ¡Teletransportando jugadores!")
    
    -- Teletransportar
    for _, player in ipairs(playersInLobby) do
        teleportEvent:FireClient(player)
    end
    
    wait(3)
    
    -- Reset
    gameStarted = false
    playersInLobby = {}
    for _, circleData in ipairs(spawnCircles) do
        circleData.occupied = false
    end
    playerCircles = {}
end

-- ========================================
-- EVENTOS DE JUGADORES
-- ========================================
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(0.5)
        local success = spawnPlayerInCircle(player)
        
        if success and #playersInLobby >= MIN_PLAYERS and not gameStarted then
            task.delay(2, function()
                if not gameStarted then
                    startCountdown()
                end
            end)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    for i, p in ipairs(playersInLobby) do
        if p == player then
            table.remove(playersInLobby, i)
            break
        end
    end
    
    if playerCircles[player.UserId] then
        playerCircles[player.UserId].occupied = false
        playerCircles[player.UserId] = nil
    end
end)

-- ========================================
-- INICIALIZAR
-- ========================================
print("🎮 Iniciando lobby de supervivencia...")
createSurvivalDock()
createFloorCircles()
createSurvivalProps()
print("✅ Lobby listo!")
