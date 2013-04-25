
class Animator
{
  boolean playing;
  
  float start;
  float offset;
  float end;
  
  float inc;
  float x;
  
  int frames;
  
  public Animator()
  {
    init(0, 0, 1);
  }
  
  public Animator(float s, float e, int c)
  {
    init(s, e, c);
  }
  
  public void init(float s, float e, int f)
  {
    playing = false;
    
    start = s;
    end = e;
    frames = f;
    
    x = 0;
    offset = 0;
    inc = (float)1/frames;
  }
  
  public void play()
  {
    playing = true;
  }
  
  public void stop()
  {
    playing = false;
  }
  
  public float getNextFrame()
  {
    return start+offset;
  }
  
  public void update()
  {
    if (!playing)
      return;
      
    frames--;
    
    x += inc;
    
    // linear interpolation
    offset = (end-start)*x;

    if (frames==0)
      playing = false;
  }
}
