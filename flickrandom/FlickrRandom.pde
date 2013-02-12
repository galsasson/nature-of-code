/**********************/
/* FlickrRandom class */
/**********************/

class FlickrRandom
{
  FlickrSearch search;
  PImage image;
  
  public FlickrRandom(String str)
  {
    search = new FlickrSearch(str);
    search.execute();
    image = search.getImage((int)random(0, 100));
  }
  
  public float noise(float pos)
  {
    int prevPix = (int)pos;
    prevPix = prevPix%(image.width*image.height);
    
    float distance = pos - prevPix;
    float brightness;
    
    if (distance > 0)
    {
      int nextPix = (int)(pos+1);
      nextPix = nextPix%(image.width*image.height);
      
      float prevB = 
          sqrt(pow(red(image.pixels[prevPix]), 2) +
                pow(green(image.pixels[prevPix]), 2) +
                pow(blue(image.pixels[prevPix]), 2)) / 442;
      float nextB = 
          sqrt(pow(red(image.pixels[nextPix]), 2) +
                pow(green(image.pixels[nextPix]), 2) +
                pow(blue(image.pixels[nextPix]), 2)) / 442;
  
      return prevB + (nextB-prevB)*distance;
    }
    else
    {
       brightness = 
          sqrt(pow(red(image.pixels[prevPix]), 2) +
                pow(green(image.pixels[prevPix]), 2) +
                pow(blue(image.pixels[prevPix]), 2)) / 442;
                
       return brightness;
    }
  }
  
  public PImage getSourceImage()
  {
    return image;
  }
}
