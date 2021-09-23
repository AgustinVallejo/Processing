"""
SIMULACIÓN VISUAL DE UN CAMPO DE ESTRELLAS
Agustín Vallejo - 2021

En este script estático se dibuja un campo de estrellas.

Se realizó para el curso El Universo Programable del
Planetario de Medellín
"""
size(600,600)
background(0)

nStars = 2000 # Cantidad de estrellas
starRadius = 3 # Tamaño promedio de estrella

for n in range(nStars):
    fill(255)
    circle(random(width), random(height), starRadius*random(0.1,1.1))
