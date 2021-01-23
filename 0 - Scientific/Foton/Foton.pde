int a = 0, da = 2, t=0;
boolean time = false, laser = false;

void setup(){
 colorMode(HSB,125,100,100);
 size(800,500);
 background(0,80,50); 
}

void draw(){ 
   background(a,80,50);
   foton(t,a,laser);
   if (time == true){t ++;}
   
  if (laser){da = 10;}
  else{da = 2;}
}

void keyPressed() { //Para manejar manualmente la Temperatura
  if (keyCode == LEFT) {
    a -= da;
    if (a < 0) a = 0;
  } else if (keyCode == RIGHT) {
    a += da;
    if (a > 100) a = 100;
  }
  else if (keyCode == DOWN) {
    time = !time;
  }
  else if (keyCode == UP) {
    laser = !laser;
  }
}


void foton(float t,float hue,boolean laser){
  
  float xmid = width/2;
  
  pushMatrix();
  translate(0,height/2);
  stroke(hue,100,100);
  strokeWeight(4);
  for (int x = 1; x < width ; x++){
    float H1 = wave(xmid,x-1,t,hue+100,laser);
    float H2 = wave(xmid,x,t,hue+100,laser);
    line(x-1,H1,x,H2);
  }
  popMatrix();
}

float wave(float x0,float x,float t,float a,boolean laser){
 float sigma = width/8, A=height/2.2;
 float w = 5e-4*a, k = a*16*PI/(200*width);
 if (!laser){
   return A*exp(-(x-x0)*(x-x0)/(2*sigma*sigma))*sin(w*t - k*x);
 }
 else {
   return A*sin(w*t - k*x);
 }
}
