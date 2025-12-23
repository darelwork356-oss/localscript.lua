# 🧜♀️ MAKO MERMAIDS - Juego de Supervivencia Rústica

## 📦 INSTALACIÓN

1. Abre Roblox Studio
2. Crea un nuevo lugar (Place)
3. Ve a ServerScriptService
4. Crea un nuevo Script
5. Copia TODO el contenido de `MakoMermaids.lua`
6. Pégalo en el Script
7. Presiona Play (F5)

## ✅ QUÉ DEBERÍAS VER:

### 🌊 Océano:
- Agua desde Y=0 hasta Y=50
- Arena en el fondo (Y=-20 a Y=0)

### 🪵 Bote Rústico (en Y=51-53):
- 15 troncos cilíndricos horizontales como base
- 10 palos de madera cruzados encima
- 4 bordes de palos alrededor
- Spawn azul transparente

### 🔥 Fogata (centro del bote):
- 8 piedras grises en círculo
- 4 leños inclinados
- Fuego naranja animado que cambia de tamaño
- Luz brillante

### ⚙️ Molinillo (esquina del bote):
- Base de madera marrón
- Cilindro metálico gris encima
- ProximityPrompt: "Moler Madera"

### 🪵 200 Maderas Flotantes:
- Troncos cilíndricos flotando en Y=49
- Highlight amarillo/naranja
- Esparcidas por todo el océano
- ProximityPrompt: "Recoger Madera"

### 🌿 500 Algas:
- Bolas verdes brillantes en Y=10
- Esparcidas en el fondo del océano
- ProximityPrompt: "Arrancar Alga"

### 🦈 20 Tiburones:
- Cuerpo gris con cabeza y aleta dorsal
- Ojos rojos brillantes
- SOLO activos de NOCHE
- Patrullan y atacan jugadores lejos del bote

## 🎮 MECÁNICAS:

### 📊 Recursos (en la esquina superior derecha):
- **Madera**: Recolectar de troncos flotantes
- **Algas**: Arrancar del fondo marino
- **MaderaMolida**: Usar molinillo (5 Maderas → 10 Molidas)

### 🌞 DÍA (5 minutos):
- Luz clara
- Seguro para explorar
- Recolecta recursos libremente

### 🌙 NOCHE (3 minutos):
- Oscuro
- Niebla densa
- 🦈 Tiburones activos (atacan si estás >30 studs del bote)
- 💥 Terremotos aleatorios (sacuden cámara)
- ⚠️ VUELVE AL BOTE O MORIRÁS

## 🐛 SI NO VES NADA:

1. Verifica que el script esté en **ServerScriptService**
2. Presiona F5 para iniciar el juego
3. Espera 5-10 segundos a que todo se genere
4. Revisa la consola (View → Output) para ver los mensajes:
   ```
   🌊 Iniciando Mako Mermaids - Supervivencia...
   ✅ Océano creado
   🪵 Construyendo bote rústico...
   ✅ Bote rústico creado
   🔥 Creando fogata...
   ✅ Fogata creada
   ⚙️ Creando molinillo...
   ✅ Molinillo creado
   🪵 Creando maderas flotantes...
   ✅ 200 maderas flotantes creadas
   🌿 Creando algas...
   ✅ 500 algas creadas
   📦 Sistema de recursos...
   ✅ Sistema configurado
   🌞 Sistema día/noche...
   🦈 Creando tiburones nocturnos...
   ✅ 20 tiburones nocturnos creados
   💥 Sistema de terremotos...
   ✅ Sistema de terremotos configurado
   ```

5. Si ves errores rojos, copia el error y repórtalo

## 📍 UBICACIONES:

- **Bote**: X=0, Y=51, Z=0
- **Fogata**: X=0, Y=55, Z=0 (centro del bote)
- **Molinillo**: X=8, Y=54, Z=-8 (esquina del bote)
- **Spawn**: X=-8, Y=53, Z=0 (lado izquierdo del bote)

## 🎯 OBJETIVO:

Sobrevive recolectando recursos durante el día y refugiándote en el bote durante la noche para evitar tiburones y terremotos.

---

**Versión**: 1.0  
**Última actualización**: 2024
