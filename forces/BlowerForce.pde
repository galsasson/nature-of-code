
class BlowerForce
{
  PVector pos;
  PVector direction;
  
  float strength;
  
  public BlowerForce(PVector pos, PVector force)
  {
    this.pos = pos;
    strength = force.mag();
    force.normalize();
    direction = force;
  }
  
  public PVector getForce(PVector ppos)
  {
    float distanceFromCenter = PVector.sub(ppos, pos).mag();
    
    if (distanceFromCenter < strength) 
        return PVector.div(PVector.mult(direction, strength*4),distanceFromCenter);
    else
        return new PVector(0, 0);
  }
  
  public void draw()
  {
    fill(198, 59, 72, 120);    
    noStroke();
    ellipse(pos.x, pos.y, strength*2, strength*2); 
    
    strokeWeight(2);
    stroke(198, 59, 72, 255);
    line(pos.x, pos.y, pos.x + strength*direction.x, pos.y + strength*direction.y);
  }
}
