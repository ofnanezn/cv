// Exercise 13-5: Using Example 13-5, draw a spiral path. Start in the center and move 
// outward. Note that this can be done by changing only one line of code and adding one line 
// of code!           

int circles = 1;
int r = 10;
float rotate = PI/200;
boolean alternate = false;

boolean clear = false;

void setup() {
  size(500, 500);
  background(255);
  noLoop();
}

void draw() {
  background(255);
  println(clear);
  if (!clear) {
    for (int i = 0; i<1000; i++) {
      strokeWeight((r/2)+1);
      noFill();

      //Upper half circumferences. ALternate colors
      if (alternate) {
        stroke(239, 28, 115);
      } else stroke(255, 144, 0);
      arc(width/2, height/2, circles*r, circles*r, PI, TWO_PI);
      //Upper green over orange
      if (!alternate) {
        stroke(0, 255, 141);
        arc(width/2, height/2, circles*r, circles*r, PI+QUARTER_PI+rotate*circles, PI+HALF_PI+rotate*circles);
      }
      //Lower half circumferences. ALternate colors
      if (!alternate) {
        stroke(239, 28, 115);
        arc(width/2+(r)/2, height/2, circles*r, circles*r, 0, PI);
      } else stroke(255, 144, 0);
      arc(width/2+(r)/2, height/2, circles*r, circles*r, 0, PI);

      //Lower green over purple 
      if (!alternate) {
        stroke(0, 255, 141);
        arc(width/2+(r)/2, height/2, circles*r, circles*r, QUARTER_PI+rotate*circles, HALF_PI+rotate*circles);
      }

      alternate = !alternate;
      circles+=1;
      //println(circles);
    }
  } else { 
    for (int i = 0; i<1000; i++) {
      //Lower green over purple 
      if (!alternate) {
        stroke(0, 255, 141);
        arc(width/2+(r)/2, height/2, circles*r, circles*r, QUARTER_PI+rotate*circles, HALF_PI+rotate*circles);
      }
      //Upper green over orange
      if (!alternate) {
        stroke(0, 255, 141);
        arc(width/2, height/2, circles*r, circles*r, PI+QUARTER_PI+rotate*circles, PI+HALF_PI+rotate*circles);
      }
      alternate = !alternate;
      circles+=1;
    }
  }
}

void mouseClicked() {
  clear = !clear;
  circles = 1;
  r = 10;
  rotate = PI/200;
  alternate = false;
  redraw();
}
