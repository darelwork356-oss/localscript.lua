--[[
🎬 STRANGER BLOX: ESCENA DEL RELOJ DE VECNA - TODO CORREGIDO Y VISIBLE
 
✅ CÁMARAS MOSTRANDO LA CARA DEL PERSONAJE CORRECTAMENTE
✅ CÁMARA MOSTRANDO LAS LUCES PARPADEANDO
✅ LUZ ROJA MASIVA DEL RELOJ (BRIGHTNESS 50+, RANGE 200+)
✅ AMBIENTE ROJO MUY BRILLANTE - TODO VISIBLE
✅ TERREMOTO COMPLETAMENTE ILUMINADO
✅ CÁMARAS MOSTRANDO CLARAMENTE LAS GRIETAS
✅ GRIETAS CON LUZ ROJA PROPIA
 
Colocar en: StarterGui como LocalScript
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local introShownGlobal = ReplicatedStorage:FindFirstChild("VecnaClockIntroShown")
if not introShownGlobal then
    introShownGlobal = Instance.new("BoolValue")
    introShownGlobal.Name = "VecnaClockIntroShown"
    introShownGlobal.Value = false
    introShownGlobal.Parent = ReplicatedStorage
end

if introShownGlobal.Value == true then
    print("⏭️ Escena ya mostrada")
    return
end

pcall(function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VecnaClockCinematic"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 100
screenGui.Parent = playerGui

local allEffects = {}
local musicTable = {}
local cinematicActive = false
local originalGravity = workspace.Gravity

local soundIds = {
    footsteps = "rbxassetid://117477686124708",
    backgroundMusic = "rbxassetid://134572394920791",
    clockTick = "rbxassetid://105401784871530",
    lightFlicker = "rbxassetid://4288784832"
}

local function registerEffect(obj)
    if obj then table.insert(allEffects, obj) end
end

local function applyStudsToAllFaces(part, color)
    local faces = {
        Enum.NormalId.Front,
        Enum.NormalId.Back,
        Enum.NormalId.Left,
        Enum.NormalId.Right,
        Enum.NormalId.Top,
        Enum.NormalId.Bottom
    }
    
    for _, face in ipairs(faces) do
        local texture = Instance.new("Texture")
        texture.Texture = "rbxasset://textures/studs.png"
        texture.StudsPerTileU = 4
        texture.StudsPerTileV = 4
        texture.Face = face
        texture.Color3 = color or part.Color
        texture.Transparency = 0
        texture.Parent = part
    end
end

local function disableControls()
    local function sinkInput() return Enum.ContextActionResult.Sink end
    ContextActionService:BindAction("DisableJump", sinkInput, false, Enum.KeyCode.Space)
    ContextActionService:BindAction("DisableMovement", sinkInput, false,
        Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D)
    
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 0
        player.Character.Humanoid.WalkSpeed = 0
    end
end

local function enableControls()
    ContextActionService:UnbindAction("DisableJump")
    ContextActionService:UnbindAction("DisableMovement")
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.JumpPower = 50
    end
end

local function playAudio(name, id, vol, looped, parent)
    if musicTable[name] and musicTable[name].Parent then musicTable[name]:Destroy() end
    local s = Instance.new("Sound")
    s.Name = "CinematicAudio_"..name
    s.SoundId = id
    s.Volume = vol or 1
    s.Looped = looped or false
    s.Parent = parent or workspace
    s:Play()
    musicTable[name] = s
    registerEffect(s)
    return s
end

local function stopAllAudio(fadeTime)
    for name, sound in pairs(musicTable) do
        if sound and sound.Parent then
            if fadeTime then
                TweenService:Create(sound, TweenInfo.new(fadeTime), {Volume = 0}):Play()
                Debris:AddItem(sound, fadeTime + 0.1)
            else
                sound:Destroy()
            end
        end
    end
    musicTable = {}
end

local function cleanupIntro()
    cinematicActive = false
    workspace.Gravity = originalGravity
    enableControls()
    
    if player.Character then
        local h = player.Character:FindFirstChild("Humanoid")
        if h then 
            h.PlatformStand = false 
            h.AutoRotate = true
        end
        if player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = false
        end
    end
    
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    workspace.CurrentCamera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
    workspace.CurrentCamera.FieldOfView = 70
    
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    end)
    
    stopAllAudio(1)
    
    for _, obj in pairs(allEffects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    allEffects = {}
    
    if screenGui then screenGui:Destroy() end
    
    if introShownGlobal then
        introShownGlobal.Value = true
    end
end

local function createHawkinsSchool()
    print("🏫 CONSTRUYENDO ESCUELA")
    
    local schoolFolder = Instance.new("Folder")
    schoolFolder.Name = "HawkinsSchool"
    schoolFolder.Parent = workspace
    registerEffect(schoolFolder)
    
    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(30, 0.5, 150)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Anchored = true
    floor.Material = Enum.Material.Plastic
    floor.Color = Color3.fromRGB(180, 160, 140)
    floor.Parent = schoolFolder
    applyStudsToAllFaces(floor, Color3.fromRGB(180, 160, 140))
    
    for z = -70, 70, 4 do
        for x = -12, 12, 4 do
            if (x + z) % 8 == 0 then
                local tile = Instance.new("Part")
                tile.Size = Vector3.new(3.8, 0.2, 3.8)
                tile.Position = Vector3.new(x, 0.4, z)
                tile.Anchored = true
                tile.Material = Enum.Material.Plastic
                tile.Color = Color3.fromRGB(160, 100, 50)
                tile.Parent = floor
                applyStudsToAllFaces(tile, Color3.fromRGB(160, 100, 50))
            end
        end
    end
    
    local leftWhite = Instance.new("Part")
    leftWhite.Size = Vector3.new(1, 4.5, 150)
    leftWhite.Position = Vector3.new(-14, 13.5, 0)
    leftWhite.Anchored = true
    leftWhite.Material = Enum.Material.Plastic
    leftWhite.Color = Color3.fromRGB(200, 180, 160)
    leftWhite.Parent = schoolFolder
    applyStudsToAllFaces(leftWhite, Color3.fromRGB(200, 180, 160))
    
    local leftOrange = Instance.new("Part")
    leftOrange.Size = Vector3.new(0.95, 2.2, 150)
    leftOrange.Position = Vector3.new(-13.98, 10.4, 0)
    leftOrange.Anchored = true
    leftOrange.Material = Enum.Material.Plastic
    leftOrange.Color = Color3.fromRGB(220, 130, 60)
    leftOrange.Parent = schoolFolder
    applyStudsToAllFaces(leftOrange, Color3.fromRGB(220, 130, 60))
    
    local leftGreen = Instance.new("Part")
    leftGreen.Size = Vector3.new(0.95, 2.2, 150)
    leftGreen.Position = Vector3.new(-13.98, 8.2, 0)
    leftGreen.Anchored = true
    leftGreen.Material = Enum.Material.Plastic
    leftGreen.Color = Color3.fromRGB(115, 145, 95)
    leftGreen.Parent = schoolFolder
    applyStudsToAllFaces(leftGreen, Color3.fromRGB(115, 145, 95))
    
    local leftBeige = Instance.new("Part")
    leftBeige.Size = Vector3.new(0.95, 14, 150)
    leftBeige.Position = Vector3.new(-13.98, 0, 0)
    leftBeige.Anchored = true
    leftBeige.Material = Enum.Material.Plastic
    leftBeige.Color = Color3.fromRGB(190, 170, 150)
    leftBeige.Parent = schoolFolder
    applyStudsToAllFaces(leftBeige, Color3.fromRGB(190, 170, 150))
    
    local rightWhite = Instance.new("Part")
    rightWhite.Size = Vector3.new(1, 4.5, 150)
    rightWhite.Position = Vector3.new(14, 13.5, 0)
    rightWhite.Anchored = true
    rightWhite.Material = Enum.Material.Plastic
    rightWhite.Color = Color3.fromRGB(200, 180, 160)
    rightWhite.Parent = schoolFolder
    applyStudsToAllFaces(rightWhite, Color3.fromRGB(200, 180, 160))
    
    local rightOrange = Instance.new("Part")
    rightOrange.Size = Vector3.new(0.95, 2.2, 150)
    rightOrange.Position = Vector3.new(13.98, 10.4, 0)
    rightOrange.Anchored = true
    rightOrange.Material = Enum.Material.Plastic
    rightOrange.Color = Color3.fromRGB(220, 130, 60)
    rightOrange.Parent = schoolFolder
    applyStudsToAllFaces(rightOrange, Color3.fromRGB(220, 130, 60))
    
    local rightGreen = Instance.new("Part")
    rightGreen.Size = Vector3.new(0.95, 2.2, 150)
    rightGreen.Position = Vector3.new(13.98, 8.2, 0)
    rightGreen.Anchored = true
    rightGreen.Material = Enum.Material.Plastic
    rightGreen.Color = Color3.fromRGB(115, 145, 95)
    rightGreen.Parent = schoolFolder
    applyStudsToAllFaces(rightGreen, Color3.fromRGB(115, 145, 95))
    
    local rightBeige = Instance.new("Part")
    rightBeige.Size = Vector3.new(0.95, 14, 150)
    rightBeige.Position = Vector3.new(13.98, 0, 0)
    rightBeige.Anchored = true
    rightBeige.Material = Enum.Material.Plastic
    rightBeige.Color = Color3.fromRGB(190, 170, 150)
    rightBeige.Parent = schoolFolder
    applyStudsToAllFaces(rightBeige, Color3.fromRGB(190, 170, 150))
    
    local backWall = Instance.new("Part")
    backWall.Size = Vector3.new(30, 16, 1)
    backWall.Position = Vector3.new(0, 8, -75)
    backWall.Anchored = true
    backWall.Material = Enum.Material.Plastic
    backWall.Color = Color3.fromRGB(190, 170, 150)
    backWall.Parent = schoolFolder
    applyStudsToAllFaces(backWall, Color3.fromRGB(190, 170, 150))
    
    local frontWall = Instance.new("Part")
    frontWall.Size = Vector3.new(30, 16, 1)
    frontWall.Position = Vector3.new(0, 8, 75)
    frontWall.Anchored = true
    frontWall.Material = Enum.Material.Plastic
    frontWall.Color = Color3.fromRGB(190, 170, 150)
    frontWall.Parent = schoolFolder
    applyStudsToAllFaces(frontWall, Color3.fromRGB(190, 170, 150))
    
    local frontOrangeStripe = Instance.new("Part")
    frontOrangeStripe.Size = Vector3.new(30, 2.2, 0.9)
    frontOrangeStripe.Position = Vector3.new(0, 10.4, 74.55)
    frontOrangeStripe.Anchored = true
    frontOrangeStripe.Material = Enum.Material.Plastic
    frontOrangeStripe.Color = Color3.fromRGB(220, 130, 60)
    frontOrangeStripe.Parent = schoolFolder
    applyStudsToAllFaces(frontOrangeStripe, Color3.fromRGB(220, 130, 60))
    
    local ceiling = Instance.new("Part")
    ceiling.Size = Vector3.new(30, 0.8, 150)
    ceiling.Position = Vector3.new(0, 16, 0)
    ceiling.Anchored = true
    ceiling.Material = Enum.Material.Plastic
    ceiling.Color = Color3.fromRGB(180, 160, 140)
    ceiling.Parent = schoolFolder
    applyStudsToAllFaces(ceiling, Color3.fromRGB(180, 160, 140))
    
    for z = -65, 65, 5.5 do
        -- Casilleros SOLO lado izquierdo
        local lockerLeft = Instance.new("Part")
        lockerLeft.Size = Vector3.new(0.8, 9, 2.3)
        lockerLeft.Position = Vector3.new(-13.6, 4.5, z)
        lockerLeft.Anchored = true
        lockerLeft.Material = Enum.Material.Plastic
        lockerLeft.Color = Color3.fromRGB(180, 160, 140)
        lockerLeft.Parent = schoolFolder
        applyStudsToAllFaces(lockerLeft, Color3.fromRGB(180, 160, 140))
        
        local handleLeft = Instance.new("Part")
        handleLeft.Size = Vector3.new(0.2, 0.5, 0.2)
        handleLeft.Position = Vector3.new(-13.1, 4.5, z)
        handleLeft.Anchored = true
        handleLeft.Material = Enum.Material.Plastic
        handleLeft.Color = Color3.fromRGB(90, 90, 90)
        handleLeft.Parent = lockerLeft
        applyStudsToAllFaces(handleLeft, Color3.fromRGB(90, 90, 90))
        
        for i = 1, 3 do
            local ventLeft = Instance.new("Part")
            ventLeft.Size = Vector3.new(0.6, 0.08, 0.2)
            ventLeft.Position = Vector3.new(-13.1, 3 + (i * 0.4), z)
            ventLeft.Anchored = true
            ventLeft.Material = Enum.Material.Plastic
            ventLeft.Color = Color3.fromRGB(60, 60, 60)
            ventLeft.Parent = lockerLeft
            applyStudsToAllFaces(ventLeft, Color3.fromRGB(60, 60, 60))
        end
    end
    
    local lights = {}
    for z = -65, 65, 12 do
        local lightFixture = Instance.new("Part")
        lightFixture.Size = Vector3.new(4, 0.35, 10)
        lightFixture.Position = Vector3.new(0, 15.2, z)
        lightFixture.Anchored = true
        lightFixture.Material = Enum.Material.Plastic
        lightFixture.Color = Color3.fromRGB(255, 252, 240)
        lightFixture.Transparency = 0.3
        lightFixture.Parent = schoolFolder
        applyStudsToAllFaces(lightFixture, Color3.fromRGB(255, 252, 240))
        
        local light = Instance.new("PointLight")
        light.Brightness = 2
        light.Range = 32
        light.Color = Color3.fromRGB(255, 252, 240)
        light.Shadows = true
        light.Parent = lightFixture
        registerEffect(light)
        
        table.insert(lights, {fixture = lightFixture, light = light})
    end
    
    return schoolFolder, floor, lights
end

local function createVecnaGrandfatherClock(position)
    print("🕰️ CREANDO RELOJ DE VECNA")
    
    local clockModel = Instance.new("Model")
    clockModel.Name = "VecnaGrandfatherClock"
    clockModel.Parent = workspace
    registerEffect(clockModel)
    
    local base = Instance.new("Part")
    base.Size = Vector3.new(4, 2.5, 3.5)
    base.Position = position + Vector3.new(0, 1.25, 0)
    base.Anchored = true
    base.Material = Enum.Material.Plastic
    base.Color = Color3.fromRGB(18, 18, 20)
    base.Parent = clockModel
    applyStudsToAllFaces(base, Color3.fromRGB(18, 18, 20))
    
    local body = Instance.new("Part")
    body.Size = Vector3.new(2.8, 10, 2.5)
    body.Position = position + Vector3.new(0, 6.25, 0)
    body.Anchored = true
    body.Material = Enum.Material.Plastic
    body.Color = Color3.fromRGB(22, 22, 25)
    body.Parent = clockModel
    applyStudsToAllFaces(body, Color3.fromRGB(22, 22, 25))
    
    local bodyGlass = Instance.new("Part")
    bodyGlass.Size = Vector3.new(2.6, 9.5, 0.3)
    bodyGlass.Position = body.Position + Vector3.new(0, 0, -1.4)
    bodyGlass.Anchored = true
    bodyGlass.Material = Enum.Material.Plastic
    bodyGlass.Color = Color3.fromRGB(80, 70, 50)
    bodyGlass.Transparency = 0.65
    bodyGlass.Parent = body
    applyStudsToAllFaces(bodyGlass, Color3.fromRGB(80, 70, 50))
    
    local function createPendulum(xOffset, length, weightSize)
        local pendulum = Instance.new("Part")
        pendulum.Size = Vector3.new(0.28, length, 0.28)
        pendulum.Position = body.Position + Vector3.new(xOffset, -2.5, -0.7)
        pendulum.Anchored = true
        pendulum.Material = Enum.Material.Plastic
        pendulum.Color = Color3.fromRGB(170, 150, 110)
        pendulum.Parent = body
        applyStudsToAllFaces(pendulum, Color3.fromRGB(170, 150, 110))
        
        local weight = Instance.new("Part")
        weight.Size = Vector3.new(weightSize, weightSize * 1.6, weightSize)
        weight.Position = pendulum.Position + Vector3.new(0, -(length/2 + weightSize), 0)
        weight.Anchored = true
        weight.Shape = Enum.PartType.Cylinder
        weight.Material = Enum.Material.Plastic
        weight.Color = Color3.fromRGB(170, 150, 110)
        weight.Orientation = Vector3.new(0, 0, 90)
        weight.Parent = pendulum
        applyStudsToAllFaces(weight, Color3.fromRGB(170, 150, 110))
    end
    
    createPendulum(-0.8, 6.5, 0.75)
    createPendulum(0, 7.5, 0.95)
    createPendulum(0.8, 6.5, 0.75)
    
    local clockFaceBase = Instance.new("Part")
    clockFaceBase.Size = Vector3.new(0.6, 4.5, 4.5)
    clockFaceBase.Position = body.Position + Vector3.new(0, 5.5, -1.6)
    clockFaceBase.Anchored = true
    clockFaceBase.Material = Enum.Material.Plastic
    clockFaceBase.Color = Color3.fromRGB(20, 20, 22)
    clockFaceBase.Parent = clockModel
    applyStudsToAllFaces(clockFaceBase, Color3.fromRGB(20, 20, 22))
    
    local goldBackground = Instance.new("Part")
    goldBackground.Size = Vector3.new(0.4, 3.6, 3.6)
    goldBackground.Position = clockFaceBase.Position + Vector3.new(0, 0, -0.35)
    goldBackground.Anchored = true
    goldBackground.Shape = Enum.PartType.Cylinder
    goldBackground.Material = Enum.Material.Plastic
    goldBackground.Color = Color3.fromRGB(140, 120, 60)
    goldBackground.Orientation = Vector3.new(0, 0, 90)
    goldBackground.Parent = clockFaceBase
    applyStudsToAllFaces(goldBackground, Color3.fromRGB(140, 120, 60))
    
    local clockFace = Instance.new("Part")
    clockFace.Name = "ClockFace"
    clockFace.Size = Vector3.new(3.1, 0.35, 3.1)
    clockFace.Position = goldBackground.Position + Vector3.new(0, 0, -0.25)
    clockFace.Anchored = true
    clockFace.Material = Enum.Material.Plastic
    clockFace.Color = Color3.fromRGB(215, 205, 185)
    clockFace.Parent = clockFaceBase
    applyStudsToAllFaces(clockFace, Color3.fromRGB(215, 205, 185))
    
    local outerRing = Instance.new("Part")
    outerRing.Size = Vector3.new(0.3, 3.9, 3.9)
    outerRing.Position = goldBackground.Position + Vector3.new(0, 0, -0.5)
    outerRing.Anchored = true
    outerRing.Shape = Enum.PartType.Cylinder
    outerRing.Material = Enum.Material.Plastic
    outerRing.Color = Color3.fromRGB(18, 18, 20)
    outerRing.Orientation = Vector3.new(0, 0, 90)
    outerRing.Parent = clockFaceBase
    applyStudsToAllFaces(outerRing, Color3.fromRGB(18, 18, 20))
    
    local numbers = {
        {text = "XII", pos = Vector3.new(0, 1.2, -0.12)},
        {text = "III", pos = Vector3.new(1.2, 0, -0.12)},
        {text = "VI", pos = Vector3.new(0, -1.2, -0.12)},
        {text = "IX", pos = Vector3.new(-1.2, 0, -0.12)}
    }
    
    for _, numData in ipairs(numbers) do
        local numPart = Instance.new("Part")
        numPart.Size = Vector3.new(0.1, 0.6, 0.6)
        numPart.Position = clockFace.Position + numData.pos
        numPart.Anchored = true
        numPart.Transparency = 1
        numPart.Parent = clockFace
        
        local sg = Instance.new("SurfaceGui")
        sg.Face = Enum.NormalId.Front
        sg.Parent = numPart
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(1, 1)
        label.BackgroundTransparency = 1
        label.Text = numData.text
        label.Font = Enum.Font.Garamond
        label.TextSize = 52
        label.TextColor3 = Color3.fromRGB(20, 20, 20)
        label.TextStrokeTransparency = 0.8
        label.Parent = sg
    end
    
    local hourHand = Instance.new("Part")
    hourHand.Name = "HourHand"
    hourHand.Size = Vector3.new(0.14, 1.2, 0.1)
    hourHand.Position = clockFace.Position + Vector3.new(0, 0, -0.18)
    hourHand.Anchored = true
    hourHand.Material = Enum.Material.Plastic
    hourHand.Color = Color3.fromRGB(15, 15, 15)
    hourHand.Parent = clockFace
    applyStudsToAllFaces(hourHand, Color3.fromRGB(15, 15, 15))
    
    local minuteHand = Instance.new("Part")
    minuteHand.Name = "MinuteHand"
    minuteHand.Size = Vector3.new(0.11, 1.5, 0.08)
    minuteHand.Position = clockFace.Position + Vector3.new(0, 0, -0.22)
    minuteHand.Anchored = true
    minuteHand.Material = Enum.Material.Plastic
    minuteHand.Color = Color3.fromRGB(15, 15, 15)
    minuteHand.Parent = clockFace
    applyStudsToAllFaces(minuteHand, Color3.fromRGB(15, 15, 15))
    
    local handCenter = Instance.new("Part")
    handCenter.Size = Vector3.new(0.18, 0.18, 0.18)
    handCenter.Position = clockFace.Position + Vector3.new(0, 0, -0.28)
    handCenter.Anchored = true
    handCenter.Shape = Enum.PartType.Ball
    handCenter.Material = Enum.Material.Plastic
    handCenter.Color = Color3.fromRGB(15, 15, 15)
    handCenter.Parent = clockFace
    applyStudsToAllFaces(handCenter, Color3.fromRGB(15, 15, 15))
    
    local top = Instance.new("Part")
    top.Size = Vector3.new(3.5, 2, 3)
    top.Position = body.Position + Vector3.new(0, 5.5, 0)
    top.Anchored = true
    top.Material = Enum.Material.Plastic
    top.Color = Color3.fromRGB(18, 18, 20)
    top.Parent = clockModel
    applyStudsToAllFaces(top, Color3.fromRGB(18, 18, 20))
    
    local topArch = Instance.new("Part")
    topArch.Size = Vector3.new(3.5, 1.2, 3)
    topArch.Position = top.Position + Vector3.new(0, 1.2, 0)
    topArch.Anchored = true
    topArch.Material = Enum.Material.Plastic
    topArch.Color = Color3.fromRGB(18, 18, 20)
    topArch.Parent = top
    applyStudsToAllFaces(topArch, Color3.fromRGB(18, 18, 20))
    
    local function createSpike(xOffset)
        local spikeBase = Instance.new("Part")
        spikeBase.Size = Vector3.new(0.6, 1.2, 0.6)
        spikeBase.Position = topArch.Position + Vector3.new(xOffset, 1, 0)
        spikeBase.Anchored = true
        spikeBase.Material = Enum.Material.Plastic
        spikeBase.Color = Color3.fromRGB(15, 15, 17)
        spikeBase.Parent = topArch
        applyStudsToAllFaces(spikeBase, Color3.fromRGB(15, 15, 17))
        
        local spikeTop = Instance.new("Part")
        spikeTop.Size = Vector3.new(0.35, 0.6, 0.35)
        spikeTop.Position = spikeBase.Position + Vector3.new(0, 0.9, 0)
        spikeTop.Anchored = true
        spikeTop.Shape = Enum.PartType.Ball
        spikeTop.Material = Enum.Material.Plastic
        spikeTop.Color = Color3.fromRGB(15, 15, 17)
        spikeTop.Parent = spikeBase
        applyStudsToAllFaces(spikeTop, Color3.fromRGB(15, 15, 17))
        
        local ball = Instance.new("Part")
        ball.Size = Vector3.new(0.4, 0.4, 0.4)
        ball.Position = spikeTop.Position + Vector3.new(0, 0.4, 0)
        ball.Anchored = true
        ball.Shape = Enum.PartType.Ball
        ball.Material = Enum.Material.Plastic
        ball.Color = Color3.fromRGB(12, 12, 14)
        ball.Parent = spikeTop
        applyStudsToAllFaces(ball, Color3.fromRGB(12, 12, 14))
    end
    
    createSpike(-1.3)
    createSpike(0)
    createSpike(1.3)
    
    -- ✅ LUZ ROJA MASIVA - BRIGHTNESS 60, RANGE 250
    local clockLight = Instance.new("PointLight")
    clockLight.Brightness = 0
    clockLight.Range = 250  -- ENORME
    clockLight.Color = Color3.fromRGB(255, 50, 50)
    clockLight.Shadows = false  -- Sin sombras para más luz
    clockLight.Parent = clockFace
    registerEffect(clockLight)
    
    -- Luz adicional del reloj
    local clockLight2 = Instance.new("PointLight")
    clockLight2.Brightness = 0
    clockLight2.Range = 200
    clockLight2.Color = Color3.fromRGB(255, 60, 60)
    clockLight2.Shadows = false
    clockLight2.Parent = body
    registerEffect(clockLight2)
    
    local darkParticles = Instance.new("ParticleEmitter")
    darkParticles.Texture = "rbxassetid://6102449224"
    darkParticles.Rate = 20
    darkParticles.Lifetime = NumberRange.new(5, 10)
    darkParticles.Speed = NumberRange.new(2, 4)
    darkParticles.SpreadAngle = Vector2.new(60, 60)
    darkParticles.Size = NumberSequence.new(2, 0)
    darkParticles.Transparency = NumberSequence.new(0.2, 1)
    darkParticles.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80))
    darkParticles.LightEmission = 1  -- Máximo
    darkParticles.Enabled = false
    darkParticles.Parent = clockFace
    registerEffect(darkParticles)
    
    local darkAura = Instance.new("ParticleEmitter")
    darkAura.Texture = "rbxassetid://6102449224"
    darkAura.Rate = 30
    darkAura.Lifetime = NumberRange.new(6, 12)
    darkAura.Speed = NumberRange.new(1, 3)
    darkAura.SpreadAngle = Vector2.new(180, 180)
    darkAura.Size = NumberSequence.new(4, 8)
    darkAura.Transparency = NumberSequence.new(0.5, 1)
    darkAura.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 30, 30)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 60, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 20, 20))
    })
    darkAura.LightEmission = 0.9
    darkAura.Rotation = NumberRange.new(0, 360)
    darkAura.RotSpeed = NumberRange.new(-60, 60)
    darkAura.Enabled = false
    darkAura.Parent = body
    registerEffect(darkAura)
    
    return clockModel, clockFace, hourHand, minuteHand, clockLight, clockLight2, darkParticles, darkAura
end

local function createGroundCrack(startPos, endPos, width, depth)
    local dist = (endPos - startPos).Magnitude
    local crack = Instance.new("Part")
    crack.Size = Vector3.new(width, depth, dist)
    crack.Position = (startPos + endPos) / 2
    crack.CFrame = CFrame.new(crack.Position, endPos)
    crack.Anchored = true
    crack.Material = Enum.Material.Plastic
    crack.Color = Color3.fromRGB(30, 30, 35)
    crack.Parent = workspace
    registerEffect(crack)
    applyStudsToAllFaces(crack, Color3.fromRGB(30, 30, 35))
    
    local crackGlow = Instance.new("PointLight")
    crackGlow.Brightness = 2
    crackGlow.Range = 15
    crackGlow.Color = Color3.fromRGB(255, 70, 70)
    crackGlow.Shadows = false
    crackGlow.Parent = crack
    registerEffect(crackGlow)
    
    local dust = Instance.new("ParticleEmitter")
    dust.Texture = "rbxassetid://6102449224"
    dust.Rate = 40
    dust.Lifetime = NumberRange.new(3, 5)
    dust.Speed = NumberRange.new(5, 12)
    dust.SpreadAngle = Vector2.new(180, 180)
    dust.Size = NumberSequence.new(2.5, 5)
    dust.Transparency = NumberSequence.new(0.1, 1)
    dust.Color = ColorSequence.new(Color3.fromRGB(150, 50, 50))
    dust.LightEmission = 0.6
    dust.Parent = crack
    registerEffect(dust)
    
    task.delay(4, function()
        dust.Enabled = false
    end)
    
    return crack
end

local function startVecnaClockScene()
    cinematicActive = true
    
    local cam = workspace.CurrentCamera
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local head = char:FindFirstChild("Head")
    
    disableControls()
    cam.CameraType = Enum.CameraType.Scriptable
    
    print("🎬 CONSTRUYENDO ESCENARIO")
    
    local school, floor, lights = createHawkinsSchool()
    
    local startPos = Vector3.new(0, 1.5, -70)
    root.CFrame = CFrame.new(startPos)
    root.Anchored = true
    
    Lighting.Ambient = Color3.fromRGB(160, 150, 140)
    Lighting.Brightness = 2.5
    Lighting.ColorShift_Top = Color3.fromRGB(220, 210, 200)
    Lighting.FogEnd = 400
    Lighting.FogColor = Color3.fromRGB(200, 190, 180)
    
    local blackFrame = Instance.new("Frame", screenGui)
    blackFrame.Size = UDim2.fromScale(1, 1)
    blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    blackFrame.ZIndex = 100
    registerEffect(blackFrame)
    
    playAudio("BackgroundMusic", soundIds.backgroundMusic, 0.3, true)
    
    -- Botón SKIP que aparece después de 20 segundos
    local skipBtn = Instance.new("TextButton", screenGui)
    skipBtn.Text = "SKIP"
    skipBtn.Size = UDim2.fromScale(0.13, 0.07)
    skipBtn.Position = UDim2.fromScale(0.84, 0.91)
    skipBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    skipBtn.TextColor3 = Color3.new(1, 1, 1)
    skipBtn.BackgroundTransparency = 1
    skipBtn.TextTransparency = 1
    skipBtn.Font = Enum.Font.GothamBold
    skipBtn.TextSize = 24
    skipBtn.BorderSizePixel = 0
    registerEffect(skipBtn)
    
    local skipCorner = Instance.new("UICorner", skipBtn)
    skipCorner.CornerRadius = UDim.new(0, 12)
    
    -- Aparecer después de 20 segundos
    task.spawn(function()
        task.wait(20)
        TweenService:Create(skipBtn, TweenInfo.new(1), {
            BackgroundTransparency = 0.5,
            TextTransparency = 0
        }):Play()
    end)
    
    skipBtn.MouseButton1Click:Connect(function()
        if introShownGlobal then introShownGlobal.Value = true end
        cleanupIntro()
    end)
    
    task.wait(1.5)
    TweenService:Create(blackFrame, TweenInfo.new(3), {BackgroundTransparency = 1}):Play()
    task.wait(3)
    
    print("🎬 FASE 1: Caminando")
    
    local camOffset = Vector3.new(-6, 3, -10)
    cam.CFrame = CFrame.new(startPos + camOffset, startPos + Vector3.new(0, 2, 0))
    cam.FieldOfView = 70
    
    root.Anchored = false
    hum.WalkSpeed = 10
    
    local walkTarget1 = Vector3.new(0, 1.5, 35)
    hum:MoveTo(walkTarget1)
    
    local lastStepTime = 0
    local stepInterval = 0.5
    
    local followConnection = RunService.RenderStepped:Connect(function()
        if not cinematicActive or not root or not root.Parent or not hum then return end
        local targetCamPos = root.Position + Vector3.new(-7, 2.5, -12)
        local targetCamCF = CFrame.new(targetCamPos, root.Position + Vector3.new(0, 1.5, 0))
        cam.CFrame = cam.CFrame:Lerp(targetCamCF, 0.06)
        
        local moving = false
        if hum.MoveVector then
            moving = hum.MoveVector.Magnitude > 0.1
        elseif hum.MoveDirection then
            moving = hum.MoveDirection.Magnitude > 0.1
        end
        
        if hum.WalkSpeed > 0 and moving then
            if tick() - lastStepTime >= stepInterval then
                playAudio("Footstep", soundIds.footsteps, 0.4, false, root)
                lastStepTime = tick()
            end
        end
    end)
    
    task.wait(11)
    
    print("🎬 FASE 2: ✅ REACCIÓN - CÁMARAS MOSTRANDO LA CARA")
    
    hum.WalkSpeed = 0
    if followConnection then followConnection:Disconnect() end
    
    -- ✅ CÁMARA 1: FRENTE COMPLETO - 7 STUDS ADELANTE
    print("📹 CÁMARA 1: Frontal completa de la cara")
    if head then
        local frontFullCam = head.Position + Vector3.new(0, 0.3, -7)
        TweenService:Create(cam, TweenInfo.new(2), {
            CFrame = CFrame.new(frontFullCam, head.Position + Vector3.new(0, -0.2, 0)),
            FieldOfView = 55
        }):Play()
    end
    
    task.wait(2.5)
    
    -- Dolor de cabeza
    if head then
        print("🤕 Dolor de cabeza...")
        task.spawn(function()
            for i = 1, 8 do
                head.CFrame = head.CFrame * CFrame.Angles(math.rad(8), 0, 0)
                task.wait(0.25)
                head.CFrame = head.CFrame * CFrame.Angles(math.rad(-8), 0, 0)
                task.wait(0.25)
            end
        end)
    end
    
    task.wait(2)
    
    -- ✅ CÁMARA 2: PERFIL COMPLETO - LATERAL
    print("📹 CÁMARA 2: Perfil lateral")
    if head then
        local sideProfileCam = head.Position + Vector3.new(-5, 0.2, 0)
        TweenService:Create(cam, TweenInfo.new(1.8), {
            CFrame = CFrame.new(sideProfileCam, head.Position),
            FieldOfView = 50
        }):Play()
    end
    
    task.wait(2.5)
    
    -- ✅ CÁMARA 3: DIAGONAL MOSTRANDO EXPRESIÓN
    print("📹 CÁMARA 3: Diagonal de la cara")
    if head then
        local diagonalCam = head.Position + Vector3.new(-3, 1, -4.5)
        TweenService:Create(cam, TweenInfo.new(1.8), {
            CFrame = CFrame.new(diagonalCam, head.Position),
            FieldOfView = 48
        }):Play()
    end
    
    task.wait(3)
    
    print("🎬 FASE 3: ✅ LUCES PARPADEANDO - CÁMARA MOSTRANDO EL TECHO")
    
    -- ✅ CÁMARA 1: MIRANDO ARRIBA AL TECHO Y LUCES
    print("📹 CÁMARA 1: Luces del techo desde abajo")
    local ceilingCam = Vector3.new(0, 8, 30)
    TweenService:Create(cam, TweenInfo.new(2), {
        CFrame = CFrame.new(ceilingCam, Vector3.new(0, 14, 35)),
        FieldOfView = 70
    }):Play()
    
    task.wait(1.5)
    
    playAudio("LightFlicker", soundIds.lightFlicker, 0.8, true)
    
    task.spawn(function()
        for flicker = 1, 30 do
            for _, lightData in ipairs(lights) do
                lightData.light.Enabled = not lightData.light.Enabled
                lightData.fixture.Transparency = lightData.light.Enabled and 0.15 or 0.98
                if lightData.light.Enabled then
                    playAudio("LightFlicker"..flicker.."_".._, soundIds.lightFlicker, 0.3, false, lightData.fixture)
                end
            end
            task.wait(0.07)
        end
        
        -- CÁMARA 2: Vista lateral del pasillo con luces
        print("📹 CÁMARA 2: Lateral del pasillo")
        TweenService:Create(cam, TweenInfo.new(2), {
            CFrame = CFrame.new(Vector3.new(-10, 8, 0), Vector3.new(0, 12, 0)),
            FieldOfView = 65
        }):Play()
        
        task.wait(0.5)
        
        for flicker = 1, 15 do
            for _, lightData in ipairs(lights) do
                lightData.light.Enabled = false
                lightData.fixture.Transparency = 0.98
            end
            task.wait(0.2)
            for _, lightData in ipairs(lights) do
                lightData.light.Enabled = true
                lightData.fixture.Transparency = 0.15
                playAudio("LightOn"..flicker.."_".._, soundIds.lightFlicker, 0.2, false, lightData.fixture)
            end
            task.wait(0.2)
        end
        
        -- CÁMARA 3: Vista frontal del pasillo
        print("📹 CÁMARA 3: Frontal del pasillo")
        TweenService:Create(cam, TweenInfo.new(2), {
            CFrame = CFrame.new(Vector3.new(0, 8, -40), Vector3.new(0, 10, 20)),
            FieldOfView = 65
        }):Play()
        
        task.wait(1)
        
        for i = #lights, 1, -1 do
            local lightData = lights[i]
            for mini = 1, 7 do
                lightData.light.Enabled = false
                lightData.fixture.Transparency = 0.98
                task.wait(0.03)
                lightData.light.Enabled = true
                lightData.fixture.Transparency = 0.15
                playAudio("LightMini"..i.."_"..mini, soundIds.lightFlicker, 0.15, false, lightData.fixture)
                task.wait(0.03)
            end
            lightData.light.Enabled = false
            TweenService:Create(lightData.fixture, TweenInfo.new(0.3), {
                Transparency = 1
            }):Play()
            task.wait(0.1)
        end
        
        if musicTable["LightFlicker"] then
            musicTable["LightFlicker"]:Stop()
        end
    end)
    
    task.wait(20)
    
    print("🎬 FASE 4: RELOJ APARECE")
    
    local clockPosition = Vector3.new(0, 0.5, 68)
    local clockModel, clockFace, hourHand, minuteHand, clockLight, clockLight2, darkParticles, darkAura = createVecnaGrandfatherClock(clockPosition)
    
    for _, part in pairs(clockModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
    
    task.spawn(function()
        for i = 1, 60 do
            for _, part in pairs(clockModel:GetDescendants()) do
                if part:IsA("BasePart") then
                    local targetTransparency = 0
                    if part.Transparency > 0.5 then
                        targetTransparency = 0.65
                    end
                    part.Transparency = 1 - (i / 60) * (1 - targetTransparency)
                end
            end
            task.wait(0.05)
        end
        darkParticles.Enabled = true
        darkAura.Enabled = true
        
        playAudio("ClockTick", soundIds.clockTick, 0.6, true, clockFace)
    end)
    
    -- ✅ LUZ ROJA MASIVA INMEDIATA
    task.spawn(function()
        task.wait(2)
        TweenService:Create(clockLight, TweenInfo.new(4), {
            Brightness = 60,
            Range = 250
        }):Play()
        TweenService:Create(clockLight2, TweenInfo.new(4), {
            Brightness = 45,
            Range = 200
        }):Play()
    end)
    
    -- ✅ AMBIENTE ROJO MUY BRILLANTE - NO OSCURO
    print("🔴 AMBIENTE ROJO BRILLANTE")
    TweenService:Create(Lighting, TweenInfo.new(6), {
        Ambient = Color3.fromRGB(150, 40, 40),  -- MUY BRILLANTE
        Brightness = 2.8,  -- MÁXIMO BRILLO
        ColorShift_Top = Color3.fromRGB(220, 70, 70),
        FogEnd = 120,
        FogColor = Color3.fromRGB(100, 30, 30)
    }):Play()
    
    local clockViewCam = clockPosition + Vector3.new(5, 4, -8)
    TweenService:Create(cam, TweenInfo.new(6, Enum.EasingStyle.Sine), {
        CFrame = CFrame.new(clockViewCam, clockPosition + Vector3.new(0, 6, 0)),
        FieldOfView = 52
    }):Play()
    
    task.wait(10)
    
    print("🎬 FASE 5: PERSONAJE CAMINA Y EXTIENDE LA MANO")
    
    root.Anchored = false
    hum.WalkSpeed = 4
    
    local walkToClockTarget = Vector3.new(0, 1.5, 65)
    hum:MoveTo(walkToClockTarget)
    
    followConnection = RunService.RenderStepped:Connect(function()
        if not cinematicActive or not root or not root.Parent or not hum then return end
        local behindPos = root.Position + Vector3.new(0, 2, -8)
        local targetCF = CFrame.new(behindPos, clockPosition + Vector3.new(0, 5, 0))
        cam.CFrame = cam.CFrame:Lerp(targetCF, 0.04)
        cam.FieldOfView = 58
        
        local moving = false
        if hum.MoveVector then
            moving = hum.MoveVector.Magnitude > 0.1
        elseif hum.MoveDirection then
            moving = hum.MoveDirection.Magnitude > 0.1
        end
        
        if hum.WalkSpeed > 0 and moving then
            if tick() - lastStepTime >= 0.6 then
                playAudio("Footstep", soundIds.footsteps, 0.4, false, root)
                lastStepTime = tick()
            end
        end
    end)
    
    -- Esperar hasta que llegue cerca del reloj
    repeat
        task.wait(0.1)
    until not root or not root.Parent or (root.Position - walkToClockTarget).Magnitude < 3
    
    task.wait(0.5)
    
    hum.WalkSpeed = 0
    root.Anchored = true
    if followConnection then followConnection:Disconnect() end
    
    task.wait(1)
    
    print("✋ EXTENDIENDO LA MANO...")
    
    local sideHandCam = root.Position + Vector3.new(4, 1.5, 0)
    TweenService:Create(cam, TweenInfo.new(2), {
        CFrame = CFrame.new(sideHandCam, root.Position + Vector3.new(0, 1.5, 2)),
        FieldOfView = 48
    }):Play()
    
    task.wait(2)
    
    print("💥 GRÁFICOS")
    
    for i = 1, 20 do
        local vfxPart = Instance.new("Part")
        vfxPart.Size = Vector3.new(2, 2, 2)
        vfxPart.Position = clockPosition + Vector3.new(
            math.random(-15, 15),
            math.random(-5, 10),
            math.random(-8, 8)
        )
        vfxPart.Anchored = true
        vfxPart.CanCollide = false
        vfxPart.Material = Enum.Material.Plastic
        vfxPart.Color = Color3.fromRGB(150, 30, 30)
        vfxPart.Transparency = 0.4
        vfxPart.Parent = workspace
        registerEffect(vfxPart)
        applyStudsToAllFaces(vfxPart, Color3.fromRGB(150, 30, 30))
        
        local vfxLight = Instance.new("PointLight")
        vfxLight.Brightness = 2
        vfxLight.Range = 12
        vfxLight.Color = Color3.fromRGB(255, 50, 50)
        vfxLight.Parent = vfxPart
        
        TweenService:Create(vfxPart, TweenInfo.new(2.5), {
            Size = Vector3.new(8, 8, 8),
            Transparency = 1
        }):Play()
        Debris:AddItem(vfxPart, 3)
    end
    
    local bigFlash = Instance.new("Frame", screenGui)
    bigFlash.Size = UDim2.fromScale(1, 1)
    bigFlash.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    bigFlash.ZIndex = 150
    TweenService:Create(bigFlash, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    Debris:AddItem(bigFlash, 1)
    
    task.wait(1.5)
    
    print("💥 ✅ TERREMOTO VISIBLE CON LUZ ROJA BRILLANTE")
    
    -- ✅ AUMENTAR AÚN MÁS LA LUZ
    TweenService:Create(clockLight, TweenInfo.new(2), {
        Brightness = 80,
        Range = 300
    }):Play()
    TweenService:Create(clockLight2, TweenInfo.new(2), {
        Brightness = 60,
        Range = 250
    }):Play()
    
    -- ✅ MANTENER AMBIENTE MUY BRILLANTE
    TweenService:Create(Lighting, TweenInfo.new(2), {
        Ambient = Color3.fromRGB(180, 50, 50),  -- SUPER BRILLANTE
        Brightness = 3.5,  -- MÁXIMO
        ColorShift_Top = Color3.fromRGB(255, 80, 80)
    }):Play()
    
    task.wait(1)
    
    print("⚡ ✅ GRIETAS VISIBLES CON LUCES")
    
    local crackOrigin = Vector3.new(0, 0.5, 68)
    
    task.spawn(function()
        for angle = 0, 360, 30 do
            local rad = math.rad(angle)
            local endPos = crackOrigin + Vector3.new(
                math.cos(rad) * 25,
                0,
                math.sin(rad) * 25
            )
            createGroundCrack(crackOrigin, endPos, 0.8, 2)
            task.wait(0.15)
        end
        
        for i = 1, 15 do
            local startPos = crackOrigin + Vector3.new(
                math.random(-15, 15),
                0,
                math.random(-15, 15)
            )
            local endPos = startPos + Vector3.new(
                math.random(-10, 10),
                0,
                math.random(-10, 10)
            )
            createGroundCrack(startPos, endPos, 0.6, 1.5)
            task.wait(0.08)
        end
    end)
    
    -- ✅ CÁMARA 1: VISTA AÉREA CLARA DE LAS GRIETAS - DENTRO DEL PASILLO
    print("📹 CÁMARA 1: Vista aérea del terremoto")
    TweenService:Create(cam, TweenInfo.new(2.5), {
        CFrame = CFrame.new(Vector3.new(0, 14, 40), Vector3.new(0, 0, 68)),
        FieldOfView = 80
    }):Play()
    
    task.spawn(function()
        for i = 1, 60 do
            if cam then
                cam.CFrame = cam.CFrame * CFrame.new(
                    math.random(-4, 4) * 0.1,
                    math.random(-4, 4) * 0.1,
                    math.random(-4, 4) * 0.1
                )
            end
            task.wait(0.035)
        end
    end)
    
    task.wait(4)
    
    -- ✅ CÁMARA 2: LATERAL MOSTRANDO GRIETAS - DENTRO DEL PASILLO
    print("📹 CÁMARA 2: Lateral del suelo rompiéndose")
    TweenService:Create(cam, TweenInfo.new(2.5), {
        CFrame = CFrame.new(Vector3.new(-12, 4, 50), Vector3.new(0, 0, 68)),
        FieldOfView = 70
    }):Play()
    
    task.wait(4)
    
    print("😱 PERSONAJE CAE")
    
    root.Anchored = false
    hum.PlatformStand = true
    
    -- ✅ CÁMARA 3: CERCA DEL PERSONAJE CAYENDO
    print("📹 CÁMARA 3: Personaje cayendo")
    local fallingCam = root.Position + Vector3.new(-7, 5, -7)
    TweenService:Create(cam, TweenInfo.new(2.5), {
        CFrame = CFrame.new(fallingCam, root.Position),
        FieldOfView = 60
    }):Play()
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, -10, -20)
    bodyVelocity.MaxForce = Vector3.new(50000, 50000, 50000)
    bodyVelocity.Parent = root
    registerEffect(bodyVelocity)
    
    task.wait(2)
    bodyVelocity:Destroy()
    
    task.wait(2.5)
    
    -- ✅ CÁMARA 4: DESDE EL SUELO - DENTRO DEL PASILLO
    print("📹 CÁMARA 4: Vista desde el suelo")
    TweenService:Create(cam, TweenInfo.new(3.5), {
        CFrame = CFrame.new(Vector3.new(8, 2, 50), Vector3.new(0, 0, 68)),
        FieldOfView = 65
    }):Play()
    
    task.wait(5)
    
    -- ✅ CÁMARA 5: ZOOM FINAL AL RELOJ
    print("📹 CÁMARA 5: Zoom final épico")
    TweenService:Create(cam, TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        CFrame = CFrame.new(clockPosition + Vector3.new(0, 7, -2), clockPosition + Vector3.new(0, 7, 0)),
        FieldOfView = 20
    }):Play()
    
    task.wait(5)
    
    local finalBigFlash = Instance.new("Frame", screenGui)
    finalBigFlash.Size = UDim2.fromScale(1, 1)
    finalBigFlash.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    finalBigFlash.ZIndex = 150
    TweenService:Create(finalBigFlash, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    
    task.wait(2)
    
    TweenService:Create(blackFrame, TweenInfo.new(4), {BackgroundTransparency = 0}):Play()
    stopAllAudio(4)
    task.wait(4)
    
    print("🎬 MENÚ FINAL")
    
    local menuFrame = Instance.new("Frame", screenGui)
    menuFrame.Size = UDim2.fromScale(1, 1)
    menuFrame.BackgroundTransparency = 1
    registerEffect(menuFrame)
    
    local title = Instance.new("TextLabel", menuFrame)
    title.Text = "STRANGER BLOX"
    title.Font = Enum.Font.Creepster
    title.TextColor3 = Color3.fromRGB(230, 0, 0)
    title.TextSize = 110
    title.Size = UDim2.fromScale(1, 0.25)
    title.Position = UDim2.fromScale(0, 0.12)
    title.BackgroundTransparency = 1
    title.TextTransparency = 1
    title.TextStrokeTransparency = 0.2
    title.TextStrokeColor3 = Color3.new(0, 0, 0)
    TweenService:Create(title, TweenInfo.new(3), {TextTransparency = 0}):Play()
    
    local subtitle = Instance.new("TextLabel", menuFrame)
    subtitle.Text = "When The Clock Chimes..."
    subtitle.Font = Enum.Font.Garamond
    subtitle.TextColor3 = Color3.fromRGB(190, 190, 190)
    subtitle.TextSize = 36
    subtitle.Size = UDim2.fromScale(1, 0.1)
    subtitle.Position = UDim2.fromScale(0, 0.33)
    subtitle.BackgroundTransparency = 1
    subtitle.TextTransparency = 1
    TweenService:Create(subtitle, TweenInfo.new(3), {TextTransparency = 0.2}):Play()
    
    local playBtn = Instance.new("TextButton", menuFrame)
    playBtn.Text = "ENTER THE UPSIDE DOWN"
    playBtn.Font = Enum.Font.GothamBlack
    playBtn.TextSize = 36
    playBtn.TextColor3 = Color3.new(1, 1, 1)
    playBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
    playBtn.Size = UDim2.fromScale(0.4, 0.11)
    playBtn.Position = UDim2.fromScale(0.3, 0.52)
    playBtn.BackgroundTransparency = 1
    playBtn.TextTransparency = 1
    playBtn.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", playBtn)
    corner.CornerRadius = UDim.new(0, 15)
    TweenService:Create(playBtn, TweenInfo.new(3), {
        BackgroundTransparency = 0,
        TextTransparency = 0
    }):Play()
    
    playBtn.MouseButton1Click:Connect(function()
        TweenService:Create(blackFrame, TweenInfo.new(1.5), {BackgroundTransparency = 0}):Play()
        task.wait(1.5)
        if introShownGlobal then introShownGlobal.Value = true end
        cleanupIntro()
    end)
end

task.wait(2)
if player.Character then
    startVecnaClockScene()
else
    player.CharacterAdded:Connect(function()
        task.wait(1)
        startVecnaClockScene()
    end)
end

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").Died:Connect(function()
        if cinematicActive then
            if introShownGlobal then introShownGlobal.Value = true end
            cleanupIntro()
        end
    end)
end)
