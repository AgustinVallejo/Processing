// Agustin Vallejo 2021

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

import processing.sound.*;

// The noise object
BrownNoise noise;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;

float time = 0;
float amp = 0; // initial amplitude of noise
IntList fishColors; // list of fish colors

void setup() {
  //size(1500, 900);
  fullScreen();
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  colorMode(HSB);
  
  // Create and start the noise generator
  noise = new BrownNoise(this);
  noise.play();
  noise.amp(0);
  
  // Save the colors of the fish
  fishColors = new IntList();
  for (int i=0; i<100; i++){
   fishColors.append(int(random(255))); 
  }
}

void draw() {
  background(0);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();
  // Get the raw location
  PVector v1 = tracker.getPos();
  float X = constrain(v1.x,0,kinect.width); // Limit it to the screen
  X = map(X,0,kinect.width,-1.0,1.0); // Map it to noise panning
  float Y = constrain(v1.y,0,kinect.height);
  Y = map(Y,0,kinect.height,0.3,0.7);  // Map it to ocean heights
  
  // Other depth properties
  float meanDepth = tracker.meanDepth;
  float threshold = tracker.threshold;
  int count = tracker.count;
  float Nfish = map(count,0,kinect.width*kinect.height,0,100); // Number of fishes
  amp = map(meanDepth,400,threshold,0.5,0.0)*sin(time) + 0.1; // Volume of waves
  
  time += 0.1; // Advance time
  
  drawWave(Y,time,0.1,25,180,255);
  drawWave(Y,-time,0.2,40,170,100);
  drawWave(Y,2*time,0.3,30,160,200);  
  drawFish(Nfish, time, Y);
  
  noise.pan(X);
  noise.amp(amp);
      
  // Display some info
  int t = tracker.getThreshold();
  fill(255);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, int(0.95*height));
}

void drawWave(float hgt, float time, float dt, int amp, int hue_, int sat_){
  // hgt: fraction of height of ocean
  // dt: offset of time between waves
  // amp: size of the waves
  // hue_,sat_: color data of the waves
 fill(hue_,sat_,255,150);
 noStroke();
  
 PShape wave;
 int waveHeight = int(hgt*height);
 wave = createShape();
 wave.beginShape();
 
 // Border the screen
 wave.vertex(width,waveHeight);
 wave.vertex(width,height);
 wave.vertex(0,height);
 wave.vertex(0,waveHeight);
 
 // Position of central wave
 int posx = int(map(tracker.getPos().x,0,kinect.width,0,width));
 int di = 10; // Distance between wave nodes
 for (int i=0; i < width + di ; i += di){
   int y = waveHeight;
   y += int(amp*sin(2*PI/width*i + 3*time + dt)); // Normal wave
   y -= int(4*amp*pow(cos(PI/width*(i-posx)),3)); // Central wave
   wave.vertex(i,y);
 }
 wave.endShape();
 shape(wave,0,0);
}

void drawFish(float Nfish, float time, float Y){
  // Y: fraction of height of ocean
  for (int fish = 0; fish < Nfish; fish++){
    fill(fishColors.get(fish),100,255);
    int x = int(noise(100*fish + 0.1*time)*width);
    int y = int(noise(200*fish + 0.1*time)*height);
    y = int(map(y,0,height,Y*height,height));
    ellipse(x,y,40,20);
}
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
