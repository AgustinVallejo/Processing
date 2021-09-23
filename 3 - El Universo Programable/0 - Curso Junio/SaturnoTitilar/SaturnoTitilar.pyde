#VARIABLES GLOBALES
stars = [] # [[x,y,s],[x,y,s],[x,y,s]...]
NStars = 1000

def setup():
    size(500,500)
    background(0)
    crear_estrellas()
    
def crear_estrellas():
    global stars, NStars
    for x in range(NStars):
        stars.append([random(width),random(height),random(1,3)])
    
def draw(): # while
    background(0)
    estrellas()
    saturno()
    
def estrellas():
    global stars, NStars
    noStroke()
    fill(255) # esto llena las figuras de color blanco
    for star in stars:
        circle(star[0], star[1], random(1,3))
    
def saturno():
    noFill()
    stroke(255)
    strokeWeight(20)
    
    ellipseMode(CENTER)
    arc(mouseX,mouseY,0.8*width,0.2*height,PI,2*PI)
    
    fill(0)
    circle(mouseX,mouseY,0.4*width)
    noFill()
    arc(mouseX,mouseY,0.8*width,0.2*height,0,PI)
