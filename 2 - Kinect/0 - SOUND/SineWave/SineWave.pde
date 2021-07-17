// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

import processing.sound.*;

SinOsc sine;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;


void setup() {
  size(1500, 900);
  colorMode(HSB);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  // create and start the sine oscillator.
  sine = new SinOsc(this);
  sine.play();
}

void draw() {
  background(0);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();
  // Get the raw location
  PVector v1 = tracker.getPos();
  float X = constrain(v1.x,0,kinect.width);
  X = map(X,0,kinect.width, 80.0, 1000.0);
  float Y = constrain(v1.y,0,kinect.height);
  Y = map(X,0,kinect.height,1.0,0.0);
  
  sine.pan(X);
  sine.freq(X);
  sine.amp(Y);
  
  
  // Other depth properties
  float meanDepth = tracker.meanDepth;
  float threshold = tracker.threshold;
  int count = tracker.count;
  
  
      
  // Display some info
  int t = tracker.getThreshold();
  fill(255);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, int(0.95*height));
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
