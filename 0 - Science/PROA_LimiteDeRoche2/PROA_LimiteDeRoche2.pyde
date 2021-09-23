def setup():
    fullScreen()
    background(0)
    
    
    # CONSTANTES
    Radio_saturno      = 250
    densidad_mimas     = 1.17 #g/cm3
    densidad_pan       = 0.6 #g/cm3
    densidad_saturno   = 0.69 #g/cm3
    distancia_mimas_RS = 3.17*Radio_saturno
    distancia_pan_RS   = 2.28*Radio_saturno
    
    # PLANETA SATURNO
    fill(255,200,200)
    circle(width/2, height/2, 2*Radio_saturno)
    
    # LUNAS
    fill(90)
    circle(width/2 + distancia_mimas_RS, height/2, 10)
    fill(200)
    circle(width/2 + distancia_pan_RS, height/2, 10)
    
    # LIMITE DE ROCHE
    def lim1(R,p1,p2):
        d = ((2.423*R)*((p1/p2)**((1.0/3.0))))
        return d
    def lim2(R,p1,p2):
        d = ((R)*(2*(p1/p2)**(1.0/3.0)))
        return d
    
    
    D1 = lim1(Radio_saturno, densidad_saturno, densidad_pan)
    D2 = lim2(Radio_saturno, densidad_saturno, densidad_pan)
    noFill()
    stroke(0,0,255)
    circle(width/2, height/2, 2*D1)
    stroke(0,255,0)
    circle(width/2, height/2, 2*D2)
