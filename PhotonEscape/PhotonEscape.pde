PVector move,pos1,pos2;
float Rstar = 200,ini,scale;
int t;

void setup(){
  size(500,500);
  background(0);
  pos2 = new PVector(0,0);
  
  pushMatrix();
  translate(width/2,height/2);
   stroke(255,255,0);
   strokeWeight(2);
  fill(150,150,0);
  ellipse(0,0,2*Rstar,2*Rstar);
  popMatrix();
  
  textSize(16);
  fill(255);
  text(t+" Años", 0.01*width, 0.1*height);
  
  t = 0;
}

void draw(){
   delay(10);
   pos1 = pos2;
   
   if (pos1.mag() < Rstar){
     float th = random(0,2*PI);
     move = new PVector(cos(th),sin(th));
     
     ini = 5;
     scale = 10;
     
     move.mult(ini+ scale*pos1.mag()/Rstar);
     pos2 = PVector.add(pos1,move);
     
     stroke(255,255,0);
     strokeWeight(2);
     
     pushMatrix();
     translate(width/2,height/2);
     line(pos1.x,pos1.y,pos2.x,pos2.y);
     popMatrix();
     
      fill(0);
      noStroke();
      rect(0, 0,150,70);
      textSize(16);
      fill(255);
      text(t+" Años", 0.05*width, 0.05*height);
     
     t += 100;
   }
}


void keyPressed()
{
 if(key == ' ')
 {
   setup();
 }
}
