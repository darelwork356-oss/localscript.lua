--[[
🧜♀️ MAKO MERMAIDS - JUEGO DE SUPERVIVENCIA EN BALSA
Colocar en: ServerScriptService
]]

print("🌊 Iniciando Mako Mermaids - Supervivencia...")

local terrain = workspace.Terrain
terrain:Clear()

-- ========================================
-- OCÉANO INFINITO
-- ========================================
print("💧 Creando océano infinito...")

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

print("✅ Océano infinito creado")

-- ========================================
-- BALSA ÉPICA Y DETALLADA
-- ========================================
print("🛟 Construyendo balsa épica...")

local raftFolder = Instance.new("Model")
raftFolder.Name = "Raft"
raftFolder.Parent = workspace

local raftBase = Instance.new("Part")
raftBase.Name = "RaftBase"
raftBase.Size = Vector3.new(30, 3, 30)
raftBase.Position = Vector3.new(0, 51, 0)
raftBase.Anchored = true
raftBase.Material = Enum.Material.WoodPlanks
raftBase.Color = Color3.fromRGB(139, 90, 43)
raftBase.Parent = raftFolder

local baseMesh = Instance.new("BlockMesh")
baseMesh.Scale = Vector3.new(1, 0.3, 1)
baseMesh.Parent = raftBase

for i = 1, 6 do
    for j = 1, 2 do
        local log = Instance.new("Part")
        log.Size = Vector3.new(3, 3, 28)
        log.Position = raftBase.Position + Vector3.new(-15 + i*5, -2, -14 + j*28)
        log.Anchored = true
        log.Material = Enum.Material.Wood
        log.Color = Color3.fromRGB(101, 67, 33)
        log.Shape = Enum.PartType.Cylinder
        log.Orientation = Vector3.new(0, 0, 90)
        log.Parent = raftFolder
        
        local mesh = Instance.new("CylinderMesh")
        mesh.Scale = Vector3.new(1.2, 1, 1.2)
        mesh.Parent = log
    end
end

for i = 1, 12 do
    local plank = Instance.new("Part")
    plank.Size = Vector3.new(30, 0.5, 2.3)
    plank.Position = raftBase.Position + Vector3.new(0, 2, -13.5 + i*2.3)
    plank.Anchored = true
    plank.Material = Enum.Material.WoodPlanks
    plank.Color = Color3.fromRGB(160, 120, 80)
    plank.Parent = raftFolder
    
    local plankMesh = Instance.new("BlockMesh")
    plankMesh.Scale = Vector3.new(1, 1, 0.95)
    plankMesh.Parent = plank
end

for i = 1, 4 do
    local side = Instance.new("Part")
    if i <= 2 then
        side.Size = Vector3.new(32, 2, 1)
        side.Position = raftBase.Position + Vector3.new(0, 3, i == 1 and -15.5 or 15.5)
    else
        side.Size = Vector3.new(1, 2, 30)
        side.Position = raftBase.Position + Vector3.new(i == 3 and -15.5 or 15.5, 3, 0)
    end
    side.Anchored = true
    side.Material = Enum.Material.Wood
    side.Color = Color3.fromRGB(120, 80, 50)
    side.Parent = raftFolder
end

local mast = Instance.new("Part")
mast.Name = "Mast"
mast.Size = Vector3.new(2, 25, 2)
mast.Position = raftBase.Position + Vector3.new(0, 14.5, -5)
mast.Anchored = true
mast.Material = Enum.Material.Wood
mast.Color = Color3.fromRGB(90, 60, 30)
mast.Parent = raftFolder

local mastMesh = Instance.new("CylinderMesh")
mastMesh.Parent = mast

local sail = Instance.new("Part")
sail.Name = "Sail"
sail.Size = Vector3.new(0.3, 18, 15)
sail.Position = mast.Position + Vector3.new(0, 0, 8)
sail.Anchored = true
sail.Material = Enum.Material.Fabric
sail.Color = Color3.fromRGB(240, 240, 250)
sail.Parent = raftFolder

local seatBase = Instance.new("Part")
seatBase.Size = Vector3.new(6, 1, 6)
seatBase.Position = raftBase.Position + Vector3.new(0, 3, 8)
seatBase.Anchored = true
seatBase.Material = Enum.Material.Wood
seatBase.Color = Color3.fromRGB(139, 90, 43)
seatBase.Parent = raftFolder

local seat = Instance.new("Seat")
seat.Name = "DriverSeat"
seat.Size = Vector3.new(5, 1, 5)
seat.Position = seatBase.Position + Vector3.new(0, 1, 0)
seat.Anchored = true
seat.Material = Enum.Material.Wood
seat.Color = Color3.fromRGB(160, 110, 60)
seat.Parent = raftFolder

local backrest = Instance.new("Part")
backrest.Size = Vector3.new(5, 4, 1)
backrest.Position = seat.Position + Vector3.new(0, 2.5, -2.5)
backrest.Anchored = true
backrest.Material = Enum.Material.Wood
backrest.Color = Color3.fromRGB(160, 110, 60)
backrest.Parent = raftFolder

for i = 1, 3 do
    local crate = Instance.new("Part")
    crate.Size = Vector3.new(4, 3, 4)
    crate.Position = raftBase.Position + Vector3.new(-10 + i*5, 3.5, -10)
    crate.Anchored = true
    crate.Material = Enum.Material.Wood
    crate.Color = Color3.fromRGB(120, 80, 40)
    crate.Parent = raftFolder
end

local spawn = Instance.new("SpawnLocation")
spawn.Size = Vector3.new(8, 1, 8)
spawn.Position = raftBase.Position + Vector3.new(-8, 3.5, 0)
spawn.Anchored = true
spawn.Material = Enum.Material.Wood
spawn.Color = Color3.fromRGB(160, 120, 80)
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.TopSurface = Enum.SurfaceType.Smooth
spawn.Transparency = 0.3
spawn.Parent = raftFolder

print("✅ Balsa épica creada en Y=51")

-- ========================================
-- ALGAS RECOLECTABLES
-- ========================================
print("🌿 Creando algas recolectables...")

local algaeFolder = Instance.new("Folder")
algaeFolder.Name = "Algae"
algaeFolder.Parent = workspace

for i = 1, 1000 do
    local algaeModel = Instance.new("Model")
    algaeModel.Name = "Algae"
    algaeModel.Parent = algaeFolder
    
    local x = math.random(-1800, 1800)
    local z = math.random(-1800, 1800)
    local distance = math.sqrt(x*x + z*z)
    
    if distance > 60 then
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
        
        local highlight = Instance.new("Highlight")
        highlight.FillColor = baseColor
        highlight.OutlineColor = Color3.fromRGB(255, 255, 100)
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = algaeBase
        
        local prompt = Instance.new("ProximityPrompt")
        prompt.ActionText = "Arrancar Alga"
        prompt.ObjectText = "🌿 Alga Marina"
        prompt.HoldDuration = 0.8
        prompt.MaxActivationDistance = 15
        prompt.RequiresLineOfSight = false
        prompt.Parent = algaeBase
        
        for seg = 1, 8 do
            local segment = Instance.new("Part")
            segment.Size = Vector3.new(1.5, 4, 0.5)
            segment.Position = Vector3.new(
                x + math.sin(seg * 0.6) * (seg * 0.5),
                10 + seg * 4,
                z + math.cos(seg * 0.6) * (seg * 0.5)
            )
            segment.Anchored = true
            segment.CanCollide = false
            segment.Material = Enum.Material.Neon
            segment.Color = baseColor
            segment.Transparency = 0.3
            segment.Parent = algaeModel
            
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = "rbxassetid://1290033"
            mesh.Scale = Vector3.new(2, 4, 1.5)
            mesh.Parent = segment
        end
        
        task.spawn(function()
            local time = math.random(0, 100)
            while algaeModel.Parent do
                time = time + 0.04
                for _, part in pairs(algaeModel:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "AlgaeBase" then
                        part.CFrame = part.CFrame * CFrame.Angles(math.sin(time) * 0.08, 0, math.cos(time) * 0.08)
                    end
                end
                task.wait(0.04)
            end
        end)
    end
end

print("✅ 1000 algas recolectables creadas")

-- ========================================
-- SISTEMA DE RECOLECCIÓN
-- ========================================
print("📦 Configurando sistema...")

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

for _, algae in pairs(algaeFolder:GetChildren()) do
    local algaeBase = algae:FindFirstChild("AlgaeBase")
    if algaeBase then
        local prompt = algaeBase:FindFirstChild("ProximityPrompt")
        if prompt then
            prompt.Triggered:Connect(function(player)
                giveResource(player, "Algas", 1)
                giveResource(player, "Madera", math.random(1, 3))
                
                local explosion = Instance.new("Part")
                explosion.Size = Vector3.new(2, 2, 2)
                explosion.Position = algaeBase.Position
                explosion.Anchored = true
                explosion.CanCollide = false
                explosion.Material = Enum.Material.Neon
                explosion.Color = algaeBase.Color
                explosion.Shape = Enum.PartType.Ball
                explosion.Transparency = 0
                explosion.Parent = workspace
                
                task.spawn(function()
                    for i = 1, 15 do
                        explosion.Size = explosion.Size + Vector3.new(1, 1, 1)
                        explosion.Transparency = i / 15
                        task.wait(0.03)
                    end
                    explosion:Destroy()
                end)
                
                algae:Destroy()
            end)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = 25
        
        local leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
        
        local algas = Instance.new("IntValue")
        algas.Name = "Algas"
        algas.Value = 0
        algas.Parent = leaderstats
        
        local madera = Instance.new("IntValue")
        madera.Name = "Madera"
        madera.Value = 0
        madera.Parent = leaderstats
        
        local velocidad = Instance.new("IntValue")
        velocidad.Name = "Velocidad"
        velocidad.Value = 25
        velocidad.Parent = leaderstats
        
        algas.Changed:Connect(function(value)
            velocidad.Value = 25 + math.floor(value / 10) * 10
            humanoid.WalkSpeed = velocidad.Value
        end)
    end)
end)

print("✅ Sistema configurado")

-- ========================================
-- DECORACIÓN OCEÁNICA MODERNA
-- ========================================
print("🏗️ Agregando decoración moderna...")

local decorFolder = Instance.new("Folder")
decorFolder.Name = "OceanDecor"
decorFolder.Parent = workspace

for i = 1, 50 do
    local buoy = Instance.new("Part")
    buoy.Size = Vector3.new(3, 5, 3)
    buoy.Position = Vector3.new(math.random(-1500, 1500), 48, math.random(-1500, 1500))
    buoy.Anchored = true
    buoy.Material = Enum.Material.SmoothPlastic
    buoy.Color = Color3.fromRGB(255, 100, 50)
    buoy.Shape = Enum.PartType.Ball
    buoy.Parent = decorFolder
    
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 150, 50)
    light.Brightness = 3
    light.Range = 40
    light.Parent = buoy
end

for i = 1, 20 do
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(15, 2, 15)
    platform.Position = Vector3.new(math.random(-1500, 1500), 50, math.random(-1500, 1500))
    platform.Anchored = true
    platform.Material = Enum.Material.Metal
    platform.Color = Color3.fromRGB(150, 150, 150)
    platform.Parent = decorFolder
end

for i = 1, 15 do
    local wreck = Instance.new("Part")
    wreck.Size = Vector3.new(20, 10, 30)
    wreck.Position = Vector3.new(math.random(-1500, 1500), -5, math.random(-1500, 1500))
    wreck.Anchored = true
    wreck.Material = Enum.Material.CorrodedMetal
    wreck.Color = Color3.fromRGB(100, 80, 60)
    wreck.Orientation = Vector3.new(math.random(-30, 30), math.random(0, 360), math.random(-30, 30))
    wreck.Parent = decorFolder
end

print("✅ Decoración moderna agregada")

-- ========================================
-- TIBURONES PELIGROSOS
-- ========================================
print("🦈 Creando tiburones...")

local sharksFolder = Instance.new("Folder")
sharksFolder.Name = "Sharks"
sharksFolder.Parent = workspace

for i = 1, 30 do
    local sharkModel = Instance.new("Model")
    sharkModel.Name = "Shark"
    sharkModel.Parent = sharksFolder
    
    local x = math.random(-1500, 1500)
    local z = math.random(-1500, 1500)
    
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(4, 3, 12)
    body.Position = Vector3.new(x, 25, z)
    body.Anchored = false
    body.Material = Enum.Material.SmoothPlastic
    body.Color = Color3.fromRGB(70, 80, 90)
    body.Parent = sharkModel
    
    local bodyMesh = Instance.new("SpecialMesh")
    bodyMesh.MeshType = Enum.MeshType.Sphere
    bodyMesh.Scale = Vector3.new(1, 0.8, 1.5)
    bodyMesh.Parent = body
    
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(3, 2.5, 4)
    head.Position = body.Position + Vector3.new(0, 0, -8)
    head.Material = Enum.Material.SmoothPlastic
    head.Color = Color3.fromRGB(60, 70, 80)
    head.Parent = sharkModel
    
    local headMesh = Instance.new("SpecialMesh")
    headMesh.MeshType = Enum.MeshType.Wedge
    headMesh.Parent = head
    
    local weld1 = Instance.new("WeldConstraint")
    weld1.Part0 = body
    weld1.Part1 = head
    weld1.Parent = head
    
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
    
    local tail = Instance.new("Part")
    tail.Size = Vector3.new(0.5, 5, 3)
    tail.Position = body.Position + Vector3.new(0, 1, 7)
    tail.Material = Enum.Material.SmoothPlastic
    tail.Color = Color3.fromRGB(60, 70, 80)
    tail.Parent = sharkModel
    
    local weld3 = Instance.new("WeldConstraint")
    weld3.Part0 = body
    weld3.Part1 = tail
    weld3.Parent = tail
    
    for side = -1, 1, 2 do
        local eye = Instance.new("Part")
        eye.Size = Vector3.new(0.5, 0.5, 0.5)
        eye.Position = head.Position + Vector3.new(side * 1, 0.5, -1.5)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 0, 0)
        eye.Shape = Enum.PartType.Ball
        eye.Parent = sharkModel
        
        local eyeWeld = Instance.new("WeldConstraint")
        eyeWeld.Part0 = head
        eyeWeld.Part1 = eye
        eyeWeld.Parent = eye
        
        local eyeLight = Instance.new("PointLight")
        eyeLight.Color = Color3.fromRGB(255, 0, 0)
        eyeLight.Brightness = 2
        eyeLight.Range = 20
        eyeLight.Parent = eye
    end
    
    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyVel.Parent = body
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.Parent = body
    
    task.spawn(function()
        local patrolTime = 0
        
        while body.Parent do
            patrolTime = patrolTime + 0.1
            
            local closestPlayer = nil
            local closestDistance = 40
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - body.Position).Magnitude
                    if distance < closestDistance then
                        closestPlayer = player
                        closestDistance = distance
                    end
                end
            end
            
            if closestPlayer and closestPlayer.Character then
                local targetPos = closestPlayer.Character.HumanoidRootPart.Position
                local direction = (targetPos - body.Position).Unit
                bodyVel.Velocity = direction * 30
                bodyGyro.CFrame = CFrame.lookAt(body.Position, targetPos)
                
                if closestDistance < 8 then
                    local humanoid = closestPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        humanoid:TakeDamage(20)
                    end
                end
            else
                local patrolDir = Vector3.new(
                    math.sin(patrolTime * 0.5),
                    math.sin(patrolTime * 0.3) * 0.5,
                    math.cos(patrolTime * 0.5)
                )
                bodyVel.Velocity = patrolDir * 15
                bodyGyro.CFrame = CFrame.lookAt(body.Position, body.Position + patrolDir)
            end
            
            task.wait(0.1)
        end
    end)
end

print("✅ 30 tiburones peligrosos creados")

-- ========================================
-- ILUMINACIÓN
-- ========================================
local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(100, 150, 200)
Lighting.Brightness = 2.5
Lighting.ColorShift_Top = Color3.fromRGB(150, 200, 255)
Lighting.OutdoorAmbient = Color3.fromRGB(120, 170, 220)
Lighting.FogEnd = 1200
Lighting.FogColor = Color3.fromRGB(100, 180, 230)
Lighting.ClockTime = 13

local atmos = Instance.new("Atmosphere")
atmos.Density = 0.3
atmos.Offset = 0.5
atmos.Color = Color3.fromRGB(150, 200, 255)
atmos.Decay = Color3.fromRGB(120, 180, 230)
atmos.Glare = 0.6
atmos.Haze = 1.8
atmos.Parent = Lighting

local sun = Instance.new("SunRaysEffect")
sun.Intensity = 0.2
sun.Spread = 0.12
sun.Parent = Lighting

print("")
print("🎉 ═══════════════════════════════════════")
print("🧜♀️ MAKO MERMAIDS - SUPERVIVENCIA")
print("═══════════════════════════════════════")
print("🛟 Balsa: 30x30 studs en Y=51")
print("🌿 Algas: 1000 recolectables")
print("🏊 Velocidad: 25 studs/s (+10 cada 10 algas)")
print("🏗️ Decoración: 50 boyas, 20 plataformas, 15 naufragios")
print("🦈 Tiburones: 30 con IA (persiguen y atacan)")
print("═══════════════════════════════════════")
print("✨ ¡Sobrevive y evita los tiburones!")
print("")
