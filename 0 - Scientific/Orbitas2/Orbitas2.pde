int N = 250;
Mover[] m = new Mover[N];
int b = 30;

void setup(){
  size(640,640);
  background(0);
  //delay(3000);
  for (int i = 0 ; i < m.length ; i++){
   m[i] = new Mover(i);
   m[i].display();
  }
  colorMode(HSB,N+80,100,100);
}

void draw(){
  //background(0);
  for (int i = 0 ; i < m.length ; i++){
    m[i].force();
    m[i].update();
    m[i].display();
  }
}

void mousePressed(){
  setup();
}

class Mover{
 PVector loc,vel,acc,col;
 float mass;
 float topspeed = 10;
 float p1 = 30;
 
 int wall = 50;
 
 PVector center = new PVector(width,height);
 
 Mover(float i_){
  center.mult(0.9);
  loc = new PVector(center.x+b,center.y);
  vel = new PVector(0,-1-3*i_/N);
  acc = new PVector(0,0);
  
  //col = new PVector(random(255),random(1),random(1));
  col = new PVector(i_,100,100);
  mass = 1;
 }
 
 void update(){ 
  vel.add(acc);
  vel.limit(topspeed);
  loc.add(vel);
 }
 
 void display(){
  noStroke();
  fill(col.x,col.y,col.z);
  ellipse(loc.x,loc.y,mass*2,mass*2);
 }
  
 void force(){
  PVector dir = PVector.sub(center,loc);
  PVector dir1 = dir.div(pow(dir.mag(),3));
  dir1.mult(p1);
  acc = dir1;
 }

}
