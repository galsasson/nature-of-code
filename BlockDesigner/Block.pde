
class Block
{
  PVector pos;
  PVector angle;
  
  public Block(float x, float y, float z)
  {
    pos = new PVector(x, y, z);
    angle = new PVector();
  } 
  
  public void update()
  {
    //angle.z+=0.02;
  }
  
  public void draw()
  {
    pushMatrix();
    
    translate(pos.x, pos.y, pos.z);
    rotateZ(angle.z);
    
    box(20, 20, 20);
    
    popMatrix();
  }
}
