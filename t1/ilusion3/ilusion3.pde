import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;  

import java.io.*;
PeasyCam cam;

float x=15;
float y=15; 
float z=15;
float e;

boolean showGrid=false;
boolean showAxis=true;  //false;
boolean lockMouse=true;

CameraState state;

void setup() {
  size (1000, 700, P3D);
  ortho(-width/2, width/2, -height/2, height/2);
  //noLoop();
  cam = new PeasyCam(this, 700);
  state = readState();
  cam.setState(state);
  cam.setResetOnDoubleClick(false);
  /*try
   {    
   //Saving of object in a file 
   FileOutputStream file = new FileOutputStream(filename); 
   ObjectOutputStream out = new ObjectOutputStream(file); 
   
   // Method for serialization of object 
   out.writeObject(state); 
   
   out.close(); 
   file.close(); 
   
   System.out.println("Object has been serialized"); 
   
   } 
   
   catch(IOException ex) 
   { 
   System.out.println("IOException is caught"); 
   }
   */
}

CameraState readState(){
  String filename = "/home/juan/sketchbook/ilusion3/initState.ser";
  CameraState s = null;
  try {
    FileInputStream file = new FileInputStream(filename); 
    ObjectInputStream in = new ObjectInputStream(file); 

    // Method for deserialization of object 
    s = (CameraState)in.readObject(); 
    println("Good");
    in.close(); 
    file.close();
  }
  catch(IOException ex) 
  { 
    System.out.println("IOException is caught");
  } 
  catch(ClassNotFoundException ex) 
  { 
    System.out.println("ClassNotFoundException is caught");
  } 
  return s;
}
void draw() {
  background(0);
  println(cam.getRotations());

  if (showGrid) drawGrid(200, 200, 100, 2);
  if (showAxis) drawAxis(200);

  pushMatrix();
  //translate(5, 5, 0);
  fill(255);
  stroke(255);
  //sphere(5);
  popMatrix();
  pushMatrix();
  fill(255, 0, 0);
  stroke(255, 0, 0);
  translate(x, y, z);
  //sphere(5);


  //obvoiusly not working method
  //if (mousePressed && (mouseButton == RIGHT)) {
  if (showGrid==true && lockMouse==false) {
    //x= x+(mouseX-pmouseX);
    //y= y+(mouseY-pmouseY);
    x=mouseX;
    y=mouseY;
  }
  popMatrix();

  stroke(0, 0, 255);
  //line(0, 0, 0, x, y, z);
}
void mouseWheel(MouseEvent event) {
  e = event.getCount();
  z=z+e;
  println(e);
}
void mousePressed(MouseEvent evt) {
  if (evt.getCount() == 2) doubleClicked();
}

void doubleClicked() {
  cam.setState(state);
}

void mouseReleased() {
  //cam.setActive(true);
}

void keyReleased() {


  //if (key=='a')
  //showAxis=!showAxis;


  if (key=='g') {
    showGrid=!showGrid;
    lockMouse=true;   //Mouse always lock when changing states
    cam.setActive(!showGrid);
  }

  if (key=='m' && showGrid==true) {
    lockMouse=!lockMouse;
  }
}



// -------------------------------------------------------
void drawAxis(float len) {
  drawAxis(len, len, len);
}


// -------------------------------------------------------
void drawAxis(float len1, float len2, float len3) {

  pushStyle();
  strokeWeight(3);

  stroke(255, 0, 0);  //RED
  //line(0, 0, 0, len1, 0, 0);

  stroke(0, 255, 0);  //GREEN
  //line(0, 0, 0, 0, len2, 0);

  stroke(0, 0, 255);  //BLUE
  //line(0, 0, 0, 0, 0, len3);

  popStyle();

  //Left
  translate(-300, -400, -240);
  drawLadder(200);
  translate(0, 100, 0);
  drawLadder(210);
  translate(0, 100, 20);
  drawLadder(200);
  translate(0, 100, 0);
  drawLadder(210);

  //Front
  translate(100, 0, 0);
  drawLadder(220);
  translate(100, 0, 0);
  drawLadder(230);
  translate(100, 0, 0);
  drawLadder(240);
  translate(100, 0, 0);
  drawLadder(250);

  //Right
  translate(0, -100, 0);
  drawLadder(260);
  translate(0, -100, 0);
  drawLadder(270);

  //Back
  translate(-100, 0, 0);
  drawLadder(280);

  translate(-100, 0, 290);
  drawWeird();
}

void drawWeird() {
  stroke(0);
  fill(255);
  beginShape();

  //Top
  vertex(0, 0, 0);
  vertex( 100, 0, 0);
  vertex(   100, 100, 0);

  vertex(   80, 80, 0);

  vertex( 0, 80, 0);
  vertex(0, 0, 0);
  endShape();

  //left
  beginShape();
  vertex(0, 0, 0);
  vertex( 0, 0, -10);
  vertex( 0, 80, 0);
  endShape();


  beginShape();
  vertex( 0, 0, 0);
  vertex( 0, 0, -10);
  vertex( 100, 0, -10);
  vertex( 100, 0, 0);
  endShape();


  beginShape();
  vertex( 100, 100, 0);
  vertex( 100, 100, -10);
  vertex( 100, 0, -10);
  vertex( 100, 0, 0);
  vertex( 100, 100, 0);
  endShape();
  /*
  beginShape();
   vertex(0, 100, 0);
   vertex( 0, 0, -10);
   vertex(   99.2, 0, -10);
   vertex( 99.2, 100, 0);
   endShape();
   */
}

void drawLadder(int height1) {
  stroke(0);
  fill(255);
  beginShape();
  vertex(0, 0, 0);
  vertex( 100, 0, 0);
  vertex(   100, 100, 0);
  vertex( 0, 100, 0);
  vertex(0, 0, 0);
  endShape();

  beginShape();
  vertex(0, 0, 0);
  vertex( 0, 0, height1);
  vertex( 100, 0, height1);
  vertex( 100, 0, 0);
  endShape();

  beginShape();
  vertex( 100, 0, 0);
  vertex( 100, 0, height1);
  vertex( 100, 100, height1);
  vertex( 100, 100, 0);
  endShape();

  beginShape();
  vertex( 100, 100, 0);
  vertex( 100, 100, height1);
  vertex( 0, 100, height1);
  vertex( 0, 100, 0);
  endShape();

  beginShape();
  vertex( 0, 100, 0);
  vertex( 0, 100, height1);
  vertex( 0, 0, height1);
  vertex( 0, 0, 0);
  endShape();

  beginShape();
  vertex( 0, 0, height1);
  vertex( 100, 0, height1);
  vertex( 100, 100, height1);
  vertex( 0, 100, height1);
  vertex( 0, 0, height1);
  endShape();
}



// -------------------------------------------------------
// <a href="/two/profile/Args">@Args</a>:  Plane: 0=YZ  1=XZ  2=XY 
void drawGrid(int size, int w, int h, int plane) {
  pushStyle();
  noFill();
  if (plane == 0) stroke(255, 0, 0);
  if (plane == 1) stroke(0, 255, 0);
  if (plane == 2) stroke(0, 0, 255);
  int total = w * h;
  int tw = w * size;
  int th = h * size;
  beginShape(LINES);
  for (int i = 0; i < total; i++) {
    int x = (i % w) * size;
    int y = (i / w) * size;
    if (plane == 0) {
      vertex(0, x, 0);
      vertex(0, x, th);
      vertex(0, 0, y);
      vertex(0, tw, y);
    }
    if (plane == 1) {
      vertex(x, 0, 0);
      vertex(x, 0, th);
      vertex(0, 0, y);
      vertex(tw, 0, y);
    }
    if (plane == 2) {
      vertex(x, 0, 0);
      vertex(x, th, 0);
      vertex(0, y, 0);
      vertex(tw, y, 0);
    }
  }
  endShape();
  popStyle();
}
