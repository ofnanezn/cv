import java.util.Random;
import java.lang.Math.*;

float edgeFunction(Vector a, Vector b, Vector c) { 
    return ((c.x() - a.x()) * (b.y() - a.y()) - (c.y() - a.y()) * (b.x() - a.x())); 
} 

float[] computeSimple(Vector p, float delta, boolean master){
  boolean inside = true;
  float[] lambda = new float[4];
  float[] edge = new float[3];
  float area = edgeFunction(v[0], v[1], v[2]);
  //if( p.x()  && p.y() )
  if( !orientation( v[0], v[1], v[2] ) ){
    for(int i = 2; i >= 0; i--){
      edge[i] = edgeFunction(v[(i+1)%3], v[i], p);
      inside &= edge[i] >= 0;
    }
    
  }else{
    for(int i = 0; i < 3; i++){
      edge[i] = edgeFunction(v[i], v[(i+1)%3], p);
      inside &= edge[i] >= 0;
    }
  }
  if( !inside ) return null;
  lambda[0] = abs(edge[1]/area);
  lambda[1] = abs(edge[2]/area);
  lambda[2] = abs(edge[0]/area);
  lambda[3] = 1;
  return lambda;
}

float[] compute(Vector p, float delta, boolean master){
  boolean inside = false;
  float[] lambda = new float[4];
  float[] edge = new float[3];
  float area = edgeFunction(v[0], v[1], v[2]);
  if( !orientation( v[0], v[1], v[2] ) ){
    for(int i = 2; i >= 0; i--){
      edge[i] = edgeFunction(v[(i+1)%3], v[i], p);
    }
    for(int x = round(p.x() - delta); x <= p.x() + delta; x+= delta){
      for(int y = round(p.y() - delta); y <= p.y() + delta; y+= delta){
        boolean cornerInside = true;
        for(int i = 2; i >= 0; i--){
          cornerInside &= edgeFunction(v[(i+1)%3], v[i], new Vector(x,y)) >= 0;
        }
        inside = inside || cornerInside;
      }
    }
    
  }else{
    for(int i = 0; i < 3; i++){
      edge[i] = edgeFunction(v[i], v[(i+1)%3], p);
    }
    for(int x = round(p.x() - delta); x <= p.x() + delta; x+= delta){
      for(int y = round(p.y() - delta); y <= p.y() + delta; y+= delta){
        boolean cornerInside = true;
        for(int i = 0; i < 3; i++){
          cornerInside &= edgeFunction(v[i], v[(i+1)%3], new Vector(x,y)) >= 0;
        }
        inside = inside || cornerInside;
      }
    }
  }
  if( !inside ) return null;
  lambda[0] = abs(edge[1]/area);
  lambda[1] = abs(edge[2]/area);
  lambda[2] = abs(edge[0]/area);
  lambda[3] = 1;
  return lambda;
}

boolean orientation(Vector v0, Vector v1, Vector v2){
  Vector a = new Vector( v2.x() - v0.x(), v2.y() - v0.y() );
  Vector b = new Vector( v1.x() - v0.x(), v1.y() - v0.y() );
  return a.x() * b.y() - a.y() * b.x() > 0;
}
