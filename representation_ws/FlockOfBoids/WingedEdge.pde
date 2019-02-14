
class WE_Edge {
  int v1, v2;
  int aFace, bFace;
  WE_Edge aPrev, aNext, bPrev, bNext;
  WE_Edge(int v1, int v2, int aFace, int bFace, WE_Edge aPrev, WE_Edge aNext, WE_Edge bPrev, WE_Edge bNext){
    this.v1 = v1;
    this.v1 = v2;
    this.aFace = aFace;
    this.bFace = bFace;
    this.aPrev = aPrev;
    this.aNext = aNext;
    this.bPrev = bPrev;
    this.bNext = bNext;
  }
}

class WE_Vertex {
  float x, y, z;
  int incidentEdge;
  
  WE_Vertex(float x, float y, float z, int incidentEdge){
    this.x = x;
    this.y = y;
    this.z = z;
    this.incidentEdge = incidentEdge;
  }
}

class WE_Face {
  int incidentEdge;
  
  WE_Face(int incidentEdge){
    this.incidentEdge = incidentEdge;
  }
}
