int N = 200; //Cantidad de puntos en la linea
int xpos;
color col;

float p1 = 0.2; //Fracción del width donde empieza el visible
float p2 = p1*7.5/3.8; //Fracción del width donde termina el visible
float lfin = 0.38/p1; //Longitud de onda donde termina el gráfico en micrómetros
float dp = p2 - p1; //Ancho del espectro visible
int Temp; //Temperatura inicial
float L;

int frame = 0;

void setup() {
  Temp = 3000;
  L = 1000*2898/Temp;
  size(1000, 500);
  background(0);
  colorMode(HSB, 1.5*N, N, N); //Esto es para hacer el arcoíris
  noStroke();
  rainbow();
  star();
  go();

  fill(255);
  textSize(20);
  text(Temp + " K", width - 150, 0.3*height-15); //Pone la Temperatura en Pantalla
  text(L + " nm", width - 150,0.3*height+15);

  //delay(3000);
}

void keyPressed() { //Para manejar manualmente la Temperatura
  if (keyCode == LEFT) {
    Temp += 10;
  } else if (keyCode == RIGHT) {
    Temp -= 10;
  } else if (keyCode == DOWN) {
    Temp += 0;
  } else if (keyCode == UP) {
    setup();
  } else if (keyCode == ENTER) {
    saveFrame(frame+".png");
    frame++;
  }
}

void draw() {
  background(0);
  rainbow();
  star();
  go();
  keyPressed();

  fill(255);
  textSize(20);
  text(Temp + " K", width - 150, 0.3*height-15); //Pone la Temperatura en Pantalla
  text(L + " nm", width - 150, 0.3*height+15); //Pone la Longitud de onda Mäxima en Pantalla
  //Temp += 10;
  L = 1000*2898/Temp;

  if ((Temp > 2e4)||(Temp<0)) {
    setup(); //Reinicia cuando llega a 20 000K
  }
}

void rainbow() { //Dibuja el espectro visible
  colorMode(HSB, 1.5*N, N, N);
  for (int i = 0; i < N; i++) {
    col = color(N-i, N, 0.3*N);
    xpos = (int) map(i, 0, N, p1*width, p2*width);
    noStroke();
    fill(col);
    rect(xpos, 0, dp*width/N, height);
  }
}

void star() {
  int thold = 80;
  colorMode(RGB, thold, thold, thold, 2e4);
  float c1 = I(Temp, (int)(p1*width)); //AZUL
  float c2 = I(Temp, (int)((p1+dp/2)*width)); //VERDE
  float c3 = I(Temp, (int)(p2*width)); //ROJO
  float mx = max(c1, c2, c3);
  c1 = 100*c1/mx;
  c2 = 100*c2/mx;
  c3 = 100*c3/mx;
  col = color(c3, c2, c1, Temp+3840);
  fill(col);
  noStroke();

  float radius = 0.5*height;

  ellipse(0.7*width, 0.3*height, radius, radius);
  ellipse(0.7*width, 0.3*height, 0.9*radius, 0.9*radius);
  ellipse(0.7*width, 0.3*height, 0.8*radius, 0.8*radius);
  
  float size = 40;
  float T = pow(Temp+3840,1);
  
  fill(c3,0,0,T);
  ellipse(0.7*width-(1)*size,0.7*height, size, size);
  fill(0,c2,0,T);
  ellipse(0.7*width-(0)*size,0.7*height, size, size);
  fill(0,0,c1,T);
  ellipse(0.7*width+(1)*size,0.7*height, size, size);
}

void go() { //Dibuja la función de Planck  
  colorMode(HSB, 1.5*N, N, N);
  int xini = 0;
  int yini = height;

  for (int i = 1; i < N; i++) {

    xpos = (int) map(i, 0, N, 0, width);
    float y = I(Temp, xpos);
    float ypos = map(y, 0, 1, height, 0);

    //fill(N);
    //ellipse(xpos,ypos,5,5);

    fill(255);
    stroke(N);
    strokeWeight(3);
    line(xini, yini, xpos, ypos);

    xini = xpos;
    yini = (int) ypos;
  }
}

float planck(int T_, float lm_) {
  float c = 3e14;
  float h = 6.626e-22;
  float k = 1.38e-11;
  float uno = 2*h*c;
  float dos = pow(lm_, 3);
  float tres = exp((h*c)/(k*T_*lm_))-1;

  return 1e6*uno/(dos*tres);
}

float I(int T_, int pix_) {
  int T = T_ + 3840;
  float lambda = map(pix_, 0, width, 0, lfin);
  float in = planck(T, lambda);

  return in;
}
