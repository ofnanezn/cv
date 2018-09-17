int box = 0;

void setup(){
  size(800, 600, P2D);
  background(255);
  strokeWeight(2);
  
  for(int i = 250; i <= 500; i += 50)
    line(i, 202, i, 400);
  
  for(int i = 240; i <= 500; i += 100)
    line(i, 200, i + 35, 150);
  
  for(int i = 310; i <= 600; i += 100)
    line(i, 200, i - 35, 150);
  
  noFill();
  for(int i = 240; i < 500; i += 100 ){
    beginShape();
    curveVertex(i+25,175);
    curveVertex(i ,200);
    curveVertex(i+70,200);
    curveVertex(i+45,175);
    endShape();
  }
  
  beginShape();
  curveVertex(300,0);
  curveVertex(250,400);
  curveVertex(350,500);
  curveVertex(450,400);
  curveVertex(400,0);
  endShape();
  
  beginShape();
  curveVertex(400,500);
  curveVertex(350,500.5);
  curveVertex(455,485);
  curveVertex(500,400);
  curveVertex(500,200);
  endShape();
  
  beginShape();
  curveVertex(325,200);
  curveVertex(300,400);
  curveVertex(350,450);
  curveVertex(400,400);
  curveVertex(375,200);
  endShape();
  
  beginShape();
  curveVertex(350,275);
  curveVertex(350,400);
  curveVertex(370,435);
  curveVertex(385,435);
  curveVertex(375,400);
  endShape();
}

void draw(){
  if(box == 0){
    background(255);
    strokeWeight(2);
    
    for(int i = 250; i <= 500; i += 50)
      line(i, 202, i, 400);
    
    for(int i = 240; i <= 500; i += 100)
      line(i, 200, i + 35, 150);
    
    for(int i = 310; i <= 600; i += 100)
      line(i, 200, i - 35, 150);
    
    noFill();
    for(int i = 240; i < 500; i += 100 ){
      beginShape();
      curveVertex(i+25,175);
      curveVertex(i ,200);
      curveVertex(i+70,200);
      curveVertex(i+45,175);
      endShape();
    }
    
    beginShape();
    curveVertex(300,0);
    curveVertex(250,400);
    curveVertex(350,500);
    curveVertex(450,400);
    curveVertex(400,0);
    endShape();
    
    beginShape();
    curveVertex(400,500);
    curveVertex(350,500.5);
    curveVertex(455,485);
    curveVertex(500,400);
    curveVertex(500,200);
    endShape();
    
    beginShape();
    curveVertex(325,200);
    curveVertex(300,400);
    curveVertex(350,450);
    curveVertex(400,400);
    curveVertex(375,200);
    endShape();
    
    beginShape();
    curveVertex(350,275);
    curveVertex(350,400);
    curveVertex(370,435);
    curveVertex(385,435);
    curveVertex(375,400);
    endShape();
  }
  else if(box == 1){
    background(255);
    strokeWeight(2);
    
    for(int i = 250; i <= 500; i += 50)
      line(i, 202, i, 400);
    
    for(int i = 240; i <= 500; i += 100)
      line(i, 200, i + 35, 150);
    
    for(int i = 310; i <= 600; i += 100)
      line(i, 200, i - 35, 150);
    
    noFill();
    for(int i = 240; i < 500; i += 100 ){
      beginShape();
      curveVertex(i+25,175);
      curveVertex(i ,200);
      curveVertex(i+70,200);
      curveVertex(i+45,175);
      endShape();
    }
    
    beginShape();
    curveVertex(300,0);
    curveVertex(250,400);
    curveVertex(350,500);
    curveVertex(450,400);
    curveVertex(400,0);
    endShape();
    
    beginShape();
    curveVertex(400,500);
    curveVertex(350,500.5);
    curveVertex(455,485);
    curveVertex(500,400);
    curveVertex(500,200);
    endShape();
    
    beginShape();
    curveVertex(325,200);
    curveVertex(300,400);
    curveVertex(350,450);
    curveVertex(400,400);
    curveVertex(375,200);
    endShape();
    
    beginShape();
    curveVertex(350,275);
    curveVertex(350,400);
    curveVertex(370,435);
    curveVertex(385,435);
    curveVertex(375,400);
    endShape();
    fill(100);
    rect(0,0,800,300);
  }
  else{
    background(255);
    strokeWeight(2);
    
    for(int i = 250; i <= 500; i += 50)
      line(i, 202, i, 400);
    
    for(int i = 240; i <= 500; i += 100)
      line(i, 200, i + 35, 150);
    
    for(int i = 310; i <= 600; i += 100)
      line(i, 200, i - 35, 150);
    
    noFill();
    for(int i = 240; i < 500; i += 100 ){
      beginShape();
      curveVertex(i+25,175);
      curveVertex(i ,200);
      curveVertex(i+70,200);
      curveVertex(i+45,175);
      endShape();
    }
    
    beginShape();
    curveVertex(300,0);
    curveVertex(250,400);
    curveVertex(350,500);
    curveVertex(450,400);
    curveVertex(400,0);
    endShape();
    
    beginShape();
    curveVertex(400,500);
    curveVertex(350,500.5);
    curveVertex(455,485);
    curveVertex(500,400);
    curveVertex(500,200);
    endShape();
    
    beginShape();
    curveVertex(325,200);
    curveVertex(300,400);
    curveVertex(350,450);
    curveVertex(400,400);
    curveVertex(375,200);
    endShape();
    
    beginShape();
    curveVertex(350,275);
    curveVertex(350,400);
    curveVertex(370,435);
    curveVertex(385,435);
    curveVertex(375,400);
    endShape();
    fill(100);
    rect(0,300,800,600);
  }
}

void mousePressed(){
  box = (box + 1) % 3;
}
