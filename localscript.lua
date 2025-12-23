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
    
    local frontGreenStripe = Instance.new("Part")
    frontGreenStripe.Size = Vector3.new(30, 2.2, 0.9)
    frontGreenStripe.Position = Vector3.new(0, 8.2, 74.55)
    frontGreenStripe.Anchored = true
    frontGreenStripe.Material = Enum.Material.Plastic
    frontGreenStripe.Color = Color3.fromRGB(115, 145, 95)
    frontGreenStripe.Parent = schoolFolder
    applyStudsToAllFaces(frontGreenStripe, Color3.fromRGB(115, 145, 95))
    
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
    print("🕰️ CREANDO RELOJ DE VECNA REALISTA")
    
    local clockModel = Instance.new("Model")
    clockModel.Name = "VecnaGrandfatherClock"
    clockModel.Parent = workspace
    registerEffect(clockModel)
    
    -- Base pegada al suelo
    local base = Instance.new("Part")
    base.Size = Vector3.new(4.5, 1.8, 3.8)
    base.Position = position + Vector3.new(0, 0.9, 0)
    base.Anchored = true
    base.Material = Enum.Material.Wood
    base.Color = Color3.fromRGB(25, 20, 18)
    base.Parent = clockModel
    
    -- Detalles tallados en la base
    for i = -1, 1 do
        local carving = Instance.new("Part")
        carving.Size = Vector3.new(0.3, 1.5, 0.2)
        carving.Position = base.Position + Vector3.new(i * 1.5, 0, -1.8)
        carving.Anchored = true
        carving.Material = Enum.Material.Wood
        carving.Color = Color3.fromRGB(20, 16, 14)
        carving.Parent = base
    end
    
    -- Cuerpo principal más alto y realista
    local body = Instance.new("Part")
    body.Size = Vector3.new(3.2, 11, 2.8)
    body.Position = position + Vector3.new(0, 7.4, 0)
    body.Anchored = true
    body.Material = Enum.Material.Wood
    body.Color = Color3.fromRGB(28, 24, 22)
    body.Parent = clockModel
    
    -- Marcos decorativos del cuerpo
    local frameLeft = Instance.new("Part")
    frameLeft.Size = Vector3.new(0.25, 11, 0.3)
    frameLeft.Position = body.Position + Vector3.new(-1.5, 0, -1.3)
    frameLeft.Anchored = true
    frameLeft.Material = Enum.Material.Wood
    frameLeft.Color = Color3.fromRGB(18, 15, 13)
    frameLeft.Parent = body
    
    local frameRight = Instance.new("Part")
    frameRight.Size = Vector3.new(0.25, 11, 0.3)
    frameRight.Position = body.Position + Vector3.new(1.5, 0, -1.3)
    frameRight.Anchored = true
    frameRight.Material = Enum.Material.Wood
    frameRight.Color = Color3.fromRGB(18, 15, 13)
    frameRight.Parent = body
    
    -- Vidrio realista con reflejos
    local bodyGlass = Instance.new("Part")
    bodyGlass.Size = Vector3.new(2.8, 10, 0.2)
    bodyGlass.Position = body.Position + Vector3.new(0, 0, -1.5)
    bodyGlass.Anchored = true
    bodyGlass.Material = Enum.Material.Glass
    bodyGlass.Color = Color3.fromRGB(60, 50, 40)
    bodyGlass.Transparency = 0.7
    bodyGlass.Reflectance = 0.3
    bodyGlass.Parent = body
    
    -- Péndulo realista con cadena
    local pendulumChain = Instance.new("Part")
    pendulumChain.Size = Vector3.new(0.15, 7, 0.15)
    pendulumChain.Position = body.Position + Vector3.new(0, -1.5, -0.8)
    pendulumChain.Anchored = true
    pendulumChain.Material = Enum.Material.Metal
    pendulumChain.Color = Color3.fromRGB(180, 160, 120)
    pendulumChain.Parent = body
    
    local pendulumWeight = Instance.new("Part")
    pendulumWeight.Size = Vector3.new(1.2, 1.8, 0.8)
    pendulumWeight.Position = pendulumChain.Position + Vector3.new(0, -4.5, 0)
    pendulumWeight.Anchored = true
    pendulumWeight.Material = Enum.Material.Metal
    pendulumWeight.Color = Color3.fromRGB(200, 180, 130)
    pendulumWeight.Parent = pendulumChain
    
    -- Disco del péndulo
    local pendulumDisc = Instance.new("Part")
    pendulumDisc.Size = Vector3.new(0.3, 2, 2)
    pendulumDisc.Position = pendulumWeight.Position + Vector3.new(0, -1.2, 0)
    pendulumDisc.Anchored = true
    pendulumDisc.Shape = Enum.PartType.Cylinder
    pendulumDisc.Material = Enum.Material.Metal
    pendulumDisc.Color = Color3.fromRGB(220, 200, 140)
    pendulumDisc.Orientation = Vector3.new(0, 0, 90)
    pendulumDisc.Parent = pendulumWeight
    
    -- Base del reloj más elaborada
    local clockFaceBase = Instance.new("Part")
    clockFaceBase.Size = Vector3.new(0.8, 5, 5)
    clockFaceBase.Position = body.Position + Vector3.new(0, 6.2, -1.7)
    clockFaceBase.Anchored = true
    clockFaceBase.Material = Enum.Material.Wood
    clockFaceBase.Color = Color3.fromRGB(22, 18, 16)
    clockFaceBase.Parent = clockModel
    
    -- Marco dorado ornamentado
    local goldFrame = Instance.new("Part")
    goldFrame.Size = Vector3.new(0.5, 4.2, 4.2)
    goldFrame.Position = clockFaceBase.Position + Vector3.new(0, 0, -0.4)
    goldFrame.Anchored = true
    goldFrame.Shape = Enum.PartType.Cylinder
    goldFrame.Material = Enum.Material.Metal
    goldFrame.Color = Color3.fromRGB(180, 150, 80)
    goldFrame.Orientation = Vector3.new(0, 0, 90)
    goldFrame.Parent = clockFaceBase
    
    -- Cara del reloj realista
    local clockFace = Instance.new("Part")
    clockFace.Name = "ClockFace"
    clockFace.Size = Vector3.new(3.6, 0.3, 3.6)
    clockFace.Position = goldFrame.Position + Vector3.new(0, 0, -0.35)
    clockFace.Anchored = true
    clockFace.Material = Enum.Material.Marble
    clockFace.Color = Color3.fromRGB(230, 220, 200)
    clockFace.Parent = clockFaceBase
    
    -- Anillo exterior negro
    local outerRing = Instance.new("Part")
    outerRing.Size = Vector3.new(0.25, 4, 4)
    outerRing.Position = goldFrame.Position + Vector3.new(0, 0, -0.6)
    outerRing.Anchored = true
    outerRing.Shape = Enum.PartType.Cylinder
    outerRing.Material = Enum.Material.Metal
    outerRing.Color = Color3.fromRGB(15, 12, 10)
    outerRing.Orientation = Vector3.new(0, 0, 90)
    outerRing.Parent = clockFaceBase
    
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
    
    -- Manecillas realistas
    local hourHand = Instance.new("Part")
    hourHand.Name = "HourHand"
    hourHand.Size = Vector3.new(0.18, 1.4, 0.12)
    hourHand.Position = clockFace.Position + Vector3.new(0, 0.5, -0.2)
    hourHand.Anchored = true
    hourHand.Material = Enum.Material.Metal
    hourHand.Color = Color3.fromRGB(10, 8, 8)
    hourHand.Parent = clockFace
    
    local minuteHand = Instance.new("Part")
    minuteHand.Name = "MinuteHand"
    minuteHand.Size = Vector3.new(0.14, 1.8, 0.1)
    minuteHand.Position = clockFace.Position + Vector3.new(0, 0.7, -0.25)
    minuteHand.Anchored = true
    minuteHand.Material = Enum.Material.Metal
    minuteHand.Color = Color3.fromRGB(10, 8, 8)
    minuteHand.Parent = clockFace
    
    -- Centro de las manecillas
    local handCenter = Instance.new("Part")
    handCenter.Size = Vector3.new(0.25, 0.25, 0.25)
    handCenter.Position = clockFace.Position + Vector3.new(0, 0, -0.3)
    handCenter.Anchored = true
    handCenter.Shape = Enum.PartType.Ball
    handCenter.Material = Enum.Material.Metal
    handCenter.Color = Color3.fromRGB(8, 6, 6)
    handCenter.Parent = clockFace
    
    -- Corona superior elaborada
    local top = Instance.new("Part")
    top.Size = Vector3.new(3.8, 2.5, 3.2)
    top.Position = body.Position + Vector3.new(0, 6.5, 0)
    top.Anchored = true
    top.Material = Enum.Material.Wood
    top.Color = Color3.fromRGB(20, 16, 14)
    top.Parent = clockModel
    
    -- Arco decorativo
    local topArch = Instance.new("Part")
    topArch.Size = Vector3.new(3.8, 1.5, 3.2)
    topArch.Position = top.Position + Vector3.new(0, 1.5, 0)
    topArch.Anchored = true
    topArch.Material = Enum.Material.Wood
    topArch.Color = Color3.fromRGB(18, 14, 12)
    topArch.Parent = top
    
    -- Ornamentos superiores realistas
    local function createOrnament(xOffset)
        local ornBase = Instance.new("Part")
        ornBase.Size = Vector3.new(0.7, 1.5, 0.7)
        ornBase.Position = topArch.Position + Vector3.new(xOffset, 1.2, 0)
        ornBase.Anchored = true
        ornBase.Material = Enum.Material.Wood
        ornBase.Color = Color3.fromRGB(16, 12, 10)
        ornBase.Parent = topArch
        
        local ornTop = Instance.new("Part")
        ornTop.Size = Vector3.new(0.5, 0.8, 0.5)
        ornTop.Position = ornBase.Position + Vector3.new(0, 1.1, 0)
        ornTop.Anchored = true
        ornTop.Shape = Enum.PartType.Ball
        ornTop.Material = Enum.Material.Metal
        ornTop.Color = Color3.fromRGB(140, 120, 70)
        ornTop.Parent = ornBase
        
        local ornBall = Instance.new("Part")
        ornBall.Size = Vector3.new(0.5, 0.5, 0.5)
        ornBall.Position = ornTop.Position + Vector3.new(0, 0.5, 0)
        ornBall.Anchored = true
        ornBall.Shape = Enum.PartType.Ball
        ornBall.Material = Enum.Material.Metal
        ornBall.Color = Color3.fromRGB(160, 140, 80)
        ornBall.Parent = ornTop
    end
    
    createOrnament(-1.5)
    createOrnament(0)
    createOrnament(1.5)
    
    -- ✅ LUZ ROJA MASIVA VISIBLE - BRIGHTNESS 100, RANGE 300
    local clockLight = Instance.new("PointLight")
    clockLight.Brightness = 100  -- MÁXIMO DESDE EL INICIO
    clockLight.Range = 300  -- ENORME
    clockLight.Color = Color3.fromRGB(255, 0, 0)
    clockLight.Shadows = false
    clockLight.Parent = clockFace
    registerEffect(clockLight)
    
    local clockLight2 = Instance.new("PointLight")
    clockLight2.Brightness = 80
    clockLight2.Range = 250
    clockLight2.Color = Color3.fromRGB(255, 30, 30)
    clockLight2.Shadows = false
    clockLight2.Parent = body
    registerEffect(clockLight2)
    
    local clockLight3 = Instance.new("PointLight")
    clockLight3.Brightness = 70
    clockLight3.Range = 200
    clockLight3.Color = Color3.fromRGB(255, 50, 50)
    clockLight3.Shadows = false
    clockLight3.Parent = base
    registerEffect(clockLight3)
    
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
    
    return clockModel, clockFace, hourHand, minuteHand, clockLight, clockLight2, clockLight3, darkParticles, darkAura
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
        
        local moving = hum.MoveDirection.Magnitude > 0.1
        
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
    local clockModel, clockFace, hourHand, minuteHand, clockLight, clockLight2, clockLight3, darkParticles, darkAura = createVecnaGrandfatherClock(clockPosition)
    
    -- ✅ RELOJ COMPLETAMENTE VISIBLE DESDE EL INICIO
    for _, part in pairs(clockModel:GetDescendants()) do
        if part:IsA("BasePart") then
            if part.Name == "ClockFace" or part.Parent.Name == "ClockFace" then
                part.Transparency = 0  -- Cara del reloj 100% visible
            elseif part.Transparency > 0.5 then
                part.Transparency = 0.65
            else
                part.Transparency = 0
            end
        end
    end
    
    darkParticles.Enabled = true
    darkAura.Enabled = true
    playAudio("ClockTick", soundIds.clockTick, 0.6, true, clockFace)
    
    -- ✅ LUZ ROJA YA ESTÁ AL MÁXIMO (no necesita animación)
    
    -- ✅ AMBIENTE ROJO SUPER BRILLANTE - ESTILO STRANGER THINGS
    print("🔴 AMBIENTE ROJO BRILLANTE")
    TweenService:Create(Lighting, TweenInfo.new(6), {
        Ambient = Color3.fromRGB(200, 60, 60),  -- SUPER BRILLANTE
        Brightness = 4,  -- MÁXIMO ABSOLUTO
        ColorShift_Top = Color3.fromRGB(255, 100, 100),
        FogEnd = 150,
        FogColor = Color3.fromRGB(150, 40, 40)
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
    
    local walkToClockTarget = Vector3.new(0, 1.5, 62)
    
    followConnection = RunService.RenderStepped:Connect(function()
        if not cinematicActive or not root or not root.Parent or not hum then return end
        
        hum:MoveTo(walkToClockTarget)
        
        local behindPos = root.Position + Vector3.new(0, 2, -8)
        local targetCF = CFrame.new(behindPos, clockPosition + Vector3.new(0, 5, 0))
        cam.CFrame = cam.CFrame:Lerp(targetCF, 0.04)
        cam.FieldOfView = 58
        
        local moving = hum.MoveDirection.Magnitude > 0.1
        
        if hum.WalkSpeed > 0 and moving then
            if tick() - lastStepTime >= 0.6 then
                playAudio("Footstep", soundIds.footsteps, 0.4, false, root)
                lastStepTime = tick()
            end
        end
        
        if (root.Position - walkToClockTarget).Magnitude < 4 then
            hum.WalkSpeed = 0
            if followConnection then followConnection:Disconnect() end
        end
    end)
    
    repeat
        task.wait(0.1)
    until not root or not root.Parent or (root.Position - walkToClockTarget).Magnitude < 4
    
    task.wait(0.5)
    root.Anchored = true
    
    task.wait(1)
    
    print("✋ EXTENDIENDO LA MANO...")
    
    local sideHandCam = root.Position + Vector3.new(4, 1.5, 0)
    TweenService:Create(cam, TweenInfo.new(2), {
        CFrame = CFrame.new(sideHandCam, root.Position + Vector3.new(0, 1.5, 2)),
        FieldOfView = 48
    }):Play()
    
    task.wait(2)
    
    print("💥 EXPLOSIÓN ÉPICA DE GRÁFICOS")
    
    for wave = 1, 3 do
        task.spawn(function()
            for i = 1, 40 do
                local vfxPart = Instance.new("Part")
                vfxPart.Size = Vector3.new(3, 3, 3)
                vfxPart.Position = clockPosition + Vector3.new(
                    math.random(-20, 20),
                    math.random(-8, 15),
                    math.random(-12, 12)
                )
                vfxPart.Anchored = true
                vfxPart.CanCollide = false
                vfxPart.Material = Enum.Material.Neon
                vfxPart.Color = Color3.fromRGB(255, math.random(20, 80), math.random(20, 80))
                vfxPart.Transparency = 0.2
                vfxPart.Parent = workspace
                registerEffect(vfxPart)
                
                local vfxLight = Instance.new("PointLight")
                vfxLight.Brightness = 5
                vfxLight.Range = 25
                vfxLight.Color = Color3.fromRGB(255, 50, 50)
                vfxLight.Parent = vfxPart
                
                local smoke = Instance.new("ParticleEmitter")
                smoke.Texture = "rbxassetid://6102449224"
                smoke.Rate = 50
                smoke.Lifetime = NumberRange.new(2, 4)
                smoke.Speed = NumberRange.new(8, 15)
                smoke.SpreadAngle = Vector2.new(180, 180)
                smoke.Size = NumberSequence.new(3, 8)
                smoke.Transparency = NumberSequence.new(0, 1)
                smoke.Color = ColorSequence.new(Color3.fromRGB(255, 60, 60))
                smoke.LightEmission = 1
                smoke.Parent = vfxPart
                
                TweenService:Create(vfxPart, TweenInfo.new(3), {
                    Size = Vector3.new(12, 12, 12),
                    Transparency = 1
                }):Play()
                Debris:AddItem(vfxPart, 3.5)
                task.wait(0.03)
            end
        end)
        task.wait(0.5)
    end
    
    local bigFlash = Instance.new("Frame", screenGui)
    bigFlash.Size = UDim2.fromScale(1, 1)
    bigFlash.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    bigFlash.ZIndex = 150
    TweenService:Create(bigFlash, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    Debris:AddItem(bigFlash, 1)
    
    task.wait(1.5)
    
    print("💥 ✅ TERREMOTO REALISTA CON ANIMACIÓN CINEMATOGRÁFICA")
    
    -- Sonido de terremoto
    local earthquakeSound = Instance.new("Sound")
    earthquakeSound.SoundId = "rbxassetid://9125402735"
    earthquakeSound.Volume = 0.8
    earthquakeSound.Parent = workspace
    earthquakeSound:Play()
    registerEffect(earthquakeSound)
    
    -- Intensificar ambiente rojo
    TweenService:Create(Lighting, TweenInfo.new(2), {
        Ambient = Color3.fromRGB(220, 70, 70),
        Brightness = 5,
        ColorShift_Top = Color3.fromRGB(255, 120, 120)
    }):Play()
    
    task.wait(1)
    
    print("⚡ GRIETAS REALISTAS PROGRESIVAS")
    
    local crackOrigin = Vector3.new(0, 0.5, 68)
    
    -- Fase 1: Grietas principales desde el reloj
    task.spawn(function()
        for angle = 0, 360, 20 do
            local rad = math.rad(angle)
            local endPos = crackOrigin + Vector3.new(
                math.cos(rad) * 35,
                0,
                math.sin(rad) * 35
            )
            createGroundCrack(crackOrigin, endPos, 1.2, 3)
            
            -- Escombros realistas cayendo
            for debris = 1, 3 do
                task.spawn(function()
                    local debrisPart = Instance.new("Part")
                    debrisPart.Size = Vector3.new(math.random(15, 30) / 10, math.random(10, 25) / 10, math.random(15, 30) / 10)
                    debrisPart.Position = (crackOrigin + endPos) / 2 + Vector3.new(
                        math.random(-3, 3),
                        0.5,
                        math.random(-3, 3)
                    )
                    debrisPart.Anchored = false
                    debrisPart.Material = Enum.Material.Concrete
                    debrisPart.Color = Color3.fromRGB(math.random(100, 140), math.random(90, 120), math.random(90, 120))
                    debrisPart.Parent = workspace
                    registerEffect(debrisPart)
                    
                    -- Impulso realista
                    local bodyVel = Instance.new("BodyVelocity")
                    bodyVel.Velocity = Vector3.new(
                        math.random(-15, 15),
                        math.random(8, 18),
                        math.random(-15, 15)
                    )
                    bodyVel.MaxForce = Vector3.new(50000, 50000, 50000)
                    bodyVel.Parent = debrisPart
                    
                    task.wait(0.3)
                    bodyVel:Destroy()
                    
                    Debris:AddItem(debrisPart, 10)
                end)
            end
            
            task.wait(0.08)
        end
        
        -- Fase 2: Grietas secundarias ramificadas
        task.wait(0.5)
        for i = 1, 30 do
            local startPos = crackOrigin + Vector3.new(
                math.random(-25, 25),
                0,
                math.random(-25, 25)
            )
            local endPos = startPos + Vector3.new(
                math.random(-15, 15),
                0,
                math.random(-15, 15)
            )
            createGroundCrack(startPos, endPos, 0.9, 2.5)
            task.wait(0.04)
        end
        
        -- Fase 3: Grietas finas finales
        task.wait(0.3)
        for i = 1, 20 do
            local startPos = crackOrigin + Vector3.new(
                math.random(-30, 30),
                0,
                math.random(-30, 30)
            )
            local endPos = startPos + Vector3.new(
                math.random(-8, 8),
                0,
                math.random(-8, 8)
            )
            createGroundCrack(startPos, endPos, 0.5, 1.5)
            task.wait(0.02)
        end
    end)
    
    -- CÁMARA 1: Vista aérea cinematográfica con movimiento suave
    print("📹 CÁMARA 1: Vista aérea del terremoto")
    local aerialStart = Vector3.new(0, 18, 40)
    local aerialEnd = Vector3.new(0, 12, 55)
    
    task.spawn(function()
        local startTime = tick()
        local duration = 4
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            local currentPos = aerialStart:Lerp(aerialEnd, alpha)
            cam.CFrame = CFrame.new(currentPos, Vector3.new(0, 0, 68))
            cam.FieldOfView = 75 + (alpha * 5)
            
            -- Shake realista
            cam.CFrame = cam.CFrame * CFrame.new(
                math.sin(tick() * 20) * 0.3,
                math.cos(tick() * 25) * 0.3,
                math.sin(tick() * 15) * 0.2
            )
            task.wait()
        end
    end)
    
    task.wait(4)
    
    -- CÁMARA 2: Lateral dramática con zoom
    print("📹 CÁMARA 2: Lateral del suelo rompiéndose")
    local lateralStart = Vector3.new(-15, 5, 50)
    local lateralEnd = Vector3.new(-10, 3, 60)
    
    task.spawn(function()
        local startTime = tick()
        local duration = 4
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            local currentPos = lateralStart:Lerp(lateralEnd, alpha)
            cam.CFrame = CFrame.new(currentPos, Vector3.new(0, 0, 68))
            cam.FieldOfView = 70 - (alpha * 5)
            
            -- Shake intenso
            cam.CFrame = cam.CFrame * CFrame.new(
                math.sin(tick() * 25) * 0.4,
                math.cos(tick() * 30) * 0.4,
                math.sin(tick() * 20) * 0.3
            )
            task.wait()
        end
    end)
    
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
