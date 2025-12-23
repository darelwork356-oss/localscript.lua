-- LOCAL: UI Épica - Sobrevive 40 Noches
-- Colocar en StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local updateUI = RS:WaitForChild("UpdateUI")
local showNotif = RS:WaitForChild("ShowNotif")

-- UI Principal
local screen = Instance.new("ScreenGui", gui)
screen.Name = "GameUI"
screen.ResetOnSpawn = false
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- CONTADOR DE NOCHES (Centro superior)
local nightFrame = Instance.new("Frame", screen)
nightFrame.Size = UDim2.new(0,400,0,120)
nightFrame.Position = UDim2.new(0.5,-200,0,20)
nightFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
nightFrame.BackgroundTransparency = 0.2
nightFrame.BorderSizePixel = 0

local nightCorner = Instance.new("UICorner", nightFrame)
nightCorner.CornerRadius = UDim.new(0,15)

local nightTitle = Instance.new("TextLabel", nightFrame)
nightTitle.Size = UDim2.new(1,0,0,40)
nightTitle.Position = UDim2.new(0,0,0,10)
nightTitle.BackgroundTransparency = 1
nightTitle.Text = "SOBREVIVE 40 NOCHES"
nightTitle.TextColor3 = Color3.fromRGB(255,255,255)
nightTitle.TextSize = 24
nightTitle.Font = Enum.Font.GothamBold
nightTitle.TextStrokeTransparency = 0.5

local nightCounter = Instance.new("TextLabel", nightFrame)
nightCounter.Size = UDim2.new(1,0,0,60)
nightCounter.Position = UDim2.new(0,0,0,50)
nightCounter.BackgroundTransparency = 1
nightCounter.Text = "NOCHE 0/40"
nightCounter.TextColor3 = Color3.fromRGB(255,200,0)
nightCounter.TextSize = 36
nightCounter.Font = Enum.Font.GothamBold
nightCounter.TextStrokeTransparency = 0

-- TIEMPO (Derecha superior)
local timeFrame = Instance.new("Frame", screen)
timeFrame.Size = UDim2.new(0,250,0,150)
timeFrame.Position = UDim2.new(1,-260,0,20)
timeFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
timeFrame.BackgroundTransparency = 0.2
timeFrame.BorderSizePixel = 0

local timeCorner = Instance.new("UICorner", timeFrame)
timeCorner.CornerRadius = UDim.new(0,15)

local timeIcon = Instance.new("TextLabel", timeFrame)
timeIcon.Size = UDim2.new(0,80,0,80)
timeIcon.Position = UDim2.new(0.5,-40,0,10)
timeIcon.BackgroundTransparency = 1
timeIcon.Text = "☀️"
timeIcon.TextSize = 60
timeIcon.Font = Enum.Font.GothamBold

local timeLabel = Instance.new("TextLabel", timeFrame)
timeLabel.Size = UDim2.new(1,0,0,50)
timeLabel.Position = UDim2.new(0,0,1,-60)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "DÍA: 60s"
timeLabel.TextColor3 = Color3.fromRGB(100,255,100)
timeLabel.TextSize = 28
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextStrokeTransparency = 0

-- RECURSOS (Izquierda superior)
local resFrame = Instance.new("Frame", screen)
resFrame.Size = UDim2.new(0,280,0,200)
resFrame.Position = UDim2.new(0,10,0,20)
resFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
resFrame.BackgroundTransparency = 0.2
resFrame.BorderSizePixel = 0

local resCorner = Instance.new("UICorner", resFrame)
resCorner.CornerRadius = UDim.new(0,15)

local resTitle = Instance.new("TextLabel", resFrame)
resTitle.Size = UDim2.new(1,0,0,40)
resTitle.BackgroundTransparency = 1
resTitle.Text = "📦 RECURSOS"
resTitle.TextColor3 = Color3.fromRGB(255,255,255)
resTitle.TextSize = 22
resTitle.Font = Enum.Font.GothamBold

local maderaLabel = Instance.new("TextLabel", resFrame)
maderaLabel.Size = UDim2.new(1,-20,0,35)
maderaLabel.Position = UDim2.new(0,10,0,50)
maderaLabel.BackgroundTransparency = 1
maderaLabel.Text = "🪵 Madera: 0"
maderaLabel.TextColor3 = Color3.fromRGB(255,255,255)
maderaLabel.TextSize = 20
maderaLabel.Font = Enum.Font.Gotham
maderaLabel.TextXAlignment = Enum.TextXAlignment.Left

local algasLabel = Instance.new("TextLabel", resFrame)
algasLabel.Size = UDim2.new(1,-20,0,35)
algasLabel.Position = UDim2.new(0,10,0,90)
algasLabel.BackgroundTransparency = 1
algasLabel.Text = "🌿 Algas: 0"
algasLabel.TextColor3 = Color3.fromRGB(255,255,255)
algasLabel.TextSize = 20
algasLabel.Font = Enum.Font.Gotham
algasLabel.TextXAlignment = Enum.TextXAlignment.Left

-- NOTIFICACIONES
local notifFrame = Instance.new("Frame", screen)
notifFrame.Size = UDim2.new(0,350,0,100)
notifFrame.Position = UDim2.new(0.5,-175,0,200)
notifFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
notifFrame.BackgroundTransparency = 1
notifFrame.BorderSizePixel = 0
notifFrame.Visible = false

local notifCorner = Instance.new("UICorner", notifFrame)
notifCorner.CornerRadius = UDim.new(0,20)

local notifText = Instance.new("TextLabel", notifFrame)
notifText.Size = UDim2.new(1,0,1,0)
notifText.BackgroundTransparency = 1
notifText.TextColor3 = Color3.fromRGB(255,255,255)
notifText.TextSize = 32
notifText.Font = Enum.Font.GothamBold
notifText.TextStrokeTransparency = 0

-- ADVERTENCIA NOCHE
local warningFrame = Instance.new("Frame", screen)
warningFrame.Size = UDim2.new(1,0,0,150)
warningFrame.Position = UDim2.new(0,0,0.5,-75)
warningFrame.BackgroundTransparency = 1
warningFrame.Visible = false

local warningText = Instance.new("TextLabel", warningFrame)
warningText.Size = UDim2.new(1,0,1,0)
warningText.BackgroundTransparency = 1
warningText.Text = "⚠️ NOCHE 1 ⚠️"
warningText.TextColor3 = Color3.fromRGB(255,50,50)
warningText.TextSize = 72
warningText.Font = Enum.Font.GothamBold
warningText.TextStrokeTransparency = 0

-- Actualizar UI
updateUI.OnClientEvent:Connect(function()
    local stats = player:FindFirstChild("Stats")
    if stats then
        local madera = stats:FindFirstChild("Madera")
        local algas = stats:FindFirstChild("Algas")
        
        if madera then
            maderaLabel.Text = "🪵 Madera: "..madera.Value
            maderaLabel.TextColor3 = madera.Value > 0 and Color3.fromRGB(100,255,100) or Color3.fromRGB(150,150,150)
        end
        
        if algas then
            algasLabel.Text = "🌿 Algas: "..algas.Value
            algasLabel.TextColor3 = algas.Value > 0 and Color3.fromRGB(100,255,100) or Color3.fromRGB(150,150,150)
        end
    end
    
    -- Actualizar noche
    local night = _G.CurrentNight or 0
    local isNight = _G.IsNight or false
    local timeLeft = _G.TimeRemaining or 60
    
    nightCounter.Text = "NOCHE "..night.."/40"
    
    if night >= 40 then
        nightCounter.Text = "¡VICTORIA!"
        nightCounter.TextColor3 = Color3.fromRGB(0,255,0)
    elseif night >= 30 then
        nightCounter.TextColor3 = Color3.fromRGB(255,100,100)
    elseif night >= 20 then
        nightCounter.TextColor3 = Color3.fromRGB(255,150,100)
    else
        nightCounter.TextColor3 = Color3.fromRGB(255,200,0)
    end
    
    if isNight then
        timeIcon.Text = "🌙"
        timeIcon.TextColor3 = Color3.fromRGB(200,200,255)
        timeLabel.Text = "NOCHE: "..timeLeft.."s"
        timeLabel.TextColor3 = Color3.fromRGB(255,100,100)
        timeFrame.BackgroundColor3 = Color3.fromRGB(20,20,40)
        
        if timeLeft == 60 then
            warningText.Text = "⚠️ NOCHE "..night.." ⚠️"
            warningFrame.Visible = true
            
            task.spawn(function()
                for i = 1, 15 do
                    warningText.TextTransparency = 0
                    wait(0.15)
                    warningText.TextTransparency = 0.5
                    wait(0.15)
                end
                warningFrame.Visible = false
            end)
        end
    else
        timeIcon.Text = "☀️"
        timeIcon.TextColor3 = Color3.fromRGB(255,255,100)
        timeLabel.Text = "DÍA: "..timeLeft.."s"
        timeLabel.TextColor3 = Color3.fromRGB(100,255,100)
        timeFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end
    
    -- Animación pulso
    timeIcon:TweenSize(UDim2.new(0,90,0,90), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.3, true, function()
        timeIcon:TweenSize(UDim2.new(0,80,0,80), Enum.EasingDirection.In, Enum.EasingStyle.Elastic, 0.3, true)
    end)
end)

-- Notificaciones
showNotif.OnClientEvent:Connect(function(text)
    notifText.Text = text
    notifFrame.Visible = true
    notifFrame.BackgroundTransparency = 0.2
    
    notifFrame:TweenPosition(UDim2.new(0.5,-175,0,220), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)
    
    wait(2)
    
    notifFrame:TweenPosition(UDim2.new(0.5,-175,0,200), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.4, true, function()
        notifFrame.Visible = false
        notifFrame.BackgroundTransparency = 1
    end)
end)

-- Actualizar cada segundo
task.spawn(function()
    while true do
        updateUI:FireServer()
        wait(1)
    end
end)

print("✅ UI LISTA")
