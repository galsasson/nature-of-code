class Player
{
  PVector pos;
  
  Creature creature;
  float angle;
  
  int channel;
  int octave;
  
  int playOn;
  int playCounter;
  
  float lastLaserLength;
  
  float[] frequencies = {130.81, 138.59, 164.81, 174.61, 196, 207.65, 246.94, 261.63, 277.18, 329.63, 349.23, 392, 415.30, 493.88, 523.25}; 
  int[] orientalScale = {0, 1, 4, 5, 6, 9, 10};
  
  int[] pitches = {36, 38, 41, 43, 46, 48, 50, 53, 55, 58, 60};                    // 6 notes sounds good
//  int[] pitches = {36, 37, 40, 41, 42, 45, 46, 48, 49, 52, 53, 54, 57, 58, 60};    // oriental pitches
//  int[] pitches = {36, 38, 40, 41, 43, 45, 47, 48, 50, 52, 53, 55, 57, 59, 60};    // C Major
//  int[] pitches = {36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48};              // chromatic

  
  Note note;
  NoteRing ring;
  
  float progressFactor;
  int beatsPerNote;
  int holdTime;

    
  public Player(PVector p, String name, int oct)
  {
    pos = p;
    octave = oct;

    initPlayer(name);    
    
    angle = 0;
    creature = null;
    
    ring = null;
    
    playCounter = 0;
    playOn = 0;
  }
  
  private void initPlayer(String name)
  {
    if (name == "Guitar-Balladeer")
    {
      channel = 0;
      progressFactor = PI*2/(24*4*4);
      beatsPerNote=12;
      holdTime = 300;
    }
    if (name == "Guitar-Reg")
    {
      channel = 1;
      progressFactor = PI*2/(24*4);
      beatsPerNote=6;
      holdTime = 300;
    }
    if (name == "Pad-Fat")
    {
      channel = 2;
      progressFactor = PI*2/(24*4*8);
      beatsPerNote=192;
      holdTime=2500;
    }  
  }

  
  public void beat()
  {
    angle += progressFactor;
    
    if (creature != null)
      creature.rotation = angle-PI/2;
    
    /* calculate the intersection between the laser and the shape */
    if (creature!=null)
    {
      try
      {
        lastLaserLength = getLaserIntersection();
      
        if (playCounter % beatsPerNote == playOn) {
        
          if (lastLaserLength != 1)
          {
            int noteVal = pitches[(int)map(lastLaserLength, 0, 1, 0, pitches.length-1)]+12;
            note = new Note(noteVal + octave*12, creature.genome.getVolume(angle), channel, holdTime);
            note.play();
            ring = new NoteRing(new PVector(0, 95), 40-lastLaserLength*20, 5);
          }
        }
      }
      catch (Exception e) {}
    }
    
    playCounter++;
  }
  
  public void setBeat()
  {
    playCounter = 0;
    angle = 0;
  }
  
  /* calculate the intersection between the laser and the shape, return result between 0-1 */
  private float getLaserIntersection()
  {
    float maxInter = 0;
    
    ArrayList<Float> yInters = new ArrayList<Float>();
    
    if (creature != null)
    {  
      yInters.clear();
//      PVector p1 = creature.genome.shape.get(creature.genome.shape.size()-1).get();
      PVector p1 = creature.getPointPos(creature.genome.shape.size()-1);
      p1.rotate(angle);
      for (int i=0; i<creature.genome.shape.size(); i++)
      {
//        PVector p2 = creature.genome.shape.get(i).get();
        PVector p2 = creature.getPointPos(i);
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
    
    noFill();
    stroke(0);
    strokeWeight(1);
    
    line(-30, 40, -36, 0);
    line(30, 40, 36, 0);
    
    
    rect(-30, 40, 60, 80, 5);
    ellipse(0, 55, 20, 20);
    ellipse(0, 95, 40, 40);
    
    strokeWeight(1);
    ellipse(0, 95, 40-lastLaserLength*20, 40-lastLaserLength*20);
    
    if (creature != null/* && playCounter % 12 == playOn*/)
    {
      stroke(255, 0, 0);
      strokeWeight(1);
      line(0, 40, 0, map(lastLaserLength, 0, 1, 5, 35.5));
      
      /* handle speaker rings */
      if (ring != null)
      {
        if (!ring.update())
          ring = null;
        else
          ring.draw();
      }
    }
    
    popMatrix();
  }
  
  public void draw2()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    strokeWeight(2);
    stroke(0);
    arc(-50, 0, 180, 180, -PI/7, PI/7, OPEN);
    line(40, 0, 80, 0);
    
    stroke(255, 0, 0);
    strokeWeight(2);
    
    float end = map(lastLaserLength, 0, 1, 5, 35.5);
    line(40, 0, end, 0);
    stroke(255, 0, 0, 100);
    ellipse(end, 0, 5, 5);    
    
    popMatrix();
  }
  
  public void setCreature(Creature c)
  {
    creature = c;
    creature.set(pos.x, pos.y);
  }
  
  public Creature getCreature()
  {
    return creature; 
  }
  
  public void empty()
  {
    if (note != null) {
      note.stopNote();
      note = null;
    }
    ring = null;
    lastLaserLength = 0;
    creature = null;
  }
  
  public boolean pick(PVector p)
  {
    if (PVector.dist(pos,p) < 50)
      return true;
      
    return false;
  }
}
