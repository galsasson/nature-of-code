
class Emitter
{
  PVector pos;
  PVector direction;
  
  int counter;
  
  float tSpeed, tMass;
  
  public Emitter(PVector pos, PVector direction)
  {
    this.pos = pos;
    this.direction = direction;
    
    tSpeed = 0;
    tMass = 10000;
    counter = 3;
  }
  
  public Particle emit()
  {
    if (counter-- == 0)
    {
      counter = 0;
      tSpeed += 0.1;
      tMass += 0.1;
    
      return new Particle(PVector.add(pos, direction), 
                          PVector.mult(direction, 0.2+noise(tSpeed)*0.1),
                          7*noise(tMass), color(10+random(50), 100, 80));
    }
    
    return null;
  }
  
  public void draw()
  {
    stroke(0, 0, 255, 200);
    strokeWeight(5);
    
    line(pos.x, pos.y, pos.x + direction.x, pos.y + direction.y);
  }
  
}
