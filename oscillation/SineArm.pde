

class SineArm
{
  final int ARM_LENGTH = 15;
  
  PVector pos;
  float speed;
  float rot;
  float t;
  
  float length;
  
  public SineArm(float rot)
  {
    this.pos = new PVector();
    this.rot = rot;
    
    t = random(0,100);
    speed = 0.08;
    length = ARM_LENGTH + random(4) - 2;
  }
  
  public void setSpeed(float s)
  {
    speed = s;
  }
  
  public void update(float size)
  {
    pos.x = cos(rot)*size;
    pos.y = sin(rot)*size;
    
    t-=speed;
  }
  
  public void draw()
  {
    pushMatrix();
    noStroke();
    fill(255, 255, 255, 100);
    translate(pos.x, pos.y);
    rotate(rot);
    
    for (int i=0; i<length; i++)
    {
      ellipse(i, cos(t+i*speed)*8*((float)i/length), 2, 2);
    }
    
    popMatrix();
  }
}
