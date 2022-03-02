// Original creation by The Space Dude
// Thanks for sharing!

float angle;
float m = 0;

void setup(){
  //size(1112,834);
  fullScreen();
  colorMode(HSB, 255);
  noStroke();
  m = random(255);
  fill(0,15,30);
}

void draw(){
  background(0);
  float x=width;
  float d=150;
  int num=100;
  
  translate(width/2, height/2);
  for(int a=0; a<360; a+=45){
    rotate(radians(a));
    pushMatrix();
  for(int i=0; i<num;i++){
    scale(0.95);
    fill((m+i/num*255)%255, 200, 255);
    rotate(radians(angle));
    ellipse(x,0,d,d);
  }
    popMatrix();
    pushMatrix();
  for(int i=0; i<num;i++){
    scale(0.95);
    fill((m+i/num*255)%255, 200, 255);
    rotate(radians(-angle));
    ellipse(x,0,d,d);
  }
    popMatrix();
  }
  angle+=0.02;
  m++;
}
    
