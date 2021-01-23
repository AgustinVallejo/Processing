import java.util.*;
Random gen;

void setup(){
  size(600,600);
  background(0);
  gen = new Random();
}

void draw(){
  int psize = 3*int(random(5)) + 1;
  float x = (float) gen.nextGaussian();
  float y = (float) gen.nextGaussian();
  float numR = (float) gen.nextGaussian();
  float numG = (float) gen.nextGaussian();
  float numB = (float) gen.nextGaussian();
  
  int sd = 50;
  int csd = 50;
  int cini = 150;
  
  fill(cini+csd*numR,0,cini+csd*numB);
  
  
  x = sd*x + width/2;
  y = sd*y + height/2;
  
  noStroke();
  ellipse(x,y,psize,psize);
  
}
