
class Deformation
{
  ArrayList<PVector> frames;
  PVector dir;
  
  public Deformation(PVector direction)
  {
    frames = new ArrayList<PVector>();
    dir = direction.get();
    dir.rotate(PI/2);
    
    
    
    int[] sequence2 = {0, 1, 0, 1, 0, -1, 0, -1, 0, -1, 0, 1, 0, 1, 0, 1, 0};
    
    addSquareWave(70, sequence2);
    addRandom(70, 4);
  }
  
  public void addRandom(int numFrames, float h)
  {
    for (int i=0; i<numFrames; i++)
    {
      frames.add(PVector.mult(new PVector(random(h) - h/2, random(h) - h/2), dir));
    }
  }
  
  public void addNoise(int numFrames, float strength, float period)
  {
    float t=random(100000);
    for (int i=0; i<numFrames; i++)
    {
      frames.add(PVector.mult(new PVector((noise(t)-0.5)*strength, (noise(t)-0.5)*strength), dir));
      t+=period;      
    }
  }
  
  public void addSilence(int numFrames)
  {
    for (int i=0; i<numFrames; i++)
    {
      frames.add(new PVector(0, 0));
    }
  }
  
  public void addSine(int numFrames)
  {
    float t=0;
    for (int i=0; i<numFrames; i++)
    {
      frames.add(PVector.mult(new PVector(sin(t)*100, sin(t)*100), dir));
      t += PI/10;
    }
  }
  
  public void addSquareWave(int numFrames, int[] sequence)
  {
    int sequencePeriod = numFrames / sequence.length;
    for (int bit=0; bit<sequence.length; bit++)
    {
      for (int i=0; i<sequencePeriod; i++)
      {
        frames.add(PVector.mult(new PVector(-sequence[bit]*10, -sequence[bit]*10), dir));
      }
    }
  }
  
  public PVector getFrame(int index)
  {
    return frames.get(index);
  }
  
  public int size()
  {
    return frames.size();
  }
}
