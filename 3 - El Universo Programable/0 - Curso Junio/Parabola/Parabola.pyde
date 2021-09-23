objeto = {
          "posy":250,
          "posx":250,
          "vely":-5,
          "velx":1,
          "accy":+0.1,
          "accx":0,
          }

def setup():
    size(500,500)
    background(0)

def draw():
    global objeto
    # background(0)
    noStroke()
    circle(objeto['posx'],objeto['posy'],20)
    fisica("x")
    fisica("y")
    
def fisica(dir):
    global objeto
    objeto['pos'+dir] += objeto['vel'+dir]
    objeto['vel'+dir] += objeto['acc'+dir]
    
    
