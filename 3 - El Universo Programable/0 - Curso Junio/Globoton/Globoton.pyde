pos = PVector(250,250)
vel = PVector(5,4)

    
def setup():
    global pos, vel
    size(500,500)
    pos = PVector(random(width),random(height))
    
def draw():
    global pos, vel
    
    fill(255)
    circle(pos.x,pos.y,20)
    pos += vel
    
    if pos.x < 0:
        vel.x *= -1
    if pos.x > width:
        vel.x *= -1
    if pos.y < 0:
        vel.y *= -1
    if pos.y > height:
        vel.y *= -1
