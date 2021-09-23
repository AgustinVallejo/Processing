radio = 0.3 # fracción del ancho de la pantalla que será el radioio del círculo

def setup():
    global radio
    size(600,600)
    background(250,250,230) # El fondo crema es porque tiene un poco más de RG que de B
    translate(width/2,height/2) # Esto mueve el origen de la esquina sup izquierda al centro
    radio = radio*width
    
def draw():
    # CALCULOS
    lineaRadio = PVector(mouseX-width/2, mouseY-height/2)
    lineaRadio = radio*lineaRadio / lineaRadio.mag()
    angulo = -asin(lineaRadio.y/radio)
    if lineaRadio.x < 0:
        angulo = PI - angulo
    if angulo < 0:
        angulo += 2*PI
        
    # DIBUJOS
    background(250,250,230)
    translate(width/2,height/2) # Esto mueve el origen de la esquina sup izquierda al centro
    
    # Líneas centrales
    stroke(0) # El color de la línea (stroke) es negro
    strokeWeight(1) # El ancho de la línea es 5px
    line(-radio,0,radio,0)
    line(0,-radio,0,radio)
    
    # Angulito interno
    textSize(20)
    fill(0)
    da = angulo/2
    dr = 0.3
    text("x",cos(angulo-da)*radio*dr*0.6,-sin(angulo-da)*radio*dr*0.6)
    noFill()
    arc(0,0,dr*radio,dr*radio,2*PI-angulo,2*PI)
    
    # Círculo Unitario
    strokeWeight(5) # El ancho de la línea es 5px
    circle(0,0,2*radio)
    
    # Valor de x en el tope de la pantalla
    fill(0)
    textSize(30)
    textAlign(CENTER)
    text("x ={:4.0f}*".format(int(angulo*180/PI)),0,-1.2*radio)
    
    # RADIO
    stroke(0,0,255)  # El color de la línea (stroke) es azul
    line(0,0,lineaRadio.x,lineaRadio.y)
    
    # SENO
    stroke(255,0,0)
    line(lineaRadio.x,0, lineaRadio.x,lineaRadio.y)
    fill(255,0,0)
    textSize(20)
    textAlign(LEFT)
    text("sin(x)={:3.2f}".format(sin(angulo)),lineaRadio.x+10,lineaRadio.y/2)
    stroke(100)
    line(0.9*width/2,0, 0.9*width/2,lineaRadio.y)
    
    # COSENO
    stroke(0,200,0)
    line(0,0, lineaRadio.x,0)
    fill(0,200,0)
    textSize(20)
    textAlign(CENTER)
    text("cos(x)={:3.2f}".format(cos(angulo)),lineaRadio.x/2,+20)
    stroke(100)
    line(0,0.9*width/2, lineaRadio.x,0.9*width/2)
