def setup():
    size(500,500)
    background(0)
    stroke(0)
    colorMode(HSB)
    
def draw():
    background(0)
    N = int(map(mouseY,0,height,10,250))
    frac = map(mouseX,0,width,0,0.5)
    dtheta = 2*PI*frac
    fill(255)
    text(frac,20,20)
    
    R = width/2/N
    vini = PVector(width/2,height/2)
    
    for i in range(N):
        fill(map(i+mouseX,0,N+width,0,255),150,150)
        vend = vini + R*i*PVector(cos(i*dtheta),sin(i*dtheta))
        circle(vend.x,vend.y,map(i,0,N,10,40))
    
