size(500,500)
background(0)

fill(255)
for x in range(1000):
    circle(random(width),random(height),random(1,3))

noFill()
stroke(255)
strokeWeight(20)

ellipseMode(CENTER)
arc(width/2,height/2,0.8*width,0.2*height,PI,2*PI)

fill(0)
circle(width/2,height/2,0.4*width)
noFill()
arc(width/2,height/2,0.8*width,0.2*height,0,PI)
