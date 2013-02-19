
class SineFish
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float rot;
  
  float initialSize;
  float size;
  
  float t;
  
  ArrayList<SineArm> arms;
  
  public SineFish(PVector pos, float initSize, int numOfLegs)
  {
    this.pos = pos;
    
    initialSize = initSize;
    size = initialSize;
    
    rot = 0.1;
    
    arms = new ArrayList<SineArm>();
    
    for (float i=0; i<PI*2-0.01; i+=(PI*2)/numOfLegs)
    {
      arms.add(new SineArm(i));
    }
    
    t=0;
  }
  
  public void update()
  {
    t+=0.01;
    size = initialSize+noise(t)*3;
    
    for (int i=0; i<arms.size(); i++)
          arms.get(i).update(size);
    
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    
    fill(255, 255, 255, 80);
    ellipse(0, 0, size*2, size*2);
    
    for (int i=0; i<arms.size(); i++)
          arms.get(i).draw();
    
    popMatrix();

  }
}
