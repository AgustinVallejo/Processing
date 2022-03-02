R = 50
points = []
forbidden_angles = []
N = 5
i = 0

def setup():
    global points, R, N
    size(500,500)
    background(125)
    randx = width/2 #random(R,width-R)
    randy = height/2 #random(R,height-R)
    points.append(PVector(randx,randy))
    for n in range(N-1):
        points = add_point(points,R)
    draw_points(points)
        
def add_point(points,R):
    global forbidden_angles, i
    forbidden_angles = []
    last_point = points[-1]
    for point in points[:-1]:
        Dvec = PVector.sub(point,last_point)
        D = Dvec.mag()
        TH = Dvec.heading()
        rel = D/(4*R)
        if rel<=1:
            dth = acos(rel)
            forbidden_angles.append((TH-dth,TH+dth))
    boundaries(last_point)
    TH = random(-PI,PI)
    while not in_range(TH,forbidden_angles):
        TH = random(0,2*PI)
    add_vec = PVector(R*cos(TH),R*sin(TH))
    new_point = PVector.add(last_point,add_vec)
    points.append(new_point)
    i += 1
    return points


def boundaries(last_point):
    global R
    Dy = min(last_point.y, height - last_point.y) - R
    Dx = min(last_point.x,  width - last_point.x) - R
    
    if Dy < 2*R:
        
        dth = acos(Dy/(2*R))
        forbidden_angles.append(())
    
def in_range(TH,forbidden_angles):
    for ang1,ang2 in forbidden_angles:
        if (TH > ang1) and (TH < ang2):
            return False
    return True

def draw_points(points):
    global N
    val = 0
    stroke(0)
    for point in points:
        fill(255,255,val)
        circle(point.x,point.y,R)
        val += 255/(N-1)
