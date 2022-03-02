N = 500
dt = 0.0001
DA = 1
DB = 0.5
f = 0.55
k = 0.062

a = [[0]*N]*N
b = [[0]*N]*N

a_ = [[0]*N]*N
b_ = [[0]*N]*N
t = 0

def setup():
    global t,a,a_,b,b_
    t = 0
    size(N,N)
    frameRate(30)
    colorMode(RGB,1)
    loadPixels()
    for i in range(1,N-1):
        for j in range(1,N-1):
            a_[i][j] = noise(i+j*N)
            b_[i][j] = noise(i+j*N)
            a[i][j] = a_[i][j]
            b[i][j] = b_[i][j]
            pixels[i+j*N] = color(a[i][j],0,b[i][j])
    updatePixels()
    
def mousePressed():
    fill(0,0,255)
    noStroke()
    ellipse(mouseX,mouseY,20,20)
    loadPixels()
    for i in range(1,N-1):
        for j in range(1,N-1):
            b_[i][j] = map(blue(pixels[i+j*N]),0,255,0,1)
            a_[i][j] = map(red(pixels[i+j*N]),0,255,0,1)
            
def draw():
    global t,a,a_,b,b_
    t += 1
    loadPixels()
    for i in range(1,N-1):
        for j in range(1,N-1):
            a[i][j] = a_[i][j]
            b[i][j] = b_[i][j]
            pixels[i+j*N] = color(a[i][j],0,b[i][j])
            a_[i][j] = reactA(a,b,i,j)
            b_[i][j] = reactB(a,b,i,j)
    updatePixels()
    
def reactA(a,b,i,j):
    A = a[i][j]
    B = b[i][j]
    out = A + dt*(DA*conv(a,i,j) - A*B*B + f*(1-A))
    return constrain(out,0,1)

def reactB(a,b,i,j):
    A = a[i][j]
    B = b[i][j]
    out = B + dt*(DB*conv(b,i,j) + A*B*B - B*(k+f))
    return constrain(out,0,1)
            
def conv(L,i,j):
    sum = 0
    rango = [-1,0,1]
    k = 0
    for x in rango:
        for y in rango:
            xy = abs(x)+abs(y)
            if   xy == 2: k = 0.05
            elif xy == 1: k = 0.2
            elif xy == 0: k = -1
            sum += L[i+x][j+y]*k
    return sum
            
    
