
class Camera
{
  PVector pos;
  PVector look;
  
  public Camera(float x, float y, float z, float lx, float ly, float lz)
  {
    pos = new PVector(x, y, z);
    look = new PVector(lx, ly, lz);
  }
  
  public void draw()
  {
    //camera(pos.x, pos.y, pos.z, look.x, look.y, look.z, 0, 0, -1);
    translate(pos.x, pos.y, pos.z);
    rotateX(look.x);
    rotateY(look.y);
    rotateZ(look.z);
  }
}
