

class SineArm
{
  final int ARM_LENGTH = 15;
  
  PVector pos;
  float speed;
  float rot;
  float t;
  
  public SineArm(PVector pos, float rot)
  {
    this.pos = pos;
    this.rot = rot;
    
    t = random(0,100);
    speed = 0.1;
  }
  
  public void setSpeed(float s)
  {
    speed = s;
  }
  
  public void update()
  {
    t-=speed;
  }
  
  public void draw()
  {
    pushMatrix();
    strokeWeight(1);
    translate(pos.x, pos.y);
    rotate(rot);
    
    for (int i=0; i<ARM_LENGTH; i++)
    {
      ellipse(i, cos(t+i*speed)*5*((float)i/ARM_LENGTH), 1, 1);
    }
    
    popMatrix();
  }
}
