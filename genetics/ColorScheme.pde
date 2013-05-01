
class ColorScheme
{
  Animator anim;
  
  public ColorScheme()
  {
    anim = new Animator();
    anim.init(35, 220, 1);
  }
  
  public color getDark()
  {
    return color(anim.getNextFrame());
  }
  
  public color getLight()
  {
    return color(255 - anim.getNextFrame());
  }
  
  public color getNoteColor(float pitch)
  {
    return color(map(pitch, 0, 1, 0, 360), 200, 200);
  }
  
  public color getLaserColor()
  {
    return color(0, 190, 190);
  }
  
  public void startFlip(int frames)
  {
    if (red(getDark()) == 0)
      anim.init(0, 255, frames);
    else
      anim.init(255, 0, frames);
      
    anim.play();
  }
  
  public void update()
  {
    anim.update();
  }
}
