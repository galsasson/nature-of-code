class Player
{
  PVector pos;
  
  Creature creature;
  float angle;
  
  int playOn;
  
  float lastLaserLength;
  
  float[] frequencies = {130.81, 138.59, 164.81, 174.61, 196, 207.65, 246.94, 261.63, 277.18, 329.63, 349.23, 392, 415.30, 493.88, 523.25}; 
    
  public Player(PVector p, AudioOutput out)
  {
    pos = p;
    angle = 0;
    creature = null;
    
    playOn = (int)random(10);
  }
  
  public void update()
  {
    angle+=0.02;
    if (creature != null)
      creature.angle = angle;
    
    /* calculate the intersection between the laser and the shape */
    if (creature!=null)
    {
      lastLaserLength = getLaserIntersection();

      int noteVal = (int)map(lastLaserLength, 0, 1, 40, 90);
      Note n = new Note(noteVal, 127, 0, 500);
      //if (frameCount % 10 == playOn)
      if (random(1) > 0.95)
        n.play();
    }
  

//      wave.setFreq(frequencies[(int)map(maxInter, 5, 35.5, 0, 15)]);
//      wave.setAmp(0.2);
      
/*
      if (frameCount % 4 == playOn)
        wave.setAmp(0.3);
      else
        wave.setAmp(0.1);
*/
  }
  
  /* calculate the intersection between the laser and the shape, return result between 0-1 */
  private float getLaserIntersection()
  {
    float maxInter = 0;
    
    ArrayList<Float> yInters = new ArrayList<Float>();
    
    if (creature != null)
    {  
      yInters.clear();
      PVector p1 = creature.genome.shape.get(creature.genome.shape.size()-1).get();
      p1.rotate(angle);
      for (int i=0; i<creature.genome.shape.size(); i++)
      {
        PVector p2 = creature.genome.shape.get(i).get();
        p2.rotate(angle);
        if (p1.x * p2.x < 0)
        {
          float intersection = (p2.y - p1.y) / (p2.x - p1.x) * -p1.x + p1.y;
          yInters.add(new Float(intersection));
          if (intersection > maxInter)
          {
            maxInter = intersection;
          }
        }
        
        p1 = p2;
      }
      
      maxInter = constrain(maxInter, 5, 35.5);
      return map(maxInter, 5, 35.5, 0, 1);
    }
    return -1;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noStroke();
    fill(0);
    
    rect(-30, 0, 2, 60);
    rect(30, 0, 2, 60);
    rect(-30, 60, 62, 2);

    if (creature != null)
    {
      stroke(255, 0, 0);
      strokeWeight(2);
      line(0, 60, 0, lastLaserLength);
    }

    /*
    // draw all intersections
    noStroke();
    fill(0, 0, 255);
    for (Float f : yInters)
    {
      ellipse(0, f, 5, 5); 
    }
    */
    
    popMatrix();
  }
  
  public void setCreature(Creature c)
  {
    creature = c;
    creature.pos = pos.get();
//    wave.setAmp(0.2);
  }
  
  public Creature getCreature()
  {
    return creature; 
  }
  
  public void empty()
  {
//    wave.setAmp(0);
    creature = null;
  }
  
  public boolean pick(PVector p)
  {
    if (PVector.dist(pos,p) < 50)
      return true;
      
    return false;
  }
}
