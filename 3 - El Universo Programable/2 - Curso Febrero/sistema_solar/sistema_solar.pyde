t = 0
estrellas = []

def setup():
    size(500,500)
    background(0)
    crear_estrellas()
    
def draw():
    global t
    background(0)
    dibujar_estrellas()
    fill(255,255,0)
    noStroke()
    translate(width/2, height/2)
    circle(0, 0, 50)
    
    for r in range(1,6):
        noFill()
        stroke(255)    
        circle(0, 0, r*100)
        
        fill(255)
        noStroke()
        rotate(t/r)
        circle(r*50, 0, 20)
        rotate(-t/r)
        
    t += 0.01
    
    
def crear_estrellas():
    for i in range(1000):
        estrellas.append([random(width),random(height),random(1,5)])

def dibujar_estrellas():
    noStroke()
    for estrella in estrellas:
        fill(random(100,255))
        circle(estrella[0],estrella[1],estrella[2])
        

    
