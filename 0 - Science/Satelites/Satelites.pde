import java.util.Iterator;
Star[] st = new Star[1000]; //El conjunto de las estrellas de fondo
float radioT = 100,t=0 , dt=1; 
PImage IMG;
SateliteSys sys;


void setup(){
 size(700,700);
 background(0);
 
 
  IMG = loadImage("polar.png"); //Cargo la Imagen de la Tierra desde Arriba
  IMG.resize((int) radioT,(int) radioT); //La pongo del tamaño radioT
  smooth();
  
  for (int j = 0 ; j < st.length ; j++){ //Inicializo las Estrellas
   st[j] = new Star();
   st[j].display();
  }
  
  sys = new SateliteSys();
}

void draw() { 
  background(0);
  
  for (int j = 0 ; j < st.length ; j++){ //Titilan las estrellassss
    st[j].display();
   }
   
  tierra(t);
  t += dt;
  sys.addParticle();
  sys.run(dt);
}

void keyPressed()
{
 if(key == ' ')
 {
  sys.kill();
 }
 
 if (keyCode == RIGHT){dt++;}
 if (keyCode == LEFT){
  if (dt > 1){dt--;} 
 }
}

void tierra(float t){
  //Dibujo la Tierra
  pushMatrix();
  translate(width/2, height/2);
  rotate(-t*PI/500 + 1.2*PI/2); //La tierra también rota según t
  imageMode(CENTER);
  tint(200);
  image(IMG,0,0);
  popMatrix(); 
}

class SateliteSys{
 ArrayList<Satelite> sats;
 
 SateliteSys(){
  sats = new ArrayList<Satelite>();
 }
 
 void addParticle(){
   if (mousePressed){sats.add(new Satelite());}
 }
 
 void run(float dt){
  Iterator<Satelite> it = sats.iterator();
  while (it.hasNext()){
   Satelite s = it.next();
   s.run(dt);
   if (s.dead){it.remove();}
  }
 }
 
 void kill(){
  Iterator<Satelite> it = sats.iterator();
  while (it.hasNext()){
   Satelite s = it.next();
   s.kill();
  }
  }
}

class Satelite{
  PVector loc,locCentered;
  PVector center = new PVector(width/2, height/2);
  PVector xaxis = new PVector(1,0);
  
  float a,w,th0;
  float tt = 0;
  float life = 1000;
  boolean dead = false;
  
  float r = 5;
  
  Satelite(){
   loc = new PVector(mouseX,mouseY);
   locCentered = loc.sub(center);
   
   th0 = locCentered.heading();
   a = locCentered.mag();
   w = 1*pow(a,-3/2); // Velocidad Angular
  }
  
  void run(float dt){
    pushMatrix();
    translate(width/2, height/2);
    rotate(-tt*w + th0);
   
    ellipseMode (CENTER);
    fill(255);
    if (abs(w-PI/500) < 1e-4){
      fill(255,255,0);
    }
    noStroke();
    ellipse (a,0,r,r);
    
    tt += dt;
    //life--;
    
    if (life <= 0){dead = true;}
    popMatrix();
  }
  
  void kill(){dead = true;}
}

class Star{
  //La clase estelar
 PVector loc;
 float size,col;
 
  Star(){
  loc = new PVector(random(width),random(height));
  size = random(5)*0.5;
  }
  
  void display(){
    col = random(100,255);
    fill(col);
    ellipse(loc.x,loc.y,size,size);
 }
}
