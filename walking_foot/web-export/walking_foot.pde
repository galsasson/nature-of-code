
Foot foot;

void setup()
{
  size(600, 400);
  smooth();
  
  foot = new Foot();
}

void draw()
{
  foot.draw();
}




class Foot
{
  PVector pos;
  float angle;
  
  public Foot(PVector pos)
  {
     this.pos = pos;
     angle = 0;
  }
  
  public void draw()
  {
    pushMatrix();
    rotate(angle);
    translate(pos.x, pos.y);
    
    stroke(255);
    fill(150);
    rect(-60, -20, 20, 40);
    popMatrix();
  }
}

