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
    Region3.new(Vector3.new(-2000, 0, -2000), Vector3.new(2000, 100, 2000)):ExpandToGrid(4),
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
-- BALSA INICIAL
-- ========================================
print("🛟 Construyendo balsa inicial...")

local raftFolder = Instance.new("Folder")
raftFolder.Name = "Raft"
raftFolder.Parent = workspace

-- Base de la balsa (madera)
local raftBase = Instance.new("Part")
raftBase.Name = "RaftBase"
raftBase.Size = Vector3.new(20, 2, 20)
raftBase.Position = Vector3.new(0, 51, 0)
raftBase.Anchored = false
raftBase.Material = Enum.Material.Wood
raftBase.Color = Color3.fromRGB(150, 110, 70)
raftBase.Parent = raftFolder

-- Mantener la balsa flotando
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.Parent = raftBase

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
bodyGyro.CFrame = raftBase.CFrame
bodyGyro.Parent = raftBase

-- Tablas de madera (8 tablas)
for i = 1, 4 do
    for j = 1, 2 do
        local plank = Instance.new("Part")
        plank.Size = Vector3.new(4.5, 0.5, 9)
        plank.Position = raftBase.Position + Vector3.new(-7.5 + i*5, 1.5, -5 + j*10)
        plank.Material = Enum.Material.Wood
        plank.Color = Color3.fromRGB(140, 100, 60)
        plank.Parent = raftFolder
        
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = raftBase
        weld.Part1 = plank
        weld.Parent = plank
    end
end

-- Poste central
local mast = Instance.new("Part")
mast.Name = "Mast"
mast.Size = Vector3.new(1.5, 15, 1.5)
mast.Position = raftBase.Position + Vector3.new(0, 8.5, 0)
mast.Material = Enum.Material.Wood
mast.Color = Color3.fromRGB(100, 70, 40)
mast.Parent = raftFolder

local mastWeld = Instance.new("WeldConstraint")
mastWeld.Part0 = raftBase
mastWeld.Part1 = mast
mastWeld.Parent = mast

-- Asiento para manejar
local seat = Instance.new("Seat")
seat.Name = "DriverSeat"
seat.Size = Vector3.new(4, 1, 4)
seat.Position = raftBase.Position + Vector3.new(0, 2, 5)
seat.Material = Enum.Material.Wood
seat.Color = Color3.fromRGB(120, 80, 50)
seat.Parent = raftFolder

local seatWeld = Instance.new("WeldConstraint")
seatWeld.Part0 = raftBase
seatWeld.Part1 = seat
seatWeld.Parent = seat

-- Respaldo del asiento
local backrest = Instance.new("Part")
backrest.Size = Vector3.new(4, 3, 0.5)
backrest.Position = seat.Position + Vector3.new(0, 2, -2)
backrest.Material = Enum.Material.Wood
backrest.Color = Color3.fromRGB(120, 80, 50)
backrest.Parent = raftFolder

local backWeld = Instance.new("WeldConstraint")
backWeld.Part0 = seat
backWeld.Part1 = backrest
backWeld.Parent = backrest

-- Spawn en la balsa
local spawn = Instance.new("SpawnLocation")
spawn.Size = Vector3.new(6, 1, 6)
spawn.Position = raftBase.Position + Vector3.new(-5, 2, 0)
spawn.Anchored = false
spawn.Material = Enum.Material.Wood
spawn.Color = Color3.fromRGB(150, 110, 70)
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.TopSurface = Enum.SurfaceType.Smooth
spawn.CanCollide = false
spawn.Transparency = 0.5
spawn.Parent = raftFolder

local spawnWeld = Instance.new("WeldConstraint")
spawnWeld.Part0 = raftBase
spawnWeld.Part1 = spawn
spawnWeld.Parent = spawn

print("✅ Balsa inicial creada")

-- ========================================
-- SISTEMA DE RECURSOS
-- ========================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local resourcesFolder = Instance.new("Folder")
resourcesFolder.Name = "PlayerResources"
resourcesFolder.Parent = ReplicatedStorage

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
    
    -- No spawear algas cerca de la balsa
    if distance > 50 then
        local height = math.random(10, 30)
        local segments = math.floor(height / 3)
        local baseColor = Color3.fromRGB(math.random(30, 60), math.random(120, 180), math.random(30, 60))
        
        -- Base del alga (parte recolectable)
        local algaeBase = Instance.new("Part")
        algaeBase.Name = "AlgaeBase"
        algaeBase.Size = Vector3.new(2, 3, 2)
        algaeBase.Position = Vector3.new(x, 3, z)
        algaeBase.Anchored = true
        algaeBase.Material = Enum.Material.Neon
        algaeBase.Color = baseColor
        algaeBase.Transparency = 0.2
        algaeBase.Shape = Enum.PartType.Ball
        algaeBase.Parent = algaeModel
        
        -- Highlight para visibilidad
        local highlight = Instance.new("Highlight")
        highlight.FillColor = baseColor
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = algaeBase
        
        -- ProximityPrompt para recolectar
        local prompt = Instance.new("ProximityPrompt")
        prompt.ActionText = "Arrancar Alga"
        prompt.ObjectText = "Alga Marina"
        prompt.HoldDuration = 1
        prompt.MaxActivationDistance = 10
        prompt.RequiresLineOfSight = false
        prompt.Parent = algaeBase
        
        -- Segmentos del alga
        for seg = 1, segments do
            local segment = Instance.new("Part")
            segment.Size = Vector3.new(1, 3, 0.3)
            segment.Position = Vector3.new(
                x + math.sin(seg * 0.8) * (seg * 0.4),
                3 + seg * 3,
                z + math.cos(seg * 0.8) * (seg * 0.4)
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
            mesh.Scale = Vector3.new(1.5, 3, 1)
            mesh.Parent = segment
        end
        
        -- Animación ondulante
        task.spawn(function()
            local time = math.random(0, 100)
            while algaeModel.Parent do
                time = time + 0.05
                for _, part in pairs(algaeModel:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "AlgaeBase" then
                        local offset = math.sin(time + part.Position.Y * 0.1) * 1.5
                        part.CFrame = part.CFrame * CFrame.Angles(math.sin(time) * 0.1, 0, math.cos(time) * 0.1)
                    end
                end
                task.wait(0.05)
            end
        end)
    end
end

print("✅ 1000 algas recolectables creadas")

-- ========================================
-- SCRIPT DE RECOLECCIÓN
-- ========================================
print("📦 Configurando sistema de recolección...")

local Players = game:GetService("Players")

-- Función para dar recursos al jugador
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

-- Conectar ProximityPrompts
for _, algae in pairs(algaeFolder:GetChildren()) do
    local algaeBase = algae:FindFirstChild("AlgaeBase")
    if algaeBase then
        local prompt = algaeBase:FindFirstChild("ProximityPrompt")
        if prompt then
            prompt.Triggered:Connect(function(player)
                -- Dar recursos
                giveResource(player, "Algas", 1)
                giveResource(player, "Madera", math.random(1, 3))
                
                -- Efecto visual
                local explosion = Instance.new("Part")
                explosion.Size = Vector3.new(1, 1, 1)
                explosion.Position = algaeBase.Position
                explosion.Anchored = true
                explosion.CanCollide = false
                explosion.Material = Enum.Material.Neon
                explosion.Color = algaeBase.Color
                explosion.Shape = Enum.PartType.Ball
                explosion.Transparency = 0
                explosion.Parent = workspace
                
                task.spawn(function()
                    for i = 1, 20 do
                        explosion.Size = explosion.Size + Vector3.new(0.5, 0.5, 0.5)
                        explosion.Transparency = i / 20
                        task.wait(0.05)
                    end
                    explosion:Destroy()
                end)
                
                -- Eliminar alga
                algae:Destroy()
                
                -- Mensaje
                print(player.Name .. " recolectó un alga!")
            end)
        end
    end
end

print("✅ Sistema de recolección configurado")

-- ========================================
-- SISTEMA DE EXPANSIÓN DE BALSA
-- ========================================
print("🔨 Configurando expansión de balsa...")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            leaderstats = Instance.new("Folder")
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
            velocidad.Value = 10
            velocidad.Parent = leaderstats
        end
        
        -- Monitorear recursos para expandir balsa
        local algas = leaderstats:FindFirstChild("Algas")
        if algas then
            algas.Changed:Connect(function(value)
                local velocidad = leaderstats:FindFirstChild("Velocidad")
                if velocidad then
                    -- Cada 10 algas aumenta velocidad
                    velocidad.Value = 10 + math.floor(value / 10) * 5
                end
            end)
        end
    end)
end)

-- Control de la balsa
seat:GetPropertyChangedSignal("Occupant"):Connect(function()
    if seat.Occupant then
        local player = game.Players:GetPlayerFromCharacter(seat.Occupant.Parent)
        if player then
            local leaderstats = player:FindFirstChild("leaderstats")
            local velocidad = leaderstats and leaderstats:FindFirstChild("Velocidad")
            local speed = velocidad and velocidad.Value or 10
            
            -- Controles
            local humanoid = seat.Occupant
            task.spawn(function()
                while seat.Occupant == humanoid do
                    local moveDirection = humanoid.Parent:FindFirstChild("Humanoid").MoveDirection
                    if moveDirection.Magnitude > 0 then
                        bodyVelocity.Velocity = Vector3.new(moveDirection.X * speed, 0, moveDirection.Z * speed)
                    else
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                    task.wait()
                end
            end)
        end
    else
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

print("✅ Sistema de expansión configurado")

-- ========================================
-- ILUMINACIÓN
-- ========================================
print("💡 Configurando iluminación...")

local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(100, 150, 200)
Lighting.Brightness = 2
Lighting.ColorShift_Top = Color3.fromRGB(150, 200, 255)
Lighting.OutdoorAmbient = Color3.fromRGB(120, 170, 220)
Lighting.FogEnd = 1000
Lighting.FogColor = Color3.fromRGB(100, 180, 230)
Lighting.ClockTime = 14

local atmos = Instance.new("Atmosphere")
atmos.Density = 0.3
atmos.Offset = 0.5
atmos.Color = Color3.fromRGB(150, 200, 255)
atmos.Decay = Color3.fromRGB(120, 180, 230)
atmos.Glare = 0.5
atmos.Haze = 1.5
atmos.Parent = Lighting

local sun = Instance.new("SunRaysEffect")
sun.Intensity = 0.15
sun.Spread = 0.1
sun.Parent = Lighting

print("✅ Iluminación configurada")

print("")
print("🎉 ═══════════════════════════════════════")
print("🧜♀️ MAKO MERMAIDS - SUPERVIVENCIA EN BALSA")
print("═══════════════════════════════════════")
print("🛟 Balsa inicial: 20x20 studs")
print("🌿 Algas recolectables: 1000")
print("📦 Sistema: ProximityPrompt")
print("⚡ Velocidad inicial: 10 studs/s")
print("🚀 +5 velocidad cada 10 algas")
print("🎯 Objetivo: Recolectar algas para expandir")
print("═══════════════════════════════════════")
print("✨ ¡Sobrevive en el océano!")
print("")
