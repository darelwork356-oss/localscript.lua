--[[
    🇨🇺 FIESTA NOCTURNA V2.0 - SERVER ARREGLADO 🇨🇺
    Todos los problemas solucionados
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- ============================================
-- COLORES CUBANOS
-- ============================================

local COLORES_CUBANOS = {
    Rojo = Color3.fromRGB(220, 50, 50),
    Amarillo = Color3.fromRGB(255, 200, 50),
    Azul = Color3.fromRGB(30, 150, 220),
    Verde = Color3.fromRGB(50, 180, 100),
    Naranja = Color3.fromRGB(255, 120, 50),
    Rosa = Color3.fromRGB(255, 100, 150),
    Morado = Color3.fromRGB(150, 50, 200),
    Turquesa = Color3.fromRGB(50, 200, 200),
    Blanco = Color3.fromRGB(255, 255, 255),
    Negro = Color3.fromRGB(20, 20, 25)
}

-- ============================================
-- PLAYLIST
-- ============================================

local PLAYLIST_COMPLETA = {
    {nombre = "Salsa Caliente", id = "rbxassetid://1837879082", genero = "Salsa", duracion = "3:45"},
    {nombre = "Regueton Cubano", id = "rbxassetid://6131662717", genero = "Regueton", duracion = "3:20"},
    {nombre = "Son Montuno", id = "rbxassetid://1845414572", genero = "Son", duracion = "4:10"},
    {nombre = "Timba Moderna", id = "rbxassetid://1848354536", genero = "Timba", duracion = "3:55"},
    {nombre = "Mambo No 5", id = "rbxassetid://1842458264", genero = "Mambo", duracion = "3:30"},
    {nombre = "Cha Cha Cha", id = "rbxassetid://1839246711", genero = "ChaCha", duracion = "3:15"},
    {nombre = "Cumbia Cubana", id = "rbxassetid://1838717700", genero = "Cumbia", duracion = "3:40"},
    {nombre = "Merengue Latino", id = "rbxassetid://1842647812", genero = "Merengue", duracion = "3:25"},
    {nombre = "Bachata Romantica", id = "rbxassetid://1846826278", genero = "Bachata", duracion = "4:00"},
    {nombre = "Guaracha Fiesta", id = "rbxassetid://1841639758", genero = "Guaracha", duracion = "3:35"}
}

local cancionActual = 1
local musicaSound = nil

-- ============================================
-- FOLDERS
-- ============================================

local MapaFolder = Instance.new("Folder")
MapaFolder.Name = "FiestaNocturnaMap"
MapaFolder.Parent = Workspace

local CalleFolder = Instance.new("Folder")
CalleFolder.Name = "Calle"
CalleFolder.Parent = MapaFolder

local SalonFolder = Instance.new("Folder")
SalonFolder.Name = "Salon"
SalonFolder.Parent = MapaFolder

local MueblesFolder = Instance.new("Folder")
MueblesFolder.Name = "Muebles"
MueblesFolder.Parent = SalonFolder

local EfectosFolder = Instance.new("Folder")
EfectosFolder.Name = "Efectos"
EfectosFolder.Parent = MapaFolder

-- ============================================
-- ILUMINACION
-- ============================================

local function ConfigurarIluminacion()
    print("🌙 Configurando iluminacion...")
    
    Lighting.Ambient = Color3.fromRGB(80, 100, 150)
    Lighting.OutdoorAmbient = Color3.fromRGB(50, 70, 120)
    Lighting.Brightness = 1.5
    Lighting.ClockTime = 22
    Lighting.GeographicLatitude = 23
    
    local atmosphere = Instance.new("Atmosphere")
    atmosphere.Density = 0.3
    atmosphere.Offset = 0.25
    atmosphere.Color = Color3.fromRGB(180, 200, 255)
    atmosphere.Decay = Color3.fromRGB(106, 112, 125)
    atmosphere.Glare = 0.4
    atmosphere.Haze = 1.2
    atmosphere.Parent = Lighting
    
    print("✅ Iluminacion OK")
end

-- ============================================
-- BASE
-- ============================================

local function CrearBase()
    print("🏗️ Creando base...")
    
    local suelo = Instance.new("Part")
    suelo.Name = "SueloCalle"
    suelo.Size = Vector3.new(200, 1, 400)
    suelo.Position = Vector3.new(0, -0.5, 0)
    suelo.Anchored = true
    suelo.Color = Color3.fromRGB(50, 50, 55)
    suelo.Material = Enum.Material.SmoothPlastic
    suelo.Parent = CalleFolder
    
    print("✅ Base OK")
end

-- ============================================
-- PALMERAS ARREGLADAS
-- ============================================

local function CrearPalmeraCubana(posicion)
    local palmeraModel = Instance.new("Model")
    palmeraModel.Name = "PalmeraCubana"
    palmeraModel.Parent = CalleFolder
    
    -- TRONCO (14 studs alto)
    local segmentosTronco = 7
    local alturaPorSegmento = 2
    
    for i = 1, segmentosTronco do
        local segmento = Instance.new("Part")
        segmento.Size = Vector3.new(1.8, alturaPorSegmento, 1.8)
        segmento.Position = posicion + Vector3.new(0, (i - 1) * alturaPorSegmento + alturaPorSegmento/2, 0)
        segmento.Anchored = true
        segmento.Color = Color3.fromRGB(101, 67, 33)
        segmento.Material = Enum.Material.SmoothPlastic
        segmento.Parent = palmeraModel
        
        local cilindro = Instance.new("CylinderMesh")
        cilindro.Parent = segmento
        
        if i % 2 == 0 then
            local anillo = Instance.new("Part")
            anillo.Size = Vector3.new(2.1, 0.3, 2.1)
            anillo.Position = segmento.Position + Vector3.new(0, alturaPorSegmento/2, 0)
            anillo.Anchored = true
            anillo.Color = Color3.fromRGB(85, 55, 25)
            anillo.Material = Enum.Material.SmoothPlastic
            anillo.Parent = palmeraModel
            
            local anilloMesh = Instance.new("CylinderMesh")
            anilloMesh.Parent = anillo
        end
    end
    
    -- HOJAS BIEN ENDEREZADAS (8 hojas)
    local alturaCopa = segmentosTronco * alturaPorSegmento
    local posicionCopa = posicion + Vector3.new(0, alturaCopa, 0)
    
    for i = 1, 8 do
        local angulo = (i - 1) * 45
        
        local hoja = Instance.new("Part")
        hoja.Size = Vector3.new(6, 0.3, 1.5)
        hoja.CFrame = CFrame.new(posicionCopa) 
            * CFrame.Angles(math.rad(-10), math.rad(angulo), 0)
            * CFrame.new(3, 0, 0)
        hoja.Anchored = true
        hoja.Color = Color3.fromRGB(50, 150, 70)
        hoja.Material = Enum.Material.SmoothPlastic
        hoja.Parent = palmeraModel
    end
    
    -- COCOS
    for i = 1, 4 do
        local coco = Instance.new("Part")
        coco.Size = Vector3.new(1, 1.2, 1)
        coco.Position = posicionCopa + Vector3.new(
            math.cos(math.rad(i * 90)) * 0.8,
            -1,
            math.sin(math.rad(i * 90)) * 0.8
        )
        coco.Anchored = true
        coco.Color = Color3.fromRGB(139, 90, 43)
        coco.Material = Enum.Material.SmoothPlastic
        coco.Parent = palmeraModel
        
        local cocoMesh = Instance.new("SpecialMesh")
        cocoMesh.MeshType = Enum.MeshType.Sphere
        cocoMesh.Parent = coco
    end
    
    return palmeraModel
end

-- ============================================
-- CALLE CON BANCOS ARREGLADOS
-- ============================================

local function CrearCalle()
    print("🏘️ Creando calle...")
    
    -- Aceras
    for i = -1, 1, 2 do
        local acera = Instance.new("Part")
        acera.Name = "Acera"
        acera.Size = Vector3.new(12, 0.8, 400)
        acera.Position = Vector3.new(i * 50, 0.4, 0)
        acera.Anchored = true
        acera.Color = Color3.fromRGB(200, 190, 180)
        acera.Material = Enum.Material.SmoothPlastic
        acera.Parent = CalleFolder
    end
    
    -- Palmeras bien ubicadas
    local posicionesPalmeras = {
        Vector3.new(-70, 0, -140), Vector3.new(-75, 0, -100),
        Vector3.new(-68, 0, -60), Vector3.new(-72, 0, -20),
        Vector3.new(-70, 0, 20), Vector3.new(-74, 0, 60),
        Vector3.new(-69, 0, 100), Vector3.new(-73, 0, 140),
        Vector3.new(70, 0, -130), Vector3.new(75, 0, -90),
        Vector3.new(68, 0, -50), Vector3.new(72, 0, -10),
        Vector3.new(70, 0, 30), Vector3.new(74, 0, 70),
        Vector3.new(69, 0, 110), Vector3.new(73, 0, 150)
    }
    
    for _, pos in ipairs(posicionesPalmeras) do
        CrearPalmeraCubana(pos)
    end
    
    -- BANCOS BIEN ORGANIZADOS Y ORIENTADOS
    local posicionesBancos = {
        {pos = Vector3.new(-30, 0, 180), rot = 0},   -- Mirando al escenario
        {pos = Vector3.new(30, 0, 180), rot = 0},    -- Mirando al escenario
        {pos = Vector3.new(-30, 0, 160), rot = 0},   -- Mirando al escenario
        {pos = Vector3.new(30, 0, 160), rot = 0},    -- Mirando al escenario
        {pos = Vector3.new(-15, 0, 140), rot = 45},  -- Diagonal al centro
        {pos = Vector3.new(15, 0, 140), rot = -45}   -- Diagonal al centro
    }
    
    for _, bancoData in ipairs(posicionesBancos) do
        local banco = Instance.new("Seat")
        banco.Size = Vector3.new(6, 1, 2)
        banco.Position = bancoData.pos + Vector3.new(0, 1.5, 0)
        banco.Anchored = true
        banco.Color = Color3.fromRGB(180, 120, 80)
        banco.Material = Enum.Material.SmoothPlastic
        banco.Parent = CalleFolder
        
        banco.CFrame = CFrame.new(banco.Position) * CFrame.Angles(0, math.rad(bancoData.rot), 0)
        
        -- Respaldo orientado correctamente
        local respaldo = Instance.new("Part")
        respaldo.Size = Vector3.new(6, 2, 0.3)
        respaldo.Anchored = true
        respaldo.Color = Color3.fromRGB(180, 120, 80)
        respaldo.Material = Enum.Material.SmoothPlastic
        respaldo.Parent = CalleFolder
        
        local offsetRespaldo = Vector3.new(0, 1, 1.15)
        respaldo.CFrame = banco.CFrame * CFrame.new(offsetRespaldo)
    end
    
    print("✅ Calle OK")
end

-- ============================================
-- SALON
-- ============================================

local function CrearSalon()
    print("🎉 Creando salón cubano completo...")
    
    local posBase = Vector3.new(0, 0, 220)
    
    -- PISO CON MOSAICOS CUBANOS - 120 studs x 100 studs
    local piso = Instance.new("Part")
    piso.Name = "PisoSalon"
    piso.Size = Vector3.new(120, 1, 100)
    piso.Position = posBase
    piso.Anchored = true
    piso.Color = Color3.fromRGB(40, 35, 30)
    piso.Material = Enum.Material.SmoothPlastic
    piso.Parent = SalonFolder
    
    -- Mosaicos cubanos tradicionales
    for x = -56, 56, 8 do
        for z = -46, 46, 8 do
            local mosaico = Instance.new("Part")
            mosaico.Size = Vector3.new(7.5, 0.3, 7.5)
            mosaico.Position = posBase + Vector3.new(x, 0.65, z)
            mosaico.Anchored = true
            
            local patron = (math.abs(x) + math.abs(z)) / 8
            if patron % 4 == 0 then
                mosaico.Color = Color3.fromRGB(220, 200, 180)
            elseif patron % 4 == 1 then
                mosaico.Color = Color3.fromRGB(180, 160, 140)
            elseif patron % 4 == 2 then
                mosaico.Color = Color3.fromRGB(160, 120, 100)
            else
                mosaico.Color = Color3.fromRGB(120, 100, 80)
            end
            
            mosaico.Material = Enum.Material.SmoothPlastic
            mosaico.Parent = SalonFolder
        end
    end
    
    -- PAREDES (3 lados - SIN PARED FRONTAL)
    local alturaParedes = 30
    
    -- Pared trasera
    local paredTrasera = Instance.new("Part")
    paredTrasera.Name = "ParedTrasera"
    paredTrasera.Size = Vector3.new(120, alturaParedes, 3)
    paredTrasera.Position = posBase + Vector3.new(0, alturaParedes/2, 50)
    paredTrasera.Anchored = true
    paredTrasera.Color = Color3.fromRGB(45, 40, 35)
    paredTrasera.Material = Enum.Material.SmoothPlastic
    paredTrasera.Parent = SalonFolder
    
    -- Pared izquierda
    local paredIzq = Instance.new("Part")
    paredIzq.Name = "ParedIzquierda"
    paredIzq.Size = Vector3.new(3, alturaParedes, 100)
    paredIzq.Position = posBase + Vector3.new(-60, alturaParedes/2, 0)
    paredIzq.Anchored = true
    paredIzq.Color = Color3.fromRGB(55, 50, 45)
    paredIzq.Material = Enum.Material.SmoothPlastic
    paredIzq.Parent = SalonFolder
    
    -- Pared derecha
    local paredDer = Instance.new("Part")
    paredDer.Name = "ParedDerecha"
    paredDer.Size = Vector3.new(3, alturaParedes, 100)
    paredDer.Position = posBase + Vector3.new(60, alturaParedes/2, 0)
    paredDer.Anchored = true
    paredDer.Color = Color3.fromRGB(55, 50, 45)
    paredDer.Material = Enum.Material.SmoothPlastic
    paredDer.Parent = SalonFolder
    
    -- TECHO
    local techo = Instance.new("Part")
    techo.Name = "Techo"
    techo.Size = Vector3.new(120, 1, 100)
    techo.Position = posBase + Vector3.new(0, alturaParedes, 0)
    techo.Anchored = true
    techo.Color = Color3.fromRGB(30, 25, 20)
    techo.Material = Enum.Material.SmoothPlastic
    techo.Parent = SalonFolder
    
    -- Lámparas colgantes
    for i = -40, 40, 40 do
        for j = -30, 30, 30 do
            local lampara = Instance.new("Part")
            lampara.Size = Vector3.new(3, 4, 3)
            lampara.Position = posBase + Vector3.new(i, alturaParedes - 3, j)
            lampara.Anchored = true
            lampara.Color = COLORES_CUBANOS.Amarillo
            lampara.Material = Enum.Material.Neon
            lampara.Transparency = 0.2
            lampara.Parent = SalonFolder
            
            local luzLampara = Instance.new("PointLight")
            luzLampara.Brightness = 3
            luzLampara.Color = COLORES_CUBANOS.Amarillo
            luzLampara.Range = 25
            luzLampara.Parent = lampara
        end
    end
    
    print("✅ Salón completo OK")
end

-- ============================================
-- MESAS CON SILLAS ARREGLADAS
-- ============================================

local function CrearMesas()
    print("🪑 Creando mesas...")
    
    local function CrearMesa(posicion)
        -- Mesa redonda
        local mesa = Instance.new("Part")
        mesa.Size = Vector3.new(6, 0.5, 6)
        mesa.Position = posicion + Vector3.new(0, 3.25, 0)
        mesa.Anchored = true
        mesa.Color = Color3.fromRGB(120, 80, 50)
        mesa.Material = Enum.Material.SmoothPlastic
        mesa.Parent = MueblesFolder
        
        local mesaMesh = Instance.new("CylinderMesh")
        mesaMesh.Parent = mesa
        
        -- Pata central
        local pata = Instance.new("Part")
        pata.Size = Vector3.new(1, 6, 1)
        pata.Position = posicion + Vector3.new(0, 0, 0)
        pata.Anchored = true
        pata.Color = Color3.fromRGB(100, 65, 40)
        pata.Material = Enum.Material.SmoothPlastic
        pata.Parent = mesa
        
        local pataMesh = Instance.new("CylinderMesh")
        pataMesh.Parent = pata
        
        -- SILLAS CON PATAS (4 sillas)
        local posicionesSillas = {
            Vector3.new(0, 0, 4.5),   -- Norte
            Vector3.new(0, 0, -4.5),  -- Sur  
            Vector3.new(4.5, 0, 0),   -- Este
            Vector3.new(-4.5, 0, 0)   -- Oeste
        }
        
        for _, offset in ipairs(posicionesSillas) do
            -- Asiento
            local seat = Instance.new("Seat")
            seat.Size = Vector3.new(2, 0.5, 2)
            seat.Position = posicion + offset + Vector3.new(0, 2, 0)
            seat.Anchored = true
            seat.Color = Color3.fromRGB(150, 100, 70)
            seat.Material = Enum.Material.SmoothPlastic
            seat.Parent = MueblesFolder
            
            -- Respaldo
            local respaldo = Instance.new("Part")
            respaldo.Size = Vector3.new(2, 3, 0.3)
            
            if offset.Z > 0 then -- Norte
                respaldo.Position = seat.Position + Vector3.new(0, 1.75, 1.15)
            elseif offset.Z < 0 then -- Sur
                respaldo.Position = seat.Position + Vector3.new(0, 1.75, -1.15)
            elseif offset.X > 0 then -- Este
                respaldo.Position = seat.Position + Vector3.new(1.15, 1.75, 0)
                respaldo.Size = Vector3.new(0.3, 3, 2)
            else -- Oeste
                respaldo.Position = seat.Position + Vector3.new(-1.15, 1.75, 0)
                respaldo.Size = Vector3.new(0.3, 3, 2)
            end
            
            respaldo.Anchored = true
            respaldo.Color = Color3.fromRGB(130, 85, 60)
            respaldo.Material = Enum.Material.SmoothPlastic
            respaldo.Parent = MueblesFolder
            
            -- 4 PATAS DE LA SILLA
            for j = 1, 4 do
                local pataSilla = Instance.new("Part")
                pataSilla.Size = Vector3.new(0.2, 1.5, 0.2)
                
                local offsetPata = Vector3.new(
                    (j <= 2) and -0.8 or 0.8,
                    -1.25,
                    (j % 2 == 1) and -0.8 or 0.8
                )
                pataSilla.Position = seat.Position + offsetPata
                pataSilla.Anchored = true
                pataSilla.Color = Color3.fromRGB(100, 65, 40)
                pataSilla.Material = Enum.Material.SmoothPlastic
                pataSilla.Parent = MueblesFolder
            end
        end
    end
    
    -- Crear 6 mesas bien distribuidas (ALEJADAS DEL ESCENARIO)
    local posicionesMesas = {
        Vector3.new(-35, 0, 190),  -- Más lejos del escenario
        Vector3.new(35, 0, 190),
        Vector3.new(-35, 0, 210),
        Vector3.new(35, 0, 210),
        Vector3.new(-15, 0, 200),
        Vector3.new(15, 0, 200)
    }
    
    for _, pos in ipairs(posicionesMesas) do
        CrearMesa(pos)
    end
    
    print("✅ Mesas OK")
end

-- ============================================
-- ESCENARIO CON ESCALERAS ARREGLADAS
-- ============================================

local function CrearEscenario()
    print("🎤 Creando escenario...")
    
    local posEsc = Vector3.new(0, 5, 260)
    
    -- Plataforma
    local escenario = Instance.new("Part")
    escenario.Name = "EscenarioPrincipal"
    escenario.Size = Vector3.new(60, 2, 25)
    escenario.Position = posEsc
    escenario.Anchored = true
    escenario.Color = Color3.fromRGB(20, 20, 25)
    escenario.Material = Enum.Material.SmoothPlastic
    escenario.Parent = SalonFolder
    
    -- ESCALERAS CENTRALES BIEN ORIENTADAS
    for i = 1, 5 do
        local escalon = Instance.new("Part")
        escalon.Size = Vector3.new(12, 1, 3)
        escalon.Position = posEsc + Vector3.new(0, -6 + (i * 1), -20 + (i * 3))
        escalon.Anchored = true
        escalon.Color = Color3.fromRGB(60, 60, 70)
        escalon.Material = Enum.Material.SmoothPlastic
        escalon.Parent = escenario
        
        -- Barandillas
        if i > 1 then
            for lado = -1, 1, 2 do
                local barandilla = Instance.new("Part")
                barandilla.Size = Vector3.new(0.5, 2, 0.5)
                barandilla.Position = escalon.Position + Vector3.new(lado * 5.5, 1.5, 0)
                barandilla.Anchored = true
                barandilla.Color = Color3.fromRGB(80, 80, 90)
                barandilla.Material = Enum.Material.SmoothPlastic
                barandilla.Parent = escalon
            end
        end
    end
    
    print("✅ Escenario OK")
    return escenario
end

-- ============================================
-- BOLA DE DISCOTECA
-- ============================================

local function CrearBolaDiscoteca()
    print("🪩 Creando bola de discoteca completa...")
    
    local posicionBola = Vector3.new(0, 25, 220)
    
    -- BOLA PRINCIPAL
    local bola = Instance.new("Part")
    bola.Name = "BolaDiscoteca"
    bola.Size = Vector3.new(8, 8, 8)
    bola.Position = posicionBola
    bola.Anchored = true
    bola.Color = Color3.fromRGB(200, 200, 200)
    bola.Material = Enum.Material.Neon
    bola.Transparency = 0.1
    bola.Parent = SalonFolder
    
    local bolaMesh = Instance.new("SpecialMesh")
    bolaMesh.MeshType = Enum.MeshType.Sphere
    bolaMesh.Parent = bola
    
    -- ESPEJOS EN LA BOLA
    local espejos = {}
    for i = 1, 32 do
        local espejo = Instance.new("Part")
        espejo.Size = Vector3.new(0.8, 0.8, 0.1)
        espejo.Anchored = true
        espejo.Color = Color3.fromRGB(255, 255, 255)
        espejo.Material = Enum.Material.Neon
        espejo.Transparency = 0.3
        espejo.Parent = bola
        
        local angulo = (i - 1) * (360 / 32)
        local altura = math.sin(math.rad(angulo * 2)) * 2
        espejo.Position = posicionBola + Vector3.new(
            math.cos(math.rad(angulo)) * 4.2,
            altura,
            math.sin(math.rad(angulo)) * 4.2
        )
        
        table.insert(espejos, espejo)
    end
    
    -- LUCES DE DISCOTECA
    local luces = {}
    for i = 1, 12 do
        local luz = Instance.new("Part")
        luz.Size = Vector3.new(2, 2, 2)
        luz.Anchored = true
        luz.Color = COLORES_CUBANOS.Blanco
        luz.Material = Enum.Material.Neon
        luz.Transparency = 0.5
        luz.Parent = bola
        
        local angulo = (i - 1) * 30
        luz.Position = posicionBola + Vector3.new(
            math.cos(math.rad(angulo)) * 12,
            math.random(-3, 3),
            math.sin(math.rad(angulo)) * 12
        )
        
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 0
        pointLight.Range = 50
        pointLight.Parent = luz
        
        table.insert(luces, {parte = luz, luz = pointLight})
    end
    
    -- SISTEMA DE CONTROL
    local bolaActiva = false
    local anguloRotacion = 0
    
    -- CICLO DE ENCENDIDO/APAGADO (1 minuto encendida, 1 minuto apagada)
    spawn(function()
        while true do
            -- ENCENDER (1 minuto)
            bolaActiva = true
            print("🎆 Bola de discoteca ENCENDIDA")
            
            -- Apagar luces del salón
            for _, obj in pairs(SalonFolder:GetChildren()) do
                if obj:FindFirstChild("PointLight") then
                    obj.PointLight.Brightness = 0
                end
            end
            
            wait(60) -- 1 minuto encendida
            
            -- APAGAR (1 minuto)
            bolaActiva = false
            print("🌑 Bola de discoteca APAGADA")
            
            -- Encender luces del salón
            for _, obj in pairs(SalonFolder:GetChildren()) do
                if obj:FindFirstChild("PointLight") then
                    obj.PointLight.Brightness = 3
                end
            end
            
            -- Apagar luces de discoteca
            for _, luzData in pairs(luces) do
                luzData.parte.Color = COLORES_CUBANOS.Blanco
                luzData.luz.Brightness = 0
            end
            
            wait(60) -- 1 minuto apagada
        end
    end)
    
    -- ANIMACION DE ROTACION Y EFECTOS
    spawn(function()
        while true do
            if bolaActiva then
                -- Rotar bola
                anguloRotacion = anguloRotacion + 2
                bola.CFrame = CFrame.new(posicionBola) * CFrame.Angles(0, math.rad(anguloRotacion), 0)
                
                -- Actualizar espejos
                for i, espejo in pairs(espejos) do
                    local angulo = (i - 1) * (360 / 32) + anguloRotacion
                    local altura = math.sin(math.rad(angulo * 2)) * 2
                    espejo.Position = posicionBola + Vector3.new(
                        math.cos(math.rad(angulo)) * 4.2,
                        altura,
                        math.sin(math.rad(angulo)) * 4.2
                    )
                    
                    espejo.Color = Color3.fromHSV((anguloRotacion + i * 10) % 360 / 360, 0.8, 1)
                end
                
                -- Efectos de luces aleatorias
                for _, luzData in pairs(luces) do
                    if math.random() > 0.7 then
                        local colores = {COLORES_CUBANOS.Rojo, COLORES_CUBANOS.Verde, COLORES_CUBANOS.Azul, COLORES_CUBANOS.Rosa, COLORES_CUBANOS.Amarillo}
                        local colorAleatorio = colores[math.random(1, #colores)]
                        
                        luzData.parte.Color = colorAleatorio
                        luzData.luz.Color = colorAleatorio
                        luzData.luz.Brightness = math.random(5, 10)
                    else
                        luzData.luz.Brightness = 0
                    end
                end
                
                -- Rayos de luz
                if math.random() > 0.8 then
                    local rayo = Instance.new("Part")
                    rayo.Size = Vector3.new(0.5, 0.5, 30)
                    rayo.Position = posicionBola
                    rayo.Anchored = true
                    rayo.CanCollide = false
                    rayo.Color = Color3.fromHSV(math.random(), 1, 1)
                    rayo.Material = Enum.Material.Neon
                    rayo.Transparency = 0.3
                    rayo.Parent = bola
                    
                    rayo.CFrame = CFrame.new(posicionBola, posicionBola + Vector3.new(
                        math.random(-20, 20),
                        math.random(-10, -20),
                        math.random(-20, 20)
                    ))
                    
                    game:GetService("Debris"):AddItem(rayo, 0.5)
                end
            end
            
            wait(0.1)
        end
    end)
    
    print("✅ Bola de discoteca completa OK")
    return bola
end

-- ============================================
-- EVENTOS
-- ============================================

local function CrearEventos()
    local eventosFolder = Instance.new("Folder")
    eventosFolder.Name = "FiestaNocturnaEvents"
    eventosFolder.Parent = ReplicatedStorage
    
    local bailarEvent = Instance.new("RemoteEvent")
    bailarEvent.Name = "BailarEvent"
    bailarEvent.Parent = eventosFolder
    
    print("✅ Eventos OK")
end

-- ============================================
-- SPAWN
-- ============================================

local function CrearSpawn()
    local spawn = Instance.new("SpawnLocation")
    spawn.Size = Vector3.new(10, 1, 10)
    spawn.Position = Vector3.new(0, 1, -100)
    spawn.Anchored = true
    spawn.Transparency = 1
    spawn.CanCollide = false
    spawn.Color = COLORES_CUBANOS.Verde
    spawn.Material = Enum.Material.Neon
    spawn.Parent = CalleFolder
    
    print("✅ Spawn OK")
end

-- ============================================
-- INICIALIZACION
-- ============================================

print("🇨🇺 ========================================")
print("🇨🇺 FIESTA NOCTURNA - ARREGLADO")
print("🇨🇺 ========================================")

ConfigurarIluminacion()
CrearBase()
CrearCalle()
CrearSalon()
CrearMesas()
local escenario = CrearEscenario()
local bolaDiscoteca = CrearBolaDiscoteca()
CrearEventos()
CrearSpawn()

print("🇨🇺 ========================================")
print("🇨🇺 ✅ TODO ARREGLADO!")
print("🇨🇺 ========================================")

Players.PlayerAdded:Connect(function(player)
    print("👋 " .. player.Name .. " se unio!")
end)