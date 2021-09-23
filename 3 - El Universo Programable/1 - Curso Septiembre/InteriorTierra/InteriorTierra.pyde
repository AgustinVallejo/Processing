"""
Visualización del Interior de la Tierra

Código escrito por Agustín Vallejo
2021
"""


size(500,500)
background(0)
noStroke()

fill(255)
for i in range(1000):
    circle( random(width), random(height), random(1,8))
    
fill(100,100,255)
circle(width/2, height/2, 0.82*width)
    
fill(100,0,0)
circle(width/2, height/2, 0.8*width)

fill(150,150,0)
circle(width/2, height/2, 0.6*width)

fill(255,255,0)
circle(width/2, height/2, 0.2*width)
