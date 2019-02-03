
class Vertex {
  float x, y, z;
  
  Vertex(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class Face {
  Vertex[] vertices;
  
  Face(Vertex[] vertices){
    this.vertices = vertices;
  }
}
