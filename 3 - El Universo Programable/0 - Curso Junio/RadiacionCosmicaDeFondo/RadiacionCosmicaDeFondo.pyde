size(500,500)
background(0)

N_stars = 10000
noStroke()
for n in range(N_stars):
    fill(0,0,255)
    circle(random(width),
           random(height),
           random(1,5))
    fill(0,255,0)
    circle(random(width),
           random(height),
           random(1,5))
filter(BLUR, 3)
