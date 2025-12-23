-- MAKO MERMAIDS - Supervivencia
print("Iniciando juego...")

-- Limpiar
workspace:ClearAllChildren()
game.Lighting:ClearAllChildren()

-- Océano
local terrain = workspace.Terrain
terrain:Clear()
terrain:FillRegion(Region3.new(Vector3.new(-2000,0,-2000), Vector3.new(2000,50,2000)):ExpandToGrid(4), 4, Enum.Material.Water)
terrain:FillRegion(Region3.new(Vector3.new(-2000,-20,-2000), Vector3.new(2000,0,2000)):ExpandToGrid(4), 4, Enum.Material.Sand)

-- Bote rústico
local raft = Instance.new("Model", workspace)
raft.Name = "Raft"

-- 15 troncos base
for i = 1, 15 do
    local log = Instance.new("Part", raft)
    log.Size = Vector3.new(2,2,25)
    log.Position = Vector3.new(-14+i*2, 51, 0)
    log.Anchored = true
    log.Material = Enum.Material.Wood
    log.Color = Color3.fromRGB(101,67,33)
    log.Shape = Enum.PartType.Cylinder
    log.Orientation = Vector3.new(0,0,90)
end

-- 10 palos cruzados
for i = 1, 10 do
    local stick = Instance.new("Part", raft)
    stick.Size = Vector3.new(1,1,30)
    stick.Position = Vector3.new(0, 52.5, -12+i*2.5)
    stick.Anchored = true
    stick.Material = Enum.Material.Wood
    stick.Color = Color3.fromRGB(120,80,40)
end

-- Spawn
local spawn = Instance.new("SpawnLocation", raft)
spawn.Size = Vector3.new(8,1,8)
spawn.Position = Vector3.new(0,53,0)
spawn.Anchored = true
spawn.Transparency = 0.5
spawn.CanCollide = false

-- Fogata
local fire = Instance.new("Part", raft)
fire.Size = Vector3.new(3,5,3)
fire.Position = Vector3.new(0,55,0)
fire.Anchored = true
fire.CanCollide = false
fire.Material = Enum.Material.Neon
fire.Color = Color3.fromRGB(255,100,0)
fire.Transparency = 0.3

local light = Instance.new("PointLight", fire)
light.Color = Color3.fromRGB(255,150,0)
light.Brightness = 5
light.Range = 50

-- Animar fuego
task.spawn(function()
    while fire do
        fire.Size = Vector3.new(3+math.random(-5,5)/10, 5+math.random(-5,5)/10, 3+math.random(-5,5)/10)
        fire.Color = Color3.fromRGB(255, math.random(80,150), 0)
        light.Brightness = 4+math.random(0,20)/10
        wait(0.1)
    end
end)

-- Molinillo
local grinder = Instance.new("Part", raft)
grinder.Size = Vector3.new(4,3,4)
grinder.Position = Vector3.new(8,54,-8)
grinder.Anchored = true
grinder.Material = Enum.Material.Wood
grinder.Color = Color3.fromRGB(100,70,40)

local grinderTop = Instance.new("Part", raft)
grinderTop.Size = Vector3.new(3,1,3)
grinderTop.Position = Vector3.new(8,56,-8)
grinderTop.Anchored = true
grinderTop.Material = Enum.Material.Metal
grinderTop.Color = Color3.fromRGB(120,120,120)
grinderTop.Shape = Enum.PartType.Cylinder

local grinderPrompt = Instance.new("ProximityPrompt", grinder)
grinderPrompt.ActionText = "Moler Madera"
grinderPrompt.ObjectText = "Molinillo (5 Maderas)"
grinderPrompt.HoldDuration = 2
grinderPrompt.MaxActivationDistance = 10

-- 200 Maderas flotantes
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
    p.ObjectText = "Madera"
    p.HoldDuration = 0.5
    p.MaxActivationDistance = 12
end

-- 500 Algas
local algaes = Instance.new("Folder", workspace)
algaes.Name = "Algaes"

for i = 1, 500 do
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
        p.ObjectText = "Alga"
        p.HoldDuration = 0.8
        p.MaxActivationDistance = 15
    end
end

-- Sistema de recursos
local Players = game:GetService("Players")

local function give(player, resource, amount)
    local stats = player:FindFirstChild("leaderstats") or Instance.new("Folder", player)
    stats.Name = "leaderstats"
    
    local res = stats:FindFirstChild(resource) or Instance.new("IntValue", stats)
    res.Name = resource
    res.Value = res.Value + amount
end

-- Conectar maderas
for _, wood in pairs(woods:GetChildren()) do
    wood.ProximityPrompt.Triggered:Connect(function(player)
        give(player, "Madera", 1)
        wood:Destroy()
    end)
end

-- Conectar algas
for _, alga in pairs(algaes:GetChildren()) do
    alga.ProximityPrompt.Triggered:Connect(function(player)
        give(player, "Algas", 1)
        alga:Destroy()
    end)
end

-- Conectar molinillo
grinderPrompt.Triggered:Connect(function(player)
    local stats = player:FindFirstChild("leaderstats")
    local madera = stats and stats:FindFirstChild("Madera")
    if madera and madera.Value >= 5 then
        madera.Value = madera.Value - 5
        give(player, "MaderaMolida", 10)
    end
end)

-- Inicializar jugadores
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = 25
        
        local stats = Instance.new("Folder", player)
        stats.Name = "leaderstats"
        
        Instance.new("IntValue", stats).Name = "Madera"
        Instance.new("IntValue", stats).Name = "Algas"
        Instance.new("IntValue", stats).Name = "MaderaMolida"
    end)
end)

-- Sistema día/noche
local Lighting = game:GetService("Lighting")
local isNight = false

task.spawn(function()
    while true do
        -- DÍA (5 min)
        isNight = false
        print("DÍA - Seguro")
        for i = 6, 18, 0.1 do
            Lighting.ClockTime = i
            Lighting.Ambient = Color3.fromRGB(100,150,200)
            Lighting.OutdoorAmbient = Color3.fromRGB(120,170,220)
            Lighting.FogEnd = 1200
            wait(300/120)
        end
        
        -- NOCHE (3 min)
        isNight = true
        print("NOCHE - PELIGRO")
        for i = 18, 30, 0.1 do
            Lighting.ClockTime = i >= 24 and i-24 or i
            Lighting.Ambient = Color3.fromRGB(20,20,40)
            Lighting.OutdoorAmbient = Color3.fromRGB(10,10,30)
            Lighting.FogEnd = 300
            wait(180/120)
        end
    end
end)

-- 20 Tiburones
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
    
    local w = Instance.new("WeldConstraint", head)
    w.Part0 = body
    w.Part1 = head
    
    local fin = Instance.new("Part", shark)
    fin.Size = Vector3.new(0.5,4,2)
    fin.Position = body.Position + Vector3.new(0,3,0)
    fin.Material = Enum.Material.SmoothPlastic
    fin.Color = Color3.fromRGB(50,60,70)
    
    local w2 = Instance.new("WeldConstraint", fin)
    w2.Part0 = body
    w2.Part1 = fin
    
    -- Ojos rojos
    for side = -1, 1, 2 do
        local eye = Instance.new("Part", shark)
        eye.Size = Vector3.new(0.5,0.5,0.5)
        eye.Position = head.Position + Vector3.new(side,0.5,-1.5)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255,0,0)
        eye.Shape = Enum.PartType.Ball
        
        local w3 = Instance.new("WeldConstraint", eye)
        w3.Part0 = head
        w3.Part1 = eye
    end
    
    local vel = Instance.new("BodyVelocity", body)
    vel.MaxForce = Vector3.new(4000,4000,4000)
    vel.Velocity = Vector3.new(0,0,0)
    
    local gyro = Instance.new("BodyGyro", body)
    gyro.MaxTorque = Vector3.new(4000,4000,4000)
    
    -- IA
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
                        local raftDist = (pos - Vector3.new(0,51,0)).Magnitude
                        
                        if raftDist > 30 then
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
                    local dir = (target - body.Position).Unit
                    vel.Velocity = dir * 35
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

-- Terremotos
task.spawn(function()
    while true do
        wait(math.random(60,120))
        if isNight then
            print("TERREMOTO")
            for i = 1, 30 do
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(
                    math.rad(math.random(-2,2)),
                    math.rad(math.random(-2,2)),
                    math.rad(math.random(-2,2))
                )
                wait(0.1)
            end
        end
    end
end)

-- Atmósfera
local atmos = Instance.new("Atmosphere", Lighting)
atmos.Density = 0.3
atmos.Color = Color3.fromRGB(150,200,255)

print("JUEGO LISTO")
print("Bote: X=0, Y=51")
print("200 Maderas flotantes")
print("500 Algas")
print("20 Tiburones nocturnos")
print("Sistema día/noche activo")
