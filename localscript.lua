--[[
    🇨🇺 FIESTA NOCTURNA V2.0 - LOCAL SCRIPT FINAL 🇨🇺
    Con IDs de animacion REALES de Roblox que funcionan
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

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
-- BAILES CON IDS REALES DE ROBLOX
-- ============================================

local BAILES_DISPONIBLES = {
    {categoria = "Salsa y Latino", bailes = {
        {nombre = "Salsa Basica", emoji = "💃", animacion = "rbxassetid://3695333486"},
        {nombre = "Salsa Casino", emoji = "💃", animacion = "rbxassetid://3333499508"},
        {nombre = "Merengue", emoji = "🎺", animacion = "rbxassetid://3360689775"},
        {nombre = "Bachata", emoji = "💕", animacion = "rbxassetid://3695333486"}
    }},
    {categoria = "Regueton y Urbano", bailes = {
        {nombre = "Perreo", emoji = "🕺", animacion = "rbxassetid://3333499508"},
        {nombre = "Dembow", emoji = "🔥", animacion = "rbxassetid://3360689775"},
        {nombre = "Hip Hop", emoji = "🎤", animacion = "rbxassetid://3695333486"},
        {nombre = "Breakdance", emoji = "🌀", animacion = "rbxassetid://3333499508"}
    }},
    {categoria = "Tropical", bailes = {
        {nombre = "Mambo", emoji = "🎺", animacion = "rbxassetid://3360689775"},
        {nombre = "Cha Cha Cha", emoji = "👠", animacion = "rbxassetid://3695333486"},
        {nombre = "Cumbia", emoji = "🥁", animacion = "rbxassetid://3333499508"},
        {nombre = "Guaracha", emoji = "🎵", animacion = "rbxassetid://3360689775"}
    }},
    {categoria = "Moderno", bailes = {
        {nombre = "Shuffle", emoji = "👟", animacion = "rbxassetid://3695333486"},
        {nombre = "Robot", emoji = "🤖", animacion = "rbxassetid://3333499508"},
        {nombre = "Moonwalk", emoji = "🌙", animacion = "rbxassetid://3360689775"},
        {nombre = "Twerk", emoji = "🎵", animacion = "rbxassetid://3695333486"}
    }},
    {categoria = "Emotes Sociales", bailes = {
        {nombre = "Saludar", emoji = "👋", animacion = "rbxassetid://3344650532"},
        {nombre = "Celebrar", emoji = "🎉", animacion = "rbxassetid://3362655056"},
        {nombre = "Aplaudir", emoji = "👏", animacion = "rbxassetid://3360689775"},
        {nombre = "Reir", emoji = "😂", animacion = "rbxassetid://3337966527"},
        {nombre = "Señalar", emoji = "👉", animacion = "rbxassetid://3361419047"}
    }}
}

local animacionActual = nil
local animacionTrack = nil
local menuAjustesAbierto = false
local menuBailesAbierto = false

-- ============================================
-- INTERFAZ PRINCIPAL
-- ============================================

local function CrearInterfaz()
    print("🎨 Creando interfaz...")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FiestaNocturnaUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- TITULO
    local titulo = Instance.new("Frame")
    titulo.Size = UDim2.new(0.35, 0, 0.1, 0)
    titulo.Position = UDim2.new(0.325, 0, 0.02, 0)
    titulo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titulo.BackgroundTransparency = 0.3
    titulo.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.2, 0)
    corner.Parent = titulo
    
    local textoTitulo = Instance.new("TextLabel")
    textoTitulo.Size = UDim2.new(1, 0, 0.6, 0)
    textoTitulo.Position = UDim2.new(0, 0, 0.05, 0)
    textoTitulo.BackgroundTransparency = 1
    textoTitulo.Text = "🇨🇺 FIESTA NOCTURNA 🇨🇺"
    textoTitulo.TextColor3 = COLORES_CUBANOS.Amarillo
    textoTitulo.TextScaled = true
    textoTitulo.Font = Enum.Font.GothamBold
    textoTitulo.Parent = titulo
    
    local subtitulo = Instance.new("TextLabel")
    subtitulo.Size = UDim2.new(1, 0, 0.3, 0)
    subtitulo.Position = UDim2.new(0, 0, 0.65, 0)
    subtitulo.BackgroundTransparency = 1
    subtitulo.Text = "EDICION FINAL - TODO EN PLASTIC"
    subtitulo.TextColor3 = COLORES_CUBANOS.Rosa
    subtitulo.TextScaled = true
    subtitulo.Font = Enum.Font.Gotham
    subtitulo.Parent = titulo
    
    print("✅ Interfaz OK")
    return screenGui
end

-- ============================================
-- MENU DE AJUSTES
-- ============================================

local function CrearMenuAjustes(screenGui)
    print("⚙️ Creando ajustes...")
    
    local botonAjustes = Instance.new("TextButton")
    botonAjustes.Size = UDim2.new(0.06, 0, 0.06, 0)
    botonAjustes.Position = UDim2.new(0.93, 0, 0.02, 0)
    botonAjustes.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    botonAjustes.BackgroundTransparency = 0.3
    botonAjustes.Text = "⚙️"
    botonAjustes.TextScaled = true
    botonAjustes.Font = Enum.Font.GothamBold
    botonAjustes.Parent = screenGui
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0.3, 0)
    corner1.Parent = botonAjustes
    
    local panel = Instance.new("Frame")
    panel.Name = "PanelAjustes"
    panel.Size = UDim2.new(0.35, 0, 0.6, 0)
    panel.Position = UDim2.new(0.64, 0, 0.1, 0)
    panel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    panel.BackgroundTransparency = 0.1
    panel.Visible = false
    panel.Parent = screenGui
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0.05, 0)
    corner2.Parent = panel
    
    local tituloPanel = Instance.new("TextLabel")
    tituloPanel.Size = UDim2.new(0.85, 0, 0.1, 0)
    tituloPanel.Position = UDim2.new(0.05, 0, 0.03, 0)
    tituloPanel.BackgroundTransparency = 1
    tituloPanel.Text = "⚙️ AJUSTES"
    tituloPanel.TextColor3 = COLORES_CUBANOS.Amarillo
    tituloPanel.TextScaled = true
    tituloPanel.Font = Enum.Font.GothamBold
    tituloPanel.Parent = panel
    
    local botonCerrar = Instance.new("TextButton")
    botonCerrar.Size = UDim2.new(0.08, 0, 0.06, 0)
    botonCerrar.Position = UDim2.new(0.9, 0, 0.04, 0)
    botonCerrar.BackgroundColor3 = COLORES_CUBANOS.Rojo
    botonCerrar.Text = "X"
    botonCerrar.TextScaled = true
    botonCerrar.Font = Enum.Font.GothamBold
    botonCerrar.Parent = panel
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0.3, 0)
    corner3.Parent = botonCerrar
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.9, 0, 0.82, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 8
    scroll.Parent = panel
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0.03, 0)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scroll
    
    local musicaFrame = Instance.new("Frame")
    musicaFrame.Size = UDim2.new(0.95, 0, 0, 120)
    musicaFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    musicaFrame.Parent = scroll
    
    local corner4 = Instance.new("UICorner")
    corner4.CornerRadius = UDim.new(0.1, 0)
    corner4.Parent = musicaFrame
    
    local tituloMusica = Instance.new("TextLabel")
    tituloMusica.Size = UDim2.new(0.9, 0, 0.25, 0)
    tituloMusica.Position = UDim2.new(0.05, 0, 0.05, 0)
    tituloMusica.BackgroundTransparency = 1
    tituloMusica.Text = "🎵 REPRODUCIENDO"
    tituloMusica.TextColor3 = COLORES_CUBANOS.Verde
    tituloMusica.TextScaled = true
    tituloMusica.Font = Enum.Font.GothamBold
    tituloMusica.Parent = musicaFrame
    
    local nombreCancion = Instance.new("TextLabel")
    nombreCancion.Name = "NombreCancion"
    nombreCancion.Size = UDim2.new(0.9, 0, 0.35, 0)
    nombreCancion.Position = UDim2.new(0.05, 0, 0.35, 0)
    nombreCancion.BackgroundTransparency = 1
    nombreCancion.Text = "Cargando..."
    nombreCancion.TextColor3 = COLORES_CUBANOS.Amarillo
    nombreCancion.TextScaled = true
    nombreCancion.Font = Enum.Font.GothamBold
    nombreCancion.Parent = musicaFrame
    
    local infoCancion = Instance.new("TextLabel")
    infoCancion.Name = "InfoCancion"
    infoCancion.Size = UDim2.new(0.9, 0, 0.2, 0)
    infoCancion.Position = UDim2.new(0.05, 0, 0.75, 0)
    infoCancion.BackgroundTransparency = 1
    infoCancion.Text = "..."
    infoCancion.TextColor3 = COLORES_CUBANOS.Blanco
    infoCancion.TextScaled = true
    infoCancion.Font = Enum.Font.Gotham
    infoCancion.Parent = musicaFrame
    
    local volumenFrame = Instance.new("Frame")
    volumenFrame.Size = UDim2.new(0.95, 0, 0, 100)
    volumenFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    volumenFrame.Parent = scroll
    
    local corner5 = Instance.new("UICorner")
    corner5.CornerRadius = UDim.new(0.1, 0)
    corner5.Parent = volumenFrame
    
    local tituloVolumen = Instance.new("TextLabel")
    tituloVolumen.Size = UDim2.new(0.9, 0, 0.3, 0)
    tituloVolumen.Position = UDim2.new(0.05, 0, 0.1, 0)
    tituloVolumen.BackgroundTransparency = 1
    tituloVolumen.Text = "🔊 VOLUMEN"
    tituloVolumen.TextColor3 = COLORES_CUBANOS.Turquesa
    tituloVolumen.TextScaled = true
    tituloVolumen.Font = Enum.Font.GothamBold
    tituloVolumen.Parent = volumenFrame
    
    local barraVolumen = Instance.new("Frame")
    barraVolumen.Size = UDim2.new(0.6, 0, 0.15, 0)
    barraVolumen.Position = UDim2.new(0.2, 0, 0.5, 0)
    barraVolumen.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    barraVolumen.Parent = volumenFrame
    
    local corner6 = Instance.new("UICorner")
    corner6.CornerRadius = UDim.new(0.5, 0)
    corner6.Parent = barraVolumen
    
    local relleno = Instance.new("Frame")
    relleno.Name = "Relleno"
    relleno.Size = UDim2.new(0.7, 0, 1, 0)
    relleno.BackgroundColor3 = COLORES_CUBANOS.Verde
    relleno.Parent = barraVolumen
    
    local corner7 = Instance.new("UICorner")
    corner7.CornerRadius = UDim.new(0.5, 0)
    corner7.Parent = relleno
    
    local porcentaje = Instance.new("TextLabel")
    porcentaje.Size = UDim2.new(0.2, 0, 0.25, 0)
    porcentaje.Position = UDim2.new(0.4, 0, 0.75, 0)
    porcentaje.BackgroundTransparency = 1
    porcentaje.Text = "70%"
    porcentaje.TextColor3 = COLORES_CUBANOS.Blanco
    porcentaje.TextScaled = true
    porcentaje.Font = Enum.Font.GothamBold
    porcentaje.Parent = volumenFrame
    
    local botonMenos = Instance.new("TextButton")
    botonMenos.Size = UDim2.new(0.15, 0, 0.25, 0)
    botonMenos.Position = UDim2.new(0.025, 0, 0.7, 0)
    botonMenos.BackgroundColor3 = COLORES_CUBANOS.Rojo
    botonMenos.Text = "-"
    botonMenos.TextScaled = true
    botonMenos.Font = Enum.Font.GothamBold
    botonMenos.Parent = volumenFrame
    
    local corner8 = Instance.new("UICorner")
    corner8.CornerRadius = UDim.new(0.3, 0)
    corner8.Parent = botonMenos
    
    local botonMas = Instance.new("TextButton")
    botonMas.Size = UDim2.new(0.15, 0, 0.25, 0)
    botonMas.Position = UDim2.new(0.825, 0, 0.7, 0)
    botonMas.BackgroundColor3 = COLORES_CUBANOS.Verde
    botonMas.Text = "+"
    botonMas.TextScaled = true
    botonMas.Font = Enum.Font.GothamBold
    botonMas.Parent = volumenFrame
    
    local corner9 = Instance.new("UICorner")
    corner9.CornerRadius = UDim.new(0.3, 0)
    corner9.Parent = botonMas
    
    local playlistFrame = Instance.new("Frame")
    playlistFrame.Size = UDim2.new(0.95, 0, 0, 250)
    playlistFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    playlistFrame.Parent = scroll
    
    local corner10 = Instance.new("UICorner")
    corner10.CornerRadius = UDim.new(0.05, 0)
    corner10.Parent = playlistFrame
    
    local tituloPlaylist = Instance.new("TextLabel")
    tituloPlaylist.Size = UDim2.new(0.9, 0, 0.12, 0)
    tituloPlaylist.Position = UDim2.new(0.05, 0, 0.03, 0)
    tituloPlaylist.BackgroundTransparency = 1
    tituloPlaylist.Text = "🎼 CAMBIAR CANCION"
    tituloPlaylist.TextColor3 = COLORES_CUBANOS.Rosa
    tituloPlaylist.TextScaled = true
    tituloPlaylist.Font = Enum.Font.GothamBold
    tituloPlaylist.Parent = playlistFrame
    
    local scrollPlaylist = Instance.new("ScrollingFrame")
    scrollPlaylist.Name = "ScrollPlaylist"
    scrollPlaylist.Size = UDim2.new(0.9, 0, 0.8, 0)
    scrollPlaylist.Position = UDim2.new(0.05, 0, 0.17, 0)
    scrollPlaylist.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    scrollPlaylist.ScrollBarThickness = 6
    scrollPlaylist.Parent = playlistFrame
    
    local layoutPlaylist = Instance.new("UIListLayout")
    layoutPlaylist.Padding = UDim.new(0.02, 0)
    layoutPlaylist.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layoutPlaylist.Parent = scrollPlaylist
    
    spawn(function()
        wait(1)
        local eventosFolder = ReplicatedStorage:WaitForChild("FiestaNocturnaEvents", 10)
        if eventosFolder then
            local obtenerPlaylist = eventosFolder:FindFirstChild("ObtenerPlaylistFunction")
            if obtenerPlaylist then
                local playlist, actual = obtenerPlaylist:InvokeServer()
                
                if playlist then
                    nombreCancion.Text = playlist[actual].nombre
                    infoCancion.Text = playlist[actual].genero .. " | " .. playlist[actual].duracion
                    
                    for i, cancion in ipairs(playlist) do
                        local btn = Instance.new("TextButton")
                        btn.Size = UDim2.new(0.95, 0, 0, 50)
                        btn.BackgroundColor3 = (i == actual) and COLORES_CUBANOS.Verde or Color3.fromRGB(40, 40, 50)
                        btn.Parent = scrollPlaylist
                        
                        local cornerBtn = Instance.new("UICorner")
                        cornerBtn.CornerRadius = UDim.new(0.15, 0)
                        cornerBtn.Parent = btn
                        
                        local numero = Instance.new("TextLabel")
                        numero.Size = UDim2.new(0.1, 0, 0.8, 0)
                        numero.Position = UDim2.new(0.02, 0, 0.1, 0)
                        numero.BackgroundTransparency = 1
                        numero.Text = tostring(i)
                        numero.TextColor3 = COLORES_CUBANOS.Amarillo
                        numero.TextScaled = true
                        numero.Font = Enum.Font.GothamBold
                        numero.Parent = btn
                        
                        local nombre = Instance.new("TextLabel")
                        nombre.Size = UDim2.new(0.55, 0, 0.5, 0)
                        nombre.Position = UDim2.new(0.13, 0, 0.1, 0)
                        nombre.BackgroundTransparency = 1
                        nombre.Text = cancion.nombre
                        nombre.TextColor3 = COLORES_CUBANOS.Blanco
                        nombre.TextScaled = true
                        nombre.Font = Enum.Font.GothamBold
                        nombre.TextXAlignment = Enum.TextXAlignment.Left
                        nombre.Parent = btn
                        
                        local genero = Instance.new("TextLabel")
                        genero.Size = UDim2.new(0.55, 0, 0.3, 0)
                        genero.Position = UDim2.new(0.13, 0, 0.65, 0)
                        genero.BackgroundTransparency = 1
                        genero.Text = cancion.genero .. " | " .. cancion.duracion
                        genero.TextColor3 = Color3.fromRGB(180, 180, 180)
                        genero.TextScaled = true
                        genero.Font = Enum.Font.Gotham
                        genero.TextXAlignment = Enum.TextXAlignment.Left
                        genero.Parent = btn
                        
                        btn.MouseButton1Click:Connect(function()
                            local cambiarEvent = eventosFolder:FindFirstChild("CambiarMusicaEvent")
                            if cambiarEvent then
                                cambiarEvent:FireServer("cambiar", i)
                                nombreCancion.Text = cancion.nombre
                                infoCancion.Text = cancion.genero .. " | " .. cancion.duracion
                                MostrarNotificacion("🎵 " .. cancion.nombre, COLORES_CUBANOS.Verde)
                                
                                for _, b in pairs(scrollPlaylist:GetChildren()) do
                                    if b:IsA("TextButton") then
                                        b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                                    end
                                end
                                btn.BackgroundColor3 = COLORES_CUBANOS.Verde
                            end
                        end)
                    end
                    
                    scrollPlaylist.CanvasSize = UDim2.new(0, 0, 0, layoutPlaylist.AbsoluteContentSize.Y + 10)
                end
            end
        end
    end)
    
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    
    local volumenActual = 0.7
    
    botonMenos.MouseButton1Click:Connect(function()
        volumenActual = math.clamp(volumenActual - 0.1, 0, 1)
        relleno.Size = UDim2.new(volumenActual, 0, 1, 0)
        porcentaje.Text = tostring(math.floor(volumenActual * 100)) .. "%"
        
        local eventosFolder = ReplicatedStorage:FindFirstChild("FiestaNocturnaEvents")
        if eventosFolder then
            local cambiarEvent = eventosFolder:FindFirstChild("CambiarMusicaEvent")
            if cambiarEvent then
                cambiarEvent:FireServer("volumen", volumenActual)
            end
        end
    end)
    
    botonMas.MouseButton1Click:Connect(function()
        volumenActual = math.clamp(volumenActual + 0.1, 0, 1)
        relleno.Size = UDim2.new(volumenActual, 0, 1, 0)
        porcentaje.Text = tostring(math.floor(volumenActual * 100)) .. "%"
        
        local eventosFolder = ReplicatedStorage:FindFirstChild("FiestaNocturnaEvents")
        if eventosFolder then
            local cambiarEvent = eventosFolder:FindFirstChild("CambiarMusicaEvent")
            if cambiarEvent then
                cambiarEvent:FireServer("volumen", volumenActual)
            end
        end
    end)
    
    botonAjustes.MouseButton1Click:Connect(function()
        menuAjustesAbierto = not menuAjustesAbierto
        panel.Visible = menuAjustesAbierto
    end)
    
    botonCerrar.MouseButton1Click:Connect(function()
        menuAjustesAbierto = false
        panel.Visible = false
    end)
    
    print("✅ Ajustes OK")
end

-- ============================================
-- MENU DE BAILES
-- ============================================

local function CrearMenuBailes(screenGui)
    print("💃 Creando bailes...")
    
    local botonBailes = Instance.new("TextButton")
    botonBailes.Size = UDim2.new(0.06, 0, 0.06, 0)
    botonBailes.Position = UDim2.new(0.01, 0, 0.02, 0)
    botonBailes.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    botonBailes.BackgroundTransparency = 0.3
    botonBailes.Text = "💃"
    botonBailes.TextScaled = true
    botonBailes.Font = Enum.Font.GothamBold
    botonBailes.Parent = screenGui
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0.3, 0)
    corner1.Parent = botonBailes
    
    local panel = Instance.new("Frame")
    panel.Name = "MenuBailes"
    panel.Size = UDim2.new(0.3, 0, 0.7, 0)
    panel.Position = UDim2.new(0.01, 0, 0.1, 0)
    panel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    panel.BackgroundTransparency = 0.1
    panel.Visible = false
    panel.Parent = screenGui
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0.05, 0)
    corner2.Parent = panel
    
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(0.85, 0, 0.08, 0)
    titulo.Position = UDim2.new(0.05, 0, 0.02, 0)
    titulo.BackgroundTransparency = 1
    titulo.Text = "💃 BAILES 🕺"
    titulo.TextColor3 = COLORES_CUBANOS.Rosa
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = panel
    
    local botonCerrar = Instance.new("TextButton")
    botonCerrar.Size = UDim2.new(0.08, 0, 0.05, 0)
    botonCerrar.Position = UDim2.new(0.9, 0, 0.025, 0)
    botonCerrar.BackgroundColor3 = COLORES_CUBANOS.Rojo
    botonCerrar.Text = "X"
    botonCerrar.TextScaled = true
    botonCerrar.Font = Enum.Font.GothamBold
    botonCerrar.Parent = panel
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0.3, 0)
    corner3.Parent = botonCerrar
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.9, 0, 0.87, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.11, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 8
    scroll.Parent = panel
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0.02, 0)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scroll
    
    for _, categoriaData in ipairs(BAILES_DISPONIBLES) do
        local categoria = categoriaData.categoria
        local bailes = categoriaData.bailes
        
        local frame = Instance.new("Frame")
        frame.Name = categoria
        frame.Size = UDim2.new(0.95, 0, 0, 50 + (#bailes * 55))
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        frame.Parent = scroll
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.05, 0)
        corner.Parent = frame
        
        local tituloCategoria = Instance.new("TextLabel")
        tituloCategoria.Size = UDim2.new(0.9, 0, 0, 40)
        tituloCategoria.Position = UDim2.new(0.05, 0, 0, 5)
        tituloCategoria.BackgroundColor3 = COLORES_CUBANOS.Morado
        tituloCategoria.Text = categoria:upper()
        tituloCategoria.TextColor3 = COLORES_CUBANOS.Blanco
        tituloCategoria.TextScaled = true
        tituloCategoria.Font = Enum.Font.GothamBold
        tituloCategoria.Parent = frame
        
        local cornerTitulo = Instance.new("UICorner")
        cornerTitulo.CornerRadius = UDim.new(0.15, 0)
        cornerTitulo.Parent = tituloCategoria
        
        for i, baile in ipairs(bailes) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.9, 0, 0, 45)
            btn.Position = UDim2.new(0.05, 0, 0, 50 + ((i - 1) * 55))
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            btn.Parent = frame
            
            local cornerBtn = Instance.new("UICorner")
            cornerBtn.CornerRadius = UDim.new(0.15, 0)
            cornerBtn.Parent = btn
            
            local emoji = Instance.new("TextLabel")
            emoji.Size = UDim2.new(0.15, 0, 0.8, 0)
            emoji.Position = UDim2.new(0.02, 0, 0.1, 0)
            emoji.BackgroundTransparency = 1
            emoji.Text = baile.emoji
            emoji.TextScaled = true
            emoji.Parent = btn
            
            local nombre = Instance.new("TextLabel")
            nombre.Size = UDim2.new(0.75, 0, 0.8, 0)
            nombre.Position = UDim2.new(0.2, 0, 0.1, 0)
            nombre.BackgroundTransparency = 1
            nombre.Text = baile.nombre
            nombre.TextColor3 = COLORES_CUBANOS.Blanco
            nombre.TextScaled = true
            nombre.Font = Enum.Font.GothamBold
            nombre.TextXAlignment = Enum.TextXAlignment.Left
            nombre.Parent = btn
            
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = COLORES_CUBANOS.Turquesa
                }):Play()
            end)
            
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                }):Play()
            end)
            
            btn.MouseButton1Click:Connect(function()
                ReproducirEmote(baile.animacion, baile.nombre)
            end)
        end
    end
    
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    
    botonBailes.MouseButton1Click:Connect(function()
        menuBailesAbierto = not menuBailesAbierto
        panel.Visible = menuBailesAbierto
    end)
    
    botonCerrar.MouseButton1Click:Connect(function()
        menuBailesAbierto = false
        panel.Visible = false
    end)
    
    print("✅ Bailes OK")
end

-- ============================================
-- EMOTES
-- ============================================

function ReproducirEmote(animacionId, nombre)
    print("💃 Bailando: " .. nombre)
    
    if animacionTrack then
        animacionTrack:Stop()
    end
    
    if not animacionActual or animacionActual.AnimationId ~= animacionId then
        animacionActual = Instance.new("Animation")
        animacionActual.AnimationId = animacionId
    end
    
    animacionTrack = humanoid:LoadAnimation(animacionActual)
    animacionTrack.Priority = Enum.AnimationPriority.Action
    animacionTrack.Looped = true
    animacionTrack:Play()
    
    local eventosFolder = ReplicatedStorage:WaitForChild("FiestaNocturnaEvents", 5)
    if eventosFolder then
        local bailarEvent = eventosFolder:FindFirstChild("BailarEvent")
        if bailarEvent then
            bailarEvent:FireServer(animacionId)
        end
    end
    
    MostrarNotificacion("💃 " .. nombre, COLORES_CUBANOS.Verde)
end

-- ============================================
-- NOTIFICACIONES
-- ============================================

local notificacionActiva = false

function MostrarNotificacion(texto, color)
    if notificacionActiva then return end
    notificacionActiva = true
    
    local screenGui = player.PlayerGui:FindFirstChild("FiestaNocturnaUI")
    if not screenGui then return end
    
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0.3, 0, 0.08, 0)
    notif.Position = UDim2.new(0.35, 0, -0.1, 0)
    notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notif.BackgroundTransparency = 0.2
    notif.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.2, 0)
    corner.Parent = notif
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.9, 0, 0.8, 0)
    label.Position = UDim2.new(0.05, 0, 0.1, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = color or COLORES_CUBANOS.Amarillo
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = notif
    
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {
        Position = UDim2.new(0.35, 0, 0.88, 0)
    }):Play()
    
    wait(2)
    TweenService:Create(notif, TweenInfo.new(0.3), {
        Position = UDim2.new(0.35, 0, 1.1, 0)
    }):Play()
    
    wait(0.3)
    notif:Destroy()
    notificacionActiva = false
end

-- ============================================
-- EFECTOS
-- ============================================

local function CrearEfectos()
    local bloom = Instance.new("BloomEffect")
    bloom.Intensity = 0.5
    bloom.Size = 24
    bloom.Threshold = 0.8
    bloom.Parent = game.Lighting
    
    local colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Brightness = 0.05
    colorCorrection.Contrast = 0.1
    colorCorrection.Saturation = 0.2
    colorCorrection.Parent = game.Lighting
end

-- ============================================
-- CONTROLES
-- ============================================

local function ConfigurarControles()
    UserInputService.InputBegan:Connect(function(input, procesado)
        if procesado then return end
        
        if input.KeyCode == Enum.KeyCode.E then
            ReproducirEmote("rbxassetid://3695333486", "Salsa Rapida")
        elseif input.KeyCode == Enum.KeyCode.Q then
            if animacionTrack then
                animacionTrack:Stop()
                MostrarNotificacion("⏸️ Detenido", COLORES_CUBANOS.Azul)
            end
        end
    end)
end

-- ============================================
-- CAMARA
-- ============================================

local enSalon = false

local function ActualizarCamara()
    RunService.RenderStepped:Connect(function()
        if not character or not character.Parent then return end
        
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local pos = root.Position
        
        if pos.Z > 180 and not enSalon then
            enSalon = true
            TweenService:Create(camera, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                FieldOfView = 80
            }):Play()
            humanoid.CameraOffset = Vector3.new(0, 2, 0)
            MostrarNotificacion("🎉 Salon!", COLORES_CUBANOS.Rosa)
        elseif pos.Z < 180 and enSalon then
            enSalon = false
            TweenService:Create(camera, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                FieldOfView = 70
            }):Play()
            humanoid.CameraOffset = Vector3.new(0, 0, 0)
        end
    end)
end

-- ============================================
-- BIENVENIDA
-- ============================================

local function MostrarBienvenida(screenGui)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.2, 0)
    frame.Position = UDim2.new(0.25, 0, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = frame
    
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(0.9, 0, 0.4, 0)
    titulo.Position = UDim2.new(0.05, 0, 0.1, 0)
    titulo.BackgroundTransparency = 1
    titulo.Text = "🇨🇺 BIENVENIDO 🇨🇺"
    titulo.TextColor3 = COLORES_CUBANOS.Amarillo
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = frame
    
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(0.9, 0, 0.4, 0)
    info.Position = UDim2.new(0.05, 0, 0.5, 0)
    info.BackgroundTransparency = 1
    info.Text = "💃 Bailes | ⚙️ Ajustes | E=Bailar | Q=Detener"
    info.TextColor3 = COLORES_CUBANOS.Blanco
    info.TextScaled = true
    info.Font = Enum.Font.Gotham
    info.Parent = frame
    
    wait(5)
    TweenService:Create(frame, TweenInfo.new(1), {
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(titulo, TweenInfo.new(1), {
        TextTransparency = 1
    }):Play()
    TweenService:Create(info, TweenInfo.new(1), {
        TextTransparency = 1
    }):Play()
    wait(1)
    frame:Destroy()
end

-- ============================================
-- INICIALIZACION
-- ============================================

print("🇨🇺 ========================================")
print("🇨🇺 CLIENTE FINAL - INICIANDO")
print("🇨🇺 ========================================")

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
end)

wait(1)
local screenGui = CrearInterfaz()
CrearMenuAjustes(screenGui)
CrearMenuBailes(screenGui)
ActualizarCamara()
CrearEfectos()
ConfigurarControles()
MostrarBienvenida(screenGui)

print("🇨🇺 ========================================")
print("🇨🇺 ✅ CLIENTE LISTO!")
print("🇨🇺 ========================================")
