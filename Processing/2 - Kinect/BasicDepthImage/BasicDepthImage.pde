import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

void setup(){
  size(640, 520);
  kinect = new Kinect(this);
  //kinect.activateDevice(1);
  kinect.initDepth();
  kinect.enableColorDepth(true);
}

void draw(){
  image(kinect.getDepthImage(),0,0,width,height);
}
