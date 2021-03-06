Mover[] movers = new Mover[100];

void setup(){
  size(640,640);
  background(0);
  
  for (int i=0 ; i < movers.length ; i++){
   movers[i] = new Mover(); 
   movers[i].display();
  }
  delay(1000);
}

void draw(){
  //background(0);
 for (int i=0 ; i < movers.length ; i++){
  movers[i].update();
  movers[i].display();
  movers[i].checkWalls();
 }
}


class Mover{
  PVector location; 
  PVector velocity;
  PVector acc;
  
  float topspeed = 5;
  
  float numR,numG,numB;
  int psize;

  
  Mover (){
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    
      //Tamaño y Colores de las Pepas
    psize = 3*int(random(5)) + 8;
    numR = random(128) + 128;
    numG = random(128) + 128;
    numB = random(128) + 128;
 }
 
 void update(){
   PVector mouse = new PVector(mouseX,mouseY);
   PVector dir = PVector.sub(mouse,location);
   PVector dir1 = dir.div(pow(dir.mag(),3));
   acc = dir1;
   acc.mult(30);
   
   velocity.add(acc);
   velocity.limit(topspeed);
   location.add(velocity);  
 }
 
 void display(){
  noStroke();
  fill(numR,numG,numB);
  //fill(255);
  ellipse(location.x,location.y,psize,psize);
 }
 
 void checkWalls(){
  if (location.x > width) location.x = 0;
  else if (location.x < 0) location.x = width;
  
  if (location.y > height) location.y = 0;
  else if (location.y < 0) location.y = height;
 }
 
 
}
