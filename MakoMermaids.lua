-- SOBREVIVE 40 NOCHES EN EL BOTE
-- Colocar en: ServerScriptService
-- Presiona F5 para jugar

print("🌊 Iniciando juego...")
wait(1)

-- Limpiar todo
for _, obj in pairs(workspace:GetChildren()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
        obj:Destroy()
    end
end

for _, obj in pairs(game.Lighting:GetChildren()) do
    obj:Destroy()
end

-- Océano
local terrain = workspace.Terrain
terrain:Clear()
terrain:FillRegion(Region3.new(Vector3.new(-2000,0,-2000), Vector3.new(2000,50,2000)):ExpandToGrid(4), 4, Enum.Material.Water)
terrain:FillRegion(Region3.new(Vector3.new(-2000,-20,-2000), Vector3.new(2000,0,2000)):ExpandToGrid(4), 4, Enum.Material.Sand)

print("✅ Océano creado")

-- Bote
local raft = Instance.new("Model", workspace)
raft.Name = "Raft"

local base = Instance.new("Part", raft)
base.Size = Vector3.new(30,2,30)
base.Position = Vector3.new(0,51,0)
base.Anchored = true
base.Material = Enum.Material.Wood
base.Color = Color3.fromRGB(101,67,33)

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

for i = 1, 15 do
    local plank = Instance.new("Part", raft)
    plank.Size = Vector3.new(30,0.3,1.8)
    plank.Position = Vector3.new(0,52.2,-13.5+i*1.8)
    plank.Anchored = true
    plank.Material = Enum.Material.WoodPlanks
    plank.Color = Color3.fromRGB(140,100,70)
end

local spawn = Instance.new("SpawnLocation", raft)
spawn.Size = Vector3.new(8,0.5,8)
spawn.Position = Vector3.new(0,52.5,0)
spawn.Anchored = true
spawn.Transparency = 0.7
spawn.CanCollide = false
spawn.Duration = 0

print("✅ Bote creado")

-- Fogata
local fire = Instance.new("Part", raft)
fire.Size = Vector3.new(4,6,4)
fire.Position = Vector3.new(0,56,0)
fire.Anchored = true
fire.CanCollide = false
fire.Material = Enum.Material.Neon
fire.Color = Color3.fromRGB(255,100,0)
fire.Transparency = 0.2

local light = Instance.new("PointLight", fire)
light.Color = Color3.fromRGB(255,150,0)
light.Brightness = 8
light.Range = 60

task.spawn(function()
    while fire and fire.Parent do
        fire.Size = Vector3.new(4+math.random(-8,8)/10, 6+math.random(-10,10)/10, 4+math.random(-8,8)/10)
        fire.Color = Color3.fromRGB(255, math.random(80,150), math.random(0,30))
        light.Brightness = 7+math.random(0,20)/10
        wait(0.08)
    end
end)

print("✅ Fogata creada")

-- Maderas
local woods = Instance.new("Folder", workspace)
woods.Name = "Woods"

for i = 1, 100 do
    local wood = Instance.new("Part", woods)
    wood.Name = "Wood"
    wood.Size = Vector3.new(2,2,6)
    wood.Position = Vector3.new(math.random(-1000,1000), 49, math.random(-1000,1000))
    wood.Anchored = true
    wood.Material = Enum.Material.Wood
    wood.Color = Color3.fromRGB(120,80,50)
    wood.Shape = Enum.PartType.Cylinder
    
    local h = Instance.new("Highlight", wood)
    h.FillColor = Color3.fromRGB(150,100,50)
    h.OutlineColor = Color3.fromRGB(255,200,100)
    h.FillTransparency = 0.5
    
    local p = Instance.new("ProximityPrompt", wood)
    p.ActionText = "Recoger"
    p.ObjectText = "🪵 Madera"
    p.HoldDuration = 0.3
    p.MaxActivationDistance = 12
end

print("✅ 100 maderas creadas")

-- Sistema
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(0.5)
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 25
        end
        
        local stats = Instance.new("Folder", player)
        stats.Name = "leaderstats"
        
        local madera = Instance.new("IntValue", stats)
        madera.Name = "Madera"
        madera.Value = 0
    end)
end)

for _, wood in pairs(woods:GetChildren()) do
    local p = wood:FindFirstChild("ProximityPrompt")
    if p then
        p.Triggered:Connect(function(player)
            local stats = player:FindFirstChild("leaderstats")
            if stats then
                local madera = stats:FindFirstChild("Madera")
                if madera then
                    madera.Value = madera.Value + 1
                end
            end
            wood:Destroy()
        end)
    end
end

print("✅ Sistema de recursos listo")

-- Iluminación
local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(100,150,200)
Lighting.Brightness = 2
Lighting.ClockTime = 12
Lighting.FogEnd = 1000

local atmos = Instance.new("Atmosphere", Lighting)
atmos.Density = 0.3
atmos.Color = Color3.fromRGB(150,200,255)

print("✅ Iluminación configurada")

print("")
print("🎉 ═══════════════════════════════")
print("✅ JUEGO LISTO")
print("═══════════════════════════════")
print("🛟 Bote en X=0, Y=51, Z=0")
print("🔥 Fogata animada")
print("🪵 100 maderas flotantes")
print("🏊 Velocidad: 25 studs/s")
print("═══════════════════════════════")
print("Presiona F5 si no ves nada")
print("")
