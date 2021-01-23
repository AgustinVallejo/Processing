Ball[] balls = new Ball[100];

void setup(){
 size(640,640);
 background(0);
 
   for (int i = 0 ; i < balls.length ; i++){
     balls[i] = new Ball();
     balls[i].display();
   }
 delay(4000);
}

void draw(){
  background(0);
  
  for (int i = 0; i < balls.length ; i++){
    for (int j = 0; j < balls.length ; j++){
      if (j != i){
        PVector point = PVector.sub(balls[i].loc,balls[j].loc);
        float dist = point.mag();
        if (dist <= balls[i].p){
          if ((balls[i].sick == true) || (balls[j].sick == true)){
            balls[i].sick = true;
            balls[j].sick = true;
          }
          point.normalize();
          float dot = balls[j].vel.dot(point);
          balls[j].vel.sub(point.mult(2*dot));
      }
    }
   }
    balls[i].update();
    balls[i].display();
    balls[i].checkWalls();
  }
  
}

class Ball{
  boolean sick;
  PVector loc,vel,col;
  int c = 255;
  int p = 10;
  float v = 0.5;
  
 Ball(){
  int ran = int(random(10));
  loc = new PVector(random(width),random(height));
  vel = new PVector(random(5),random(5));
  vel.mult(v);
  if (ran>8){
    sick = true;
    col = new PVector(c,0,0);
  }
  else{
    sick = false;
    col = new PVector(0,c,0);
  }
 }
 
 
 void update(){
  loc.add(vel);  
  if (sick==true) col.set(c,0,0);
  else col.set(0,c,0);
  
 }
 
 void display(){
  noStroke();
  fill(col.x,col.y,col.z);
  ellipse(loc.x,loc.y,p,p);
 }
 
 
  void checkWalls(){
  if (loc.x > width) vel.x *= -1;
  else if (loc.x < 0) vel.x *= -1;
  
  if (loc.y > height) vel.y *= -1;
  else if (loc.y < 0) vel.y *= -1;
 }
 
}
