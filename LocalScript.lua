-- LOCAL SCRIPT - Colocar en StarterPlayer > StarterPlayerScripts
print("🎮 Iniciando UI Cliente...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Esperar eventos
local giveResourceEvent = ReplicatedStorage:WaitForChild("GiveResource")
local updateTimeEvent = ReplicatedStorage:WaitForChild("UpdateTime")

-- Crear UI principal
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "GameUI"
screenGui.ResetOnSpawn = false

-- Panel de recursos (esquina superior izquierda)
local resourceFrame = Instance.new("Frame", screenGui)
resourceFrame.Size = UDim2.new(0,250,0,200)
resourceFrame.Position = UDim2.new(0,10,0,10)
resourceFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
resourceFrame.BackgroundTransparency = 0.3
resourceFrame.BorderSizePixel = 0

local resourceCorner = Instance.new("UICorner", resourceFrame)
resourceCorner.CornerRadius = UDim.new(0,10)

local resourceTitle = Instance.new("TextLabel", resourceFrame)
resourceTitle.Size = UDim2.new(1,0,0,30)
resourceTitle.BackgroundTransparency = 1
resourceTitle.Text = "📦 RECURSOS"
resourceTitle.TextColor3 = Color3.fromRGB(255,255,255)
resourceTitle.TextSize = 20
resourceTitle.Font = Enum.Font.GothamBold

-- Recursos individuales
local resources = {"Madera", "Chatarra", "Algas", "MaderaMolida", "MetalMolido"}
local resourceIcons = {"🪵", "⚙️", "🌿", "📦", "🔩"}
local resourceLabels = {}

for i, res in ipairs(resources) do
    local label = Instance.new("TextLabel", resourceFrame)
    label.Size = UDim2.new(1,-20,0,25)
    label.Position = UDim2.new(0,10,0,30+i*30)
    label.BackgroundTransparency = 1
    label.Text = resourceIcons[i].." "..res..": 0"
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 16
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    resourceLabels[res] = label
end

-- Panel de tiempo (esquina superior derecha)
local timeFrame = Instance.new("Frame", screenGui)
timeFrame.Size = UDim2.new(0,200,0,100)
timeFrame.Position = UDim2.new(1,-210,0,10)
timeFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
timeFrame.BackgroundTransparency = 0.3
timeFrame.BorderSizePixel = 0

local timeCorner = Instance.new("UICorner", timeFrame)
timeCorner.CornerRadius = UDim.new(0,10)

-- Icono sol/luna
local timeIcon = Instance.new("TextLabel", timeFrame)
timeIcon.Size = UDim2.new(0,60,0,60)
timeIcon.Position = UDim2.new(0.5,-30,0,5)
timeIcon.BackgroundTransparency = 1
timeIcon.Text = "☀️"
timeIcon.TextColor3 = Color3.fromRGB(255,255,255)
timeIcon.TextSize = 50
timeIcon.Font = Enum.Font.GothamBold

-- Texto de tiempo
local timeLabel = Instance.new("TextLabel", timeFrame)
timeLabel.Size = UDim2.new(1,0,0,30)
timeLabel.Position = UDim2.new(0,0,1,-35)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "DÍA: 60s"
timeLabel.TextColor3 = Color3.fromRGB(255,255,255)
timeLabel.TextSize = 18
timeLabel.Font = Enum.Font.GothamBold

-- Actualizar recursos
local function updateResources()
    local stats = player:FindFirstChild("PlayerStats")
    if stats then
        for res, label in pairs(resourceLabels) do
            local value = stats:FindFirstChild(res)
            if value then
                local icon = resourceIcons[table.find(resources, res)]
                label.Text = icon.." "..res..": "..value.Value
                
                -- Color según cantidad
                if value.Value > 50 then
                    label.TextColor3 = Color3.fromRGB(100,255,100)
                elseif value.Value > 20 then
                    label.TextColor3 = Color3.fromRGB(255,255,100)
                elseif value.Value > 0 then
                    label.TextColor3 = Color3.fromRGB(255,255,255)
                else
                    label.TextColor3 = Color3.fromRGB(150,150,150)
                end
            end
        end
    end
end

-- Monitorear cambios en recursos
player.ChildAdded:Connect(function(child)
    if child.Name == "PlayerStats" then
        for _, res in pairs(child:GetChildren()) do
            res.Changed:Connect(updateResources)
        end
        child.ChildAdded:Connect(function(res)
            res.Changed:Connect(updateResources)
        end)
        updateResources()
    end
end)

-- Notificaciones de recolección
local notificationFrame = Instance.new("Frame", screenGui)
notificationFrame.Size = UDim2.new(0,300,0,80)
notificationFrame.Position = UDim2.new(0.5,-150,0,100)
notificationFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
notificationFrame.BackgroundTransparency = 1
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false

local notifCorner = Instance.new("UICorner", notificationFrame)
notifCorner.CornerRadius = UDim.new(0,15)

local notifText = Instance.new("TextLabel", notificationFrame)
notifText.Size = UDim2.new(1,0,1,0)
notifText.BackgroundTransparency = 1
notifText.TextColor3 = Color3.fromRGB(255,255,255)
notifText.TextSize = 24
notifText.Font = Enum.Font.GothamBold
notifText.TextStrokeTransparency = 0.5

giveResourceEvent.OnClientEvent:Connect(function(resource, amount)
    local icon = resourceIcons[table.find(resources, resource)] or "📦"
    notifText.Text = "+"..amount.." "..icon.." "..resource
    notificationFrame.Visible = true
    notificationFrame.BackgroundTransparency = 0.2
    
    -- Animación
    notificationFrame:TweenPosition(
        UDim2.new(0.5,-150,0,120),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Back,
        0.3,
        true
    )
    
    wait(2)
    
    notificationFrame:TweenPosition(
        UDim2.new(0.5,-150,0,100),
        Enum.EasingDirection.In,
        Enum.EasingStyle.Back,
        0.3,
        true,
        function()
            notificationFrame.Visible = false
            notificationFrame.BackgroundTransparency = 1
        end
    )
    
    updateResources()
end)

-- Actualizar tiempo día/noche
updateTimeEvent.OnClientEvent:Connect(function(isNight, timeLeft)
    if isNight then
        timeIcon.Text = "🌙"
        timeIcon.TextColor3 = Color3.fromRGB(200,200,255)
        timeLabel.Text = "NOCHE: "..timeLeft.."s"
        timeLabel.TextColor3 = Color3.fromRGB(255,100,100)
        timeFrame.BackgroundColor3 = Color3.fromRGB(20,20,40)
    else
        timeIcon.Text = "☀️"
        timeIcon.TextColor3 = Color3.fromRGB(255,255,100)
        timeLabel.Text = "DÍA: "..timeLeft.."s"
        timeLabel.TextColor3 = Color3.fromRGB(100,255,100)
        timeFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end
    
    -- Animación de pulso
    timeIcon:TweenSize(
        UDim2.new(0,70,0,70),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Elastic,
        0.3,
        true,
        function()
            timeIcon:TweenSize(
                UDim2.new(0,60,0,60),
                Enum.EasingDirection.In,
                Enum.EasingStyle.Elastic,
                0.3,
                true
            )
        end
    )
end)

-- Advertencia de noche
local warningLabel = Instance.new("TextLabel", screenGui)
warningLabel.Size = UDim2.new(0,400,0,60)
warningLabel.Position = UDim2.new(0.5,-200,0.5,-30)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = ""
warningLabel.TextColor3 = Color3.fromRGB(255,50,50)
warningLabel.TextSize = 36
warningLabel.Font = Enum.Font.GothamBold
warningLabel.TextStrokeTransparency = 0
warningLabel.Visible = false

updateTimeEvent.OnClientEvent:Connect(function(isNight, timeLeft)
    if isNight and timeLeft == 60 then
        warningLabel.Text = "⚠️ ¡ES DE NOCHE! ⚠️"
        warningLabel.Visible = true
        
        task.spawn(function()
            for i = 1, 10 do
                warningLabel.TextTransparency = 0
                wait(0.2)
                warningLabel.TextTransparency = 0.5
                wait(0.2)
            end
            warningLabel.Visible = false
        end)
    end
end)

print("✅ UI LISTA")
