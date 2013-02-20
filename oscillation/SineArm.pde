

class SineArm
{
  final int ARM_LENGTH = 15;
  final float WAVE_DENSITY = 0.15;
  
  PVector pos;
  float speed;
  float rot;
  float t;
  
  float length;
  float armWidth;
  
  color tipColor;
  
  public SineArm(float rot, color tipColor)
  {
    this.pos = new PVector();
    this.rot = rot;
    this.tipColor = tipColor;
    
    t = random(0,100);
    speed = 0.02;
    length = ARM_LENGTH + random(4) - 2;
    armWidth=2;
  }
  
  public void setSpeed(float s)
  {
    speed = s;
  }
  
  public void update(float size)
  {
    pos.x = cos(rot)*(size);
    pos.y = sin(rot)*(size);
    armWidth = size/4;
    
    t-=speed;
  }
  
  public void draw()
  {
    pushMatrix();
    stroke(0, 0, 100, 20);
    strokeWeight(armWidth);
    translate(pos.x, pos.y);
    rotate(rot);
    
    for (int i=0; i<length; i++)
    {
      line(i, cos(t+i*WAVE_DENSITY)*8*((float)i/length), i+1, cos(t+(i+1)*WAVE_DENSITY)*8*((float)(i+1)/length));
    }
    
    noStroke();
    fill(tipColor);
    ellipse(length+1, cos(t+(length+1)*WAVE_DENSITY)*8*((float)(length+1)/length), 3, 3);
    
    popMatrix();
  }
}
