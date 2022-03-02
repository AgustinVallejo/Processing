# REFERENCES
# http://paulbourke.net/fractals/lorenz/

x = 0.1
y = 0
z = 0
shades = 0

# contants sigma=a, ro=b, and beta=c
A = 8
B = 30
C = 8 / 3

def setup():
    size(700, 700, P3D)
    frameRate(240)
    background(0)
    colorMode(HSB)

def draw():

    # for handlling time
    dt = 0.01

    # formulas
    global x, y, z, shades
    dx = (A * (y - x)) * dt
    dy = (x * (B - z) - y) * dt
    dz = (x * y - C * z) * dt
    x += dx
    y += dy
    z += dz
    
    translate(width / 2, height / 2)
    scale(5)
    stroke(shades, 255, 255)
    line(x,y,z,x-dx,y-dy,z-dz)     # point(v.x, v.y, v.z)
    shades += .05
    if shades > 255:
        shades=0
