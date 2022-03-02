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

int col = 0;
PImage back = createImage(width,height,HSB);

void setup() {
  size(1500, 900);
  colorMode(HSB);
  background(0);
  //back.loadPixels();
  kinect = new Kinect(this);
  tracker = new KinectTracker();
}

void draw() {
  //background(0);
  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display(col);
  col += 5;
  if (col > 255){col = 0;}
  // Save pixels
  equatePixels();
  //image(tracker.display.get(0,0,kinect.width,kinect.height),0,0,width,height);

  // Delete pixels of tracker
  tracker.undisplay();
  
  image(back,0,0,width,height);
  
  // Display some info
  int t = tracker.getThreshold();
  fill(255);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
}

void equatePixels(){
  float f = 0.9;
  //back.copy(0,0,width,height,0,0,int(width*f),int(height*f));
  back.loadPixels();
  //tracker.display.loadPixels();
  for (int i=0; i < kinect.width; i++){
   for (int j=0; j < kinect.height; j++){
     if (tracker.display.get(i,j) != 0){
      back.set(i,j,color(0,0,255)); 
     }
   }
  }
  back.updatePixels();
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
    } else if (keyCode == RIGHT){
      background(0);
    }
  }
}
