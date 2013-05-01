
class NoteSymbol
{
  PVector pos;
  PVector speed;
  color col;
  
  float alpha;
  
  public NoteSymbol(float x, float y, float a, color c)
  {
    pos = new PVector(x, y);
    speed = new PVector(-7, 0);
    alpha = a;
    col = c;
  }
  
  public boolean update()
  {
    pos.add(speed);
    
    speed.mult(0.98);
    alpha-=3.5;
    
    if (alpha<0)
      return false;
      
    return true;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noStroke();
    fill(col, alpha);
    ellipse(0, 0, 10, 10);
    
    popMatrix();
  }
  
}
