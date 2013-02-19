
class SineFish
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float rot;
  
  float size;
  
  float t;
  
  ArrayList<SineArm> arms;
  
  public SineFish(PVector pos)
  {
    this.pos = pos;
    
    size = 8;
    
    rot = 0.1;
    
    arms = new ArrayList<SineArm>();
    
    for (float i=0; i<PI*2-0.01; i+=PI/4)
    {
      arms.add(new SineArm(new PVector(cos(i)*size, sin(i)*size), i));
    }
  }
  
  public void update()
  {
    rot += 0.02;
    
    for (int i=0; i<arms.size(); i++)
          arms.get(i).update();
    
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    
    fill(255, 255, 255, 0);
    strokeWeight(2);
    stroke(255);
    ellipse(0, 0, size*2, size*2);
    
    for (int i=0; i<arms.size(); i++)
          arms.get(i).draw();
    
    popMatrix();

  }
}
