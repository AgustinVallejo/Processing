"""
Portada de Dark Side of the Moon

Código por Agustín Vallejo para el curso Universo Programable
2021
"""

size(500,500)
background(0)

stroke(255)
strokeWeight(3)

line(0,0.7*height,width/2, height/2)

noFill()
triangle(0.3*width,0.7*height,0.5*width,0.3*height,0.7*width,0.7*height)

colorMode(HSB)

for i in range(200):
    stroke(i,255,255)
    line(width/2, height/2, width, (0.2*i/255 + 0.5)*height)
