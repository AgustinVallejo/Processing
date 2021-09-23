size(500,500)
background(0)

# PLANETA MARTE
R_marte = 25
fill(200,50,50)
circle(width/2, height/2, 2*R_marte)

# LUNAS
distancia_fobos = 2.76*R_marte
distancia_deimos = 6.8*R_marte
fill(90)
circle(width/2 + distancia_fobos, height/2, 10)
fill(200)
circle(width/2 + distancia_deimos, height/2, 10)

# LIMITE DE ROCHE
def lim1(R,p1,p2):
    d = ((2.423*R)*((p1/p2)**((1.0/3.0))))
    return d
def lim2(R,p1,p2):
    d = ((R)*(2*(p1/p2)**(1.0/3.0)))
    return d
densidad_fobos = 1.9 #g/cm3
densidad_marte = 3.9 #g/cm3
D1 = lim1(R_marte, densidad_marte, densidad_fobos)
D2 = lim2(R_marte, densidad_marte, densidad_fobos)
noFill()
stroke(0,0,255)
circle(width/2, height/2, 2*D1)
stroke(0,255,0)
circle(width/2, height/2, 2*D2)
