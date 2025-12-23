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
    -- Modelo de palmera cubana realista
    local palmeraModel = Instance.new("Model")
    palmeraModel.Name = "PalmeraCubana"
    palmeraModel.Parent = CalleFolder
    
    -- TRONCO CURVADO REALISTA (18 studs de alto)
    local segmentosTronco = 9
    local alturaPorSegmento = 2
    local curvatura = math.random(-15, 15) -- Curvatura natural aleatoria
    
    for i = 1, segmentosTronco do
        local segmento = Instance.new("Part")
        segmento.Name = "TroncoSegmento" .. i
        
        -- Tronco más grueso en la base, más delgado arriba
        local grosor = 2.5 - (i * 0.15)
        segmento.Size = Vector3.new(grosor, alturaPorSegmento, grosor)
        
        -- Curvatura progresiva del tronco
        local offsetX = math.sin(math.rad(curvatura * i / segmentosTronco)) * (i * 0.3)
        local offsetZ = math.cos(math.rad(curvatura * i / segmentosTronco)) * (i * 0.2)
        
        segmento.Position = posicion + Vector3.new(
            offsetX, 
            (i - 1) * alturaPorSegmento + alturaPorSegmento/2, 
            offsetZ
        )
        segmento.Anchored = true
        
        -- Colores más realistas del tronco
        local colorTronco = Color3.fromRGB(120 - i*3, 85 - i*2, 45 - i)
        segmento.Color = colorTronco
        segmento.Material = Enum.Material.SmoothPlastic
        segmento.Parent = palmeraModel
        
        -- Mesh cilíndrico
        local cilindro = Instance.new("CylinderMesh")
        cilindro.Parent = segmento
        
        -- Anillos característicos de palmera (cada 2 segmentos)
        if i % 2 == 0 then
            local anillo = Instance.new("Part")
            anillo.Name = "AnilloPalmera" .. i
            anillo.Size = Vector3.new(grosor + 0.4, 0.4, grosor + 0.4)
            anillo.Position = segmento.Position + Vector3.new(0, alturaPorSegmento/2 - 0.1, 0)
            anillo.Anchored = true
            anillo.Color = Color3.fromRGB(95, 65, 35)
            anillo.Material = Enum.Material.SmoothPlastic
            anillo.Parent = palmeraModel
            
            local anilloMesh = Instance.new("CylinderMesh")
            anilloMesh.Parent = anillo
        end
        
        -- Marcas y cicatrices del tronco
        if math.random() > 0.7 then
            local cicatriz = Instance.new("Part")
            cicatriz.Size = Vector3.new(0.2, 0.8, 0.2)
            cicatriz.Position = segmento.Position + Vector3.new(
                math.random(-grosor/2, grosor/2) * 0.8,
                math.random(-alturaPorSegmento/2, alturaPorSegmento/2),
                grosor/2
            )
            cicatriz.Anchored = true
            cicatriz.Color = Color3.fromRGB(80, 50, 25)
            cicatriz.Material = Enum.Material.SmoothPlastic
            cicatriz.Parent = palmeraModel
        end
    end
    
    -- COPA DE HOJAS REALISTA (16-20 hojas)
    local numHojas = math.random(16, 20)
    local alturaCopa = segmentosTronco * alturaPorSegmento
    local posicionCopa = posicion + Vector3.new(
        math.sin(math.rad(curvatura)) * (segmentosTronco * 0.3),
        alturaCopa,
        math.cos(math.rad(curvatura)) * (segmentosTronco * 0.2)
    )
    
    for i = 1, numHojas do
        local angulo = (i - 1) * (360 / numHojas) + math.random(-10, 10)
        local inclinacion = math.random(-45, -25) -- Hojas caídas naturalmente
        
        -- RAQUIS (tallo principal de la hoja) - más largo y curvado
        local longitudRaquis = math.random(8, 12)
        local raquis = Instance.new("Part")
        raquis.Name = "RaquisHoja" .. i
        raquis.Size = Vector3.new(0.25, 0.25, longitudRaquis)
        raquis.CFrame = CFrame.new(posicionCopa) 
            * CFrame.Angles(math.rad(inclinacion), math.rad(angulo), math.rad(math.random(-5, 5)))
            * CFrame.new(0, 0, longitudRaquis/2)
        raquis.Anchored = true
        raquis.Color = Color3.fromRGB(85, 140, 60)
        raquis.Material = Enum.Material.SmoothPlastic
        raquis.Parent = palmeraModel
        
        -- FOLIOLOS (hojas pequeñas a los lados) - más realistas
        local numFoliolos = math.random(12, 18)
        for j = 1, numFoliolos do
            local posicionFoliolo = (j - 1) / (numFoliolos - 1) -- 0 a 1
            local tamanoFoliolo = 1.5 + (1 - math.abs(posicionFoliolo - 0.5) * 2) * 2 -- Más grande en el centro
            
            -- Foliolo izquierdo
            local folioloIzq = Instance.new("Part")
            folioloIzq.Name = "FolioloIzq" .. i .. "_" .. j
            folioloIzq.Size = Vector3.new(tamanoFoliolo, 0.1, 0.8)
            folioloIzq.CFrame = raquis.CFrame 
                * CFrame.new(0, 0, (posicionFoliolo - 0.5) * longitudRaquis)
                * CFrame.new(-tamanoFoliolo/2, 0, 0)
                * CFrame.Angles(0, 0, math.rad(15 + math.random(-5, 5)))
            folioloIzq.Anchored = true
            
            -- Variación de color verde más natural
            local verdeBase = math.random(45, 65)
            folioloIzq.Color = Color3.fromRGB(verdeBase, 120 + math.random(-15, 15), verdeBase + 10)
            folioloIzq.Material = Enum.Material.SmoothPlastic
            folioloIzq.Parent = palmeraModel
            
            -- Foliolo derecho
            local folioloDer = Instance.new("Part")
            folioloDer.Name = "FolioloDer" .. i .. "_" .. j
            folioloDer.Size = Vector3.new(tamanoFoliolo, 0.1, 0.8)
            folioloDer.CFrame = raquis.CFrame 
                * CFrame.new(0, 0, (posicionFoliolo - 0.5) * longitudRaquis)
                * CFrame.new(tamanoFoliolo/2, 0, 0)
                * CFrame.Angles(0, 0, math.rad(-15 + math.random(-5, 5)))
            folioloDer.Anchored = true
            folioloDer.Color = folioloIzq.Color
            folioloDer.Material = Enum.Material.SmoothPlastic
            folioloDer.Parent = palmeraModel
        end
        
        -- Punta de la hoja (ápice)
        local apice = Instance.new("Part")
        apice.Name = "ApiceHoja" .. i
        apice.Size = Vector3.new(1, 0.1, 1.5)
        apice.CFrame = raquis.CFrame * CFrame.new(0, 0, longitudRaquis/2 + 0.5)
        apice.Anchored = true
        apice.Color = Color3.fromRGB(40, 100, 35)
        apice.Material = Enum.Material.SmoothPlastic
        apice.Parent = palmeraModel
    end
    
    -- COCOS REALISTAS (racimo)
    local numCocos = math.random(6, 10)
    local racimo = Instance.new("Part")
    racimo.Name = "RacimoCocos"
    racimo.Size = Vector3.new(0.5, 2, 0.5)
    racimo.Position = posicionCopa + Vector3.new(0, -2, 0)
    racimo.Anchored = true
    racimo.Color = Color3.fromRGB(85, 140, 60)
    racimo.Material = Enum.Material.SmoothPlastic
    racimo.Parent = palmeraModel
    
    for i = 1, numCocos do
        local coco = Instance.new("Part")
        coco.Name = "Coco" .. i
        local tamano = math.random(10, 14) / 10
        coco.Size = Vector3.new(tamano, tamano * 1.3, tamano)
        
        -- Distribución natural del racimo
        local anguloCoco = math.random(0, 360)
        local radioCoco = math.random(0.5, 1.2)
        coco.Position = racimo.Position + Vector3.new(
            math.cos(math.rad(anguloCoco)) * radioCoco,
            math.random(-1, 0.5),
            math.sin(math.rad(anguloCoco)) * radioCoco
        )
        coco.Anchored = true
        
        -- Colores variados de cocos (verdes, amarillos, marrones)
        local tipoColor = math.random(1, 3)
        if tipoColor == 1 then
            coco.Color = Color3.fromRGB(60, 120, 40) -- Verde
        elseif tipoColor == 2 then
            coco.Color = Color3.fromRGB(160, 140, 60) -- Amarillo
        else
            coco.Color = Color3.fromRGB(120, 80, 40) -- Marrón
        end
        
        coco.Material = Enum.Material.SmoothPlastic
        coco.Parent = palmeraModel
        
        local cocoMesh = Instance.new("SpecialMesh")
        cocoMesh.MeshType = Enum.MeshType.Sphere
        cocoMesh.Scale = Vector3.new(1, 1.3, 1)
        cocoMesh.Parent = coco
        
        -- Tallo del coco
        local talloCoco = Instance.new("Part")
        talloCoco.Size = Vector3.new(0.1, 0.5, 0.1)
        talloCoco.Position = Vector3.new(
            (racimo.Position.X + coco.Position.X) / 2,
            (racimo.Position.Y + coco.Position.Y) / 2,
            (racimo.Position.Z + coco.Position.Z) / 2
        )
        talloCoco.Anchored = true
        talloCoco.Color = Color3.fromRGB(85, 140, 60)
        talloCoco.Material = Enum.Material.SmoothPlastic
        talloCoco.Parent = palmeraModel
    end
    
    -- BASE DE LA PALMERA (raíces visibles)
    for i = 1, 4 do
        local raiz = Instance.new("Part")
        raiz.Name = "Raiz" .. i
        raiz.Size = Vector3.new(0.8, 0.5, 3)
        local anguloRaiz = (i - 1) * 90 + math.random(-20, 20)
        raiz.CFrame = CFrame.new(posicion + Vector3.new(0, 0.2, 0))
            * CFrame.Angles(math.rad(-10), math.rad(anguloRaiz), 0)
            * CFrame.new(0, 0, 1.5)
        raiz.Anchored = true
        raiz.Color = Color3.fromRGB(100, 70, 40)
        raiz.Material = Enum.Material.SmoothPlastic
        raiz.Parent = palmeraModel
    end
    
    return palmeraModel
end

-- ============================================
-- CALLE CUBANA AUTENTICA
-- ============================================

local function CrearCalle()
    print("🏘️ Creando calle cubana auténtica...")
    
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
    
    -- Faroles coloniales cubanos cada 40 studs
    for z = -150, 150, 40 do
        for x = -48, 48, 96 do
            -- Poste colonial - 14 studs alto
            local poste = Instance.new("Part")
            poste.Size = Vector3.new(0.8, 14, 0.8)
            poste.Position = Vector3.new(x, 7, z)
            poste.Anchored = true
            poste.Color = Color3.fromRGB(40, 40, 45)
            poste.Material = Enum.Material.SmoothPlastic
            poste.Parent = CalleFolder
            
            -- Base ornamental
            local base = Instance.new("Part")
            base.Size = Vector3.new(2.5, 1, 2.5)
            base.Position = Vector3.new(x, 0.5, z)
            base.Anchored = true
            base.Color = Color3.fromRGB(80, 80, 85)
            base.Material = Enum.Material.SmoothPlastic
            base.Parent = CalleFolder
            
            -- Farol estilo colonial
            local farol = Instance.new("Part")
            farol.Size = Vector3.new(4, 4, 4)
            farol.Position = Vector3.new(x, 14.5, z)
            farol.Anchored = true
            farol.Color = COLORES_CUBANOS.Amarillo
            farol.Material = Enum.Material.Neon
            farol.Transparency = 0.3
            farol.Parent = CalleFolder
            
            -- Marco del farol
            local marco = Instance.new("Part")
            marco.Size = Vector3.new(4.5, 4.5, 4.5)
            marco.Position = Vector3.new(x, 14.5, z)
            marco.Anchored = true
            marco.Color = Color3.fromRGB(20, 20, 25)
            marco.Material = Enum.Material.SmoothPlastic
            marco.Transparency = 0.7
            marco.Parent = CalleFolder
            
            local luz = Instance.new("PointLight")
            luz.Brightness = 4
            luz.Color = COLORES_CUBANOS.Amarillo
            luz.Range = 60
            luz.Parent = farol
        end
    end
    
    -- Casas coloniales cubanas de fondo
    print("🏠 Creando casas coloniales...")
    for i = 1, 8 do
        local x = math.random(-80, 80)
        local z = math.random(-180, -100)
        
        -- Casa base
        local casa = Instance.new("Part")
        casa.Size = Vector3.new(15, 12, 10)
        casa.Position = Vector3.new(x, 6, z)
        casa.Anchored = true
        
        -- Colores típicos cubanos
        local coloresCasas = {
            Color3.fromRGB(255, 180, 120), -- Amarillo pastel
            Color3.fromRGB(180, 220, 255), -- Azul pastel
            Color3.fromRGB(255, 200, 200), -- Rosa pastel
            Color3.fromRGB(200, 255, 200), -- Verde pastel
            Color3.fromRGB(255, 220, 180)  -- Naranja pastel
        }
        casa.Color = coloresCasas[math.random(1, #coloresCasas)]
        casa.Material = Enum.Material.SmoothPlastic
        casa.Parent = CalleFolder
        
        -- Techo de tejas
        local techo = Instance.new("Part")
        techo.Size = Vector3.new(17, 1, 12)
        techo.Position = Vector3.new(x, 12.5, z)
        techo.Anchored = true
        techo.Color = Color3.fromRGB(150, 80, 60)
        techo.Material = Enum.Material.SmoothPlastic
        techo.Parent = CalleFolder
        
        -- Ventanas coloniales
        for j = 1, 2 do
            local ventana = Instance.new("Part")
            ventana.Size = Vector3.new(3, 4, 0.2)
            ventana.Position = Vector3.new(x + (j-1.5)*5, 8, z - 5.1)
            ventana.Anchored = true
            ventana.Color = Color3.fromRGB(100, 150, 200)
            ventana.Material = Enum.Material.SmoothPlastic
            ventana.Transparency = 0.3
            ventana.Parent = CalleFolder
            
            -- Marco de ventana
            local marco = Instance.new("Part")
            marco.Size = Vector3.new(3.5, 4.5, 0.3)
            marco.Position = ventana.Position + Vector3.new(0, 0, -0.1)
            marco.Anchored = true
            marco.Color = Color3.fromRGB(255, 255, 255)
            marco.Material = Enum.Material.SmoothPlastic
            marco.Parent = CalleFolder
        end
        
        -- Puerta
        local puerta = Instance.new("Part")
        puerta.Size = Vector3.new(2.5, 6, 0.3)
        puerta.Position = Vector3.new(x, 3, z - 5.15)
        puerta.Anchored = true
        puerta.Color = Color3.fromRGB(120, 80, 40)
        puerta.Material = Enum.Material.SmoothPlastic
        puerta.Parent = CalleFolder
    end
    
    -- Plantas tropicales adicionales
    print("🌺 Agregando flora tropical...")
    for i = 1, 20 do
        local x = math.random(-90, 90)
        local z = math.random(-180, 180)
        
        -- Arbustos tropicales
        local arbusto = Instance.new("Part")
        arbusto.Size = Vector3.new(3, 2, 3)
        arbusto.Position = Vector3.new(x, 1, z)
        arbusto.Anchored = true
        arbusto.Color = Color3.fromRGB(60, 140, 80)
        arbusto.Material = Enum.Material.SmoothPlastic
        arbusto.Parent = CalleFolder
        
        local arbustoMesh = Instance.new("SpecialMesh")
        arbustoMesh.MeshType = Enum.MeshType.Sphere
        arbustoMesh.Parent = arbusto
        
        -- Flores tropicales aleatorias
        if math.random() > 0.6 then
            local flor = Instance.new("Part")
            flor.Size = Vector3.new(0.8, 0.8, 0.8)
            flor.Position = arbusto.Position + Vector3.new(
                math.random(-1, 1),
                1.5,
                math.random(-1, 1)
            )
            flor.Anchored = true
            
            local coloresFlores = {
                COLORES_CUBANOS.Rosa,
                COLORES_CUBANOS.Amarillo,
                COLORES_CUBANOS.Naranja,
                Color3.fromRGB(255, 100, 255)
            }
            flor.Color = coloresFlores[math.random(1, #coloresFlores)]
            flor.Material = Enum.Material.Neon
            flor.Transparency = 0.2
            flor.Parent = CalleFolder
            
            local florMesh = Instance.new("SpecialMesh")
            florMesh.MeshType = Enum.MeshType.Sphere
            florMesh.Parent = flor
        end
    end
    
    -- Palmeras cubanas realistas (20 palmeras distribuidas)
    print("🌴 Creando palmeras cubanas realistas...")
    local posicionesPalmeras = {
        Vector3.new(-45, 0, -120), Vector3.new(45, 0, -120),
        Vector3.new(-45, 0, -80), Vector3.new(45, 0, -80),
        Vector3.new(-45, 0, -40), Vector3.new(45, 0, -40),
        Vector3.new(-45, 0, 0), Vector3.new(45, 0, 0),
        Vector3.new(-45, 0, 40), Vector3.new(45, 0, 40),
        Vector3.new(-35, 0, 100), Vector3.new(35, 0, 100),
        Vector3.new(-35, 0, 130), Vector3.new(35, 0, 130),
        Vector3.new(0, 0, 160), Vector3.new(-25, 0, 80),
        Vector3.new(25, 0, 80), Vector3.new(-60, 0, 20),
        Vector3.new(60, 0, 20), Vector3.new(0, 0, -60)
    }
    
    for _, pos in ipairs(posicionesPalmeras) do
        CrearPalmeraCubana(pos)
    end
    
    -- Bancos cubanos
    print("🪑 Agregando bancos típicos...")
    for i = 1, 6 do
        local x = math.random(-40, 40)
        local z = math.random(-100, 100)
        
        local banco = Instance.new("Seat")
        banco.Size = Vector3.new(6, 1, 2)
        banco.Position = Vector3.new(x, 1.5, z)
        banco.Anchored = true
        banco.Color = Color3.fromRGB(180, 120, 80)
        banco.Material = Enum.Material.SmoothPlastic
        banco.Parent = CalleFolder
        
        -- Respaldo
        local respaldo = Instance.new("Part")
        respaldo.Size = Vector3.new(6, 2, 0.3)
        respaldo.Position = Vector3.new(x, 2.5, z + 0.85)
        respaldo.Anchored = true
        respaldo.Color = Color3.fromRGB(180, 120, 80)
        respaldo.Material = Enum.Material.SmoothPlastic
        respaldo.Parent = CalleFolder
    end
    
    print("✅ Calle cubana auténtica completada")
end

-- ============================================
-- SALON CUBANO CON ENTRADA ABIERTA
-- ============================================

local function CrearSalon()
    print("🎉 Creando salón cubano con entrada abierta...")
    
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
    
    -- Mosaicos cubanos tradicionales - patrón de 8x8 studs
    for x = -56, 56, 8 do
        for z = -46, 46, 8 do
            local mosaico = Instance.new("Part")
            mosaico.Size = Vector3.new(7.5, 0.3, 7.5)
            mosaico.Position = posBase + Vector3.new(x, 0.65, z)
            mosaico.Anchored = true
            
            -- Patrón de colores cubanos tradicionales
            local patron = (math.abs(x) + math.abs(z)) / 8
            if patron % 4 == 0 then
                mosaico.Color = Color3.fromRGB(220, 200, 180) -- Crema
            elseif patron % 4 == 1 then
                mosaico.Color = Color3.fromRGB(180, 160, 140) -- Beige
            elseif patron % 4 == 2 then
                mosaico.Color = Color3.fromRGB(160, 120, 100) -- Terracota
            else
                mosaico.Color = Color3.fromRGB(120, 100, 80) -- Marrón
            end
            
            mosaico.Material = Enum.Material.SmoothPlastic
            mosaico.Parent = SalonFolder
            
            -- Detalles decorativos en algunos mosaicos
            if math.random() > 0.8 then
                local detalle = Instance.new("Part")
                detalle.Size = Vector3.new(1, 0.1, 1)
                detalle.Position = mosaico.Position + Vector3.new(0, 0.2, 0)
                detalle.Anchored = true
                detalle.Color = COLORES_CUBANOS.Amarillo
                detalle.Material = Enum.Material.Neon
                detalle.Transparency = 0.5
                detalle.Parent = SalonFolder
                
                local detalleMesh = Instance.new("SpecialMesh")
                detalleMesh.MeshType = Enum.MeshType.Sphere
                detalleMesh.Parent = detalle
            end
        end
    end
    
    -- PAREDES CON DECORACIÓN CUBANA (3 lados - SIN PARED FRONTAL)
    local alturaParedes = 30
    
    -- Pared trasera con murales cubanos
    local paredTrasera = Instance.new("Part")
    paredTrasera.Name = "ParedTrasera"
    paredTrasera.Size = Vector3.new(120, alturaParedes, 3)
    paredTrasera.Position = posBase + Vector3.new(0, alturaParedes/2, 50)
    paredTrasera.Anchored = true
    paredTrasera.Color = Color3.fromRGB(45, 40, 35)
    paredTrasera.Material = Enum.Material.SmoothPlastic
    paredTrasera.Parent = SalonFolder
    
    -- Mural de la bandera cubana
    local mural = Instance.new("Part")
    mural.Size = Vector3.new(40, 15, 0.2)
    mural.Position = posBase + Vector3.new(0, 20, 48.9)
    mural.Anchored = true
    mural.Color = COLORES_CUBANOS.Blanco
    mural.Material = Enum.Material.SmoothPlastic
    mural.Parent = SalonFolder
    
    -- Franjas de la bandera
    for i = 1, 5 do
        local franja = Instance.new("Part")
        franja.Size = Vector3.new(40, 3, 0.1)
        franja.Position = mural.Position + Vector3.new(0, 6 - (i * 3), -0.1)
        franja.Anchored = true
        franja.Color = (i % 2 == 1) and COLORES_CUBANOS.Azul or COLORES_CUBANOS.Blanco
        franja.Material = Enum.Material.SmoothPlastic
        franja.Parent = SalonFolder
    end
    
    -- Triángulo rojo de la bandera
    local triangulo = Instance.new("Part")
    triangulo.Size = Vector3.new(15, 15, 0.1)
    triangulo.Position = mural.Position + Vector3.new(-12.5, 0, -0.15)
    triangulo.Anchored = true
    triangulo.Color = COLORES_CUBANOS.Rojo
    triangulo.Material = Enum.Material.SmoothPlastic
    triangulo.Parent = SalonFolder
    
    -- Estrella (simplificada)
    local estrella = Instance.new("Part")
    estrella.Size = Vector3.new(3, 3, 0.1)
    estrella.Position = triangulo.Position + Vector3.new(0, 0, -0.05)
    estrella.Anchored = true
    estrella.Color = COLORES_CUBANOS.Blanco
    estrella.Material = Enum.Material.Neon
    estrella.Parent = SalonFolder
    
    local estrellaMesh = Instance.new("SpecialMesh")
    estrellaMesh.MeshType = Enum.MeshType.Sphere
    estrellaMesh.Parent = estrella
    
    -- Pared izquierda con ventanas coloniales
    local paredIzq = Instance.new("Part")
    paredIzq.Name = "ParedIzquierda"
    paredIzq.Size = Vector3.new(3, alturaParedes, 100)
    paredIzq.Position = posBase + Vector3.new(-60, alturaParedes/2, 0)
    paredIzq.Anchored = true
    paredIzq.Color = Color3.fromRGB(55, 50, 45)
    paredIzq.Material = Enum.Material.SmoothPlastic
    paredIzq.Parent = SalonFolder
    
    -- Ventanas coloniales en pared izquierda
    for i = 1, 4 do
        local ventana = Instance.new("Part")
        ventana.Size = Vector3.new(0.3, 8, 6)
        ventana.Position = posBase + Vector3.new(-61.5, 15, -30 + (i * 20))
        ventana.Anchored = true
        ventana.Color = Color3.fromRGB(100, 150, 200)
        ventana.Material = Enum.Material.SmoothPlastic
        ventana.Transparency = 0.4
        ventana.Parent = SalonFolder
        
        -- Marco de ventana
        local marco = Instance.new("Part")
        marco.Size = Vector3.new(0.4, 9, 7)
        marco.Position = ventana.Position
        marco.Anchored = true
        marco.Color = COLORES_CUBANOS.Blanco
        marco.Material = Enum.Material.SmoothPlastic
        marco.Parent = SalonFolder
    end
    
    -- Pared derecha con decoración tropical
    local paredDer = Instance.new("Part")
    paredDer.Name = "ParedDerecha"
    paredDer.Size = Vector3.new(3, alturaParedes, 100)
    paredDer.Position = posBase + Vector3.new(60, alturaParedes/2, 0)
    paredDer.Anchored = true
    paredDer.Color = Color3.fromRGB(55, 50, 45)
    paredDer.Material = Enum.Material.SmoothPlastic
    paredDer.Parent = SalonFolder
    
    -- Decoraciones tropicales en pared derecha
    for i = 1, 6 do
        local decoracion = Instance.new("Part")
        decoracion.Size = Vector3.new(0.2, 4, 4)
        decoracion.Position = posBase + Vector3.new(61.4, 10 + math.random(-5, 5), -40 + (i * 15))
        decoracion.Anchored = true
        decoracion.Color = COLORES_CUBANOS.Verde
        decoracion.Material = Enum.Material.Neon
        decoracion.Transparency = 0.3
        decoracion.Parent = SalonFolder
        
        local decorMesh = Instance.new("SpecialMesh")
        decorMesh.MeshType = Enum.MeshType.Sphere
        decorMesh.Parent = decoracion
    end
    
    -- TECHO CON VIGAS COLONIALES
    local techo = Instance.new("Part")
    techo.Name = "Techo"
    techo.Size = Vector3.new(120, 1, 100)
    techo.Position = posBase + Vector3.new(0, alturaParedes, 0)
    techo.Anchored = true
    techo.Color = Color3.fromRGB(30, 25, 20)
    techo.Material = Enum.Material.SmoothPlastic
    techo.Parent = SalonFolder
    
    -- Vigas coloniales decorativas
    for i = -50, 50, 25 do
        local viga = Instance.new("Part")
        viga.Name = "VigaColonial"
        viga.Size = Vector3.new(6, 3, 100)
        viga.Position = posBase + Vector3.new(i, alturaParedes - 1.5, 0)
        viga.Anchored = true
        viga.Color = Color3.fromRGB(80, 60, 40)
        viga.Material = Enum.Material.SmoothPlastic
        viga.Parent = SalonFolder
    end
    
    -- Lámparas coloniales colgantes
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
            
            local lamparaMesh = Instance.new("SpecialMesh")
            lamparaMesh.MeshType = Enum.MeshType.Sphere
            lamparaMesh.Parent = lampara
            
            local luzLampara = Instance.new("PointLight")
            luzLampara.Brightness = 3
            luzLampara.Color = COLORES_CUBANOS.Amarillo
            luzLampara.Range = 25
            luzLampara.Parent = lampara
            
            -- Cadena de la lámpara
            local cadena = Instance.new("Part")
            cadena.Size = Vector3.new(0.2, 2, 0.2)
            cadena.Position = lampara.Position + Vector3.new(0, 3, 0)
            cadena.Anchored = true
            cadena.Color = Color3.fromRGB(60, 60, 70)
            cadena.Material = Enum.Material.SmoothPlastic
            cadena.Parent = SalonFolder
        end
    end
    
    -- ENTRADA ABIERTA con arco colonial
    -- Columnas ornamentales de entrada
    for lado = -1, 1, 2 do
        local columna = Instance.new("Part")
        columna.Name = "ColumnaColonial"
        columna.Size = Vector3.new(4, 25, 4)
        columna.Position = posBase + Vector3.new(lado * 58, 12.5, -50)
        columna.Anchored = true
        columna.Color = Color3.fromRGB(80, 75, 70)
        columna.Material = Enum.Material.SmoothPlastic
        columna.Parent = SalonFolder
        
        -- Capitel de la columna
        local capitel = Instance.new("Part")
        capitel.Size = Vector3.new(5, 2, 5)
        capitel.Position = columna.Position + Vector3.new(0, 13.5, 0)
        capitel.Anchored = true
        capitel.Color = Color3.fromRGB(100, 95, 90)
        capitel.Material = Enum.Material.SmoothPlastic
        capitel.Parent = SalonFolder
        
        -- Base de la columna
        local base = Instance.new("Part")
        base.Size = Vector3.new(5, 2, 5)
        base.Position = columna.Position + Vector3.new(0, -13.5, 0)
        base.Anchored = true
        base.Color = Color3.fromRGB(100, 95, 90)
        base.Material = Enum.Material.SmoothPlastic
        base.Parent = SalonFolder
    end
    
    -- Arco de entrada
    local arco = Instance.new("Part")
    arco.Name = "ArcoEntrada"
    arco.Size = Vector3.new(120, 8, 4)
    arco.Position = posBase + Vector3.new(0, 22, -50)
    arco.Anchored = true
    arco.Color = Color3.fromRGB(80, 75, 70)
    arco.Material = Enum.Material.SmoothPlastic
    arco.Parent = SalonFolder
    
    -- LETRERO LUMINOSO CUBANO
    local letrero = Instance.new("Part")
    letrero.Name = "LetreroEntrada"
    letrero.Size = Vector3.new(60, 10, 1)
    letrero.Position = posBase + Vector3.new(0, 28, -52)
    letrero.Anchored = true
    letrero.Color = COLORES_CUBANOS.Rosa
    letrero.Material = Enum.Material.Neon
    letrero.Parent = SalonFolder
    
    local luzLetrero = Instance.new("PointLight")
    luzLetrero.Brightness = 6
    luzLetrero.Color = COLORES_CUBANOS.Rosa
    luzLetrero.Range = 80
    luzLetrero.Parent = letrero
    
    local textGui = Instance.new("SurfaceGui")
    textGui.Face = Enum.NormalId.Front
    textGui.Parent = letrero
    
    local texto = Instance.new("TextLabel")
    texto.Size = UDim2.new(1, 0, 1, 0)
    texto.BackgroundTransparency = 1
    texto.Text = "🇨🇺 FIESTA NOCTURNA CUBANA 🇨🇺"
    texto.TextColor3 = COLORES_CUBANOS.Blanco
    texto.TextScaled = true
    texto.Font = Enum.Font.GothamBold
    texto.Parent = textGui
    
    print("✅ Salón cubano con ENTRADA ABIERTA completado")
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
