/**
 * The Mandelbrot Set
 * by Daniel Shiffman.  
 * (slight modification by Agustín Vallejo)
 *
 * Simple rendering of the Mandelbrot set.
 */

float s = 1.0; // Scale
float f = 0.99; // Transform coefficient
float w = 3.0;
float h = (w * height) / width;
PVector center0 = new PVector(width/2,height/2);
PVector center = new PVector(0,0);


void setup(){
  size(1024 , 720);
  colorMode(HSB,1);
}

void draw(){
  background(0);

  PVector mouse = new PVector(mouseX,mouseY);
  float limX = map(center.x,0,width,-1,1);
  float limY = map(center.y,0,height,-1,1);
  float ca = map(mouseX,0,width,limX-s,limX+s);
  float cb = map(mouseY,0,height,limY-s,limY+s);
  
  center.lerp(mouse,0.9);
  
  
  // Establish a range of values on the complex plane
  // A different range will allow us to "zoom" in or out on the fractal
  
  // It all starts with the width, try higher or lower values
  h = (w * height) / width;
  
  // Start at negative half the width and height
  float xmin = -w/2;
  float ymin = -h/2;

  // Make sure we can write to the pixels[] array.
  // Only need to do this once since we don't do any other drawing.
  loadPixels();
  
  // Maximum number of iterations for each point on the complex plane
  int maxiterations = 50;
  
  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;
  
  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);
  
  // Start y
  float y = ymin;
  for (int j = 0; j < height; j++) {
    // Start x
    float x = xmin;
    for (int i = 0; i < width; i++) {
  
      // Now we test, as we iterate z = z^2 + c does z tend towards infinity?
      float a = x;
      float b = y;
      int n = 0;
      float max = 4;  // Infinity in our finite world is simple, let's just consider it 4
      float absOld = 0.0;
      float convergeNumber = maxiterations; // this will change if the while loop breaks due to non-convergence
      while (n < maxiterations) {
        // We suppose z = a+ib
        float aa = a * a;
        float bb = b * b;
        float abs = sqrt(aa + bb);
        if (abs > max) { // |z| = sqrt(a^2+b^2)
          // Now measure how much we exceeded the maximum: 
          float diffToLast = (float) (abs - absOld);
          float diffToMax  = (float) (max - absOld);
          convergeNumber = n + diffToMax/diffToLast;
          break;  // Bail
        }
        float twoab = 2.0 * a * b;
        a = aa - bb + ca; // this operation corresponds to z -> z^2+c where z=a+ib c=(x,y)
        b = twoab + cb;
        n++;
        absOld = abs;
      }
  
      // We color each pixel based on how long it takes to get to infinity
      // If we never got there, let's pick the color black
      if (n == maxiterations) {
        pixels[i+j*width] = color(0);
      } else {
        // Gosh, we could make fancy colors here if we wanted
        float norm = map(convergeNumber, 0, maxiterations, 0, 1);
        pixels[i+j*width] = color(1-norm,0.5,1);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
  
  w *= f;
  s *= f;
}
