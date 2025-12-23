--[[
🧜♀️ MAKO MERMAIDS - SUPERVIVENCIA RÚSTICA
Colocar en: ServerScriptService
]]

print("🌊 Iniciando Mako Mermaids - Supervivencia...")

local terrain = workspace.Terrain
terrain:Clear()

terrain:FillRegion(
    Region3.new(Vector3.new(-2000, 0, -2000), Vector3.new(2000, 50, 2000)):ExpandToGrid(4),
    4,
    Enum.Material.Water
)

terrain:FillRegion(
    Region3.new(Vector3.new(-2000, -20, -2000), Vector3.new(2000, 0, 2000)):ExpandToGrid(4),
    4,
    Enum.Material.Sand
)

print("✅ Océano creado")

-- ========================================
-- BOTE RÚSTICO DE PALOS
-- ========================================
print("🪵 Construyendo bote rústico...")

local raftFolder = Instance.new("Model")
raftFolder.Name = "Raft"
raftFolder.Parent = workspace

-- Troncos base (15 troncos)
for i = 1, 15 do
    local log = Instance.new("Part")
    log.Size = Vector3.new(2, 2, 25)
    log.Position = Vector3.new(-14 + i*2, 51, 0)
    log.Anchored = true
    log.Material = Enum.Material.Wood
    log.Color = Color3.fromRGB(101, 67, 33)
    log.Shape = Enum.PartType.Cylinder
    log.Orientation = Vector3.new(0, 0, 90)
    log.Parent = raftFolder
end

-- Palos cruzados (10 palos)
for i = 1, 10 do
    local stick = Instance.new("Part")
    stick.Size = Vector3.new(1, 1, 30)
    stick.Position = Vector3.new(0, 52.5, -12 + i*2.5)
    stick.Anchored = true
    stick.Material = Enum.Material.Wood
    stick.Color = Color3.fromRGB(120, 80, 40)
    stick.Parent = raftFolder
end

-- Bordes de palos
for i = 1, 4 do
    local border = Instance.new("Part")
    if i <= 2 then
        border.Size = Vector3.new(1, 2, 26)
        border.Position = Vector3.new(i == 1 and -15 or 15, 53, 0)
    else
        border.Size = Vector3.new(30, 2, 1)
        border.Position = Vector3.new(0, 53, i == 3 and -13 or 13)
    end
    border.Anchored = true
    border.Material = Enum.Material.Wood
    border.Color = Color3.fromRGB(90, 60, 30)
    border.Parent = raftFolder
end

local spawn = Instance.new("SpawnLocation")
spawn.Size = Vector3.new(8, 1, 8)
spawn.Position = Vector3.new(-8, 53, 0)
spawn.Anchored = true
spawn.Transparency = 0.5
spawn.CanCollide = false
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.Parent = raftFolder

print("✅ Bote rústico creado")

-- ========================================
-- FOGATA CON FUEGO ANIMADO
-- ========================================
print("🔥 Creando fogata...")

local campfireModel = Instance.new("Model")
campfireModel.Name = "Campfire"
campfireModel.Parent = raftFolder

-- Base de piedras
for i = 1, 8 do
    local angle = math.rad(i * 45)
    local stone = Instance.new("Part")
    stone.Size = Vector3.new(2, 1, 2)
    stone.Position = Vector3.new(math.cos(angle)*3, 53, math.sin(angle)*3)
    stone.Anchored = true
    stone.Material = Enum.Material.Rock
    stone.Color = Color3.fromRGB(80, 80, 80)
    stone.Parent = campfireModel
end

-- Leños
for i = 1, 4 do
    local angle = math.rad(i * 90)
    local wood = Instance.new("Part")
    wood.Size = Vector3.new(0.8, 0.8, 4)
    wood.Position = Vector3.new(math.cos(angle)*1.5, 54, math.sin(angle)*1.5)
    wood.Anchored = true
    wood.Material = Enum.Material.Wood
    wood.Color = Color3.fromRGB(60, 40, 20)
    wood.Orientation = Vector3.new(0, math.deg(angle), 30)
    wood.Parent = campfireModel
end

-- Fuego animado
local fire = Instance.new("Part")
fire.Name = "Fire"
fire.Size = Vector3.new(3, 5, 3)
fire.Position = Vector3.new(0, 55.5, 0)
fire.Anchored = true
fire.CanCollide = false
fire.Material = Enum.Material.Neon
fire.Color = Color3.fromRGB(255, 100, 0)
fire.Transparency = 0.3
fire.Parent = campfireModel

local fireMesh = Instance.new("SpecialMesh")
fireMesh.MeshType = Enum.MeshType.Sphere
fireMesh.Scale = Vector3.new(1, 1.5, 1)
fireMesh.Parent = fire

local fireLight = Instance.new("PointLight")
fireLight.Color = Color3.fromRGB(255, 150, 0)
fireLight.Brightness = 5
fireLight.Range = 50
fireLight.Parent = fire

-- Animación del fuego
task.spawn(function()
    while fire.Parent do
        fire.Size = Vector3.new(3 + math.random(-5, 5)/10, 5 + math.random(-5, 5)/10, 3 + math.random(-5, 5)/10)
        fire.Color = Color3.fromRGB(255, math.random(80, 150), 0)
        fireLight.Brightness = 4 + math.random(0, 20)/10
        task.wait(0.1)
    end
end)

print("✅ Fogata creada")

-- ========================================
-- MOLINILLO DE MADERA
-- ========================================
print("⚙️ Creando molinillo...")

local grinderModel = Instance.new("Model")
grinderModel.Name = "WoodGrinder"
grinderModel.Parent = raftFolder

local grinderBase = Instance.new("Part")
grinderBase.Size = Vector3.new(4, 3, 4)
grinderBase.Position = Vector3.new(8, 54, -8)
grinderBase.Anchored = true
grinderBase.Material = Enum.Material.Wood
grinderBase.Color = Color3.fromRGB(100, 70, 40)
grinderBase.Parent = grinderModel

local grinder = Instance.new("Part")
grinder.Size = Vector3.new(3, 1, 3)
grinder.Position = grinderBase.Position + Vector3.new(0, 2, 0)
grinder.Anchored = true
grinder.Material = Enum.Material.Metal
grinder.Color = Color3.fromRGB(120, 120, 120)
grinder.Shape = Enum.PartType.Cylinder
grinder.Parent = grinderModel

local grinderPrompt = Instance.new("ProximityPrompt")
grinderPrompt.ActionText = "Moler Madera"
grinderPrompt.ObjectText = "⚙️ Molinillo (5 Maderas)"
grinderPrompt.HoldDuration = 2
grinderPrompt.MaxActivationDistance = 10
grinderPrompt.Parent = grinderBase

print("✅ Molinillo creado")

-- ========================================
-- MADERAS FLOTANTES (200)
-- ========================================
print("🪵 Creando maderas flotantes...")

local woodFolder = Instance.new("Folder")
woodFolder.Name = "FloatingWood"
woodFolder.Parent = workspace

for i = 1, 200 do
    local woodLog = Instance.new("Part")
    woodLog.Name = "WoodLog"
    woodLog.Size = Vector3.new(2, 2, 6)
    woodLog.Position = Vector3.new(math.random(-1500, 1500), 49, math.random(-1500, 1500))
    woodLog.Anchored = true
    woodLog.Material = Enum.Material.Wood
    woodLog.Color = Color3.fromRGB(120, 80, 50)
    woodLog.Shape = Enum.PartType.Cylinder
    woodLog.Orientation = Vector3.new(0, math.random(0, 360), 0)
    woodLog.Parent = woodFolder
    
    local woodHighlight = Instance.new("Highlight")
    woodHighlight.FillColor = Color3.fromRGB(150, 100, 50)
    woodHighlight.OutlineColor = Color3.fromRGB(255, 200, 100)
    woodHighlight.FillTransparency = 0.5
    woodHighlight.Parent = woodLog
    
    local woodPrompt = Instance.new("ProximityPrompt")
    woodPrompt.ActionText = "Recoger Madera"
    woodPrompt.ObjectText = "🪵 Madera"
    woodPrompt.HoldDuration = 0.5
    woodPrompt.MaxActivationDistance = 12
    woodPrompt.Parent = woodLog
end

print("✅ 200 maderas flotantes creadas")

-- ========================================
-- ALGAS (500)
-- ========================================
print("🌿 Creando algas...")

local algaeFolder = Instance.new("Folder")
algaeFolder.Name = "Algae"
algaeFolder.Parent = workspace

for i = 1, 500 do
    local x = math.random(-1800, 1800)
    local z = math.random(-1800, 1800)
    
    if math.sqrt(x*x + z*z) > 60 then
        local algaeModel = Instance.new("Model")
        algaeModel.Name = "Algae"
        algaeModel.Parent = algaeFolder
        
        local baseColor = Color3.fromRGB(math.random(30, 60), math.random(130, 200), math.random(30, 60))
        
        local algaeBase = Instance.new("Part")
        algaeBase.Name = "AlgaeBase"
        algaeBase.Size = Vector3.new(3, 4, 3)
        algaeBase.Position = Vector3.new(x, 10, z)
        algaeBase.Anchored = true
        algaeBase.Material = Enum.Material.Neon
        algaeBase.Color = baseColor
        algaeBase.Transparency = 0.2
        algaeBase.Shape = Enum.PartType.Ball
        algaeBase.Parent = algaeModel
        
        local algaePrompt = Instance.new("ProximityPrompt")
        algaePrompt.ActionText = "Arrancar Alga"
        algaePrompt.ObjectText = "🌿 Alga"
        algaePrompt.HoldDuration = 0.8
        algaePrompt.MaxActivationDistance = 15
        algaePrompt.Parent = algaeBase
    end
end

print("✅ 500 algas creadas")

-- ========================================
-- SISTEMA DE RECURSOS
-- ========================================
print("📦 Sistema de recursos...")

local Players = game:GetService("Players")

local function giveResource(player, resourceType, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
    end
    
    local resource = leaderstats:FindFirstChild(resourceType)
    if not resource then
        resource = Instance.new("IntValue")
        resource.Name = resourceType
        resource.Value = 0
        resource.Parent = leaderstats
    end
    
    resource.Value = resource.Value + amount
end

-- Recolectar maderas
for _, wood in pairs(woodFolder:GetChildren()) do
    local prompt = wood:FindFirstChild("ProximityPrompt")
    if prompt then
        prompt.Triggered:Connect(function(player)
            giveResource(player, "Madera", 1)
            wood:Destroy()
        end)
    end
end

-- Recolectar algas
for _, algae in pairs(algaeFolder:GetChildren()) do
    local algaeBase = algae:FindFirstChild("AlgaeBase")
    if algaeBase then
        local prompt = algaeBase:FindFirstChild("ProximityPrompt")
        if prompt then
            prompt.Triggered:Connect(function(player)
                giveResource(player, "Algas", 1)
                algae:Destroy()
            end)
        end
    end
end

-- Molinillo
grinderPrompt.Triggered:Connect(function(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    local madera = leaderstats and leaderstats:FindFirstChild("Madera")
    
    if madera and madera.Value >= 5 then
        madera.Value = madera.Value - 5
        giveResource(player, "MaderaMolida", 10)
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = 25
        
        local leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
        
        local madera = Instance.new("IntValue")
        madera.Name = "Madera"
        madera.Value = 0
        madera.Parent = leaderstats
        
        local algas = Instance.new("IntValue")
        algas.Name = "Algas"
        algas.Value = 0
        algas.Parent = leaderstats
        
        local maderaMolida = Instance.new("IntValue")
        maderaMolida.Name = "MaderaMolida"
        maderaMolida.Value = 0
        maderaMolida.Parent = leaderstats
    end)
end)

print("✅ Sistema configurado")

-- ========================================
-- SISTEMA DÍA/NOCHE
-- ========================================
print("🌞 Sistema día/noche...")

local Lighting = game:GetService("Lighting")
local isNight = false

-- Ciclo día/noche (5 min día, 3 min noche)
task.spawn(function()
    while true do
        -- DÍA
        isNight = false
        print("☀️ Es de DÍA - Seguro para explorar")
        
        for i = 6, 18, 0.1 do
            Lighting.ClockTime = i
            Lighting.Ambient = Color3.fromRGB(100, 150, 200)
            Lighting.OutdoorAmbient = Color3.fromRGB(120, 170, 220)
            Lighting.FogEnd = 1200
            task.wait(300 / 120)
        end
        
        -- NOCHE
        isNight = true
        print("🌙 Es de NOCHE - ¡PELIGRO! Vuelve al bote")
        
        for i = 18, 30, 0.1 do
            Lighting.ClockTime = i >= 24 and i - 24 or i
            Lighting.Ambient = Color3.fromRGB(20, 20, 40)
            Lighting.OutdoorAmbient = Color3.fromRGB(10, 10, 30)
            Lighting.FogEnd = 300
            task.wait(180 / 120)
        end
    end
end)

-- ========================================
-- TIBURONES NOCTURNOS
-- ========================================
print("🦈 Creando tiburones nocturnos...")

local sharksFolder = Instance.new("Folder")
sharksFolder.Name = "Sharks"
sharksFolder.Parent = workspace

for i = 1, 20 do
    local sharkModel = Instance.new("Model")
    sharkModel.Name = "Shark"
    sharkModel.Parent = sharksFolder
    
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(4, 3, 12)
    body.Position = Vector3.new(math.random(-1500, 1500), 25, math.random(-1500, 1500))
    body.Anchored = false
    body.Material = Enum.Material.SmoothPlastic
    body.Color = Color3.fromRGB(70, 80, 90)
    body.Parent = sharkModel
    
    local head = Instance.new("Part")
    head.Size = Vector3.new(3, 2.5, 4)
    head.Position = body.Position + Vector3.new(0, 0, -8)
    head.Material = Enum.Material.SmoothPlastic
    head.Color = Color3.fromRGB(60, 70, 80)
    head.Parent = sharkModel
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = body
    weld.Part1 = head
    weld.Parent = head
    
    local dorsalFin = Instance.new("Part")
    dorsalFin.Size = Vector3.new(0.5, 4, 2)
    dorsalFin.Position = body.Position + Vector3.new(0, 3, 0)
    dorsalFin.Material = Enum.Material.SmoothPlastic
    dorsalFin.Color = Color3.fromRGB(50, 60, 70)
    dorsalFin.Parent = sharkModel
    
    local weld2 = Instance.new("WeldConstraint")
    weld2.Part0 = body
    weld2.Part1 = dorsalFin
    weld2.Parent = dorsalFin
    
    for side = -1, 1, 2 do
        local eye = Instance.new("Part")
        eye.Size = Vector3.new(0.5, 0.5, 0.5)
        eye.Position = head.Position + Vector3.new(side, 0.5, -1.5)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 0, 0)
        eye.Shape = Enum.PartType.Ball
        eye.Parent = sharkModel
        
        local eyeWeld = Instance.new("WeldConstraint")
        eyeWeld.Part0 = head
        eyeWeld.Part1 = eye
        eyeWeld.Parent = eye
    end
    
    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyVel.Parent = body
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.Parent = body
    
    -- IA: Solo activos de noche
    task.spawn(function()
        local patrolTime = 0
        
        while body.Parent do
            patrolTime = patrolTime + 0.1
            
            if isNight then
                local closestPlayer = nil
                local closestDistance = 50
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local playerPos = player.Character.HumanoidRootPart.Position
                        local raftDist = (playerPos - Vector3.new(0, 51, 0)).Magnitude
                        
                        -- Solo atacar si está lejos del bote
                        if raftDist > 30 then
                            local distance = (playerPos - body.Position).Magnitude
                            if distance < closestDistance then
                                closestPlayer = player
                                closestDistance = distance
                            end
                        end
                    end
                end
                
                if closestPlayer and closestPlayer.Character then
                    local targetPos = closestPlayer.Character.HumanoidRootPart.Position
                    local direction = (targetPos - body.Position).Unit
                    bodyVel.Velocity = direction * 35
                    bodyGyro.CFrame = CFrame.lookAt(body.Position, targetPos)
                    
                    if closestDistance < 8 then
                        local humanoid = closestPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            humanoid:TakeDamage(25)
                        end
                    end
                else
                    local patrolDir = Vector3.new(math.sin(patrolTime * 0.5), 0, math.cos(patrolTime * 0.5))
                    bodyVel.Velocity = patrolDir * 20
                    bodyGyro.CFrame = CFrame.lookAt(body.Position, body.Position + patrolDir)
                end
            else
                bodyVel.Velocity = Vector3.new(0, 0, 0)
            end
            
            task.wait(0.1)
        end
    end)
end

print("✅ 20 tiburones nocturnos creados")

-- ========================================
-- TERREMOTOS NOCTURNOS
-- ========================================
print("💥 Sistema de terremotos...")

task.spawn(function()
    while true do
        task.wait(math.random(60, 120))
        
        if isNight then
            print("💥 ¡TERREMOTO!")
            
            for i = 1, 30 do
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(
                    math.rad(math.random(-2, 2)),
                    math.rad(math.random(-2, 2)),
                    math.rad(math.random(-2, 2))
                )
                task.wait(0.1)
            end
        end
    end
end)

print("✅ Sistema de terremotos configurado")

local atmos = Instance.new("Atmosphere")
atmos.Density = 0.3
atmos.Color = Color3.fromRGB(150, 200, 255)
atmos.Parent = Lighting

print("")
print("🎉 ═══════════════════════════════════════")
print("🧜♀️ MAKO MERMAIDS - SUPERVIVENCIA RÚSTICA")
print("═══════════════════════════════════════")
print("🪵 Bote rústico de palos")
print("🔥 Fogata animada en el bote")
print("⚙️ Molinillo de madera (5 maderas → 10 molidas)")
print("🪵 200 maderas flotantes")
print("🌿 500 algas")
print("🌞 Día: 5 min (seguro)")
print("🌙 Noche: 3 min (tiburones + terremotos)")
print("🦈 20 tiburones nocturnos")
print("═══════════════════════════════════════")
print("✨ ¡Sobrevive y vuelve al bote de noche!")
print("")
