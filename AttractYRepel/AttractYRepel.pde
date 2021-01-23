Mover[] m = new Mover[100];

void setup(){
  size(640,640);
  background(0);
  
  for (int i = 0 ; i < m.length ; i++){
   m[i] = new Mover();
   m[i].display();
  }
}

void draw(){
  background(0);
  for (int i = 0 ; i < m.length ; i++){
    for (int j = 0 ; j < m.length ; j++){
      if (i != j){
       m[i].force(m[i].attract(m[j])); 
      }
    }
    m[i].force(m[i].grav());
    m[i].checkWalls();
    m[i].update();
    m[i].display();
  }
}




class Mover{
 PVector loc,vel,acc,col;
 float mass;
 float topspeed = 1;
 float p1 = 1;
 float p2 = 0.1;
 
 int wall = 50;
 
 Mover(){
  loc = new PVector(random(wall,width-wall),random(wall,height-wall));
  vel = new PVector(0,0);
  acc = new PVector(0,0);
  
  col = new PVector(random(255),random(255),random(255));
  mass = random(0.1,5);
 }
 
 void update(){ 
  vel.add(acc);
  vel.limit(topspeed);
  loc.add(vel);
 }
 
 void checkWalls(){
  if ((loc.x > width-wall)||(loc.x<wall)) vel.x *= -1; 
  if ((loc.y > height-wall)||(loc.y<wall)) vel.y *= -1;
 }
 
 void display(){
  noStroke();
  fill(col.x,col.y,col.z);
  ellipse(loc.x,loc.y,mass*2,mass*2);
 }
  
 void force(PVector fuerza){
   acc.add(fuerza);
 }
 
 PVector attract(Mover m){
   PVector fuerza = PVector.sub(loc,m.loc);
   float mag =  fuerza.mag();
   fuerza.div(mag*mag*mag);
   fuerza.mult(-1*p2);
   return fuerza;
 }
 
 PVector grav(){
  PVector mouse = new PVector(mouseX,mouseY);
  PVector dir = PVector.sub(mouse,loc);
  PVector dir1 = dir.div(pow(dir.mag(),3));
  dir1.mult(mass);
  dir1.mult(p1);
  
  return dir1;
 }
}
