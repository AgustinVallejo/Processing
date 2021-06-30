"""
SIMULACIÓN DE UN AGUJERO NEGRO COMIENDO ESTRELLAS
Agustín Vallejo - 2021

Este script simula un agujero negro controlado por el mouse
que se irá comiendo las estrellas del fondo.

Se realizó para el curso El Universo Programable del
Planetario de Medellín
"""

EAT_STARS = True # Variable para controlar si el BH comerá o no

# Variables Globales
  # Agujero Negro (Black Hole)
blackHoleSize = 20 # Tamaño del BH

  # Estrellas
nStars = 1000 # Cantidad de estrellas
stars = [[0,0,0]]*nStars # La lista de estrellas con [posX,posY,tamaño]
# Inicialmente será un montón de [0,0,0], luego se llenará
starRadius = 5 # Tamaño promedio de estrella

def setup():
    global stars, nStars # Uso las variables globales
    size(1000,600)
    background(30)
    for n in range(nStars):
        # Para cada elemento de stars asigno un valor aleatorio de X, de Y, y de tamaño
        stars[n] = [random(width), random(height), starRadius*random(0.2,1.1)]
    
def draw():
    background(30)
    drawStars() # LLamar la función de dibujar estrellas (definida abajo)
    drawBH() # Llamar la función de dibujar agujero negro (definida abajo)
    eatStars() # Función que verificará si una estrella muere
    
def drawBH():
    global blackHoleSize # Uso la variable global del tamaño
    noStroke() # Que no tenga borde
    fill(200,200,0) # Que sea de color amarillo (R y G)
    
    # Disco de acreción del BH
    ellipse(mouseX,mouseY,1.1*blackHoleSize,blackHoleSize)
    ellipse(mouseX,mouseY, 3*blackHoleSize , 0.3* blackHoleSize)
    
    # Agujero Negro
    fill(0)
    circle(mouseX,mouseY,0.9*blackHoleSize)
    
    # La parte frontal del disco de acreción
    stroke(200,200,0)
    strokeWeight(blackHoleSize*0.1)
    line(mouseX-blackHoleSize/2, mouseY+0.1*blackHoleSize,
         mouseX+blackHoleSize/2, mouseY+0.1*blackHoleSize)
    
def drawStars():
    global stars, nStars, starRadius
    fill(255)
    noStroke()
    for n in range(nStars):
        circle(stars[n][0],stars[n][1],stars[n][2])
        
def eatStars():
    global stars, nStars, blackHoleSize, EAT_STARS
    for n in range(nStars):
        distance = distToMouse(stars[n][0],stars[n][1])
        if EAT_STARS:
            if distance < blackHoleSize/2:
                if stars[n][2] != 0:
                    blackHoleSize = blackHoleSize+stars[n][2]*0.05
                    stars[n][2] = 0
    
def distToMouse(x,y):
    distance = ( (x-mouseX)**2 + (y-mouseY)**2 ) ** 0.5 # Teorema de pitágoras para la distancia
    return distance

def mouseClicked(): # Implemento que si se clickea el mouse, se imprime el tamaño del BH
    global blackHoleSize
    print(blackHoleSize)
