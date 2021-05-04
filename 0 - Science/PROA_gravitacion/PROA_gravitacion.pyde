objs = []
N = 20
i = 0

def setup():
    global objs, N
    size(500,500)
    background(0)
    colorMode(HSB)
    
    for i in range(N):
        objs.append({"pos":PVector(random(width),random(height)),
                     "vel":PVector(random(-1,1),random(-1,1)),
                     "color":color(random(255),200,200)})
    objs[1]["vel"] *= -1
    
def draw():
    global objs, N, i
    #background(0)
    for obj in objs:
        obj["pos"].add(obj["vel"])
        d = PVector.sub(obj["pos"],PVector(width/2,height/2))
        Fg = -100*d/(d.mag()**3)
        obj["vel"].add(Fg)
        
        noStroke()
        fill(obj["color"])
        circle(obj["pos"].x,obj["pos"].y,10)
    i += 1
