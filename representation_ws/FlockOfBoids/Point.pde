class Point{
  
  float x,y,z;
  
  public Point(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Point add( Point p ){
    return new Point(x+p.x, y+p.y, z+p.z);
  }
  
  public Point dot( float m ){
    return new Point(x*m , y*m, z*m);
  }  
  
}
