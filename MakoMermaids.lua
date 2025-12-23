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
    Region3.new(Vector3.new(-2000, 0, -2000), Vector3.new(2000, 80, 2000)):ExpandToGrid(4),
    4,
    Enum.Material.Water
)

terrain:FillRegion(
    Region3.new(Vector3.new(-2000, -50, -2000), Vector3.new(2000, 0, 2000)):ExpandToGrid(4),
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

-- Base principal flotante
local raftBase = Instance.new("Part")
raftBase.Name = "RaftBase"
raftBase.Size = Vector3.new(30, 3, 30)
raftBase.Position = Vector3.new(0, 81, 0)
raftBase.Anchored = true
raftBase.Material = Enum.Material.Wood
raftBase.Color = Color3.fromRGB(139, 90, 43)
raftBase.Parent = raftFolder

-- Troncos flotadores (6 troncos grandes)
for i = 1, 3 do
    for j = 1, 2 do
        local log = Instance.new("Part")
        log.Size = Vector3.new(8, 2, 28)
        log.Position = raftBase.Position + Vector3.new(-10 + i*10, -2, -14 + j*28)
        log.Anchored = true
        log.Material = Enum.Material.Wood
        log.Color = Color3.fromRGB(101, 67, 33)
        log.Shape = Enum.PartType.Cylinder
        log.Orientation = Vector3.new(0, 0, 90)
        log.Parent = raftFolder
        
        -- Textura de tronco
        local mesh = Instance.new("CylinderMesh")
        mesh.Parent = log
    end
end

-- Tablas del piso (diseño cruzado)
for i = 1, 10 do
    local plank = Instance.new("Part")
    plank.Size = Vector3.new(30, 0.8, 2.5)
    plank.Position = raftBase.Position + Vector3.new(0, 2, -12 + i*2.5)
    plank.Anchored = true
    plank.Material = Enum.Material.WoodPlanks
    plank.Color = Color3.fromRGB(160, 120, 80)
    plank.Parent = raftFolder
end

-- Bordes de la balsa (barandilla)
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

-- Mástil central robusto
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

-- Vela
local sail = Instance.new("Part")
sail.Name = "Sail"
sail.Size = Vector3.new(0.3, 18, 15)
sail.Position = mast.Position + Vector3.new(0, 0, 8)
sail.Anchored = true
sail.Material = Enum.Material.Fabric
sail.Color = Color3.fromRGB(240, 240, 250)
sail.Parent = raftFolder

-- Asiento del capitán (elevado)
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

-- Respaldo del asiento
local backrest = Instance.new("Part")
backrest.Size = Vector3.new(5, 4, 1)
backrest.Position = seat.Position + Vector3.new(0, 2.5, -2.5)
backrest.Anchored = true
backrest.Material = Enum.Material.Wood
backrest.Color = Color3.fromRGB(160, 110, 60)
backrest.Parent = raftFolder

-- Timón decorativo
local rudder = Instance.new("Part")
rudder.Size = Vector3.new(0.5, 6, 3)
rudder.Position = raftBase.Position + Vector3.new(0, 2, 15)
rudder.Anchored = true
rudder.Material = Enum.Material.Wood
rudder.Color = Color3.fromRGB(100, 65, 35)
rudder.Parent = raftFolder

-- Cajas de almacenamiento (decoración)
for i = 1, 3 do
    local crate = Instance.new("Part")
    crate.Size = Vector3.new(4, 3, 4)
    crate.Position = raftBase.Position + Vector3.new(-10 + i*5, 3.5, -10)
    crate.Anchored = true
    crate.Material = Enum.Material.Wood
    crate.Color = Color3.fromRGB(120, 80, 40)
    crate.Parent = raftFolder
end

-- Barril decorativo
local barrel = Instance.new("Part")
barrel.Size = Vector3.new(3, 4, 3)
barrel.Position = raftBase.Position + Vector3.new(10, 4, -10)
barrel.Anchored = true
barrel.Material = Enum.Material.Wood
barrel.Color = Color3.fromRGB(100, 60, 30)
barrel.Shape = Enum.PartType.Cylinder
barrel.Orientation = Vector3.new(90, 0, 0)
barrel.Parent = raftFolder

-- Spawn en la balsa
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

print("✅ Balsa épica creada en Y=81")

-- ========================================
-- ALGAS RECOLECTABLES (1000 algas)
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
        local height = math.random(15, 35)
        local segments = math.floor(height / 4)
        local baseColor = Color3.fromRGB(math.random(30, 60), math.random(130, 200), math.random(30, 60))
        
        local algaeBase = Instance.new("Part")
        algaeBase.Name = "AlgaeBase"
        algaeBase.Size = Vector3.new(3, 4, 3)
        algaeBase.Position = Vector3.new(x, 5, z)
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
        
        for seg = 1, segments do
            local segment = Instance.new("Part")
            segment.Size = Vector3.new(1.5, 4, 0.5)
            segment.Position = Vector3.new(
                x + math.sin(seg * 0.6) * (seg * 0.5),
                5 + seg * 4,
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
-- SISTEMA DE RECOLECCIÓN Y VELOCIDAD
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

-- Aumentar velocidad de nado
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        -- Velocidad de nado RÁPIDA
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
print("🛟 Balsa épica: 30x30 studs en Y=81")
print("🌿 Algas: 1000 recolectables")
print("🏊 Velocidad nado: 25 studs/s")
print("🚀 +10 velocidad cada 10 algas")
print("📦 Recursos: Algas + Madera")
print("═══════════════════════════════════════")
print("✨ ¡Sobrevive y recolecta!")
print("")
