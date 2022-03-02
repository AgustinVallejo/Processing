int a = 0;
int b = 0;

void setup(){
 colorMode(HSB,100,100,100);
 size(2048,1000);
 background(0,0,100); 
}

void draw(){ 
   background(a,b,100);
}

void keyPressed() { //Para manejar manualmente la Temperatura
  if (keyCode == LEFT) {
    a -= 1;
    if (a < 0) a = 100;
  } else if (keyCode == RIGHT) {
    a += 1;
    if (a > 100) a = 0;
  } else if (keyCode == DOWN) {
     b -= 5;
     if (b < 0) b = 0;
  } else if (keyCode == UP) {
    b += 5;
    if (b > 100) b = 100;
  }
}
