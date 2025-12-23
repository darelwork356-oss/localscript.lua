--[[
🎮 LOBBY DE SUPERVIVENCIA - LOCAL SCRIPT
Colocar en: StarterPlayer > StarterPlayerScripts
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Esperar RemoteEvents
local remoteFolder = ReplicatedStorage:WaitForChild("LobbyRemotes")
local updateTimerEvent = remoteFolder:WaitForChild("UpdateTimer")
local teleportEvent = remoteFolder:WaitForChild("TeleportToGame")

-- ========================================
-- CREAR CRONÓMETRO ARRIBA DEL JUGADOR
-- ========================================
local timerGui = nil

local function createTimerAbovePlayer()
    if timerGui then timerGui:Destroy() end
    
    -- BillboardGui que sigue al jugador
    timerGui = Instance.new("BillboardGui")
    timerGui.Name = "CountdownTimer"
    timerGui.Size = UDim2.fromScale(6, 3)
    timerGui.StudsOffset = Vector3.new(0, 4, 0)  -- ARRIBA del jugador
    timerGui.AlwaysOnTop = true
    timerGui.Parent = humanoidRootPart
    
    -- Fondo del cronómetro
    local background = Instance.new("Frame")
    background.Size = UDim2.fromScale(1, 1)
    background.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Parent = timerGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.2, 0)
    corner.Parent = background
    
    -- Borde brillante
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(50, 255, 150)
    border.Thickness = 4
    border.Transparency = 0
    border.Parent = background
    
    -- Texto del tiempo
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Size = UDim2.fromScale(1, 0.6)
    timeLabel.Position = UDim2.fromScale(0, 0.2)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "20"
    timeLabel.Font = Enum.Font.GothamBlack
    timeLabel.TextSize = 80
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.TextStrokeTransparency = 0
    timeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    timeLabel.Parent = background
    
    -- Texto "segundos"
    local secondsLabel = Instance.new("TextLabel")
    secondsLabel.Size = UDim2.fromScale(1, 0.2)
    secondsLabel.Position = UDim2.fromScale(0, 0.75)
    secondsLabel.BackgroundTransparency = 1
    secondsLabel.Text = "SEGUNDOS"
    secondsLabel.Font = Enum.Font.GothamBold
    secondsLabel.TextSize = 24
    secondsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    secondsLabel.TextStrokeTransparency = 0.5
    secondsLabel.Parent = background
    
    -- Efecto de partículas alrededor del cronómetro
    local particleAttachment = Instance.new("Attachment")
    particleAttachment.Position = Vector3.new(0, 4, 0)
    particleAttachment.Parent = humanoidRootPart
    
    local particles = Instance.new("ParticleEmitter")
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Rate = 15
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(2, 4)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Size = NumberSequence.new(0.5, 0)
    particles.Transparency = NumberSequence.new(0, 1)
    particles.Color = ColorSequence.new(Color3.fromRGB(50, 255, 150))
    particles.LightEmission = 1
    particles.Parent = particleAttachment
    
    return timeLabel, border, particleAttachment
end

-- ========================================
-- ACTUALIZAR CRONÓMETRO
-- ========================================
updateTimerEvent.OnClientEvent:Connect(function(timeLeft)
    if not timerGui then
        local timeLabel, border, particleAttachment = createTimerAbovePlayer()
        
        -- Guardar referencias
        timerGui.TimeLabel = timeLabel
        timerGui.Border = border
        timerGui.ParticleAttachment = particleAttachment
    end
    
    local timeLabel = timerGui:FindFirstChild("TimeLabel", true)
    local border = timerGui:FindFirstChild("UIStroke", true)
    
    if timeLabel then
        timeLabel.Text = tostring(timeLeft)
        
        -- Cambiar color según el tiempo
        if timeLeft <= 5 then
            timeLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            if border then
                border.Color = Color3.fromRGB(255, 50, 50)
            end
            
            -- Efecto de pulso rápido
            TweenService:Create(
                timeLabel,
                TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, true),
                {TextSize = 90}
            ):Play()
        elseif timeLeft <= 10 then
            timeLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
            if border then
                border.Color = Color3.fromRGB(255, 200, 50)
            end
        else
            timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            if border then
                border.Color = Color3.fromRGB(50, 255, 150)
            end
        end
        
        -- Animación de escala
        timeLabel.TextSize = 80
        TweenService:Create(
            timeLabel,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {TextSize = 100}
        ):Play()
        
        task.wait(0.3)
        TweenService:Create(
            timeLabel,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {TextSize = 80}
        ):Play()
    end
    
    -- Cuando llega a 0
    if timeLeft == 0 then
        if timeLabel then
            timeLabel.Text = "¡VAMOS!"
            timeLabel.TextColor3 = Color3.fromRGB(50, 255, 150)
            timeLabel.TextSize = 70
        end
        
        task.wait(2)
        if timerGui then
            timerGui:Destroy()
            timerGui = nil
        end
    end
end)

-- ========================================
-- TELETRANSPORTE
-- ========================================
teleportEvent.OnClientEvent:Connect(function()
    print("📍 Teletransportando al juego...")
    
    -- Efecto de flash
    local screenGui = Instance.new("ScreenGui")
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local flash = Instance.new("Frame")
    flash.Size = UDim2.fromScale(1, 1)
    flash.BackgroundColor3 = Color3.fromRGB(50, 255, 150)
    flash.BackgroundTransparency = 1
    flash.Parent = screenGui
    
    TweenService:Create(
        flash,
        TweenInfo.new(0.5),
        {BackgroundTransparency = 0}
    ):Play()
    
    task.wait(0.5)
    
    TweenService:Create(
        flash,
        TweenInfo.new(1),
        {BackgroundTransparency = 1}
    ):Play()
    
    task.wait(1)
    screenGui:Destroy()
    
    -- Aquí se teletransportará al mapa del juego
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(0, 50, 100)  -- Posición temporal
    end
end)

-- ========================================
-- LIMPIAR AL MORIR
-- ========================================
character:WaitForChild("Humanoid").Died:Connect(function()
    if timerGui then
        timerGui:Destroy()
        timerGui = nil
    end
end)

-- Actualizar referencias si el personaje reaparece
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    timerGui = nil
end)

print("✅ LocalScript del lobby cargado")
