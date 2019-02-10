import java.util.HashSet;
class Boid {
  public Frame frame;
  boolean retained = true;
  String mode = "VV";
  // fields
  Vector position, velocity, acceleration, alignment, cohesion, separation; // position, velocity, and acceleration in
  // a vector datatype
  float neighborhoodRadius; // radius in which it looks for fellow boids
  float maxSpeed = 4; // maximum magnitude for the velocity vector
  float maxSteerForce = .1f; // maximum magnitude of the steering vector
  float sc = 3; // scale factor for the render of the boid
  float flap = 0;
  float t = 0;
  Face[] faces = new Face[4];
  PShape faceVertex;
  PShape vertexVertex;

  Boid(Vector inPos) {
    position = new Vector();
    position.set(inPos);    
    //ArrayList<Vertex> vertices = new ArrayList();
    //ArrayList<Face> bird = new ArrayList();[
    if(mode == "FV"){
      Vertex[] vertices = new Vertex[4];
    
      vertices[0] = new Vertex(3 * sc, 0, 0);
      vertices[1] = new Vertex(-3 * sc, 2 * sc, 0);
      vertices[2] = new Vertex(-3 * sc, -2 * sc, 0);
      vertices[3] = new Vertex(-3 * sc, 0, 2 * sc);
      
      faces[0] = new Face(new Vertex[]{vertices[0], vertices[1], vertices[2]});
      faces[1] = new Face(new Vertex[]{vertices[0], vertices[1], vertices[3]});
      faces[2] = new Face(new Vertex[]{vertices[0], vertices[3], vertices[2]});
      faces[3] = new Face(new Vertex[]{vertices[3], vertices[1], vertices[2]});
      
      if(retained){
        pushStyle();
        strokeWeight(2);
        stroke(color(40, 255, 40));
        fill(color(0, 255, 0, 125));
        faceVertex = createShape();
        faceVertex.beginShape(TRIANGLES);
        for(int i = 0; i < faces.length; i++){
          for(int j = 0; j < 3; j++){
            Vertex this_vertex = faces[i].vertices[j]; 
            faceVertex.vertex(this_vertex.x, this_vertex.y, this_vertex.z); 
          }
        }
        faceVertex.endShape(CLOSE);
        popStyle();
      }
    }
    else{
      VVertex[] V = new VVertex[4];
      int[] adj0 = new int[]{1,2,3};
      int[] adj1 = new int[]{0,2,3};
      int[] adj2 = new int[]{0,1,3};
      int[] adj3 = new int[]{0,1,2};
      V[0] = new VVertex(3 * sc, 0, 0, adj0);
      V[1] = new VVertex(-3 * sc, 2 * sc, 0, adj1);
      V[2] = new VVertex(-3 * sc, -2 * sc, 0, adj2);
      V[3] = new VVertex(-3 * sc, 0, 2 * sc, adj3);
      HashSet<HashSet<Integer>> edges = new HashSet<HashSet<Integer>>();
      for(int i = 0; i < V.length; i++){
          for(int j=0; j < V[i].adj.length; j++){
            HashSet<Integer> edge = new HashSet<Integer>();
            edge.add(i);
            edge.add(V[i].adj[j]);
            edges.add(edge);
          }
        }
      if(retained){
        pushStyle();
        strokeWeight(2);
        stroke(color(40, 255, 40));
        fill(color(0, 255, 0, 125));
        faceVertex = createShape();
        faceVertex.beginShape(LINES);
        for(HashSet<Integer> edge: edges){
          int[] points = new int[2];
          int count = 0;
          for(Integer v: edge){
            points[count] = v;
            faceVertex.vertex(V[v].x, V[v].y, V[v].z);
            count+=1;
          }
        }
        faceVertex.endShape(CLOSE);
        popStyle();
      }
    }
    
    frame = new Frame(scene) {
      // Note that within visit() geometry is defined at the
      // frame local coordinate system.
      @Override
        public void visit() {
        if (animate)
          run(flock);
        render();
      }
    };
    frame.setPosition(new Vector(position.x(), position.y(), position.z()));
    velocity = new Vector(random(-1, 1), random(-1, 1), random(1, -1));
    acceleration = new Vector(0, 0, 0);
    neighborhoodRadius = 100;
  }

  public void run(ArrayList<Boid> bl) {
    t += .1;
    flap = 10 * sin(t);
    // acceleration.add(steer(new Vector(mouseX,mouseY,300),true));
    // acceleration.add(new Vector(0,.05,0));
    if (avoidWalls) {
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), flockHeight, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), 0, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(flockWidth, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(0, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), 0)), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), flockDepth)), 5));
    }
    flock(bl);
    move();
    checkBounds();
  }

  Vector avoid(Vector target) {
    Vector steer = new Vector(); // creates vector for steering
    steer.set(Vector.subtract(position, target)); // steering vector points away from
    steer.multiply(1 / sq(Vector.distance(position, target)));
    return steer;
  }

  //-----------behaviors---------------

  void flock(ArrayList<Boid> boids) {
    //alignment
    alignment = new Vector(0, 0, 0);
    int alignmentCount = 0;
    //cohesion
    Vector posSum = new Vector();
    int cohesionCount = 0;
    //separation
    separation = new Vector(0, 0, 0);
    Vector repulse;
    for (int i = 0; i < boids.size(); i++) {
      Boid boid = boids.get(i);
      //alignment
      float distance = Vector.distance(position, boid.position);
      if (distance > 0 && distance <= neighborhoodRadius) {
        alignment.add(boid.velocity);
        alignmentCount++;
      }
      //cohesion
      float dist = dist(position.x(), position.y(), boid.position.x(), boid.position.y());
      if (dist > 0 && dist <= neighborhoodRadius) {
        posSum.add(boid.position);
        cohesionCount++;
      }
      //separation
      if (distance > 0 && distance <= neighborhoodRadius) {
        repulse = Vector.subtract(position, boid.position);
        repulse.normalize();
        repulse.divide(distance);
        separation.add(repulse);
      }
    }
    //alignment
    if (alignmentCount > 0) {
      alignment.divide((float) alignmentCount);
      alignment.limit(maxSteerForce);
    }
    //cohesion
    if (cohesionCount > 0)
      posSum.divide((float) cohesionCount);
    cohesion = Vector.subtract(posSum, position);
    cohesion.limit(maxSteerForce);

    acceleration.add(Vector.multiply(alignment, 1));
    acceleration.add(Vector.multiply(cohesion, 3));
    acceleration.add(Vector.multiply(separation, 1));
  }

  void move() {
    velocity.add(acceleration); // add acceleration to velocity
    velocity.limit(maxSpeed); // make sure the velocity vector magnitude does not
    // exceed maxSpeed
    position.add(velocity); // add velocity to position
    frame.setPosition(position);
    frame.setRotation(Quaternion.multiply(new Quaternion(new Vector(0, 1, 0), atan2(-velocity.z(), velocity.x())), 
      new Quaternion(new Vector(0, 0, 1), asin(velocity.y() / velocity.magnitude()))));
    acceleration.multiply(0); // reset acceleration
  }

  void checkBounds() {
    if (position.x() > flockWidth)
      position.setX(0);
    if (position.x() < 0)
      position.setX(flockWidth);
    if (position.y() > flockHeight)
      position.setY(0);
    if (position.y() < 0)
      position.setY(flockHeight);
    if (position.z() > flockDepth)
      position.setZ(0);
    if (position.z() < 0)
      position.setZ(flockDepth);
  }

  void render() {
    pushStyle();

    // uncomment to draw boid axes
    //scene.drawAxes(10);

    strokeWeight(2);
    stroke(color(40, 255, 40));
    fill(color(0, 255, 0, 125));

    // highlight boids under the mouse
    if (scene.trackedFrame("mouseMoved") == frame) {
      stroke(color(0, 0, 255));
      fill(color(0, 0, 255));
    }

    // highlight avatar
    if (frame ==  avatar) {
      stroke(color(255, 0, 0));
      fill(color(255, 0, 0));
    }

    //draw boid
    if(retained == true){
      shape(faceVertex);
    }else{
      if(mode == "FV"){
        beginShape(TRIANGLES);
        for(int i = 0; i < faces.length; i++){
          for(int j = 0; j < 3; j++){
            Vertex this_vertex = faces[i].vertices[j]; 
            vertex(this_vertex.x, this_vertex.y, this_vertex.z); 
          }
        }
        endShape();
      }else{
      }
    }
    popStyle();
  }
}
