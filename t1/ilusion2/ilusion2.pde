PImage img;
boolean clear;

void setup() {
  clear = true;
  img = loadImage("./girl.jpg");
  println( "Your image size is " + img.width + ", " + img.height );
  size(608, 811);
  background(255);
  noLoop();
}


void super_draw_lines() {
  int thickness = 10;
  strokeWeight(thickness/2);
  //strokeJoin(MITER);
  strokeCap(PROJECT);
  noFill();
  for ( int j=-2*(int)pow(thickness,3); j < img.width + thickness; j+=sqrt(2)*thickness ) {
    boolean flag = false;
    beginShape();
    for ( int i=0; i < img.height+100; i += 50 ) {
      vertex((flag?0:50) + j, i);
      flag = !flag;
    }
    endShape();
  }
}

void average(){
  loadPixels();
  int dimension = width * height;
  img.filter(GRAY);
  for ( int i=0; i<dimension; i++ ){
    color newC = lerpColor(pixels[i], img.pixels[i], 0.20);
    //println( pixels[i] + " "+ img.pixels[i] + " " + newC );
    pixels[i] = newC;
  }
  updatePixels();
}

void draw() {
  if (clear) {
    //image(img, 0, 0, img.width, img.height);
    //filter(GRAY);
    background(255);
    super_draw_lines();
    average();
    //draw_lines();
  } else {
    background(255);
    image(img, 0, 0, img.width, img.height);
    //filter(GRAY);
  }
}
void mouseClicked() {
  clear = !clear;
  redraw();
}
