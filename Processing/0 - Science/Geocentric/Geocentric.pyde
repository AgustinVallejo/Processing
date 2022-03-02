dists = [0.4,0.7,1,1.5,5.2]
distsJup = [x/5.2 for x in dists]
angles = [0 for x in dists]
cols = ["#aaaaaa","#ffcc4f","#28a9ff","#ff0000","#af6c00"]
geocentric = False
t = 0
f = 0.5
sun = 30
planet = 10

def setup():
    size(800,800)
    background(0)
    noStroke()

def draw():
    global geocentric
    fill(0,5);
    rect(0,0,width,height);
    if geocentric:
        draw_geocentric()
    else:
        draw_heliocentric()
        
def draw_geocentric():
    global t, angles
    earth_dth = 0.02
    pushMatrix()
    translate(width/2,height/2)
    i = 2
    th = angles[i]
    R = height*distsJup[i]*f
    earth_pos = PVector(R*cos(th),R*sin(th))
    fill(cols[i])
    circle(0,0,planet)

    for i in range(len(angles)):
        th = angles[i]
        R = height*distsJup[i]*f
        if i != 2:
            fill(cols[i])
            circle(R*cos(th)-earth_pos.x,R*sin(th)-earth_pos.y,planet)
        else:
            fill(255,255,0)
            circle(-earth_pos.x,-earth_pos.y,sun)
        angles[i] -= earth_dth*dists[i]**(-3/2)
    popMatrix()
    
def draw_heliocentric():
    global t, angles
    earth_dth = 0.01
    pushMatrix()
    translate(width/2,height/2)
    fill(255,255,0)
    circle(0,0,sun)
    for i in range(len(angles)):
        th = angles[i]
        fill(cols[i])
        R = height*distsJup[i]*f
        circle(R*cos(th),R*sin(th),planet)
        angles[i] -= earth_dth*dists[i]**(-3/2)
    popMatrix()
    
def keyPressed():
    global geocentric
    if key == " ":
        background(0)
        geocentric = not geocentric
