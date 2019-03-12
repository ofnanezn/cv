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
PShader lightShader;
float angle2 = 0;

State[] states;

PVector lastPosition;
int nBoxes;
int selectedBox;
Random randomGenerator;

float[] x;
float[] y;
float[] z;

void settings(){
  size(1280, 520, P3D);
}

void setup() {
  
  lightShader = loadShader("lightfrag.glsl", "lightvert.glsl");
  minDepth = 400;
  maxDepth = 830;
  leftViewport = createGraphics(w/2, h, P3D);
  rightViewport = createGraphics(w/2, h, P3D);
  kinect = new Kinect(this);
  tracker = new KinectTracker(minDepth, maxDepth);
  scale = 1;
  lastPosition = new PVector(0, 0, 0);
  nBoxes = 5;
  states = new State[nBoxes];
  selectedBox = 0;
  randomGenerator = new Random();
  x = new float[nBoxes];
  y = new float[nBoxes];
  z = new float[nBoxes];
  for(int i = 0; i < nBoxes; i++){
    x[i] = 200 + randomGenerator.nextFloat() * (300);
    y[i] = 200 + randomGenerator.nextFloat() * (300);
    z[i] = 0 + randomGenerator.nextFloat() * (0);
  }
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
  rightViewport.shader(lightShader);
  rightViewport.pointLight(255, 255, 255, 2, 0, 100);
  rightViewport.lights();
  for(int i = 0; i < nBoxes; i++){
    println(x[i]);
    drawBox(x[i], y[i] , z[i], rightViewport, i);
  }
  
  rightViewport.pushMatrix();
  PVector selectedPosition = states[selectedBox].position;
  PVector selectedRotation = states[selectedBox].rotation;
  rightViewport.translate(-selectedPosition.x, -selectedPosition.y, -selectedPosition.z);
  rightViewport.rotateX(selectedRotation.x);
  rightViewport.rotateY(selectedRotation.y);
  rightViewport.rotateZ(selectedRotation.z);
  //rotations
  if(nClusters == 1){
    rightViewport.scale(scale);
  }else{
    rightViewport.scale(lastPosition.z);
    tracker.calculateClusterDepth();
    float dy = v1.y - v2.y; //Y distance between two points
    float dd = tracker.lerpK1Depth - tracker.lerpK2Depth; //Depth distance between two points
    float xAngle = map(lerpAvgMinDepth, minDepth+40, maxDepth, -4*PI, 4*PI);
    float yAngle = map(dd, -200, 200, -PI, PI);
    float zAngle = map(dy, -100, 100, -PI, PI);
    rightViewport.rotateX(xAngle);
    if(Math.abs(dy) > 5){
      rightViewport.rotateZ(zAngle);
    }
    println(dd);
    //rightViewport.rotateY(yAngle);  
    states[selectedBox].rotation = new PVector(xAngle, yAngle, zAngle);
  }
  rightViewport.translate(selectedPosition.x, selectedPosition.y, selectedPosition.z);
  //translations
  if(nClusters == 1){
    rightViewport.translate(v1.x, v1.y, v1.z);
    lastPosition = new PVector(v1.x, v1.y, scale);
  }else{
    rightViewport.translate(lastPosition.x, lastPosition.y, 0);
  }
  rightViewport.popMatrix();
  
  
  rightViewport.endDraw();
  
  image(leftViewport, 0, 0);
  image(rightViewport, w/2, 0);
}

void drawBox(float x, float y , float z, PGraphics viewPort, int i){
  viewPort.pushMatrix();
  
  viewPort.translate(x,y,z);
  viewPort.noStroke();
  viewPort.fill(204);
  
  //rightViewport.perspective();//default
  viewPort.box(50);
  states[i] = new State(new PVector(x, y, z), new PVector(0, 0, 0));
  viewPort.popMatrix();
}
