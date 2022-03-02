
followMouse = True
posX = 0
posY = 0
t = 1

starVector = PVector(0,0)

def setup():
    size(500,500) # width = 500; height = 500
    background(0)
    
def draw():
    global followMouse,posX,posY,t,starVector
    if followMouse:
        background(0,0,0,255)
        fill(200,200,0)
        noStroke()
        ellipse(mouseX,mouseY,400,50)
        ellipse(mouseX,mouseY,int(150*t),int(120*t))
        
        fill(0)
        stroke(255)
        strokeWeight(5)
        circle(mouseX,mouseY,int(100*t)) # Esto es un círculo amarillo
        
        posX = mouseX
        posY = mouseY
    else:
        background(0)
        fill(200,200,0)
        noStroke()
        ellipse(posX,posY,400,50)
        ellipse(posX,posY,int(150*t),int(120*t))
        
        fill(0)
        stroke(255)
        strokeWeight(5)
        circle(posX,posY,int(100*t)) # Esto es un círculo amarillo
    t += 0.001
    
    BHVector = PVector(posX,posY)
    if starVector.dist(BHVector) > 100*t:
        fill(255)
        circle(starVector.x,starVector.y,10)
        starVector.lerp(BHVector,0.01*t)
    
    
def mousePressed():
    global followMouse
    followMouse = not followMouse
