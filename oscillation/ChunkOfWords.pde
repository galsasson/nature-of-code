

class ChunkOfWords
{
  PVector pos;  
  String str;
  int life;
  
  public ChunkOfWords(PVector p, String s, int l)
  {
    pos = p;
    str = s;
    life = l;
  }
  
  public void display()
  {
    if (life==0)
      return;
    
    if (life > 0) life--;
    
    fill(0, 0, 100, 50);
    
    pushMatrix();
    translate(pos.x, pos.y);
    text(str, 0, 0);
    popMatrix();
  }
}


