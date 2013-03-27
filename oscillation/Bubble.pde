
class Bubble
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float size;
  
  float t;
  
  public Bubble(PVector pos, PVector vel, float size)
  {
    this.pos = pos;
    this.vel = vel;
    this.size = size;
    
    // simulate drag for x axis
    vel.x *= 0.8;
    
    this.acc = new PVector(0, 0);
    t = 0;
  }
  
  public void update()
  {
    pos.add(vel);
    vel.add(acc);
    
    t+=0.5;
    
    acc.mult(0);
  }
  
  public void applyForce(PVector force)
  {
    PVector f = PVector.mult(force, size);
    acc.add(f);
  }
  
  public boolean isAlive()
  {
    if (pos.y < -1000)
          return false;
          
    return true;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    fill(0, 0, 100, 60);
    stroke(0, 0, 100, 80);
    strokeWeight(1);
    
    ellipse(0+sin(t)*2, 0, size, size);
    
    popMatrix();
  }
}
