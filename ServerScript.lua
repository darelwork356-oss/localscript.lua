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
    print("🏗️ Construyendo muelle elevado sobre el océano...")
    
    -- Plataforma principal ELEVADA
    local mainDock = Instance.new("Part")
    mainDock.Name = "MainDock"
    mainDock.Size = Vector3.new(50, 1.2, 70)
    mainDock.Position = Vector3.new(0, 20, 0)  -- ELEVADO
    mainDock.Anchored = true
    mainDock.Material = Enum.Material.Wood
    mainDock.Color = Color3.fromRGB(90, 65, 45)
    mainDock.Parent = lobbyFolder
    
    -- Tablas individuales desgastadas
    for z = -33, 33, 3.5 do
        for x = -23, 23, 46 do
            local plank = Instance.new("Part")
            plank.Size = Vector3.new(48, 0.4, 3)
            plank.Position = Vector3.new(0, 20.8, z)  -- ELEVADO
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
    
    -- Pilares LARGOS que llegan al océano
    for x = -20, 20, 10 do
        for z = -30, 30, 15 do
            local pillar = Instance.new("Part")
            pillar.Size = Vector3.new(1.8, 40, 1.8)  -- MÁS LARGOS
            pillar.Position = Vector3.new(x, 0, z)  -- Desde el océano hasta el muelle
            pillar.Anchored = true
            pillar.Material = Enum.Material.Wood
            pillar.Color = Color3.fromRGB(70, 50, 35)
            pillar.Parent = mainDock
            
            -- Algas en la parte sumergida
            for i = 1, 3 do
                local moss = Instance.new("Part")
                moss.Size = Vector3.new(2.2, 2, 2.2)
                moss.Position = pillar.Position + Vector3.new(0, -15 + (i * 3), 0)
                moss.Anchored = true
                moss.Material = Enum.Material.Grass
                moss.Color = Color3.fromRGB(40, 60, 35)
                moss.Parent = pillar
            end
            
            -- Cuerdas y refuerzos
            local rope = Instance.new("Part")
            rope.Size = Vector3.new(0.25, 35, 0.25)
            rope.Position = pillar.Position + Vector3.new(0.9, 0, 0)
            rope.Anchored = true
            rope.Material = Enum.Material.Fabric
            rope.Color = Color3.fromRGB(100, 80, 50)
            rope.Parent = pillar
        end
    end
    
    -- PAREDES INVISIBLES para evitar caídas
    local wallLeft = Instance.new("Part")
    wallLeft.Name = "InvisibleWall"
    wallLeft.Size = Vector3.new(1, 10, 70)
    wallLeft.Position = Vector3.new(-25, 25, 0)
    wallLeft.Anchored = true
    wallLeft.Transparency = 1
    wallLeft.CanCollide = true
    wallLeft.Parent = mainDock
    
    local wallRight = Instance.new("Part")
    wallRight.Name = "InvisibleWall"
    wallRight.Size = Vector3.new(1, 10, 70)
    wallRight.Position = Vector3.new(25, 25, 0)
    wallRight.Anchored = true
    wallRight.Transparency = 1
    wallRight.CanCollide = true
    wallRight.Parent = mainDock
    
    local wallFront = Instance.new("Part")
    wallFront.Name = "InvisibleWall"
    wallFront.Size = Vector3.new(50, 10, 1)
    wallFront.Position = Vector3.new(0, 25, 35)
    wallFront.Anchored = true
    wallFront.Transparency = 1
    wallFront.CanCollide = true
    wallFront.Parent = mainDock
    
    local wallBack = Instance.new("Part")
    wallBack.Name = "InvisibleWall"
    wallBack.Size = Vector3.new(50, 10, 1)
    wallBack.Position = Vector3.new(0, 25, -35)
    wallBack.Anchored = true
    wallBack.Transparency = 1
    wallBack.CanCollide = true
    wallBack.Parent = mainDock
    
    -- Barandas decorativas (visibles pero no funcionales)
    for z = -32, 32, 4 do
        if math.random(1, 3) ~= 1 then
            local railLeft = Instance.new("Part")
            railLeft.Size = Vector3.new(0.4, 2.5, 3.5)
            railLeft.Position = Vector3.new(-24, 22, z)
            railLeft.Anchored = true
            railLeft.CanCollide = false
            railLeft.Material = Enum.Material.Wood
            railLeft.Color = Color3.fromRGB(80, 60, 45)
            railLeft.Orientation = Vector3.new(0, 0, math.random(-5, 5))
            railLeft.Parent = mainDock
        end
        
        if math.random(1, 3) ~= 1 then
            local railRight = Instance.new("Part")
            railRight.Size = Vector3.new(0.4, 2.5, 3.5)
            railRight.Position = Vector3.new(24, 22, z)
            railRight.Anchored = true
            railRight.CanCollide = false
            railRight.Material = Enum.Material.Wood
            railRight.Color = Color3.fromRGB(80, 60, 45)
            railRight.Orientation = Vector3.new(0, 0, math.random(-5, 5))
            railRight.Parent = mainDock
        end
    end
    
    -- Cajas de suministros ELEVADAS
    local boxPositions = {
        Vector3.new(-20, 21.5, 25),
        Vector3.new(-18, 21.5, 28),
        Vector3.new(18, 21.5, 25),
        Vector3.new(20, 21.5, 28),
        Vector3.new(-20, 21.5, -28),
        Vector3.new(20, 21.5, -28)
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
    
    -- Linternas colgantes ELEVADAS
    for z = -25, 25, 25 do
        for x = -15, 15, 30 do
            local lanternPost = Instance.new("Part")
            lanternPost.Size = Vector3.new(0.3, 4, 0.3)
            lanternPost.Position = Vector3.new(x, 23.5, z)
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
    
    -- OCÉANO ABAJO del muelle
    local ocean = Instance.new("Part")
    ocean.Name = "Ocean"
    ocean.Size = Vector3.new(500, 1, 500)
    ocean.Position = Vector3.new(0, -20, 0)  -- MUY ABAJO
    ocean.Anchored = true
    ocean.Material = Enum.Material.Water
    ocean.Color = Color3.fromRGB(20, 40, 55)
    ocean.Transparency = 0.3
    ocean.CanCollide = false
    ocean.Parent = lobbyFolder
    
    -- Olas y movimiento del agua
    local waterParticles = Instance.new("ParticleEmitter")
    waterParticles.Texture = "rbxasset://textures/particles/smoke_main.dds"
    waterParticles.Rate = 5
    waterParticles.Lifetime = NumberRange.new(3, 5)
    waterParticles.Speed = NumberRange.new(1, 2)
    waterParticles.SpreadAngle = Vector2.new(180, 0)
    waterParticles.Size = NumberSequence.new(8, 12)
    waterParticles.Transparency = NumberSequence.new(0.7, 1)
    waterParticles.Color = ColorSequence.new(Color3.fromRGB(30, 50, 65))
    waterParticles.Parent = ocean
    
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
-- CREAR 5 CUADROS DE ESPERA EN EL PISO
-- ========================================
local spawnCircles = {}
local function createFloorCircles()
    print("✨ Creando cuadros de espera en el piso...")
    
    local positions = {
        Vector3.new(-18, 20.7, -10),
        Vector3.new(-9, 20.7, -10),
        Vector3.new(0, 20.7, -10),
        Vector3.new(9, 20.7, -10),
        Vector3.new(18, 20.7, -10)
    }
    
    for i, pos in ipairs(positions) do
        -- CUADRO GRANDE EN EL PISO (8x8 studs)
        local waitingPad = Instance.new("Part")
        waitingPad.Name = "WaitingPad" .. i
        waitingPad.Size = Vector3.new(8, 0.5, 8)  -- GRANDE
        waitingPad.Position = pos
        waitingPad.Anchored = true
        waitingPad.Material = Enum.Material.SmoothPlastic
        waitingPad.Color = Color3.fromRGB(40, 40, 45)
        waitingPad.Parent = lobbyFolder
        
        -- Borde brillante del cuadro
        local border = Instance.new("Part")
        border.Size = Vector3.new(8.3, 0.3, 8.3)
        border.Position = pos + Vector3.new(0, -0.15, 0)
        border.Anchored = true
        border.Material = Enum.Material.Neon
        border.Color = Color3.fromRGB(50, 255, 150)
        border.Transparency = 0.3
        border.Parent = waitingPad
        
        -- Líneas decorativas en el cuadro
        for x = -3, 3, 3 do
            local line = Instance.new("Part")
            line.Size = Vector3.new(0.2, 0.6, 7.5)
            line.Position = pos + Vector3.new(x, 0.3, 0)
            line.Anchored = true
            line.Material = Enum.Material.Neon
            line.Color = Color3.fromRGB(50, 255, 150)
            line.Transparency = 0.5
            line.Parent = waitingPad
        end
        
        for z = -3, 3, 3 do
            local line = Instance.new("Part")
            line.Size = Vector3.new(7.5, 0.6, 0.2)
            line.Position = pos + Vector3.new(0, 0.3, z)
            line.Anchored = true
            line.Material = Enum.Material.Neon
            line.Color = Color3.fromRGB(50, 255, 150)
            line.Transparency = 0.5
            line.Parent = waitingPad
        end
        
        -- Número grande en el cuadro
        local numberPart = Instance.new("Part")
        numberPart.Size = Vector3.new(7, 0.1, 7)
        numberPart.Position = pos + Vector3.new(0, 0.3, 0)
        numberPart.Anchored = true
        numberPart.Transparency = 1
        numberPart.CanCollide = false
        numberPart.Parent = waitingPad
        
        local surfaceGui = Instance.new("SurfaceGui")
        surfaceGui.Face = Enum.NormalId.Top
        surfaceGui.Parent = numberPart
        
        local numberLabel = Instance.new("TextLabel")
        numberLabel.Size = UDim2.fromScale(1, 1)
        numberLabel.BackgroundTransparency = 1
        numberLabel.Text = tostring(i)
        numberLabel.Font = Enum.Font.GothamBlack
        numberLabel.TextSize = 200
        numberLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        numberLabel.TextStrokeTransparency = 0
        numberLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        numberLabel.TextTransparency = 0.3
        numberLabel.Parent = surfaceGui
        
        -- Partículas alrededor del cuadro
        local particleAttachment = Instance.new("Attachment")
        particleAttachment.Position = Vector3.new(0, 0.5, 0)
        particleAttachment.Parent = waitingPad
        
        local particles = Instance.new("ParticleEmitter")
        particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particles.Rate = 20
        particles.Lifetime = NumberRange.new(2, 3)
        particles.Speed = NumberRange.new(2, 4)
        particles.SpreadAngle = Vector2.new(180, 10)
        particles.Size = NumberSequence.new(0.5, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.Color = ColorSequence.new(Color3.fromRGB(50, 255, 150))
        particles.LightEmission = 1
        particles.EmissionDirection = Enum.NormalDirection.Top
        particles.Parent = particleAttachment
        
        -- Luz del cuadro
        local light = Instance.new("PointLight")
        light.Brightness = 2.5
        light.Range = 15
        light.Color = Color3.fromRGB(50, 255, 150)
        light.Shadows = false
        light.Parent = waitingPad
        
        table.insert(spawnCircles, {
            circle = waitingPad,
            position = pos + Vector3.new(0, 3, 0),
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
    
    -- Bolsas de arena apiladas ELEVADAS
    local sandbagGroups = {
        {base = Vector3.new(-22, 21, 18), count = 6},
        {base = Vector3.new(22, 21, 18), count = 6},
        {base = Vector3.new(-22, 21, -30), count = 4},
        {base = Vector3.new(22, 21, -30), count = 4}
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
    
    -- Barriles oxidados ELEVADOS
    for i = 1, 8 do
        local barrel = Instance.new("Part")
        barrel.Size = Vector3.new(2, 3, 2)
        barrel.Position = Vector3.new(
            math.random(-23, 23),
            22,
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
