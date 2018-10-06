import frames.timing.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

// 1. Frames' objects
Scene scene;
Frame frame;
Vector v1, v2, v3;
Vector[] v;
color[] c;
int antiAliasing;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  //use 2^n to change the dimensions
  size(512, 512, renderer);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fitBallInterpolation();
  strokeCap(SQUARE);
  c = new color[3];
  c[0] = color(255,0,0);
  c[1] = color(0,255,0);
  c[2] = color(0,0,255);
  antiAliasing = 2;


  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
      public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  frame = new Frame();
  frame.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(frame);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n

int aliasing(int startx, int starty, int endx, int endy, int cellSize){
  int cnt = 0;
  float center = cellSize/(2*antiAliasing);
  for (int x = startx; x < endx; x += (int)(cellSize / antiAliasing) ) {
    for (int y = starty; y < endy; y += (int)(cellSize / antiAliasing) ){
      Vector p = new Vector(x + center, y + center);
      float[] lambda = computeSimple(p, center, true);
      if(lambda == null) continue;
      cnt += 1;
    }
  }
  return cnt;
}   

void rasterize(int startx, int starty, int endx, int endy, int cellSize, boolean master) {
  int total_squares = int(pow(antiAliasing, 2));
  for (int x = startx; x <= endx; x += cellSize ) {
    for (int y = starty; y <= endy; y += cellSize ){
      int alias = 0;
      Vector p = new Vector(x + cellSize/2, y + cellSize/2);
      float[] lambda = compute(p, cellSize/2, true);
      //println(x);
      if(lambda == null) continue;
      alias = aliasing(x,y, x+cellSize, y+cellSize, cellSize);
      float percent = (total_squares - alias + 0.0)/total_squares;
      //println(percent);
      color backg = g.backgroundColor; 
      float red = lambda[0] * red(c[0]) + lambda[0] * red(c[1]) + lambda[0] * red(c[2]);
      float green = lambda[1] * green(c[0]) + lambda[1] * green(c[1]) + lambda[1] * green(c[2]);
      float blue = lambda[2] * blue(c[0]) + lambda[2] * blue(c[1]) + lambda[2] * blue(c[2]);
      color noAlias = color(red, green, blue);
      color col = lerpColor(noAlias, backg, percent);
      stroke(col);
      strokeCap(SQUARE);
      point(frame.location(p).x(), frame.location(p).y());
      //rect(frame.location(p).x(), frame.location(p).y(), 1, 1);
    }
  }
}

void triangleRaster() {
  // frame.location converts points from world to frame
  // here we convert v1 to illustrate the idea
  if (debug) {
    pushStyle();
    stroke(255, 255, 0, 125);
    int cellSize = round(width/pow(2, n));
    //rotate(PI/2);
    rasterize(round(-(width/2)),round(-(height/2)), round((width/2)), round((height/2)), cellSize, true);
    //point(round(frame.location(v1).x()), round(frame.location(v1).y()));
    popStyle();
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
  v = new Vector[]{v1, v2, v3};
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
  if (key == 'a'){
    if(antiAliasing * 2 >= 8)
      antiAliasing = 1;
    else
      antiAliasing = antiAliasing == 1? 2 : antiAliasing*2;
    println(antiAliasing);
  }
}
