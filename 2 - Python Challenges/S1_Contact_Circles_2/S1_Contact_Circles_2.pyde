points = []
R = 25
N = 5

def setup():
    size(500,500)
    background(100)
    for i in range(N):
        points.append(PVector(random(R,width-R),random(R,height-R)))
    draw_points()
    
def draw():
    background(0)
    push_points()
    draw_points()
    
def draw_points():
    global points
    fill(255)
    stroke(0)
    for point in points:
        circle(point.x,point.y,2*R)
    
def push_points():
    global points
    K = 0.1
    for i, pointA in enumerate(points):
        for j, pointB in enumerate(points):
            if i != j:
                Dvec = PVector.sub(pointB,pointA)
                D = Dvec.mag()
                if D < 2*R:
                    pointA.add( -2 * Dvec / D )
                elif D > 2*R*1.5:
                    pointA.add( K * Dvec / D )
