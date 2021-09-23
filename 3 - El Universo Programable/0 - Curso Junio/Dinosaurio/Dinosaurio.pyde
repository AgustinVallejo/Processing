y = 400
vy = 0
x = 600
vx = 5
pts = 0
maxpts = 0

def setup():
    size(500,500)
    background(200)
    
def draw():
    global pts, maxpts
    background(200)
    fill(0)
    textSize(32)
    text("Puntaje:%i"%int(pts),50,50)
    obstaculo()
    jugador()
    pts += 0.1
    if maxpts > 0:
        text("Max:%i"%int(maxpts),50,100)
    
def obstaculo():
    global y, x, vx, pts, maxpts
    vx += 0.01
    x -= vx
    if abs(x-100) < 70:
        if y>375:
            textSize(32)
            fill(255,0,0)
            #circle(250,250,100)
            text("Game Over",50,150)
            if pts > maxpts:
                maxpts = pts
            vx = 5
            pts = 0
    if x < 0:
        x = random(500,700)
    fill(0)
    square(x,450,50)  # Enemigo  

def jugador():
    global y, vy
    if keyPressed and (key == 'w') and (y==400):
        vy = 20
    vy -= 1
    y -= vy
    if y > 400: y = 400
    fill(0)
    square(100,y,100)
