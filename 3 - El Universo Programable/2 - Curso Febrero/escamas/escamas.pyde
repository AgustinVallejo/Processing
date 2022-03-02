# Codigo de Escamas
# El Universo Programable
# Febrero 2022

size(500,500)
background(0)

noStroke()
for j in range(-550,550,100):
    for i in range(0,550,50):
        c = map(i, 0,550, 0,255)
        fill(c,255-c,255-c)
        circle(i, i+j, 100)
