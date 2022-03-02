def setup():
    size(500,500)
    background(0)
    stroke(0)
    colorMode(RGB)
    
def draw():
    background(0)
    vini = PVector(width/2,height/2)
    N = 100 # int(map(mouseY,0,height,10,250))
    N_petals = 30
    
    R = width/3/N
    R2 = width/2.2
    fill(200,150,0)
    circle(vini.x,vini.y,R2)
    petals(N_petals, 0, 1.2*R2, 200)
    petals(N_petals, 1.2, R2, 255)
    # frac = map(mouseX,0,width,0,0.5)
    dtheta = 2.4 # 2*PI*frac
    for i in range(N):
        fill(250,200,0)
        vend = vini + R*i*PVector(cos(i*dtheta),sin(i*dtheta))
        circle(vend.x,vend.y,map(i,0,N,10,40))
    
def petals(N_petals, th_ini, R2, colorr):
    for i in range(N_petals):
        pushMatrix()
        translate(width/2,height/2)
        rotate(th_ini + map(i,0,N_petals,0,2*PI))
        fill(colorr,colorr,0)
        ellipse(0.6*R2, 0, 100, 30)
        popMatrix()
