/**********************/
/* Walker class       */
/**********************/

class Walker
{
  FlickrRandom random;
  float tX;
  PVector pos;
  
  public Walker(String str, float y)
  {
    random = new FlickrRandom(str);

    tX = 0;
    pos = new PVector(width/2, y);
  }
  
  public void tick()
  {
    pos.x = random.noise(tX)*width;
    
    tX+=0.2;
  }
  
  public void draw()
  {
    stroke(255);
    fill(255, 255, 255, 100);
    
    ellipse(pos.x, pos.y, 30, 30);
    
    /* debug where the data is coming from */
    /*
    stroke(255, 0, 0);
    fill(255, 0, 0, 50);
    PVector samplePoint = new PVector(tX%random.getSourceImage().width,
                                      tX/random.getSourceImage().width);
    ellipse(samplePoint.x, samplePoint.y, 5, 5);
    point(samplePoint.x, samplePoint.y);
    */
  }
  
  public PImage getRandomSourceImage()
  {
    return random.getSourceImage();
  }
}


