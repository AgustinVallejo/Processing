int N = 600; // Change the size

float[] a  = new float[N*N];
float[] b  = new float[N*N];
float[] a_ = new float[N*N];
float[] b_ = new float[N*N];

float dt = 1e-3;
float f  = 0.055;
float k  = 0.062;
float DA = 1;
float DB = 0.5;

void setup(){
  size(600,600);
  colorMode(RGB,100);
  loadPixels();
  for(int i = 1; i < N-1 ; i++){
   for(int j = 1; j < N-1 ; j++){
     a[i+j*N] = 0; //noise(i+j*N)*100;
     b[i+j*N] = 0; //noise(i+j*N+100)*100;
     a_[i+j*N] = a[i+j*N];
     b_[i+j*N] = b[i+j*N];
     pixels[i+j*N] = color(a_[i+j*N],0,b_[i+j*N]);
  }
 }
  updatePixels();
}

void draw(){
  for(int i = 1; i < N-1 ; i++){
   for(int j = 1; j < N-1 ; j++){
     a[i+j*N] = react(a_,b_,i,j,0);
     b[i+j*N] = react(a_,b_,i,j,1);
   }
  }
  loadPixels();
  for(int i = 1; i < N-1 ; i++){
   for(int j = 1; j < N-1 ; j++){
     a_[i+j*N] = a[i+j*N];
     b_[i+j*N] = b[i+j*N];
     pixels[i+j*N] = color(a_[i+j*N],0,b_[i+j*N]);
   }
 }
  updatePixels();
}

void mousePressed(){
 if (mouseButton == RIGHT){fill(0,0,100);}
 if (mouseButton == LEFT){fill(100,0,0);}
 noStroke();
 int radius = 50;
 ellipse(mouseX,mouseY,radius,radius);
 loadPixels();
  for(int i = 1; i < N-1 ; i++){
   for(int j = 1; j < N-1 ; j++){
     a_[i+j*N] = red(pixels[i+j*N]);
     b_[i+j*N] = blue(pixels[i+j*N]);
  }
 }
}

float react(float[] AL, float[] BL, int i, int j, int which){
  float A = AL[i+j*N];
  float B = BL[i+j*N];
  float out = 0;
  if (which == 0){out = A + dt*(DA*conv(AL,i,j) - A*B*B + f*(1-A));}
  if (which == 1){out = B + dt*(DB*conv(BL,i,j) + A*B*B - B*(k+f));}
  return out;
}

float conv(float[] L, int i, int j){
    float sum = 0;
    float k = 0;
    for(int x = -1; x < 2; x++){
      for(int y = -1; y < 2; y++){
            int xy = abs(x)+abs(y);
            if(xy == 2){k = 0.05;}
            else if (xy == 1){k = 0.2;}
            else if (xy == 0){k = -1;}
            sum += L[(i+x) + N*(j+y)]* k;
          }
        }
    return sum;
}
