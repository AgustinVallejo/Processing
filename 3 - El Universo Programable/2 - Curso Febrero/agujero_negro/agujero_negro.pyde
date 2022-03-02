# AGUJERO NEGRO ESTÁTICO
# El Universo Programable
# Febrero 2022

size(800,800)
background(0)

def estrellas():
    noStroke()
    for i in range(1000):
        fill(random(100,255))
        circle(random(width),random(height),random(1,5))

def acrecion(disco):
    noStroke()
    N = 100
    for i in range(N):
        c = map(i, 0,N, 0,255) # Variable de color
        s = map(i, 0,N, 0.3,0.25) 
        fill(255, c, 0)
        if disco:
            ellipse(width/2, height/2, 2*height*s, height*s/10)
        else:
            circle(width/2, height/2, height*s)
            
def agujero_negro():
    fill(0)
    circle(width/2, height/2, height*0.2)

# DIBUJO
acrecion(disco=True)
acrecion(disco=False)
filter(BLUR,10)
estrellas()
acrecion(disco=False)
agujero_negro()
acrecion(disco=True)
