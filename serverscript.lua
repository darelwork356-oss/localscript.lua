--[[
    🇨🇺 FIESTA NOCTURNA V2.0 - SERVER REDISEÑADO 🇨🇺
    TODO en Plastic, entrada abierta, palmeras realistas
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
    
    -- Suelo de calle - 200 studs ancho x 400 studs largo
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
-- PALMERAS CUBANAS REALISTAS
-- ============================================

local function CrearPalmeraCubana(posicion)
    -- Modelo de palmera realista
    local palmeraModel = Instance.new("Model")
    palmeraModel.Name = "PalmeraCubana"
    palmeraModel.Parent = CalleFolder
    
    -- TRONCO (15 studs de alto, segmentado)
    local segmentosTronco = 6
    local alturaPorSegmento = 2.5
    
    for i = 1, segmentosTronco do
        local segmento = Instance.new("Part")
        segmento.Name = "TroncoSegmento" .. i
        segmento.Size = Vector3.new(2, alturaPorSegmento, 2)
        segmento.Position = posicion + Vector3.new(0, (i - 1) * alturaPorSegmento + alturaPorSegmento/2, 0)
        segmento.Anchored = true
        segmento.Color = Color3.fromRGB(101, 67, 33)
        segmento.Material = Enum.Material.SmoothPlastic
        segmento.Parent = palmeraModel
        
        -- Textura del tronco
        local cilindro = Instance.new("CylinderMesh")
        cilindro.Parent = segmento
        
        -- Anillos del tronco
        if i % 2 == 0 then
            local anillo = Instance.new("Part")
            anillo.Name = "Anillo"
            anillo.Size = Vector3.new(2.3, 0.3, 2.3)
            anillo.Position = segmento.Position + Vector3.new(0, alturaPorSegmento/2, 0)
            anillo.Anchored = true
            anillo.Color = Color3.fromRGB(85, 55, 25)
            anillo.Material = Enum.Material.SmoothPlastic
            anillo.Parent = palmeraModel
            
            local anilloMesh = Instance.new("CylinderMesh")
            anilloMesh.Parent = anillo
        end
    end
    
    -- COPA DE HOJAS (12 hojas grandes)
    local alturaCopa = segmentosTronco * alturaPorSegmento
    local posicionCopa = posicion + Vector3.new(0, alturaCopa, 0)
    
    for i = 1, 12 do
        local angulo = (i - 1) * 30 -- 12 hojas = 30 grados cada una
        
        -- Tallo de la hoja
        local tallo = Instance.new("Part")
        tallo.Name = "TalloHoja" .. i
        tallo.Size = Vector3.new(0.3, 0.3, 6)
        tallo.CFrame = CFrame.new(posicionCopa) 
            * CFrame.Angles(math.rad(-35), math.rad(angulo), 0)
            * CFrame.new(0, 0, 3)
        tallo.Anchored = true
        tallo.Color = Color3.fromRGB(60, 120, 40)
        tallo.Material = Enum.Material.SmoothPlastic
        tallo.Parent = palmeraModel
        
        -- Hoja izquierda
        local hojaIzq = Instance.new("Part")
        hojaIzq.Name = "HojaIzq" .. i
        hojaIzq.Size = Vector3.new(3, 0.2, 5)
        hojaIzq.CFrame = tallo.CFrame 
            * CFrame.new(-1.5, 0, 0)
            * CFrame.Angles(0, 0, math.rad(15))
        hojaIzq.Anchored = true
        hojaIzq.Color = COLORES_CUBANOS.Verde
        hojaIzq.Material = Enum.Material.SmoothPlastic
        hojaIzq.Parent = palmeraModel
        
        -- Hoja derecha
        local hojaDer = Instance.new("Part")
        hojaDer.Name = "HojaDer" .. i
        hojaDer.Size = Vector3.new(3, 0.2, 5)
        hojaDer.CFrame = tallo.CFrame 
            * CFrame.new(1.5, 0, 0)
            * CFrame.Angles(0, 0, math.rad(-15))
        hojaDer.Anchored = true
        hojaDer.Color = COLORES_CUBANOS.Verde
        hojaDer.Material = Enum.Material.SmoothPlastic
        hojaDer.Parent = palmeraModel
        
        -- Detalle de punta
        local punta = Instance.new("Part")
        punta.Name = "PuntaHoja" .. i
        punta.Size = Vector3.new(2, 0.2, 2)
        punta.CFrame = tallo.CFrame * CFrame.new(0, 0, 3)
        punta.Anchored = true
        punta.Color = Color3.fromRGB(40, 100, 30)
        punta.Material = Enum.Material.SmoothPlastic
        punta.Parent = palmeraModel
    end
    
    -- Cocos decorativos
    for i = 1, 4 do
        local coco = Instance.new("Part")
        coco.Name = "Coco" .. i
        coco.Size = Vector3.new(1.2, 1.5, 1.2)
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
        cocoMesh.Scale = Vector3.new(1, 1.2, 1)
        cocoMesh.Parent = coco
    end
    
    return palmeraModel
end

-- ============================================
-- CALLE
-- ============================================

local function CrearCalle()
    print("🏘️ Creando calle...")
    
    -- Aceras - 12 studs ancho x 400 studs largo
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
    
    -- Faroles cada 40 studs
    for z = -150, 150, 40 do
        for x = -48, 48, 96 do
            -- Poste - 14 studs alto
            local poste = Instance.new("Part")
            poste.Size = Vector3.new(0.8, 14, 0.8)
            poste.Position = Vector3.new(x, 7, z)
            poste.Anchored = true
            poste.Color = Color3.fromRGB(40, 40, 45)
            poste.Material = Enum.Material.SmoothPlastic
            poste.Parent = CalleFolder
            
            -- Base del poste
            local base = Instance.new("Part")
            base.Size = Vector3.new(2, 0.5, 2)
            base.Position = Vector3.new(x, 0.25, z)
            base.Anchored = true
            base.Color = Color3.fromRGB(60, 60, 65)
            base.Material = Enum.Material.SmoothPlastic
            base.Parent = CalleFolder
            
            -- Farol - 3 studs de diametro
            local farol = Instance.new("Part")
            farol.Size = Vector3.new(3, 3, 3)
            farol.Position = Vector3.new(x, 14, z)
            farol.Anchored = true
            farol.Color = COLORES_CUBANOS.Amarillo
            farol.Material = Enum.Material.Neon
            farol.Transparency = 0.2
            farol.Parent = CalleFolder
            
            local farolMesh = Instance.new("SpecialMesh")
            farolMesh.MeshType = Enum.MeshType.Sphere
            farolMesh.Parent = farol
            
            local luz = Instance.new("PointLight")
            luz.Brightness = 3
            luz.Color = COLORES_CUBANOS.Amarillo
            luz.Range = 50
            luz.Parent = farol
        end
    end
    
    -- Palmeras cubanas realistas (15 palmeras distribuidas)
    print("🌴 Creando palmeras cubanas...")
    local posicionesPalmeras = {
        Vector3.new(-45, 0, -120),
        Vector3.new(45, 0, -120),
        Vector3.new(-45, 0, -80),
        Vector3.new(45, 0, -80),
        Vector3.new(-45, 0, -40),
        Vector3.new(45, 0, -40),
        Vector3.new(-45, 0, 0),
        Vector3.new(45, 0, 0),
        Vector3.new(-45, 0, 40),
        Vector3.new(45, 0, 40),
        Vector3.new(-35, 0, 100),
        Vector3.new(35, 0, 100),
        Vector3.new(-35, 0, 130),
        Vector3.new(35, 0, 130),
        Vector3.new(0, 0, 160)
    }
    
    for _, pos in ipairs(posicionesPalmeras) do
        CrearPalmeraCubana(pos)
    end
    
    print("✅ Calle con palmeras OK")
end

-- ============================================
-- SALON CON ENTRADA ABIERTA
-- ============================================

local function CrearSalon()
    print("🎉 Creando salon con entrada abierta...")
    
    local posBase = Vector3.new(0, 0, 220)
    
    -- PISO - 120 studs x 100 studs
    local piso = Instance.new("Part")
    piso.Name = "PisoSalon"
    piso.Size = Vector3.new(120, 1, 100)
    piso.Position = posBase
    piso.Anchored = true
    piso.Color = Color3.fromRGB(30, 30, 35)
    piso.Material = Enum.Material.SmoothPlastic
    piso.Parent = SalonFolder
    
    -- Baldosas decorativas - 10x10 studs cada una
    for x = -55, 55, 10 do
        for z = -45, 45, 10 do
            local baldosa = Instance.new("Part")
            baldosa.Size = Vector3.new(9, 0.2, 9)
            baldosa.Position = posBase + Vector3.new(x, 0.6, z)
            baldosa.Anchored = true
            local esPar = ((x + z) / 10) % 2 == 0
            baldosa.Color = esPar and Color3.fromRGB(45, 45, 50) or Color3.fromRGB(25, 25, 30)
            baldosa.Material = Enum.Material.SmoothPlastic
            baldosa.Parent = SalonFolder
        end
    end
    
    -- PAREDES (3 lados - SIN PARED FRONTAL = ENTRADA ABIERTA)
    local alturaParedes = 30
    
    -- Pared trasera - 120 studs ancho x 30 studs alto
    local paredTrasera = Instance.new("Part")
    paredTrasera.Name = "ParedTrasera"
    paredTrasera.Size = Vector3.new(120, alturaParedes, 2)
    paredTrasera.Position = posBase + Vector3.new(0, alturaParedes/2, 50)
    paredTrasera.Anchored = true
    paredTrasera.Color = Color3.fromRGB(25, 25, 30)
    paredTrasera.Material = Enum.Material.SmoothPlastic
    paredTrasera.Parent = SalonFolder
    
    -- Pared izquierda - 100 studs largo x 30 studs alto
    local paredIzq = Instance.new("Part")
    paredIzq.Name = "ParedIzquierda"
    paredIzq.Size = Vector3.new(2, alturaParedes, 100)
    paredIzq.Position = posBase + Vector3.new(-60, alturaParedes/2, 0)
    paredIzq.Anchored = true
    paredIzq.Color = Color3.fromRGB(35, 35, 40)
    paredIzq.Material = Enum.Material.SmoothPlastic
    paredIzq.Parent = SalonFolder
    
    -- Pared derecha - 100 studs largo x 30 studs alto
    local paredDer = Instance.new("Part")
    paredDer.Name = "ParedDerecha"
    paredDer.Size = Vector3.new(2, alturaParedes, 100)
    paredDer.Position = posBase + Vector3.new(60, alturaParedes/2, 0)
    paredDer.Anchored = true
    paredDer.Color = Color3.fromRGB(35, 35, 40)
    paredDer.Material = Enum.Material.SmoothPlastic
    paredDer.Parent = SalonFolder
    
    -- TECHO - 120 studs x 100 studs
    local techo = Instance.new("Part")
    techo.Name = "Techo"
    techo.Size = Vector3.new(120, 1, 100)
    techo.Position = posBase + Vector3.new(0, alturaParedes, 0)
    techo.Anchored = true
    techo.Color = Color3.fromRGB(20, 20, 25)
    techo.Material = Enum.Material.SmoothPlastic
    techo.Parent = SalonFolder
    
    -- Vigas decorativas - 4 studs ancho cada una
    for i = -40, 40, 20 do
        local viga = Instance.new("Part")
        viga.Name = "Viga"
        viga.Size = Vector3.new(4, 2, 100)
        viga.Position = posBase + Vector3.new(i, alturaParedes - 1, 0)
        viga.Anchored = true
        viga.Color = Color3.fromRGB(60, 60, 70)
        viga.Material = Enum.Material.SmoothPlastic
        viga.Parent = SalonFolder
    end
    
    -- ENTRADA ABIERTA - Solo decoración lateral
    -- Columnas laterales de entrada - 3 studs ancho x 20 studs alto
    for lado = -1, 1, 2 do
        local columna = Instance.new("Part")
        columna.Name = "ColumnaEntrada"
        columna.Size = Vector3.new(3, 20, 3)
        columna.Position = posBase + Vector3.new(lado * 58, 10, -50)
        columna.Anchored = true
        columna.Color = Color3.fromRGB(60, 60, 70)
        columna.Material = Enum.Material.SmoothPlastic
        columna.Parent = SalonFolder
    end
    
    -- LETRERO LUMINOSO - 50 studs ancho x 8 studs alto
    local letrero = Instance.new("Part")
    letrero.Name = "LetreroEntrada"
    letrero.Size = Vector3.new(50, 8, 1)
    letrero.Position = posBase + Vector3.new(0, 25, -51)
    letrero.Anchored = true
    letrero.Color = COLORES_CUBANOS.Rosa
    letrero.Material = Enum.Material.Neon
    letrero.Parent = SalonFolder
    
    local luzLetrero = Instance.new("PointLight")
    luzLetrero.Brightness = 5
    luzLetrero.Color = COLORES_CUBANOS.Rosa
    luzLetrero.Range = 60
    luzLetrero.Parent = letrero
    
    local textGui = Instance.new("SurfaceGui")
    textGui.Face = Enum.NormalId.Front
    textGui.Parent = letrero
    
    local texto = Instance.new("TextLabel")
    texto.Size = UDim2.new(1, 0, 1, 0)
    texto.BackgroundTransparency = 1
    texto.Text = "🇨🇺 FIESTA NOCTURNA 🇨🇺"
    texto.TextColor3 = COLORES_CUBANOS.Blanco
    texto.TextScaled = true
    texto.Font = Enum.Font.GothamBold
    texto.Parent = textGui
    
    print("✅ Salon con ENTRADA ABIERTA OK")
end

-- ============================================
-- MESAS Y SILLAS
-- ============================================

local function CrearMesas()
    print("🪑 Creando mesas...")
    
    local function CrearMesa(posicion)
        -- Mesa - 6 studs x 6 studs x 1 stud alto
        local mesa = Instance.new("Part")
        mesa.Size = Vector3.new(6, 1, 6)
        mesa.Position = posicion + Vector3.new(0, 4, 0)
        mesa.Anchored = true
        mesa.Color = Color3.fromRGB(80, 50, 30)
        mesa.Material = Enum.Material.SmoothPlastic
        mesa.Parent = MueblesFolder
        
        -- Superficie - 7 studs x 7 studs
        local superficie = Instance.new("Part")
        superficie.Size = Vector3.new(7, 0.3, 7)
        superficie.Position = posicion + Vector3.new(0, 4.5, 0)
        superficie.Anchored = true
        superficie.Color = COLORES_CUBANOS.Rosa
        superficie.Material = Enum.Material.SmoothPlastic
        superficie.Transparency = 0.3
        superficie.Parent = mesa
        
        -- Centro luminoso - 1.5 studs
        local centro = Instance.new("Part")
        centro.Size = Vector3.new(1.5, 2, 1.5)
        centro.Position = posicion + Vector3.new(0, 5.5, 0)
        centro.Anchored = true
        centro.Color = COLORES_CUBANOS.Amarillo
        centro.Material = Enum.Material.Neon
        centro.Transparency = 0.2
        centro.Parent = mesa
        
        local centroMesh = Instance.new("CylinderMesh")
        centroMesh.Parent = centro
        
        local luz = Instance.new("PointLight")
        luz.Brightness = 2
        luz.Color = COLORES_CUBANOS.Amarillo
        luz.Range = 15
        luz.Parent = centro
        
        -- Sillas - 2x2x0.5 studs, separadas 4.5 studs del centro
        local posiciones = {
            Vector3.new(0, 0, 4.5),
            Vector3.new(0, 0, -4.5),
            Vector3.new(4.5, 0, 0),
            Vector3.new(-4.5, 0, 0)
        }
        
        for _, offset in ipairs(posiciones) do
            local seat = Instance.new("Seat")
            seat.Size = Vector3.new(2, 0.5, 2)
            seat.Position = posicion + offset + Vector3.new(0, 2.5, 0)
            seat.Anchored = true
            seat.Color = Color3.fromRGB(60, 60, 70)
            seat.Material = Enum.Material.SmoothPlastic
            seat.Parent = MueblesFolder
        end
    end
    
    -- Crear 6 mesas - espaciadas 20 studs
    local posicionesMesas = {
        Vector3.new(-40, 0, 200),
        Vector3.new(-40, 0, 220),
        Vector3.new(-40, 0, 240),
        Vector3.new(40, 0, 200),
        Vector3.new(40, 0, 220),
        Vector3.new(40, 0, 240)
    }
    
    for _, pos in ipairs(posicionesMesas) do
        CrearMesa(pos)
    end
    
    print("✅ Mesas OK")
end

-- ============================================
-- BAR
-- ============================================

local function CrearBar()
    print("🍹 Creando bar...")
    
    local posBar = Vector3.new(-50, 0, 220)
    
    -- Mostrador - 3 studs ancho x 6 studs alto x 30 studs largo
    local mostrador = Instance.new("Part")
    mostrador.Size = Vector3.new(3, 6, 30)
    mostrador.Position = posBar + Vector3.new(0, 3, 0)
    mostrador.Anchored = true
    mostrador.Color = Color3.fromRGB(80, 50, 30)
    mostrador.Material = Enum.Material.SmoothPlastic
    mostrador.Parent = MueblesFolder
    
    -- Superficie - 3.5 studs x 30.5 studs
    local superficie = Instance.new("Part")
    superficie.Size = Vector3.new(3.5, 0.3, 30.5)
    superficie.Position = posBar + Vector3.new(0, 6, 0)
    superficie.Anchored = true
    superficie.Color = Color3.fromRGB(20, 20, 25)
    superficie.Material = Enum.Material.SmoothPlastic
    superficie.Parent = mostrador
    
    -- Estantes (3 niveles, separados 3 studs)
    for nivel = 1, 3 do
        local estante = Instance.new("Part")
        estante.Size = Vector3.new(1, 0.3, 28)
        estante.Position = posBar + Vector3.new(-2, 6 + (nivel * 3), 0)
        estante.Anchored = true
        estante.Color = Color3.fromRGB(60, 40, 25)
        estante.Material = Enum.Material.SmoothPlastic
        estante.Parent = mostrador
        
        -- Botellas - 0.8 studs ancho x 2.5 studs alto, cada 4 studs
        for i = -12, 12, 4 do
            local botella = Instance.new("Part")
            botella.Size = Vector3.new(0.8, 2.5, 0.8)
            botella.Position = estante.Position + Vector3.new(0, 1.5, i)
            botella.Anchored = true
            botella.Color = Color3.fromRGB(100, 200, 100)
            botella.Material = Enum.Material.SmoothPlastic
            botella.Transparency = 0.3
            botella.Parent = estante
        end
    end
    
    -- Taburetes - 2 studs diametro, cada 5 studs
    for i = -10, 10, 5 do
        local seat = Instance.new("Seat")
        seat.Size = Vector3.new(2, 0.5, 2)
        seat.Position = posBar + Vector3.new(3, 4, i)
        seat.Anchored = true
        seat.Color = COLORES_CUBANOS.Rojo
        seat.Material = Enum.Material.SmoothPlastic
        seat.Parent = MueblesFolder
        
        local mesh = Instance.new("CylinderMesh")
        mesh.Parent = seat
    end
    
    print("✅ Bar OK")
end

-- ============================================
-- ESCENARIO
-- ============================================

local function CrearEscenario()
    print("🎤 Creando escenario...")
    
    local posEsc = Vector3.new(0, 5, 260)
    
    -- Plataforma - 50 studs x 20 studs x 1 stud alto
    local escenario = Instance.new("Part")
    escenario.Name = "EscenarioPrincipal"
    escenario.Size = Vector3.new(50, 1, 20)
    escenario.Position = posEsc
    escenario.Anchored = true
    escenario.Color = Color3.fromRGB(15, 15, 20)
    escenario.Material = Enum.Material.SmoothPlastic
    escenario.Parent = SalonFolder
    
    -- LEDs frontales - 0.5 studs, cada 2.5 studs
    local coloresLED = {COLORES_CUBANOS.Rojo, COLORES_CUBANOS.Amarillo, COLORES_CUBANOS.Verde, COLORES_CUBANOS.Azul}
    for i = 1, 20 do
        local led = Instance.new("Part")
        led.Size = Vector3.new(0.5, 0.5, 0.5)
        led.Position = posEsc + Vector3.new(-25 + (i * 2.5), -0.5, -10)
        led.Anchored = true
        led.Color = coloresLED[math.random(1, #coloresLED)]
        led.Material = Enum.Material.Neon
        led.Parent = escenario
        
        local ledMesh = Instance.new("SpecialMesh")
        ledMesh.MeshType = Enum.MeshType.Sphere
        ledMesh.Parent = led
        
        local luz = Instance.new("PointLight")
        luz.Brightness = 3
        luz.Color = led.Color
        luz.Range = 10
        luz.Parent = led
    end
    
    -- Escaleras (5 escalones de 1 stud cada uno)
    for lado = -1, 1, 2 do
        for i = 1, 5 do
            local escalon = Instance.new("Part")
            escalon.Size = Vector3.new(5, 1, 3)
            escalon.Position = posEsc + Vector3.new(lado * 27, -5 + i, -12 - (i * 2))
            escalon.Anchored = true
            escalon.Color = Color3.fromRGB(60, 60, 70)
            escalon.Material = Enum.Material.SmoothPlastic
            escalon.Parent = escenario
        end
    end
    
    print("✅ Escenario OK")
    return escenario
end

-- ============================================
-- TELEVISOR
-- ============================================

local function CrearTV(escenario)
    print("📺 Creando TV...")
    
    local posTV = escenario.Position + Vector3.new(0, 45, 12)
    
    -- Marco - 55 studs x 32 studs x 2 studs
    local marco = Instance.new("Part")
    marco.Size = Vector3.new(55, 32, 2)
    marco.Position = posTV
    marco.Anchored = true
    marco.Color = Color3.fromRGB(10, 10, 15)
    marco.Material = Enum.Material.SmoothPlastic
    marco.Orientation = Vector3.new(15, 0, 0)
    marco.Parent = SalonFolder
    
    -- Pantalla - 53 studs x 30 studs
    local pantalla = Instance.new("Part")
    pantalla.Name = "PantallaTV"
    pantalla.Size = Vector3.new(53, 30, 0.5)
    pantalla.Position = posTV + Vector3.new(0, 0, -1.2)
    pantalla.Anchored = true
    pantalla.Color = Color3.fromRGB(0, 0, 0)
    pantalla.Material = Enum.Material.Neon
    pantalla.Orientation = Vector3.new(15, 0, 0)
    pantalla.Parent = SalonFolder
    
    -- GUI
    local gui = Instance.new("SurfaceGui")
    gui.Name = "PlaylistGUI"
    gui.Face = Enum.NormalId.Back
    gui.LightInfluence = 0
    gui.Brightness = 2
    gui.Parent = pantalla
    
    local fondo = Instance.new("Frame")
    fondo.Size = UDim2.new(1, 0, 1, 0)
    fondo.BackgroundColor3 = COLORES_CUBANOS.Morado
    fondo.Parent = gui
    
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(0.9, 0, 0.15, 0)
    titulo.Position = UDim2.new(0.05, 0, 0.05, 0)
    titulo.BackgroundTransparency = 1
    titulo.Text = "🎵 PLAYLIST EN VIVO 🎵"
    titulo.TextColor3 = COLORES_CUBANOS.Blanco
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = fondo
    
    local actualFrame = Instance.new("Frame")
    actualFrame.Size = UDim2.new(0.9, 0, 0.25, 0)
    actualFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
    actualFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    actualFrame.BackgroundTransparency = 0.3
    actualFrame.Parent = fondo
    
    local nombreActual = Instance.new("TextLabel")
    nombreActual.Name = "NombreCancionActual"
    nombreActual.Size = UDim2.new(0.95, 0, 0.5, 0)
    nombreActual.Position = UDim2.new(0.025, 0, 0.2, 0)
    nombreActual.BackgroundTransparency = 1
    nombreActual.Text = PLAYLIST_COMPLETA[1].nombre
    nombreActual.TextColor3 = COLORES_CUBANOS.Amarillo
    nombreActual.TextScaled = true
    nombreActual.Font = Enum.Font.GothamBold
    nombreActual.Parent = actualFrame
    
    local infoActual = Instance.new("TextLabel")
    infoActual.Name = "InfoCancionActual"
    infoActual.Size = UDim2.new(0.95, 0, 0.25, 0)
    infoActual.Position = UDim2.new(0.025, 0, 0.7, 0)
    infoActual.BackgroundTransparency = 1
    infoActual.Text = PLAYLIST_COMPLETA[1].genero .. " | " .. PLAYLIST_COMPLETA[1].duracion
    infoActual.TextColor3 = COLORES_CUBANOS.Blanco
    infoActual.TextScaled = true
    infoActual.Font = Enum.Font.Gotham
    infoActual.Parent = actualFrame
    
    print("✅ TV OK")
    return pantalla
end

-- ============================================
-- SISTEMA DE MUSICA
-- ============================================

local function SistemaMusica(pantallaTV)
    print("🎵 Sistema de musica...")
    
    musicaSound = Instance.new("Sound")
    musicaSound.Name = "MusicaAmbiental"
    musicaSound.Volume = 0.7
    musicaSound.Looped = false
    musicaSound.SoundId = PLAYLIST_COMPLETA[cancionActual].id
    musicaSound.Parent = Workspace
    
    musicaSound:Play()
    
    local function CambiarCancion(nuevaCancion)
        if nuevaCancion and nuevaCancion >= 1 and nuevaCancion <= #PLAYLIST_COMPLETA then
            cancionActual = nuevaCancion
        else
            cancionActual = (cancionActual % #PLAYLIST_COMPLETA) + 1
        end
        
        musicaSound.SoundId = PLAYLIST_COMPLETA[cancionActual].id
        musicaSound:Play()
        
        if pantallaTV then
            local gui = pantallaTV:FindFirstChild("PlaylistGUI")
            if gui then
                local fondo = gui:FindFirstChild("Frame")
                if fondo then
                    local actualFrame = fondo:FindFirstChild("Frame")
                    if actualFrame then
                        local nombreLabel = actualFrame:FindFirstChild("NombreCancionActual")
                        local infoLabel = actualFrame:FindFirstChild("InfoCancionActual")
                        if nombreLabel then
                            nombreLabel.Text = PLAYLIST_COMPLETA[cancionActual].nombre
                        end
                        if infoLabel then
                            infoLabel.Text = PLAYLIST_COMPLETA[cancionActual].genero .. " | " .. PLAYLIST_COMPLETA[cancionActual].duracion
                        end
                    end
                end
            end
        end
    end
    
    musicaSound.Ended:Connect(function()
        CambiarCancion()
    end)
    
    local eventosFolder = ReplicatedStorage:WaitForChild("FiestaNocturnaEvents", 5)
    if eventosFolder then
        local cambiarMusicaEvent = eventosFolder:FindFirstChild("CambiarMusicaEvent")
        if cambiarMusicaEvent then
            cambiarMusicaEvent.OnServerEvent:Connect(function(player, accion, valor)
                if accion == "cambiar" then
                    CambiarCancion(valor)
                elseif accion == "volumen" then
                    musicaSound.Volume = math.clamp(valor, 0, 1)
                end
            end)
        end
    end
    
    print("✅ Musica OK")
end

-- ============================================
-- EFECTOS
-- ============================================

local function CrearEfectos(escenario)
    print("✨ Efectos...")
    
    local humo = Instance.new("Part")
    humo.Size = Vector3.new(40, 1, 18)
    humo.Position = escenario.Position + Vector3.new(0, -2, 0)
    humo.Anchored = true
    humo.Transparency = 1
    humo.CanCollide = false
    humo.Parent = EfectosFolder
    
    local particleHumo = Instance.new("ParticleEmitter")
    particleHumo.Texture = "rbxasset://textures/particles/smoke_main.dds"
    particleHumo.Rate = 20
    particleHumo.Lifetime = NumberRange.new(5, 8)
    particleHumo.Speed = NumberRange.new(2, 5)
    particleHumo.Color = ColorSequence.new(Color3.fromRGB(200, 200, 255))
    particleHumo.Size = NumberSequence.new(8, 12)
    particleHumo.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.5, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    }
    particleHumo.Parent = humo
    
    print("✅ Efectos OK")
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
-- EVENTOS
-- ============================================

local function CrearEventos()
    local eventosFolder = Instance.new("Folder")
    eventosFolder.Name = "FiestaNocturnaEvents"
    eventosFolder.Parent = ReplicatedStorage
    
    local bailarEvent = Instance.new("RemoteEvent")
    bailarEvent.Name = "BailarEvent"
    bailarEvent.Parent = eventosFolder
    
    local cambiarMusicaEvent = Instance.new("RemoteEvent")
    cambiarMusicaEvent.Name = "CambiarMusicaEvent"
    cambiarMusicaEvent.Parent = eventosFolder
    
    local obtenerPlaylist = Instance.new("RemoteFunction")
    obtenerPlaylist.Name = "ObtenerPlaylistFunction"
    obtenerPlaylist.Parent = eventosFolder
    
    obtenerPlaylist.OnServerInvoke = function(player)
        return PLAYLIST_COMPLETA, cancionActual
    end
    
    print("✅ Eventos OK")
end

-- ============================================
-- INICIALIZACION
-- ============================================

print("🇨🇺 ========================================")
print("🇨🇺 FIESTA NOCTURNA V2 - REDISEÑADO")
print("🇨🇺 ========================================")

ConfigurarIluminacion()
CrearBase()
CrearCalle()
CrearSalon()
CrearMesas()
CrearBar()
local escenario = CrearEscenario()
local pantallaTV = CrearTV(escenario)
CrearEfectos(escenario)
CrearSpawn()
CrearEventos()
SistemaMusica(pantallaTV)

print("🇨🇺 ========================================")
print("🇨🇺 ✅ TODO LISTO - ENTRADA ABIERTA!")
print("🇨🇺 ========================================")

Players.PlayerAdded:Connect(function(player)
    print("👋 " .. player.Name .. " se unio!")
end)
