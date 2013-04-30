
class NoteSymbol
{
  PVector pos;
  PVector speed;
  
  float alpha;
  
  public NoteSymbol(float x, float y, float a)
  {
    pos = new PVector(x, y);
    speed = new PVector(-7, 0);
    
    alpha = a;
  }
  
  public boolean update()
  {
    pos.add(speed);
    
    speed.mult(0.95);
    alpha-=5;
    
    if (alpha<0)
      return false;
      
    return true;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noStroke();
    fill(colorScheme.getDark(), alpha);
    ellipse(0, 0, 10, 10);
    
    popMatrix();
  }
  
}
