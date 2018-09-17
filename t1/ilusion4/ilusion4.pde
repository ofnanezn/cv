PImage img;
PImage img2;
PImage bg;

int imgX, imgY;
int mX, mY;

void setup(){
  size(1400, 1000);
  bg = loadImage("tunnel.jpg");
  bg.resize(1400, 1000);
  background(bg);
  img = loadImage("crash.png");
  img.resize(100,120);
  image(img, 680, 250);
  imgX = 680;
  imgY = 250;
  img2 = loadImage("crash.png");
  img2.resize(100,120);
  image(img2, imgX, imgY);
}
 
void draw(){
  if(mousePressed){ // is the mousebutton being held?
    imgX = mouseX-mX;
    imgY = mouseY-mY;
  }
  background(bg);
  image(img, 680, 250);
  image(img2,imgX,imgY);
   //img2.clear();
}

void mousePressed()
{
 // set variables for holding mouseposition offset 
 // to the image
   mX = mouseX-imgX;
   mY = mouseY-imgY;
}
