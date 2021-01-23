float[] as = {0.4, 0.7, 1.0, 1.6, 5.2, 10.0};
color[] col = {#aaaaaa,#ffcc4f,#28a9ff,#ff0000,#af6c00,#ffdd89};
int N = as.length;
Mover[] m = new Mover[N];
Star[] st = new Star[1000];
int b = 0;

void setup(){
  size(648,648);
  background(0);
  
  for (int i = 0 ; i < m.length ; i++){
   m[i] = new Mover(as[i]*30,col[i]);
   m[i].display();
  }
  
  for (int j = 0 ; j < st.length ; j++){
   st[j] = new Star();
   st[j].display();
  }
  //delay(3000);
}

void draw(){
  //background(0);
  for (int i = 0 ; i < m.length ; i++){
    m[i].force();
    m[i].update();
    m[i].display();
  }
  
  for (int j = 0 ; j < st.length ; j++){
    st[j].display();
    }
  
  fill(0,10);
  rect(0,0,width,height);
}

void mousePressed(){
  setup();
}

class Star{
 PVector loc;
 float size,col;
 
  Star(){
  loc = new PVector(random(height),random(width));
  size = random(5)*0.1;
  }
  
  void display(){
    col = random(100,255);
    fill(col);
    ellipse(loc.x,loc.y,size,size);
 }
}


class Mover{
 PVector loc,vel,acc;
 float mass = 3;
 float topspeed = 10;
 float p1 = 50;
 color col;
 int wall = 50;
 
 PVector center = new PVector(width/2,height/2);
 
 Mover(float i_,color c_){
  loc = new PVector(width/2+i_,height/2);
  
  PVector dir = PVector.sub(center,loc);
  float mag = pow(p1/dir.mag(),0.5);
  
  vel = new PVector(0,-1*mag);
  //vel = new PVector(0,1);
  acc = new PVector(0,0);
  
  //col = new PVector(random(255),random(1),random(1));
  col = c_;
 }
 
 void update(){ 
  vel.add(acc);
  vel.limit(topspeed);
  loc.add(vel);
 }
 
 void display(){
  noStroke();
  
  fill(col);
  ellipse(loc.x,loc.y,mass*2,mass*2);
 }
  
 void force(){
  PVector dir = PVector.sub(center,loc);
  PVector dir1 = dir.div(pow(dir.mag(),3));
  dir1.mult(p1);
  acc = dir1;
 }

}
