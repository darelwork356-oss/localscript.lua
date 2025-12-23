--[[
🎮 LOBBY DE ESPERA - MUELLE VIEJO
Colocar en: ServerScriptService como Script
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuración
local MAX_PLAYERS = 5
local COUNTDOWN_TIME = 10
local MIN_PLAYERS = 1

-- Variables del juego
local playersInLobby = {}
local gameStarted = false

-- Crear carpeta para el lobby
local lobbyFolder = Instance.new("Folder")
lobbyFolder.Name = "Lobby"
lobbyFolder.Parent = workspace

-- ========================================
-- CREAR MUELLE VIEJO
-- ========================================
local function createDock()
    print("🏗️ Construyendo muelle viejo...")
    
    -- Plataforma principal del muelle
    local mainDock = Instance.new("Part")
    mainDock.Name = "MainDock"
    mainDock.Size = Vector3.new(40, 1, 60)
    mainDock.Position = Vector3.new(0, 0.5, 0)
    mainDock.Anchored = true
    mainDock.Material = Enum.Material.Wood
    mainDock.Color = Color3.fromRGB(120, 85, 60)
    mainDock.Parent = lobbyFolder
    
    -- Textura de madera vieja
    for _, face in pairs({Enum.NormalId.Top, Enum.NormalId.Bottom}) do
        local texture = Instance.new("Texture")
        texture.Texture = "rbxasset://textures/wood.png"
        texture.StudsPerTileU = 4
        texture.StudsPerTileV = 4
        texture.Face = face
        texture.Parent = mainDock
    end
    
    -- Tablas del muelle (efecto realista)
    for z = -28, 28, 4 do
        local plank = Instance.new("Part")
        plank.Size = Vector3.new(39, 0.3, 3.5)
        plank.Position = Vector3.new(0, 1.2, z)
        plank.Anchored = true
        plank.Material = Enum.Material.Wood
        plank.Color = Color3.fromRGB(100, 70, 50)
        plank.Parent = mainDock
    end
    
    -- Pilares de soporte
    for x = -15, 15, 15 do
        for z = -25, 25, 25 do
            local pillar = Instance.new("Part")
            pillar.Size = Vector3.new(1.5, 8, 1.5)
            pillar.Position = Vector3.new(x, -3.5, z)
            pillar.Anchored = true
            pillar.Material = Enum.Material.Wood
            pillar.Color = Color3.fromRGB(80, 60, 45)
            pillar.Parent = mainDock
            
            -- Musgo en los pilares
            local moss = Instance.new("Part")
            moss.Size = Vector3.new(1.6, 2, 1.6)
            moss.Position = pillar.Position + Vector3.new(0, -3, 0)
            moss.Anchored = true
            moss.Material = Enum.Material.Grass
            moss.Color = Color3.fromRGB(60, 80, 50)
            moss.Parent = pillar
        end
    end
    
    -- Barandas del muelle
    for z = -28, 28, 4 do
        -- Izquierda
        local railLeft = Instance.new("Part")
        railLeft.Size = Vector3.new(0.3, 2, 3)
        railLeft.Position = Vector3.new(-19.5, 2, z)
        railLeft.Anchored = true
        railLeft.Material = Enum.Material.Wood
        railLeft.Color = Color3.fromRGB(90, 65, 50)
        railLeft.Parent = mainDock
        
        -- Derecha
        local railRight = Instance.new("Part")
        railRight.Size = Vector3.new(0.3, 2, 3)
        railRight.Position = Vector3.new(19.5, 2, z)
        railRight.Anchored = true
        railRight.Material = Enum.Material.Wood
        railRight.Color = Color3.fromRGB(90, 65, 50)
        railRight.Parent = mainDock
    end
    
    -- Agua alrededor del muelle
    local water = Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(200, 1, 200)
    water.Position = Vector3.new(0, -8, 0)
    water.Anchored = true
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(50, 80, 100)
    water.Transparency = 0.3
    water.CanCollide = false
    water.Parent = lobbyFolder
    
    return mainDock
end

-- ========================================
-- CREAR CÍRCULOS BRILLANTES (5 ESPACIOS)
-- ========================================
local spawnCircles = {}
local function createSpawnCircles()
    print("✨ Creando círculos de spawn...")
    
    local positions = {
        Vector3.new(-12, 1.5, -10),
        Vector3.new(-6, 1.5, -10),
        Vector3.new(0, 1.5, -10),
        Vector3.new(6, 1.5, -10),
        Vector3.new(12, 1.5, -10)
    }
    
    for i, pos in ipairs(positions) do
        -- Círculo base
        local circle = Instance.new("Part")
        circle.Name = "SpawnCircle" .. i
        circle.Size = Vector3.new(4, 0.2, 4)
        circle.Position = pos
        circle.Anchored = true
        circle.Shape = Enum.PartType.Cylinder
        circle.Material = Enum.Material.Neon
        circle.Color = Color3.fromRGB(0, 255, 200)
        circle.Orientation = Vector3.new(0, 0, 90)
        circle.Transparency = 0.3
        circle.CanCollide = false
        circle.Parent = lobbyFolder
        
        -- Efecto de brillo pulsante
        local pulseAnim = TweenService:Create(
            circle,
            TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Transparency = 0.7}
        )
        pulseAnim:Play()
        
        -- Anillo exterior
        local ring = Instance.new("Part")
        ring.Size = Vector3.new(4.5, 0.15, 4.5)
        ring.Position = pos
        ring.Anchored = true
        ring.Shape = Enum.PartType.Cylinder
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(0, 200, 255)
        ring.Orientation = Vector3.new(0, 0, 90)
        ring.Transparency = 0.5
        ring.CanCollide = false
        ring.Parent = circle
        
        -- Partículas brillantes
        local particles = Instance.new("ParticleEmitter")
        particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particles.Rate = 20
        particles.Lifetime = NumberRange.new(1, 2)
        particles.Speed = NumberRange.new(2, 4)
        particles.SpreadAngle = Vector2.new(180, 180)
        particles.Size = NumberSequence.new(0.5, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 200))
        particles.LightEmission = 1
        particles.Parent = circle
        
        -- Luz
        local light = Instance.new("PointLight")
        light.Brightness = 2
        light.Range = 15
        light.Color = Color3.fromRGB(0, 255, 200)
        light.Parent = circle
        
        -- Número del espacio
        local numberPart = Instance.new("Part")
        numberPart.Size = Vector3.new(0.1, 0.1, 0.1)
        numberPart.Position = pos + Vector3.new(0, 3, 0)
        numberPart.Anchored = true
        numberPart.Transparency = 1
        numberPart.CanCollide = false
        numberPart.Parent = circle
        
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.fromScale(4, 4)
        billboard.AlwaysOnTop = true
        billboard.Parent = numberPart
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(1, 1)
        label.BackgroundTransparency = 1
        label.Text = tostring(i)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 60
        label.TextColor3 = Color3.fromRGB(0, 255, 200)
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Parent = billboard
        
        table.insert(spawnCircles, {circle = circle, occupied = false, position = pos})
    end
end

-- ========================================
-- CREAR BOLSAS DE ARENA DECORATIVAS
-- ========================================
local function createSandbags()
    print("🛡️ Colocando bolsas de arena...")
    
    local sandbagPositions = {
        {pos = Vector3.new(-18, 1.5, 15), rot = 0},
        {pos = Vector3.new(-15, 1.5, 15), rot = 30},
        {pos = Vector3.new(-16.5, 2.3, 15), rot = 15},
        {pos = Vector3.new(15, 1.5, 15), rot = 0},
        {pos = Vector3.new(18, 1.5, 15), rot = -30},
        {pos = Vector3.new(16.5, 2.3, 15), rot = -15},
        {pos = Vector3.new(-18, 1.5, -25), rot = 45},
        {pos = Vector3.new(-15, 1.5, -25), rot = 0},
        {pos = Vector3.new(15, 1.5, -25), rot = -45},
        {pos = Vector3.new(18, 1.5, -25), rot = 0}
    }
    
    for _, data in ipairs(sandbagPositions) do
        local sandbag = Instance.new("Part")
        sandbag.Name = "Sandbag"
        sandbag.Size = Vector3.new(2.5, 1.2, 1.5)
        sandbag.Position = data.pos
        sandbag.Anchored = true
        sandbag.Material = Enum.Material.Fabric
        sandbag.Color = Color3.fromRGB(140, 120, 90)
        sandbag.Orientation = Vector3.new(0, data.rot, 0)
        sandbag.Parent = lobbyFolder
        
        -- Textura de tela
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.Brick
        mesh.Scale = Vector3.new(1, 1, 1)
        mesh.Parent = sandbag
        
        -- Cuerda en la bolsa
        local rope = Instance.new("Part")
        rope.Size = Vector3.new(2.3, 0.1, 0.1)
        rope.Position = sandbag.Position + Vector3.new(0, 0.3, 0)
        rope.Anchored = true
        rope.Material = Enum.Material.Fabric
        rope.Color = Color3.fromRGB(80, 60, 40)
        rope.Parent = sandbag
    end
end

-- ========================================
-- CREAR 3 CUADROS INFORMATIVOS
-- ========================================
local infoBoards = {}
local function createInfoBoards()
    print("📋 Creando cuadros informativos...")
    
    local boardData = {
        {
            name = "PlayerCount",
            position = Vector3.new(-10, 5, 20),
            title = "JUGADORES",
            color = Color3.fromRGB(50, 150, 255)
        },
        {
            name = "Timer",
            position = Vector3.new(0, 5, 20),
            title = "TIEMPO",
            color = Color3.fromRGB(255, 200, 50)
        },
        {
            name = "Status",
            position = Vector3.new(10, 5, 20),
            title = "ESTADO",
            color = Color3.fromRGB(100, 255, 100)
        }
    }
    
    for _, data in ipairs(boardData) do
        -- Marco del cuadro
        local frame = Instance.new("Part")
        frame.Name = data.name .. "Frame"
        frame.Size = Vector3.new(6, 4, 0.3)
        frame.Position = data.position
        frame.Anchored = true
        frame.Material = Enum.Material.Wood
        frame.Color = Color3.fromRGB(60, 45, 35)
        frame.Parent = lobbyFolder
        
        -- Fondo del cuadro
        local board = Instance.new("Part")
        board.Name = data.name .. "Board"
        board.Size = Vector3.new(5.5, 3.5, 0.2)
        board.Position = data.position + Vector3.new(0, 0, -0.3)
        board.Anchored = true
        board.Material = Enum.Material.SmoothPlastic
        board.Color = Color3.fromRGB(30, 30, 35)
        board.Parent = frame
        
        -- Borde brillante
        local border = Instance.new("Part")
        border.Size = Vector3.new(5.7, 3.7, 0.15)
        border.Position = board.Position + Vector3.new(0, 0, -0.1)
        border.Anchored = true
        border.Material = Enum.Material.Neon
        border.Color = data.color
        border.Transparency = 0.3
        border.Parent = board
        
        -- SurfaceGui para el texto
        local surfaceGui = Instance.new("SurfaceGui")
        surfaceGui.Face = Enum.NormalId.Front
        surfaceGui.Parent = board
        
        -- Título
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.fromScale(1, 0.3)
        titleLabel.Position = UDim2.fromScale(0, 0.05)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = data.title
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 40
        titleLabel.TextColor3 = data.color
        titleLabel.TextStrokeTransparency = 0.5
        titleLabel.Parent = surfaceGui
        
        -- Contenido principal
        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.fromScale(1, 0.6)
        contentLabel.Position = UDim2.fromScale(0, 0.35)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = "..."
        contentLabel.Font = Enum.Font.GothamBold
        contentLabel.TextSize = 80
        contentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        contentLabel.TextStrokeTransparency = 0.5
        contentLabel.Parent = surfaceGui
        
        -- Luz del cuadro
        local light = Instance.new("PointLight")
        light.Brightness = 1.5
        light.Range = 12
        light.Color = data.color
        light.Parent = board
        
        infoBoards[data.name] = contentLabel
    end
end

-- ========================================
-- ACTUALIZAR CUADROS
-- ========================================
local function updateBoards(playerCount, timeLeft, status)
    if infoBoards.PlayerCount then
        infoBoards.PlayerCount.Text = playerCount .. "/" .. MAX_PLAYERS
    end
    if infoBoards.Timer then
        infoBoards.Timer.Text = timeLeft .. "s"
    end
    if infoBoards.Status then
        infoBoards.Status.Text = status
    end
end

-- ========================================
-- SISTEMA DE SPAWN DE JUGADORES
-- ========================================
local function getAvailableSpawn()
    for _, spawnData in ipairs(spawnCircles) do
        if not spawnData.occupied then
            return spawnData
        end
    end
    return nil
end

local function spawnPlayer(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local spawnData = getAvailableSpawn()
    if spawnData then
        spawnData.occupied = true
        humanoidRootPart.CFrame = CFrame.new(spawnData.position + Vector3.new(0, 3, 0))
        table.insert(playersInLobby, player)
        
        -- Efecto de spawn
        local spawnEffect = Instance.new("Part")
        spawnEffect.Size = Vector3.new(5, 8, 5)
        spawnEffect.Position = spawnData.position + Vector3.new(0, 4, 0)
        spawnEffect.Anchored = true
        spawnEffect.CanCollide = false
        spawnEffect.Material = Enum.Material.Neon
        spawnEffect.Color = Color3.fromRGB(0, 255, 200)
        spawnEffect.Transparency = 0.5
        spawnEffect.Parent = workspace
        
        TweenService:Create(spawnEffect, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(8, 12, 8)}):Play()
        game:GetService("Debris"):AddItem(spawnEffect, 1)
    end
end

-- ========================================
-- SISTEMA DE COUNTDOWN
-- ========================================
local function startCountdown()
    if gameStarted then return end
    gameStarted = true
    
    for i = COUNTDOWN_TIME, 0, -1 do
        local playerCount = #playersInLobby
        updateBoards(playerCount, i, "INICIANDO")
        wait(1)
    end
    
    -- Teletransportar jugadores (por ahora solo mensaje)
    updateBoards(#playersInLobby, 0, "¡VAMOS!")
    print("🎮 ¡Juego iniciado con " .. #playersInLobby .. " jugadores!")
    
    -- Aquí irá la lógica de teletransporte al juego
    for _, player in ipairs(playersInLobby) do
        if player.Character then
            print("📍 Teletransportando a " .. player.Name)
            -- TODO: Teletransportar al mapa del juego
        end
    end
    
    wait(3)
    gameStarted = false
    playersInLobby = {}
    for _, spawnData in ipairs(spawnCircles) do
        spawnData.occupied = false
    end
end

-- ========================================
-- EVENTOS DE JUGADORES
-- ========================================
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(0.5)
        spawnPlayer(player)
        
        local playerCount = #playersInLobby
        updateBoards(playerCount, COUNTDOWN_TIME, "ESPERANDO")
        
        if playerCount >= MIN_PLAYERS and not gameStarted then
            startCountdown()
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
    
    for _, spawnData in ipairs(spawnCircles) do
        if spawnData.occupied then
            spawnData.occupied = false
            break
        end
    end
    
    updateBoards(#playersInLobby, COUNTDOWN_TIME, "ESPERANDO")
end)

-- ========================================
-- INICIALIZAR LOBBY
-- ========================================
print("🎮 Iniciando lobby...")
createDock()
createSpawnCircles()
createSandbags()
createInfoBoards()
updateBoards(0, COUNTDOWN_TIME, "ESPERANDO")
print("✅ Lobby listo!")
