float radioT = 200, radioL = 50,t=0, frame = 0; 
Star[] st = new Star[1000]; //El conjunto de las estrellas de fondo
PImage IMG;

void setup() {
  size(1000, 700);
  background(0);
  
  for (int j = 0 ; j < st.length ; j++){ //Inicializo las Estrellas
   st[j] = new Star();
   st[j].display();
  }
  
  
  IMG = loadImage("polar.png"); //Cargo la Imagen de la Tierra desde Arriba
  IMG.resize((int) radioT,(int) radioT); //La pongo del tamaño radioT
  smooth();
}

void draw() {
  background(0);
  
  for (int j = 0 ; j < st.length ; j++){ //Titilan las estrellassss
    st[j].display();
   }
  
  alSol(); //Dibuja las flechas que señalan el Sol
  stickman(t); //Dibujo el muñequito. El parámetro t es para que gire.
  float objAngle = followMouse(); //Ejecuto la función para que la Luna siga el mouse y saco el ángulo
  mareas(500,objAngle); //Creo las mareas
  tierra(t);
  t++;
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

void mareas(int N, float objAngle){ 
  //Función que crea las mareas
  pushMatrix();
  translate(width/2, height/2);
  
 noStroke();
 fill(89, 183, 255,128);
 beginShape();
 for (int i = 0; i<N; i++){
   float th = map(i,0,N,0,2*PI);
   float drSOL = tidalForceObj(th,'S',0); //Efecto del Sol en las mareas
   float drLUNA = tidalForceObj(th,'L',objAngle); //Efecto de la Luna en las mareas
   float R = 1.1*0.5*radioT + drSOL + drLUNA; //La altura R de la marea en un ángulo th
   float x = R*cos(th);
   float y = R*sin(th);
   vertex(x,y);   //Crea el vector de la figura
 }
 
 endShape(CLOSE);
 popMatrix();
}


void arrow(float x1, float y1, float x2, float y2) {
  // Dibuja una Flecha
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 

float tidalForceObj(float angle,char obj,float objAngle){
  //Ejerce la fuerza según el objeto que se esté usando. S para SOL y L para LUNA
  float MOONTIDE = 1;
  float SUNTIDE = 0.7;
  
    switch(obj){
     case 'S':
       return tidalForce(angle,10*SUNTIDE,0);
       
     case 'L':
       return tidalForce(angle,10*MOONTIDE,objAngle);
     default:
       return 0;
    }
}

float tidalForce(float angle,float G,float objAngle){
  //El desplazamiento vertical según la posición del lugar y el objeto que perturba
  float dr = G*(1+cos(2*(angle - objAngle)));
  return dr;
}

float followMouse() {
  // Pone la Luna en la dirección del Mouse
  float moonOrbit = 300; //Tamaño de la órbita
  
  PVector loc = new PVector(width/2, height/2);
  PVector mouse = new PVector(mouseX, mouseY);
  PVector moonLoc = PVector.sub(mouse, loc);
  moonLoc.normalize();
  moonLoc.mult(moonOrbit);

  pushMatrix();
  translate(width/2, height/2);
  
  //El resto de la función es dibujando cositas
  
  // Órbita
  noFill();
  stroke(100);
  strokeWeight(1);
  ellipse(0,0,2*moonOrbit,2*moonOrbit);
  
  // Luna y Lado Iluminado
  noStroke();
  int moonCol = 120;
  fill(moonCol);
  ellipse(moonLoc.x, moonLoc.y, radioL, radioL);
  fill(moonCol*2);
  arc(moonLoc.x, moonLoc.y,radioL, radioL, -PI/2, PI/2, CHORD);  
  popMatrix();
  
  float moonAngle = atan(moonLoc.y/moonLoc.x);
  return moonAngle;
}

void alSol(){
  // Pone las flechas y pone el texto
  textSize(32);
  fill(255, 255, 0);
  text("Al Sol", 0.9*width, 0.15*height);
  float n = 8; //Cantidad de flechas
  for (int i = 0 ; i < n ; i++){
    float ypos = map(i, 0, n, 0.2*height, 0.8*height);
    stroke(255,255,0);
    strokeWeight(10);
    arrow(0.9*width, ypos, 0.99*width, ypos);
  }  
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

void stickman(float t){
  //El muñequito y su rotación
 float s = 0.3;
 float y = -0.65*radioT/s;
  
 pushMatrix();
 translate(width/2, height/2);
 scale(s);
 rotate(-t*PI/500);
 
 ellipseMode (CENTER);
  
  stroke(128);
  strokeWeight(10);
  fill(255);
  ellipse (0,-90+y,50,50);
  point (-10,-90+y);
  point (10,-90+y);
  
  rectMode (CENTER);
  
  rect (0,-15+y,50,100);
  
  line (-25,-65+y,-50,10+y);
  line (25,-65+y,50,10+y);
  line (-20,35+y,-20,100+y);
  line (-20,100+y,-25,100+y);
  line (20,35+y,20,100+y);
  line (20,100+y,25,100+y);
  
  fill(200,200,255,100);
  ellipse (0,-95+y,80,80);
  popMatrix();   
}

void keyPressed(){
  if (keyCode == ENTER) {
    saveFrame(frame+".png");
    frame++;
  }
}
