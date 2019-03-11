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
int minDepth;
int maxDepth;
PGraphics leftViewport;
PGraphics rightViewport;
int w = 1280;
int h = 520;
float angle;
float scale;
int nClusters;

PVector lastPosition;

void settings(){
  size(1280, 520, P3D);
}

void setup() {
  
  minDepth = 400;
  maxDepth = 830;
  leftViewport = createGraphics(w/2, h, P3D);
  rightViewport = createGraphics(w/2, h, P3D);
  kinect = new Kinect(this);
  tracker = new KinectTracker(minDepth, maxDepth);
  scale = 1;
  lastPosition = new PVector(0, 0, 0);
}

void draw() {
  
  leftViewport.beginDraw();
  leftViewport.background(255);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display(leftViewport);

  // Let's draw the raw location
  /*PVector v1 = tracker.getPos();
  leftViewport.fill(50, 100, 250, 200);
  leftViewport.noStroke();
  leftViewport.ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  leftViewport.fill(100, 250, 50, 200);
  leftViewport.noStroke();
  leftViewport.ellipse(v2.x, v2.y, 20, 20);
  */
  PVector v1;
  PVector v2;
  if(tracker.centroids.size() > 0){
    v1 = tracker.centroids.get(0);
    v2 = tracker.centroids.get(1);
  }else{
    v1 = new PVector(0,0,0);
    v2 = new PVector(0,0,0);
    
  }
  if(Math.sqrt(distance(v1,v2)) <= 50){
    v1 = v2 = tracker.getLerpedPos();
    nClusters = 1;
  }else {
    nClusters = 2;
  }
  //println("1 " + v1.x);
  leftViewport.fill(50, 100, 250, 200);
  leftViewport.noStroke();
  leftViewport.ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  
  //println(v2.x);
  leftViewport.fill(100, 250, 50, 200);
  leftViewport.noStroke();
  leftViewport.ellipse(v2.x, v2.y, 20, 20);
  
  // Display some info
  int t = tracker.getThreshold();
  //int avgMinDepth = tracker.avgMinDepth;
  float lerpAvgMinDepth = tracker.lerpAvgMinDepth;
  leftViewport.fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
  leftViewport.endDraw();
  
  rightViewport.beginDraw();
  rightViewport.pushMatrix();
  rightViewport.translate(300, 300, 1);
  int axesSize = 1000;
  //Draw Axes
  //X  - red
  rightViewport.stroke(192,0,0);
  rightViewport.line(0,0,0,axesSize,0,0);
  //Y - green
  rightViewport.stroke(0,192,0);
  rightViewport.line(0,0,0,0,axesSize,0);
  //Z - blue
  rightViewport.stroke(0,0,192);
  rightViewport.line(0,0,0,0,0,axesSize);

  rightViewport.translate(-300, -300, 0);
  rightViewport.popMatrix();
  
  rightViewport.pushMatrix();
  
  if(nClusters == 1){
    rightViewport.translate(v1.x, v1.y, v1.z);
    lastPosition = new PVector(v1.x, v1.y, scale);
    rightViewport.scale(scale);
  }else{
    rightViewport.translate(lastPosition.x, lastPosition.y, 0);
    rightViewport.scale(lastPosition.z);
    tracker.calculateClusterDepth();
    float dy = v1.y - v2.y; //Y distance between two points
    float dd = tracker.lerpK1Depth - tracker.lerpK2Depth; //Depth distance between two points
    
    rightViewport.rotateX(map(lerpAvgMinDepth, minDepth+40, maxDepth, -4*PI, 4*PI));
    if(Math.abs(dy) > 5){
      rightViewport.rotateZ(map(dy, -100, 100, -PI, PI));
    }
    println(dd);
    //rightViewport.rotateY(map(dd, -200, 200, -PI, PI));
  }
  
  //
  
    //Draw Scene
  angle+=.07;
  rightViewport.noStroke();
  rightViewport.fill(204);
  rightViewport.background(0);
  rightViewport.lights();
  //rightViewport.perspective();//default
  rightViewport.box(160);
  rightViewport.popMatrix();
  
  rightViewport.endDraw();
  
  image(leftViewport, 0, 0);
  image(rightViewport, w/2, 0);
}
