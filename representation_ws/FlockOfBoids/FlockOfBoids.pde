/**
 * Flock of Boids
 * by Jean Pierre Charalambos.
 *
 * This example displays the famous artificial life program "Boids", developed by
 * Craig Reynolds in 1986 [1] and then adapted to Processing by Matt Wetmore in
 * 2010 (https://www.openprocessing.org/sketch/6910#), in 'third person' eye mode.
 * The Boid under the mouse will be colored blue. If you click on a boid it will
 * be selected as the scene avatar for the eye to follow it.
 *
 * 1. Reynolds, C. W. Flocks, Herds and Schools: A Distributed Behavioral Model. 87.
 * http://www.cs.toronto.edu/~dt/siggraph97-course/cwr87/
 * 2. Check also this nice presentation about the paper:
 * https://pdfs.semanticscholar.org/73b1/5c60672971c44ef6304a39af19dc963cd0af.pdf
 * 3. Google for more...
 *
 * Press ' ' to switch between the different eye modes.
 * Press 'a' to toggle (start/stop) animation.
 * Press 'p' to print the current frame rate.
 * Press 'm' to change the boid visual mode.
 * Press 'v' to toggle boids' wall skipping.
 * Press 's' to call scene.fitBallInterpolation().
 */

import frames.primitives.*;
import frames.core.*;
import frames.processing.*;
import java.util.Random;

Scene scene;
//flock bounding box
static int flockWidth = 1280;
static int flockHeight = 720;
static int flockDepth = 600;
static boolean avoidWalls = true;

int r0, r1, r2, r3, r4, r5, r6, r7;
int initBoidNum = 900; // amount of boids to start the program with
ArrayList<Boid> flock;
Frame avatar;
boolean animate = true;
String curve = "N"; 
Random r = new Random();

int[] randoms;
int nPoints = 6;

int MAX_PTOS = 10; /* Numero maximo de puntos de control */
int NUM_SEG =  20; /* Cuanto mayor sea, mejor se dibuja */

void setup() {
  size(1000, 800, P3D);
  
  
  if(curve == "3B"){
    r0 = r.nextInt(initBoidNum);
    r1 = r.nextInt(initBoidNum);
    r2 = r.nextInt(initBoidNum);
    r3 = r.nextInt(initBoidNum);
  } else if(curve == "3H"){
    r0 = r.nextInt(initBoidNum);
    r1 = r.nextInt(initBoidNum);
  } else if(curve == "7B"){
    r0 = r.nextInt(initBoidNum);
    r1 = r.nextInt(initBoidNum);
    r2 = r.nextInt(initBoidNum);
    r3 = r.nextInt(initBoidNum);
    r4 = r.nextInt(initBoidNum);
    r5 = r.nextInt(initBoidNum);
    r6 = r.nextInt(initBoidNum);
    r7 = r.nextInt(initBoidNum);
    print(r0 + " " + r1 + " " + r2 + " " + r3 + " " + r4 + " " + r5 + " " + r6 + " " + r7);
  } else if(curve == "N"){
    randoms = new int[nPoints];
    for(int k = 0; k < nPoints; k++){
      int rPos = r.nextInt(initBoidNum);
      randoms[k] = rPos;
    }
  }
  scene = new Scene(this);
  scene.setBoundingBox(new Vector(0, 0, 0), new Vector(flockWidth, flockHeight, flockDepth));
  scene.setAnchor(scene.center());
  scene.setFieldOfView(PI / 3);
  scene.fitBall();
  // create and fill the list of boids
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2)));
}

void draw() {
  background(10, 50, 25);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  //print(flock.get(0).position);
  walls();
  scene.traverse();
  stroke(255,255,0);
  
  if(curve == "3B"){
    Vector v0 = flock.get(r0).position;
    Vector v1 = flock.get(r1).position;
    Vector v2 = flock.get(r2).position;
    Vector v3 = flock.get(r3).position;
    
    Point P0 = new Point(v0.x(), v0.y(), v0.z());
    Point P1 = new Point(v1.x(), v1.y(), v1.z());
    Point P2 = new Point(v2.x(), v2.y(), v2.z());
    Point P3 = new Point(v3.x(), v3.y(), v3.z());
    Point[] P = new Point[]{P0,P1,P2,P3};
    
    BezierCurve(P);
  } else if(curve == "3H"){
    Vector v0 = flock.get(r0).position;
    Vector v1 = flock.get(r1).position;
    
    Point P0 = new Point(v0.x(), v0.y(), v0.z());
    Point P1 = new Point(v1.x(), v1.y(), v1.z());
    Point m1 = new Point(P0.x+10, P0.y+10, P0.z+10);
    Point m0 = new Point(P1.x-20, P1.y-20, P1.z-20);
    
    cubicHermiteCurve(P0, P1, m0, m1);
  } else if(curve == "7B"){
    Vector v0 = flock.get(r0).position;
    Vector v1 = flock.get(r1).position;
    Vector v2 = flock.get(r2).position;
    Vector v3 = flock.get(r3).position;
    Vector v4 = flock.get(r4).position;
    Vector v5 = flock.get(r5).position;
    Vector v6 = flock.get(r6).position;
    Vector v7 = flock.get(r6).position;
    
    Point P0 = new Point(v0.x(), v0.y(), v0.z());
    Point P1 = new Point(v1.x(), v1.y(), v1.z());
    Point P2 = new Point(v2.x(), v2.y(), v2.z());
    Point P3 = new Point(v3.x(), v3.y(), v3.z());
    Point P4 = new Point(v4.x(), v4.y(), v4.z());
    Point P5 = new Point(v5.x(), v5.y(), v5.z());
    Point P6 = new Point(v6.x(), v6.y(), v6.z());
    Point P7 = new Point(v7.x(), v7.y(), v7.z());
    Point[] P = new Point[]{P0,P1,P2,P3,P4,P5,P6,P7};
    
    BezierCurve(P);
  }else if(curve == "N"){
    Point[] P = new Point[nPoints];
    for(int k = 0; k < P.length; k++){
      Vector vp = flock.get(randoms[k]).position;
      Point p = new Point(vp.x(), vp.y(), vp.z());
      P[k] = p;
    }
    SplineCubicaNatural(P);
  }
  
  
  // uncomment to asynchronously update boid avatar. See mouseClicked()
  // updateAvatar(scene.trackedFrame("mouseClicked"));
}

float binCoeff(int n, int k){ 
  if (k == 0 || k == n) 
    return 1; 
  return binCoeff(n - 1, k - 1) + binCoeff(n - 1, k); 
} 

void cubicHermiteCurve(Point P0, Point P1, Point m0, Point m1){  
  for(float t = 0.0; t<=1; t+=0.001){
      Point P = P0.dot(2.0*pow(t,3)-3.0*pow(t,2)+1).add(m0.dot(pow(t,3)-2.0*pow(t,2)+t)).add(P1.dot(-2.0*pow(t,3)+3.0*pow(t,2))).add(m1.dot(pow(t,3)-pow(t,2)));
      point(P.x, P.y, P.z);
  } 
}

/*void cubicBezierCurve(Point P0, Point P1, Point P2, Point P3){  
  for(float t = 0.0; t<=1; t+=0.001){
      Point B = P0.dot(pow((1 - t),3)).add(P1.dot(3.0 * t * pow((1 - t),2))).add(P2.dot(3.0 * pow(t, 2) * (1 - t))).add(P3.dot(pow(t,3)));
      point(B.x, B.y, B.z);
  } 
}*/

void BezierCurve(Point[] P){  
  for(float t = 0.0; t<=1; t+=0.001){
    Point B = new Point(0.0,0.0,0.0);
    int n = P.length - 1;
    for(int i = 0; i <= n; i++){
      B = B.add(P[i].dot(binCoeff(n, i)*pow(1-t, n-i)*pow(t,i)));
    }
    point(B.x, B.y, B.z);
  } 
}

void SplineCubicaNatural (Point[] P)
{
  int i, j, m, xp, yp, zp;
  int n = P.length;
  double[] ax = new double[MAX_PTOS];
  double[] bx = new double[MAX_PTOS]; 
  double[] cx = new double[MAX_PTOS]; 
  double[] dx = new double[MAX_PTOS];
  
  double[] ay = new double[MAX_PTOS];
  double[] by = new double[MAX_PTOS]; 
  double[] cy = new double[MAX_PTOS]; 
  double[] dy = new double[MAX_PTOS];
  
  double[] az = new double[MAX_PTOS];
  double[] bz = new double[MAX_PTOS]; 
  double[] cz = new double[MAX_PTOS]; 
  double[] dz = new double[MAX_PTOS];
  
  double[] der = new double[MAX_PTOS];
  double[] gam = new double[MAX_PTOS];
  double[] ome = new double[MAX_PTOS];
  
  double t, dt;
  m = n-1; /* m es el numero de intervalos que tendremos */
  /* Calculamos el valor de gamma (sera el mismo en X y en Y) */
  gam[0] = .5;
  for (i=1; i<m; i++) gam[i] = 1./(4.-gam[i-1]);
  gam[m] = 1./(2.-gam[m-1]);
  /* Calculamos el valor de omega para X */
  ome[0] = 3.*(P[1].x-P[0].x)*gam[0];
  for (i=1; i<m; i++) ome[i] = (3.*(P[i+1].x-P[i-1].x)-ome[i-1])*gam[i];
  ome[m] = (3.*(P[m].x-P[m-1].x)-ome[m-1])*gam[m];
  /* Valor de la primera derivada en los puntos (eje X) */
  der[m]=ome[m];
  for (i=m-1; i>=0; i=i-1) der[i] = ome[i]-gam[i]*der[i+1];
  /* Sustituimos los valores de gamma, omega y la primera derivada
  para calcular los coeficientes a, b, c y d */
  for (i=0; i<m; i++) {
    ax[i] = P[i].x;
    bx[i] = der[i];
    cx[i] = 3.*(P[i+1].x-P[i].x)-2.*der[i]-der[i+1];
    dx[i] = 2.*(P[i].x-P[i+1].x)+der[i]+der[i+1];
  }
  /* Calculamos omega para Y */
  ome[0] = 3.*(P[1].y-P[0].y)*gam[0];
  for (i=1; i<m; i++) ome[i] = (3.*(P[i+1].y-P[i-1].y)-ome[i-1])*gam[i];
  ome[m] = (3.*(P[m].y-P[m-1].y)-ome[m-1])*gam[m];
  /* Valor de la primera derivada en los puntos (eje Y) */
  der[m]=ome[m];
  for (i=m-1; i>=0; i=i-1) der[i] = ome[i]-gam[i]*der[i+1];
  /* Sustituimos los valores de gamma, omega y la primera derivada
  para calcular los coeficientes a, b, c y d */
  for (i=0; i<m; i++) {
    ay[i] = P[i].y;
    by[i] = der[i];
    cy[i] = 3.*(P[i+1].y-P[i].y)-2.*der[i]-der[i+1];
    dy[i] = 2.*(P[i].y-P[i+1].y)+der[i]+der[i+1];
  }
  /* Calculamos omega para Z */
  ome[0] = 3.*(P[1].z-P[0].z)*gam[0];
  for (i=1; i<m; i++) ome[i] = (3.*(P[i+1].z-P[i-1].z)-ome[i-1])*gam[i];
  ome[m] = (3.*(P[m].z-P[m-1].z)-ome[m-1])*gam[m];
  /* Valor de la primera derivada en los puntos (eje Z) */
  der[m]=ome[m];
  for (i=m-1; i>=0; i=i-1) der[i] = ome[i]-gam[i]*der[i+1];
  /* Sustituimos los valores de gamma, omega y la primera derivada
  para calcular los coeficientes a, b, c z d */
  for (i=0; i<m; i++) {
    az[i] = P[i].z;
    bz[i] = der[i];
    cz[i] = 3.*(P[i+1].z-P[i].z)-2.*der[i]-der[i+1];
    dz[i] = 2.*(P[i].z-P[i+1].z)+der[i]+der[i+1];
  }
  /* En esta parte, se dibujara la curva por segmentos de lineas
  rectas; si NUM_SEG es un valor alto, la grafica se dibujara
  con mayor precision. */
  dt = 1./(double) NUM_SEG;
  int prev_x = (int)P[0].x;
  int prev_y = (int)P[0].y;
  int prev_z = (int)P[0].z;
  
  for (i=0; i<m; i++) {
    for (j=1, t=dt; j<NUM_SEG; j++, t+=dt) {
      xp = (int) (ax[i]+bx[i]*t+cx[i]*t*t+dx[i]*t*t*t);
      yp = (int) (ay[i]+by[i]*t+cy[i]*t*t+dy[i]*t*t*t);
      zp = (int) (az[i]+bz[i]*t+cz[i]*t*t+dz[i]*t*t*t);
      line(prev_x, prev_y, prev_z, xp, yp, zp);
      prev_x = xp;
      prev_y = yp;
      prev_z = zp;
    }
  }
}

void walls() {
  pushStyle();
  noFill();
  stroke(255, 255, 0);

  line(0, 0, 0, 0, flockHeight, 0);
  line(0, 0, flockDepth, 0, flockHeight, flockDepth);
  line(0, 0, 0, flockWidth, 0, 0);
  line(0, 0, flockDepth, flockWidth, 0, flockDepth);

  line(flockWidth, 0, 0, flockWidth, flockHeight, 0);
  line(flockWidth, 0, flockDepth, flockWidth, flockHeight, flockDepth);
  line(0, flockHeight, 0, flockWidth, flockHeight, 0);
  line(0, flockHeight, flockDepth, flockWidth, flockHeight, flockDepth);

  line(0, 0, 0, 0, 0, flockDepth);
  line(0, flockHeight, 0, 0, flockHeight, flockDepth);
  line(flockWidth, 0, 0, flockWidth, 0, flockDepth);
  line(flockWidth, flockHeight, 0, flockWidth, flockHeight, flockDepth);
  popStyle();
}

void updateAvatar(Frame boid) {
  if (boid != avatar) {
    avatar = boid;
    if (avatar != null)
      thirdPerson();
    else if (scene.eye().reference() != null)
      resetEye();
  }
}

// Sets current avatar as the eye reference and interpolate the eye to it
void thirdPerson() {
  scene.eye().setReference(avatar);
  scene.interpolateTo(avatar);
}

// Resets the eye
void resetEye() {
  // same as: scene.eye().setReference(null);
  scene.eye().resetReference();
  scene.lookAt(scene.center());
  scene.fitBallInterpolation();
}

// picks up a boid avatar, may be null
void mouseClicked() {
  // two options to update the boid avatar:
  // 1. Synchronously
  updateAvatar(scene.track("mouseClicked", mouseX, mouseY));
  // which is the same as these two lines:
  // scene.track("mouseClicked", mouseX, mouseY);
  // updateAvatar(scene.trackedFrame("mouseClicked"));
  // 2. Asynchronously
  // which requires updateAvatar(scene.trackedFrame("mouseClicked")) to be called within draw()
  // scene.cast("mouseClicked", mouseX, mouseY);
}

// 'first-person' interaction
void mouseDragged() {
  if (scene.eye().reference() == null)
    if (mouseButton == LEFT)
      // same as: scene.spin(scene.eye());
      scene.spin();
    else if (mouseButton == RIGHT)
      // same as: scene.translate(scene.eye());
      scene.translate();
    else
      // same as: scene.zoom(mouseX - pmouseX, scene.eye());
      scene.zoom(mouseX - pmouseX);
}

// highlighting and 'third-person' interaction
void mouseMoved(MouseEvent event) {
  // 1. highlighting
  scene.cast("mouseMoved", mouseX, mouseY);
  // 2. third-person interaction
  if (scene.eye().reference() != null)
    // press shift to move the mouse without looking around
    if (!event.isShiftDown())
      scene.lookAround();
}

void mouseWheel(MouseEvent event) {
  // same as: scene.scale(event.getCount() * 20, scene.eye());
  scene.scale(event.getCount() * 20);
}

void keyPressed() {
  switch (key) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fitBallInterpolation();
    break;
  case 't':
    scene.shiftTimers();
    break;
  case 'p':
    println("Frame rate: " + frameRate);
    break;
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case ' ':
    if (scene.eye().reference() != null)
      resetEye();
    else if (avatar != null)
      thirdPerson();
    break;
  }
}
