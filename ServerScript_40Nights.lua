-- SERVER: Sobrevive 40 Noches
print("🌊 Iniciando: SOBREVIVE 40 NOCHES")

workspace:ClearAllChildren()
game.Lighting:ClearAllChildren()

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Valores globales
local _G = {}
_G.CurrentNight = 0
_G.IsNight = false
_G.TimeRemaining = 60

-- Eventos
local updateUI = Instance.new("RemoteEvent", RS)
updateUI.Name = "UpdateUI"

local showNotif = Instance.new("RemoteEvent", RS)
showNotif.Name = "ShowNotif"

-- Océano
local terrain = workspace.Terrain
terrain:Clear()
terrain:FillRegion(Region3.new(Vector3.new(-2000,0,-2000), Vector3.new(2000,50,2000)):ExpandToGrid(4), 4, Enum.Material.Water)
terrain:FillRegion(Region3.new(Vector3.new(-2000,-20,-2000), Vector3.new(2000,0,2000)):ExpandToGrid(4), 4, Enum.Material.Sand)

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
    while fire do
        fire.Size = Vector3.new(4+math.random(-8,8)/10, 6+math.random(-10,10)/10, 4+math.random(-8,8)/10)
        fire.Color = Color3.fromRGB(255, math.random(80,150), math.random(0,30))
        light.Brightness = 7+math.random(0,20)/10
        wait(0.08)
    end
end)

-- Recursos
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

-- Sistema recursos
local function give(player, res, amt)
    local stats = player:FindFirstChild("Stats")
    if not stats then
        stats = Instance.new("Folder", player)
        stats.Name = "Stats"
    end
    
    local r = stats:FindFirstChild(res)
    if not r then
        r = Instance.new("IntValue", stats)
        r.Name = res
        r.Value = 0
    end
    
    r.Value = r.Value + amt
    showNotif:FireClient(player, "+"..amt.." "..res)
    updateUI:FireClient(player)
end

for _, wood in pairs(woods:GetChildren()) do
    wood.ProximityPrompt.Triggered:Connect(function(player)
        give(player, "Madera", 1)
        wood:Destroy()
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid").WalkSpeed = 25
        
        local stats = Instance.new("Folder", player)
        stats.Name = "Stats"
        
        Instance.new("IntValue", stats).Name = "Madera"
        Instance.new("IntValue", stats).Name = "Algas"
        
        updateUI:FireClient(player)
    end)
end)

-- Sistema 40 noches
local Lighting = game:GetService("Lighting")

task.spawn(function()
    while _G.CurrentNight < 40 do
        -- DÍA
        _G.IsNight = false
        _G.TimeRemaining = 60
        
        for i = 1, 60 do
            Lighting.ClockTime = 12
            Lighting.Ambient = Color3.fromRGB(100,150,200)
            Lighting.FogEnd = 1200
            
            _G.TimeRemaining = 60 - i
            updateUI:FireAllClients()
            wait(1)
        end
        
        -- NOCHE
        _G.IsNight = true
        _G.CurrentNight = _G.CurrentNight + 1
        _G.TimeRemaining = 60
        
        for i = 1, 60 do
            Lighting.ClockTime = 0
            Lighting.Ambient = Color3.fromRGB(20,20,40)
            Lighting.FogEnd = 300
            
            _G.TimeRemaining = 60 - i
            updateUI:FireAllClients()
            wait(1)
        end
    end
    
    -- Victoria
    print("¡VICTORIA! 40 NOCHES SOBREVIVIDAS")
end)

print("✅ SERVER LISTO")
