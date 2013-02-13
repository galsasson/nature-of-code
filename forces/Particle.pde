
class Particle
{
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  
  PVector prevPos;
  
  color c;
  
  public Particle(PVector pos, PVector vel, float mass, color c)
  {
    acc = new PVector(0, 0);
    
    this.pos = pos;
    prevPos = pos.get();
    this.vel = vel;
    this.mass = mass;
    this.c = c;
  }
  
  public void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  public void update()
  {
    prevPos = pos.get();
    
    vel.add(acc);
    pos.add(vel);
    
    acc.mult(0);
  }
  
  public void checkEdges()
  {
    if (pos.x < 20)
          applyForce(new PVector(40/abs(pos.x), 0));
    
    if (pos.x > width-20)
          applyForce(new PVector(-40/abs(width-pos.x), 0));
        
    if (pos.y < 20)
          applyForce(new PVector(0, 40/abs(pos.y)));
    
    if (pos.y > height-20)
          applyForce(new PVector(0, -40/abs(height-pos.y)));
  }
  
  public void draw(PGraphics buf)
  {
    noStroke();
    fill(c, 255);
    
    ellipse(pos.x, pos.y, 1+mass, 1+mass);
    
    /* draw the path on the off-screen buffer */
    buf.line(prevPos.x, prevPos.y, pos.x, pos.y);
  }
  
  public boolean isAlive()
  {
    if (pos.y > height)
          return false;
    
    return true;
  }
}

