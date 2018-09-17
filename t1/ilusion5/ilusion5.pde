float radius = 600;
float maxDepth = 300;
int nCircles = int(maxDepth / 6);
PVector[] circle = new PVector[nCircles];

void setup() {
  size(800, 600, P3D);
  noFill();
  strokeWeight(2);
  for (int i = 0; i < nCircles; i++)
    circle[i] = new PVector(0, 0, map(i, 0, nCircles - 1, 0, maxDepth));
}

void draw() {
  background(0);
  translate(width/2, height/2);
  float fc = (float)frameCount;

  for (int i = 0; i < nCircles; i++) {
    PVector curcir = circle[i];
    curcir.x = (noise((fc*2 + curcir.z) / 500) - .5) * width * map(curcir.z, 0, maxDepth, 6, 0);
    curcir.y = (noise((fc*2 - curcir.z) / 500) - .5) * height * map(curcir.z, 0, maxDepth, 6, 0);
    curcir.z += 1;

    float depthColor = map(curcir.z, 0, maxDepth, 0, 255);
    stroke(depthColor, depthColor);
    float r = map(curcir.z, 0, maxDepth, radius*.1, radius);

    pushMatrix();
    translate(curcir.x, curcir.y, curcir.z);
    ellipse(0, 0, r, r);
    popMatrix();

    if (curcir.z > maxDepth) {
      circle[i].z = 0;
    }
  }
}
