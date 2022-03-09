t = 0
estrellas = []

def setup():
    size(500,500)
    background(0)
    crear_estrellas()
    
def draw():
    colorCielo = color(116,212,255)
    distancia = abs(width/2 - mouseX)
    if distancia < 50:
        # ECLIPSE
        f = distancia/50
        colorCielo = color(116*f,212*f,255*f)
        background(colorCielo)
        dibujar_estrellas()
    else:
        background(colorCielo)
        # NO ECLIPSE
    
    
    
    fill(255,255,0)
    noStroke()
    circle(width/2, height/2, 300)
    
    fill(colorCielo)
    circle(mouseX, height/2, 295)
    
    
def crear_estrellas():
    noStroke()
    for i in range(1000):
        estrellas.append([random(width),random(height),random(1,5)])

def dibujar_estrellas():
    for estrella in estrellas:
        fill(random(100,255))
        circle(estrella[0],estrella[1],estrella[2])
        

    
