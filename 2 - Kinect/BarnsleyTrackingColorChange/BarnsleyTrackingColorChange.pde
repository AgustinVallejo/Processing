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

// The Barnsley Stuff
int N = 20000;
color col = color(0,255,0);

int i,j;
float x0 = 0;
float y0 = 0;
float A = 0.04;
float B = -0.04;

PVector transform(float x, float y){
    float rand = random(0,1);
    if (rand < 0.01){return new PVector(0, 0.16 * y);}
    else if (rand < 0.86){return new PVector(0.85 * x + A * y, B * x + 0.85 * y + 1.6);}
    else if (rand < 0.92){return new PVector(0.2 * x - 0.26 * y, 0.23 * x + 0.22 * y + 1.6);}
    else{return new PVector(-0.15 * x + 0.28 * y, 0.26 * x + 0.24 * y + 0.44);}
}


void setup() {
  size(1500, 900);
  colorMode(HSB);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
}

void draw() {
  background(0);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  if ((v1.x > 0)&&(v1.x<kinect.width)&&(!Float.isNaN(v1.x))){
    A = map(v1.x,0,kinect.width,-1,1);
  }
  else{A=0;}
  
  if ((v1.y > 0)&&(v1.y<kinect.height)&&(!Float.isNaN(v1.y))){
    B = map(v1.y,0,kinect.height,-1,1);
  }
  else{B=0;}
  
  // Get and transform the color
  float meanDepth = tracker.meanDepth;
  float threshold = tracker.threshold;
  float hue_ = map(meanDepth,440,threshold,0,255);
  int count = tracker.count;
  float sat_ = map(count,0,kinect.width*kinect.height,255,0);
  col = color(hue_,sat_,255);

  x0 = 0;
  y0 = 0;
  for (int n = 0; n < 1e6 ; n++){
    i = int(map(x0,-5,5,0,width));
    j = int(map(y0,0,10,0,height));
    set(i,height-j,col);
    
    PVector v2 = transform(x0,y0);
    x0 = v2.x;
    y0 = v2.y;
      }
      
  // Display some info
  int t = tracker.getThreshold();
  fill(255);
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
