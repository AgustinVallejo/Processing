int N = 250;
Mover[] m = new Mover[N];
int b = 40;
int frame = 0;

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
  fill(0);
  ellipse(width/2,height/2,b,b);
  
  if (frame<1000){
    if (frame%5 == 0){
      saveFrame("../../Gifs/Orbitas/"+frame);
    }
    frame++;
  }
}

void mousePressed(){
  setup();
}

class Mover{
 PVector loc,vel,acc,col;
 float mass;
 float topspeed = 10;
 float p1 = 50;
 
 int wall = 50;
 
 PVector center = new PVector(width/2,height/2);
 
 Mover(int i_){
  loc = new PVector(width/2+b+i_,height/2);
  
  PVector dir = PVector.sub(center,loc);
  float mag = pow(2*p1/dir.mag(),0.5);
  
  //vel = new PVector(0,pow(-1,i_)*mag);
  vel = new PVector(0,1);
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
