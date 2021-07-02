"""
Este código fue escrito por

AGUSTÍN VALLEJO Y NADIE MÁS
y GABRIELA!!!

"""

phi = (sqrt(5)+1)/2

size(646,400)
translate(height/phi,0)
scale(height)
noStroke(); 
smooth()

for i in range(10):
  fill(i/10*255);
  rect(0,0,1,1);
  fill(255,255,0);
  arc(0,0,2,2,0,PI/2);
  scale(1/phi);
  rotate(PI/2);
  translate(1/phi,0);   
