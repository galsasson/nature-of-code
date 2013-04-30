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
  ArrayList<NoteSymbol> symbols;
  NoteSymbol symbolToAdd;
  
  float progressFactor;
  int beatsPerNote;
  int holdTime;
  int constantVolume;
  
  String displayStr;

    
  public Player(PVector p, String name, int oct)
  {
    pos = p;
    octave = oct;

    symbols = new ArrayList<NoteSymbol>();
    constantVolume = 0;
    angle = 0;
    creature = null;
    playCounter = 0;
    playOn = 0;
    symbolToAdd = null;
    
    initPlayer(name);
  }
  
  private void initPlayer(String name)
  {
    if (name == "Guitar-Balladeer")
    {
      channel = 0;
      progressFactor = PI*2/(24*4*4);
      beatsPerNote=12;
      holdTime = 300;
      displayStr = "Ponk";
    }
    else if (name == "Guitar-Reg")
    {
      channel = 1;
      progressFactor = PI*2/(24*4);
      beatsPerNote=6;
      holdTime = 300;
      displayStr = "Wee";
    }
    else if (name == "Guitar-Reg-Fast")
    {
      channel = 1;
      progressFactor = PI*2/24*6;
      beatsPerNote=6;
      holdTime = 300;
      constantVolume = 90;
      displayStr = "Weeee";
    }
    else if (name == "Pad-Fat")
    {
      channel = 2;
      progressFactor = PI*2/(24*4*8);
      beatsPerNote=192;
      holdTime=2600;
      constantVolume = 100;
      displayStr = "Wow";
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
        
          if (lastLaserLength < 0.99)
          {
            int vol;
            if (constantVolume == 0)
              vol = creature.genome.getVolume(angle);
            else
              vol = constantVolume;
              
            int noteVal = pitches[(int)map(lastLaserLength, 0, 1, 0, pitches.length-1)]+12;
            note = new Note(noteVal + octave*12, vol, channel, holdTime);
            note.play();
            if (vol > 40)
              symbolToAdd = new NoteSymbol(-15, lastLaserLength*-40+20, vol*2);
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
      
      println("maxInter = " + maxInter);
      
      maxInter = constrain(maxInter, 5, 35.5);
      return map(maxInter, 5, 35.5, 0, 1);
    }
    return -1;
  }
  
  public void update()
  {
    if (symbolToAdd != null) {
      symbols.add(symbolToAdd);
      symbolToAdd = null;
    }
    
    ArrayList<NoteSymbol> toRemove = new ArrayList<NoteSymbol>();
    
    for (NoteSymbol sym : symbols)
    {
      if (!sym.update())
        toRemove.add(sym);
    }
    
    for (NoteSymbol sym : toRemove)
      symbols.remove(sym);
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noFill();
    strokeWeight(2);
    stroke(colorScheme.getDark());
    arc(-50, 0, 180, 180, -PI/7, PI/7, OPEN);
    line(40, 0, width-pos.x-20, 0);
    
    stroke(190, 0, 0);
    fill(190, 0, 0);
    strokeWeight(1);
    
    float end = map(lastLaserLength, 0, 1, 5, 35.5);
    line(40, 0, end, 0);
    stroke(190, 0, 0, 100);
    ellipse(end, 0, 2, 2);
    
    /* draw sparks */
    stroke(190, 0, 0, 50);
    pushMatrix();
    translate(end, 0);
    for (int i=0; i<10; i++)
    {
      rotate(random(PI*2));
      line(0, 0, 3, 0);
    }
    popMatrix();
    
    

    fill(colorScheme.getDark());
    textFont(font, 16);
    text(displayStr, 42, -2);    
    
    for (NoteSymbol sym : symbols)
    {
      sym.draw();
    }
    
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
