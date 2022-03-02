N = 20000
col = color(0,255,0)
t = 0

x0, y0 = 0, 0
A = 0.04
B = -0.04

def transform0(x, y):
    rand = random(0,1)
    if rand < 0.01:
        return (0, 0.16 * y)
    elif rand < 0.86:
        return (0.85 * x + 0.04 * y, -0.04 * x + 0.85 * y + 1.6)
    elif rand < 0.92:
        return (0.2 * x - 0.26 * y, 0.23 * x + 0.22 * y + 1.6)
    else:
        return (-0.15 * x + 0.28 * y, 0.26 * x + 0.24 * y + 0.44)

def transform(x, y):
    rand = random(0,1)
    if rand < 0.01:
        return (0, 0.16 * y)
    elif rand < 0.86:
        return (0.85 * x + A * y, B * x + 0.85 * y + 1.6)
    elif rand < 0.92:
        return (0.2 * x - 0.26 * y, 0.23 * x + 0.22 * y + 1.6)
    else:
        return (-0.15 * x + 0.28 * y, 0.26 * x + 0.24 * y + 0.44)

def setup():
    size(800,600)
    background(0)

def draw():
    global x0, y0, t, A, B
    A = map(mouseX,0,width,-1,1) #random(-100,100)/100
    B = map(mouseY,0,height,-1,1) #random(-100,100)/100
    background(0)
    x0, y0 = 0, 0
    for _ in range(int(1e5)):
        i = map(x0,-5,5,0,width)
        j = map(y0,0,10,0,height)
        if (0 <= i < width) and (0 <= j < height):
            set(i,height-j,col)
    
        x0, y0 = transform(x0, y0)
