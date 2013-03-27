

class Foot
{
  PVector bone;
  
  PVector pos;
  PVector vel;
  PVector acc;
  
  float feetAngle;
  
  float t;
  
  public Foot(PVector pos, PVector bone)
  {
     this.pos = pos;
     this.bone = bone;
     
     feetAngle = 0;
     
     t=0;
  }
  
  public void update()
  {
    feetAngle = sin(t);
    t+=0.1;
  }
  
  public void bounceGround()
  {
    
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(feetAngle);
    
    stroke(255);
    fill(150);
    line(0, 0, bone.x, bone.y);
    popMatrix();
  }
}
