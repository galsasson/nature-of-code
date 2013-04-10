

class Genome
{
  public ArrayList<PVector> shape;
  public ArrayList<ArrayList<PVector>> distortion;
  
  public Genome()
  {
    shape = new ArrayList<PVector>();
    distortion = new ArrayList<ArrayList<PVector>>();
  }
  
  public void initRandom()
  {
    float distortionLevel = random(3, 7);
    float spikynessLevel = random(0);
    initShape(spikynessLevel);
    initDistortion(distortionLevel);
  }
  
  public Genome clone()
  {
    Genome g = new Genome();
    g.shape = new ArrayList<PVector>();
    
    for (PVector p : shape)
    {
      g.shape.add(p.get());
    }
    
    g.distortion = new ArrayList<ArrayList<PVector>>();
    for (ArrayList<PVector> arr : distortion)
    {
      ArrayList<PVector> vertexDistortion = new ArrayList<PVector>();
      
      for (PVector p : arr)
      {
        vertexDistortion.add(p.get());
      }
      
      g.distortion.add(vertexDistortion);
    }

    return g;
  }
  
  public Genome crossover(Genome c2)
  {
    Genome newGen = new Genome();
    
    /* crossover creature shape */
    int switchOn = int(random(shape.size()));
    for (int i=0; i<shape.size(); i++)
    {
      if (i<switchOn)
        newGen.shape.add(shape.get(i).get());
      else
        newGen.shape.add(c2.shape.get(i).get());
    }
    
    /* crossover distortion */
    for (int v=0; v<distortion.size(); v++)
    {
      ArrayList<PVector> vm1 = distortion.get(v);
      ArrayList<PVector> vm2 = c2.distortion.get(v);      
      ArrayList<PVector> newVertexMotion = new ArrayList<PVector>();
      
      switchOn = int(random(vm1.size()));
      for (int i=0; i<vm1.size(); i++)
      {
        if (i<switchOn)
          newVertexMotion.add(vm1.get(i).get());
        else
          newVertexMotion.add(vm2.get(i).get());
      }
      
      newGen.distortion.add(newVertexMotion);
    }
    
    return newGen;
  }
  
  public void mutate(float m)
  {
    for (int i=0; i<shape.size(); i++)
    {
      if (random(1) < m)
      {
        /* mutate */
        if (i%2==0)
          shape.get(i).x = random(SIZE);
        else
          shape.get(i).y = random(SIZE);
      }
    }
  }
  
  private void initShape(float spikynessLevel)
  {
    shape = new ArrayList<PVector>();

    float x = random(SIZE);
    float y = random(SIZE);
    shape.add(new PVector(x, y));

    for (int i=0; i<MAX_AGE; i++) {
      if (i%2 == 0) {
        x = random(SIZE);
        if (random(1) < spikynessLevel)
          y = random(SIZE);
      }
      else {
        y = random(SIZE);
        if (random(1) < spikynessLevel)
          x = random(SIZE);
      }
      shape.add(new PVector(x, y));
    }
  }

  private void initDistortion(float distortionLevel)
  {
    distortion = new ArrayList<ArrayList<PVector>>();
    float tTime = random(10000);
    float tX = random(10000);
    float tY = random(10000);

    for (int i=0; i<MAX_AGE; i++)
    {
      ArrayList<PVector> vertexDistortion = new ArrayList<PVector>();
      
      // for every vertex, calculate movement
      for (int t=0; t<27; t++)
      {
        vertexDistortion.add(new PVector(noise(tX)*distortionLevel, noise(tY)*distortionLevel));
        tX += 0.1;
        tY += 0.1;
      }
      
      /* make ease into the first */
      PVector diff = PVector.sub(vertexDistortion.get(0), vertexDistortion.get(26));
      diff.div(4);
      
      vertexDistortion.add(PVector.add(vertexDistortion.get(26), diff));
      vertexDistortion.add(PVector.add(vertexDistortion.get(27), diff));
      vertexDistortion.add(PVector.add(vertexDistortion.get(28), diff));
      
      distortion.add(vertexDistortion);
    }
  }
  
}
