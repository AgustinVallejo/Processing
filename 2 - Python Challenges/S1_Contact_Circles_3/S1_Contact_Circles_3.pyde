points = []
hues = []
R = 10
N = 500

def setup():
    size(500,500)
    background(100)
    colorMode(HSB)
    
    points.append(PVector(width/2,height/2))
    hues.append(0)
    
def draw():
    if len(points) < N:
        add_point()
        draw_points()
    
def add_point():
    i = int(random(len(points)))
    th = random(-PI,PI)
    add_vec = 2*R*PVector(cos(th),sin(th))
    new_point = PVector.add(points[i],add_vec)
    
    for j,point2 in enumerate(points):
        if j != i:
            if PVector.dist(point2,new_point) < 2*R:
                return None
            
    if (new_point.x < R) or (new_point.x > width - R): return None
    if (new_point.y < R) or (new_point.y > height - R): return None
    
    points.append(new_point)
    hue_ = random(255)
    hues.append(hue_)
    
def draw_points():
    stroke(0)
    for i,point in enumerate(points):
        fill(hues[i],150,255)
        circle(point.x,point.y,2*R)
    
