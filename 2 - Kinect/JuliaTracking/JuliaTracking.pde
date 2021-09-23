// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;

float s = 1.0; // Scale
float f = 0.99; // Transform coefficient
float w = 3.0;
float h = (w * height) / width;
PVector center0 = new PVector(width/2,height/2);
PVector center = new PVector(0,0);
float A;
float B;
float dcol;

void setup() {
  size(1500, 900);
  colorMode(HSB,1);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
}

void draw() {
  background(0);

  // Run the tracking analysis
  tracker.track();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  if ((v1.x > 0)&&(v1.x<kinect.width)&&(!Float.isNaN(v1.x))){
    A = map(v1.x,0,kinect.width,0,width);
  }
  else{A=0;}
  
  if ((v1.y > 0)&&(v1.y<kinect.height)&&(!Float.isNaN(v1.y))){
    B = map(v1.y,0,kinect.height,0,height);
  }
  else{B=0;}
  
  background(0);

  PVector mouse = new PVector(A,B);
  float limX = map(center.x,0,width,-1,1);
  float limY = map(center.y,0,height,-1,1);
  float ca = map(A,0,width,limX-s,limX+s);
  float cb = map(B,0,height,limY-s,limY+s);
  
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
  int maxiterations = 25;
  
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
        norm += dcol;
        if (norm > 1){norm -= 1;}
        pixels[i+j*width] = color(norm,0.5,1);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
  dcol += 0.01;
  if (dcol > 1){dcol = 0;}
  
  // Show the image
  tracker.display();
  
  // Display some info
  int t = tracker.getThreshold();
  fill(1);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}
