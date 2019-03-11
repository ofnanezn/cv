// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/
import java.util.Random;
import java.lang.Math;
class KinectTracker {

  // Depth threshold
  int threshold = 745;
  int maxThreshold = 800;
  int minThreshold = 650;
  int gap = 50;
  int avgMinDepth;
  float lerpAvgMinDepth;
  // Raw location
  PVector loc;
  
  ArrayList<PVector> samples;
  ArrayList<PVector> centroids;
  float k1Depth;
  float k2Depth;

  float lerpK1Depth;
  float lerpK2Depth;


  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;
  
  // What we'll show the user
  PImage display;
   
  KinectTracker(int minThreshold, int maxThreshold) {
    // This is an awkard use of a global variable here
    // But doing it this way for simplicity
    kinect.initDepth();
    kinect.enableMirror(true);
    this.minThreshold = minThreshold;
    this.maxThreshold = maxThreshold;
    // Make a blank image
    display = createImage(kinect.width, kinect.height, RGB);
    // Set up the vectors
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
    avgMinDepth = 0;
    lerpAvgMinDepth = 0;
    k1Depth = 0;
    k2Depth = 0;
    lerpK1Depth = 0;
    lerpK2Depth = 0;
    samples = new ArrayList<PVector>();
    centroids = new ArrayList<PVector>();
  }

  void track() {
    samples = new ArrayList<PVector>();
    centroids = new ArrayList<PVector>();
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;
    int minDepth = 100000;
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];
        if(rawDepth < minDepth)
          minDepth = rawDepth;
        
      }
    }
    this.setThreshold(minDepth);
    avgMinDepth = 0;
    //threshold = minDepth;
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];
        if(rawDepth < minDepth)
          minDepth = rawDepth;
        // Testing against threshold
        if (rawDepth < maxThreshold && rawDepth < this.getThreshold() + gap && rawDepth > minThreshold) {
          sumX += x;
          sumY += y;
          samples.add(new PVector(x, y, 0));
          avgMinDepth += rawDepth;
          count++;
        }
      }
    }
    // As long as we found something
    if (count != 0) {
      loc = new PVector(sumX/count, sumY/count);
      avgMinDepth = (int)(avgMinDepth/(count+0.0));
      lerpAvgMinDepth = PApplet.lerp((float)lerpAvgMinDepth, (float)avgMinDepth, 0.3f);
    }
    
    k_means(2, 6);
    // Interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }

  PVector getPos() {
    return loc;
  }
  
  void k_means(int k, int maxIter){
    if(samples.size() < 1) return;
    Random randomGenerator = new Random();
    for(int i = 0; i < k; i++){
      int index = randomGenerator.nextInt(samples.size());
      centroids.add(i, samples.get(index));
    }
    
    for(int t = 0; t < maxIter; t++){
      for(int i = 0; i < samples.size(); i++){
        float minDistance = 999999;
        int argMin = -1;
        for(int j = 0; j < k; j++){
          float kDistance = (float)distance(samples.get(i), centroids.get(j));
          if(minDistance > kDistance){
            minDistance = kDistance;
            argMin = j;
          }
        }
        samples.set(i, new PVector(samples.get(i).x, samples.get(i).y, float(argMin)));
      }
      
      float[] xs = new float[k];
      float[] ys = new float[k];
      int[] counts = new int[k];
      
      for(int j = 0; j < k; j++){
        xs[j] = 0;
        ys[j] = 0;
        counts[j] = 0;
      }
      
      for(int i = 0; i < samples.size(); i++){
        PVector sample = samples.get(i);
        for(int j = 0; j < k; j++){
          if((int)sample.z == j){
            xs[j] += sample.x;
            ys[j] += sample.y;
            counts[j] += 1;
          }
        }
      }
      
      for(int i = 0; i < k; i++){
        float nX = xs[i] / counts[i];
        float nY = ys[i] / counts[i];
        PVector newCentroid = new PVector(nX, nY, (float)i);
        centroids.set(i, newCentroid);
      }
      
    }
    
    //println(centroids.get(0).x + " " + centroids.get(0).y);
    //println(centroids.get(1).x + " " + centroids.get(1).y);
    if(centroids.get(0).x > centroids.get(1).x){
      PVector left = centroids.get(1);
      centroids.set(1, centroids.get(0));
      centroids.set(0, left);
    }
  }
  
  void calculateClusterDepth(){
    int countK1 = 0;
    int countK2 = 0;
    k1Depth = 0;
    k2Depth = 0;
    PVector sampleK1 = new PVector();
    PVector sampleK2 = new PVector();
    for(int i = 0; i < samples.size(); i++){
        if(samples.get(i).z == 0){
          countK1++;
          k1Depth += depth[(int)(samples.get(i).x + samples.get(i).y * kinect.width)];
          sampleK1 = samples.get(i);
        }else{
          countK2++;
          k2Depth += depth[(int)(samples.get(i).x + samples.get(i).y * kinect.width)];
          sampleK2 = samples.get(i);
        }
      }
    k1Depth = k1Depth / (countK1 + 0.0);
    k2Depth = k2Depth / (countK2 + 0.0);
    if(sampleK1.x > sampleK2.x){
      float rightDepth = k1Depth;
      k1Depth = k2Depth;
      k2Depth = rightDepth;
    }
    lerpK1Depth = PApplet.lerp((float)lerpK1Depth, (float)k1Depth, 0.3f);
    lerpK2Depth = PApplet.lerp((float)lerpK2Depth, (float)k2Depth, 0.3f);
  }

  void display(PGraphics viewport) {
    PImage img = kinect.getDepthImage();

    // Being overly cautious here
    if (depth == null || img == null) return;

    // Going to rewrite the depth image to show which pixels are in threshold
    // A lot aof this is redundant, but this is just for demonstration purposes
    display.loadPixels();
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {

        int offset = x + y * kinect.width;
        // Raw depth
        int rawDepth = depth[offset];
        int pix = x + y * display.width;
        if (rawDepth < maxThreshold && rawDepth < this.getThreshold() + gap && rawDepth > minDepth ) {
          // A red color instead
          display.pixels[pix] = color(150, 50, 50);
        } else {
          display.pixels[pix] = img.pixels[offset];
        }
      }
    }
    display.updatePixels();

    // Draw the image
    viewport.image(display, 0, 0);
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}

static double distance(PVector a, PVector b){
  return Math.pow((a.x-b.x), 2) + Math.pow((a.y-b.y), 2);
}
