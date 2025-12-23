-- SERVER SCRIPT - Colocar en ServerScriptService
print("🌊 Iniciando Mako Mermaids Server...")

workspace:ClearAllChildren()
game.Lighting:ClearAllChildren()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Eventos remotos
local giveResourceEvent = Instance.new("RemoteEvent", ReplicatedStorage)
giveResourceEvent.Name = "GiveResource"

local updateTimeEvent = Instance.new("RemoteEvent", ReplicatedStorage)
updateTimeEvent.Name = "UpdateTime"

-- Océano
local terrain = workspace.Terrain
terrain:Clear()
terrain:FillRegion(Region3.new(Vector3.new(-2000,0,-2000), Vector3.new(2000,50,2000)):ExpandToGrid(4), 4, Enum.Material.Water)
terrain:FillRegion(Region3.new(Vector3.new(-2000,-20,-2000), Vector3.new(2000,0,2000)):ExpandToGrid(4), 4, Enum.Material.Sand)

-- BOTE MEJORADO (más alto, no hundido)
local raft = Instance.new("Model", workspace)
raft.Name = "Raft"

-- Base sólida
local base = Instance.new("Part", raft)
base.Size = Vector3.new(30,2,30)
base.Position = Vector3.new(0,51,0)
base.Anchored = true
base.Material = Enum.Material.Wood
base.Color = Color3.fromRGB(101,67,33)

-- 20 troncos flotadores
for i = 1, 20 do
    local log = Instance.new("Part", raft)
    log.Size = Vector3.new(2,2,28)
    log.Position = Vector3.new(-19+i*2, 50, 0)
    log.Anchored = true
    log.Material = Enum.Material.Wood
    log.Color = Color3.fromRGB(90,60,30)
    log.Shape = Enum.PartType.Cylinder
    log.Orientation = Vector3.new(0,0,90)
end

-- Piso de tablas (bien diseñado)
for i = 1, 15 do
    local plank = Instance.new("Part", raft)
    plank.Size = Vector3.new(30,0.3,1.8)
    plank.Position = Vector3.new(0,52.2,-13.5+i*1.8)
    plank.Anchored = true
    plank.Material = Enum.Material.WoodPlanks
    plank.Color = Color3.fromRGB(140,100,70)
end

-- Bordes
for i = 1, 4 do
    local border = Instance.new("Part", raft)
    if i <= 2 then
        border.Size = Vector3.new(1,2,30)
        border.Position = Vector3.new(i==1 and -15.5 or 15.5, 53, 0)
    else
        border.Size = Vector3.new(30,2,1)
        border.Position = Vector3.new(0, 53, i==3 and -15 or 15)
    end
    border.Anchored = true
    border.Material = Enum.Material.Wood
    border.Color = Color3.fromRGB(80,50,30)
end

-- Spawn
local spawn = Instance.new("SpawnLocation", raft)
spawn.Size = Vector3.new(8,0.5,8)
spawn.Position = Vector3.new(0,52.5,0)
spawn.Anchored = true
spawn.Transparency = 0.7
spawn.CanCollide = false

-- FOGATA MEJORADA
local campfire = Instance.new("Model", raft)
campfire.Name = "Campfire"

-- 12 piedras en círculo
for i = 1, 12 do
    local angle = math.rad(i*30)
    local stone = Instance.new("Part", campfire)
    stone.Size = Vector3.new(1.5,1,1.5)
    stone.Position = Vector3.new(math.cos(angle)*2.5, 52.5, math.sin(angle)*2.5)
    stone.Anchored = true
    stone.Material = Enum.Material.Rock
    stone.Color = Color3.fromRGB(70,70,70)
    stone.Orientation = Vector3.new(math.random(-10,10), math.random(0,360), math.random(-10,10))
end

-- 6 leños cruzados
for i = 1, 6 do
    local angle = math.rad(i*60)
    local log = Instance.new("Part", campfire)
    log.Size = Vector3.new(0.6,0.6,3)
    log.Position = Vector3.new(math.cos(angle)*1, 53.5, math.sin(angle)*1)
    log.Anchored = true
    log.Material = Enum.Material.Wood
    log.Color = Color3.fromRGB(50,30,10)
    log.Orientation = Vector3.new(0, math.deg(angle), 40)
end

-- Fuego grande animado
local fire = Instance.new("Part", campfire)
fire.Name = "Fire"
fire.Size = Vector3.new(4,6,4)
fire.Position = Vector3.new(0,56,0)
fire.Anchored = true
fire.CanCollide = false
fire.Material = Enum.Material.Neon
fire.Color = Color3.fromRGB(255,100,0)
fire.Transparency = 0.2

local fireMesh = Instance.new("SpecialMesh", fire)
fireMesh.MeshType = Enum.MeshType.Sphere
fireMesh.Scale = Vector3.new(1,1.5,1)

local fireLight = Instance.new("PointLight", fire)
fireLight.Color = Color3.fromRGB(255,150,0)
fireLight.Brightness = 8
fireLight.Range = 60

-- Partículas de fuego
local fireParticles = Instance.new("ParticleEmitter", fire)
fireParticles.Texture = "rbxasset://textures/particles/smoke_main.dds"
fireParticles.Color = ColorSequence.new(Color3.fromRGB(255,100,0))
fireParticles.Size = NumberSequence.new(2)
fireParticles.Lifetime = NumberRange.new(1,2)
fireParticles.Rate = 50
fireParticles.Speed = NumberRange.new(5)
fireParticles.VelocitySpread = 10

task.spawn(function()
    while fire.Parent do
        fire.Size = Vector3.new(4+math.random(-8,8)/10, 6+math.random(-10,10)/10, 4+math.random(-8,8)/10)
        fire.Color = Color3.fromRGB(255, math.random(80,150), math.random(0,30))
        fireLight.Brightness = 7+math.random(0,20)/10
        wait(0.08)
    end
end)

-- MOLINILLO MEJORADO CON ANIMACIÓN
local grinder = Instance.new("Model", raft)
grinder.Name = "Grinder"

local gBase = Instance.new("Part", grinder)
gBase.Size = Vector3.new(5,4,5)
gBase.Position = Vector3.new(9,54,-9)
gBase.Anchored = true
gBase.Material = Enum.Material.Wood
gBase.Color = Color3.fromRGB(90,60,40)

-- Tolva superior
local hopper = Instance.new("Part", grinder)
hopper.Size = Vector3.new(4,2,4)
hopper.Position = gBase.Position + Vector3.new(0,3,0)
hopper.Anchored = true
hopper.Material = Enum.Material.Metal
hopper.Color = Color3.fromRGB(100,100,100)

-- Rueda giratoria
local wheel = Instance.new("Part", grinder)
wheel.Name = "Wheel"
wheel.Size = Vector3.new(3,0.5,3)
wheel.Position = gBase.Position + Vector3.new(0,1,0)
wheel.Anchored = false
wheel.Material = Enum.Material.Metal
wheel.Color = Color3.fromRGB(120,120,120)
wheel.Shape = Enum.PartType.Cylinder

local wheelWeld = Instance.new("Weld", wheel)
wheelWeld.Part0 = gBase
wheelWeld.Part1 = wheel

-- Iconos en el molinillo
local billboardWood = Instance.new("BillboardGui", hopper)
billboardWood.Size = UDim2.new(0,50,0,50)
billboardWood.StudsOffset = Vector3.new(-1,2,0)
billboardWood.AlwaysOnTop = true

local iconWood = Instance.new("ImageLabel", billboardWood)
iconWood.Size = UDim2.new(1,0,1,0)
iconWood.BackgroundTransparency = 1
iconWood.Image = "rbxassetid://6031097225"

local billboardMetal = Instance.new("BillboardGui", hopper)
billboardMetal.Size = UDim2.new(0,50,0,50)
billboardMetal.StudsOffset = Vector3.new(1,2,0)
billboardMetal.AlwaysOnTop = true

local iconMetal = Instance.new("ImageLabel", billboardMetal)
iconMetal.Size = UDim2.new(1,0,1,0)
iconMetal.BackgroundTransparency = 1
iconMetal.Image = "rbxassetid://6031097225"

local gPrompt = Instance.new("ProximityPrompt", gBase)
gPrompt.ActionText = "Moler"
gPrompt.ObjectText = "⚙️ Molinillo (5 Madera/Metal)"
gPrompt.HoldDuration = 2
gPrompt.MaxActivationDistance = 10

-- 200 Maderas
local woods = Instance.new("Folder", workspace)
woods.Name = "Woods"

for i = 1, 200 do
    local wood = Instance.new("Part", woods)
    wood.Name = "Wood"
    wood.Size = Vector3.new(2,2,6)
    wood.Position = Vector3.new(math.random(-1500,1500), 49, math.random(-1500,1500))
    wood.Anchored = true
    wood.Material = Enum.Material.Wood
    wood.Color = Color3.fromRGB(120,80,50)
    wood.Shape = Enum.PartType.Cylinder
    wood.Orientation = Vector3.new(0,math.random(0,360),0)
    
    local h = Instance.new("Highlight", wood)
    h.FillColor = Color3.fromRGB(150,100,50)
    h.OutlineColor = Color3.fromRGB(255,200,100)
    h.FillTransparency = 0.5
    
    local p = Instance.new("ProximityPrompt", wood)
    p.ActionText = "Recoger"
    p.ObjectText = "🪵 Madera"
    p.HoldDuration = 0.5
    p.MaxActivationDistance = 12
end

-- 150 Chatarra (metal)
local scraps = Instance.new("Folder", workspace)
scraps.Name = "Scraps"

for i = 1, 150 do
    local scrap = Instance.new("Part", scraps)
    scrap.Name = "Scrap"
    scrap.Size = Vector3.new(3,2,3)
    scrap.Position = Vector3.new(math.random(-1500,1500), 49, math.random(-1500,1500))
    scrap.Anchored = true
    scrap.Material = Enum.Material.CorrodedMetal
    scrap.Color = Color3.fromRGB(100,100,100)
    scrap.Orientation = Vector3.new(math.random(-20,20), math.random(0,360), math.random(-20,20))
    
    local h = Instance.new("Highlight", scrap)
    h.FillColor = Color3.fromRGB(120,120,120)
    h.OutlineColor = Color3.fromRGB(200,200,200)
    h.FillTransparency = 0.5
    
    local p = Instance.new("ProximityPrompt", scrap)
    p.ActionText = "Recoger"
    p.ObjectText = "⚙️ Chatarra"
    p.HoldDuration = 0.5
    p.MaxActivationDistance = 12
end

-- 300 Algas
local algaes = Instance.new("Folder", workspace)
algaes.Name = "Algaes"

for i = 1, 300 do
    local x = math.random(-1800,1800)
    local z = math.random(-1800,1800)
    if math.sqrt(x*x+z*z) > 60 then
        local alga = Instance.new("Part", algaes)
        alga.Name = "Alga"
        alga.Size = Vector3.new(3,4,3)
        alga.Position = Vector3.new(x,10,z)
        alga.Anchored = true
        alga.Material = Enum.Material.Neon
        alga.Color = Color3.fromRGB(math.random(30,60), math.random(130,200), math.random(30,60))
        alga.Transparency = 0.2
        alga.Shape = Enum.PartType.Ball
        
        local p = Instance.new("ProximityPrompt", alga)
        p.ActionText = "Arrancar"
        p.ObjectText = "🌿 Alga"
        p.HoldDuration = 0.8
        p.MaxActivationDistance = 15
    end
end

-- Sistema de recursos
local function give(player, resource, amount)
    local stats = player:FindFirstChild("PlayerStats")
    if not stats then
        stats = Instance.new("Folder", player)
        stats.Name = "PlayerStats"
    end
    
    local res = stats:FindFirstChild(resource)
    if not res then
        res = Instance.new("IntValue", stats)
        res.Name = resource
        res.Value = 0
    end
    
    res.Value = res.Value + amount
    giveResourceEvent:FireClient(player, resource, amount)
end

-- Conectar recursos
for _, wood in pairs(woods:GetChildren()) do
    wood.ProximityPrompt.Triggered:Connect(function(player)
        give(player, "Madera", 1)
        wood:Destroy()
    end)
end

for _, scrap in pairs(scraps:GetChildren()) do
    scrap.ProximityPrompt.Triggered:Connect(function(player)
        give(player, "Chatarra", 1)
        scrap:Destroy()
    end)
end

for _, alga in pairs(algaes:GetChildren()) do
    alga.ProximityPrompt.Triggered:Connect(function(player)
        give(player, "Algas", 1)
        alga:Destroy()
    end)
end

-- Molinillo con animación
gPrompt.Triggered:Connect(function(player)
    local stats = player:FindFirstChild("PlayerStats")
    local madera = stats and stats:FindFirstChild("Madera")
    local chatarra = stats and stats:FindFirstChild("Chatarra")
    
    if (madera and madera.Value >= 5) or (chatarra and chatarra.Value >= 5) then
        -- Animación de moler
        task.spawn(function()
            for i = 1, 20 do
                wheel.CFrame = wheel.CFrame * CFrame.Angles(0, math.rad(18), 0)
                wait(0.05)
            end
        end)
        
        if madera and madera.Value >= 5 then
            madera.Value = madera.Value - 5
            give(player, "MaderaMolida", 10)
        elseif chatarra and chatarra.Value >= 5 then
            chatarra.Value = chatarra.Value - 5
            give(player, "MetalMolido", 10)
        end
    end
end)

-- Inicializar jugadores
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = 25
        
        local stats = Instance.new("Folder", player)
        stats.Name = "PlayerStats"
        
        Instance.new("IntValue", stats).Name = "Madera"
        Instance.new("IntValue", stats).Name = "Chatarra"
        Instance.new("IntValue", stats).Name = "Algas"
        Instance.new("IntValue", stats).Name = "MaderaMolida"
        Instance.new("IntValue", stats).Name = "MetalMolido"
    end)
end)

-- Sistema día/noche (1 minuto cada uno)
local Lighting = game:GetService("Lighting")
local isNight = false
local timeRemaining = 60

-- Sol y Luna
local sky = Instance.new("Sky", Lighting)
sky.SkyboxBk = "rbxasset://sky/moon.jpg"
sky.SkyboxDn = "rbxasset://sky/moon.jpg"
sky.SkyboxFt = "rbxasset://sky/moon.jpg"
sky.SkyboxLf = "rbxasset://sky/moon.jpg"
sky.SkyboxRt = "rbxasset://sky/moon.jpg"
sky.SkyboxUp = "rbxasset://sky/moon.jpg"

task.spawn(function()
    while true do
        -- DÍA
        isNight = false
        timeRemaining = 60
        print("☀️ DÍA")
        
        for i = 1, 60 do
            Lighting.ClockTime = 12
            Lighting.Ambient = Color3.fromRGB(100,150,200)
            Lighting.OutdoorAmbient = Color3.fromRGB(120,170,220)
            Lighting.FogEnd = 1200
            sky.CelestialBodiesShown = true
            
            timeRemaining = 60 - i
            updateTimeEvent:FireAllClients(false, timeRemaining)
            wait(1)
        end
        
        -- NOCHE
        isNight = true
        timeRemaining = 60
        print("🌙 NOCHE")
        
        for i = 1, 60 do
            Lighting.ClockTime = 0
            Lighting.Ambient = Color3.fromRGB(20,20,40)
            Lighting.OutdoorAmbient = Color3.fromRGB(10,10,30)
            Lighting.FogEnd = 300
            sky.CelestialBodiesShown = true
            
            timeRemaining = 60 - i
            updateTimeEvent:FireAllClients(true, timeRemaining)
            wait(1)
        end
    end
end)

-- Tiburones (solo noche)
local sharks = Instance.new("Folder", workspace)
sharks.Name = "Sharks"

for i = 1, 20 do
    local shark = Instance.new("Model", sharks)
    shark.Name = "Shark"
    
    local body = Instance.new("Part", shark)
    body.Name = "Body"
    body.Size = Vector3.new(4,3,12)
    body.Position = Vector3.new(math.random(-1500,1500), 25, math.random(-1500,1500))
    body.Anchored = false
    body.Material = Enum.Material.SmoothPlastic
    body.Color = Color3.fromRGB(70,80,90)
    
    local head = Instance.new("Part", shark)
    head.Size = Vector3.new(3,2.5,4)
    head.Position = body.Position + Vector3.new(0,0,-8)
    head.Material = Enum.Material.SmoothPlastic
    head.Color = Color3.fromRGB(60,70,80)
    
    Instance.new("WeldConstraint", head).Part0 = body
    Instance.new("WeldConstraint", head).Part1 = head
    
    local fin = Instance.new("Part", shark)
    fin.Size = Vector3.new(0.5,4,2)
    fin.Position = body.Position + Vector3.new(0,3,0)
    fin.Material = Enum.Material.SmoothPlastic
    fin.Color = Color3.fromRGB(50,60,70)
    
    Instance.new("WeldConstraint", fin).Part0 = body
    Instance.new("WeldConstraint", fin).Part1 = fin
    
    for side = -1, 1, 2 do
        local eye = Instance.new("Part", shark)
        eye.Size = Vector3.new(0.5,0.5,0.5)
        eye.Position = head.Position + Vector3.new(side,0.5,-1.5)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255,0,0)
        eye.Shape = Enum.PartType.Ball
        
        Instance.new("WeldConstraint", eye).Part0 = head
        Instance.new("WeldConstraint", eye).Part1 = eye
    end
    
    local vel = Instance.new("BodyVelocity", body)
    vel.MaxForce = Vector3.new(4000,4000,4000)
    
    local gyro = Instance.new("BodyGyro", body)
    gyro.MaxTorque = Vector3.new(4000,4000,4000)
    
    task.spawn(function()
        local t = 0
        while body.Parent do
            t = t + 0.1
            
            if isNight then
                local closest = nil
                local closestDist = 50
                
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local pos = p.Character.HumanoidRootPart.Position
                        if (pos - Vector3.new(0,51,0)).Magnitude > 30 then
                            local dist = (pos - body.Position).Magnitude
                            if dist < closestDist then
                                closest = p
                                closestDist = dist
                            end
                        end
                    end
                end
                
                if closest and closest.Character then
                    local target = closest.Character.HumanoidRootPart.Position
                    vel.Velocity = (target - body.Position).Unit * 35
                    gyro.CFrame = CFrame.lookAt(body.Position, target)
                    
                    if closestDist < 8 then
                        local hum = closest.Character:FindFirstChild("Humanoid")
                        if hum and hum.Health > 0 then
                            hum:TakeDamage(25)
                        end
                    end
                else
                    local dir = Vector3.new(math.sin(t*0.5), 0, math.cos(t*0.5))
                    vel.Velocity = dir * 20
                    gyro.CFrame = CFrame.lookAt(body.Position, body.Position + dir)
                end
            else
                vel.Velocity = Vector3.new(0,0,0)
            end
            
            wait(0.1)
        end
    end)
end

local atmos = Instance.new("Atmosphere", Lighting)
atmos.Density = 0.3
atmos.Color = Color3.fromRGB(150,200,255)

print("✅ SERVER LISTO")
