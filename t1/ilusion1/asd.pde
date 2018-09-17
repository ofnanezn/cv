/*int centerX1 = 250;
int centerY1 =250;
int centerX2 = 250;
int centerY2 =244;
int drawsteps = 100;
float delta = 0.5;
void setup() {
  size(500, 500);
}
 
void draw() {
 beginShape();
  for (float t = 0; t < drawsteps *TWO_PI; t+=delta ) {
    float x = centerX1 + t * cos(t);
    float y = centerY1 + t * sin(t);
    float u = centerX1 + (t+delta) * cos(t+delta);
    float s = centerX1 + (t+delta) * sin(t+delta);
    stroke(255,0,150);
    strokeWeight(3);
    curveVertex(x, y);
    //line(x,y,u,s);
  }
  for (float t = 0; t < drawsteps *TWO_PI; t+=delta ) {
  float x1 = centerX2 + t * cos(t);
    float y1 = centerY2 + t * sin(t);
    float u1 = centerX2 + (t+delta) * cos(t+delta);
    float s1 = centerX2 + (t+delta) * sin(t+delta);
    stroke(255, 122, 50);
    strokeWeight(3);
    curveVertex(x1, y1);
  }
  endShape();
 
}*/
