int MAX_AGE = 30;
int SIZE = 30;

class Creature
{
  public PVector pos;
  public float age;
  public int fitness;
  
  Genome genome;

  public Creature(float x, float y)
  {
    pos = new PVector(x, y);
    age = 25;
    genome = new Genome();
  }
  
  public void initRandom()
  {
    genome.initRandom();
    
    calcFitness();
  }

  public void update(float timeSinceLastUpdate)
  {
    age += timeSinceLastUpdate;
  }

  public void draw()
  {
    stroke(50);
    fill(255);

    pushMatrix();
    translate(pos.x - SIZE/2, pos.y - SIZE/2);

    beginShape();
    for (int i=0; i<(int)age; i++)
    {
//      vertex(genome.shape.get(i).x + genome.distortion.get(i).get(frameCount%30).x, 
//                genome.shape.get(i).y + genome.distortion.get(i).get(frameCount%30).y);
      vertex(genome.shape.get(i).x, genome.shape.get(i).y);
    }

    vertex(genome.shape.get(0).x, genome.shape.get(0).y);
    
//    vertex(genome.shape.get(0).x + genome.distortion.get(0).get(frameCount%30).x,
//                genome.shape.get(0).y + genome.distortion.get(0).get(frameCount%30).y);
    endShape();
    
    fill(0);
    text(fitness, -5, 45);

    popMatrix();
  }

  public void calcFitness()
  {
    /* draw the shape on a pgraphics */
    PGraphics buf = createGraphics(30, 30, JAVA2D);
    
    buf.beginDraw();
    buf.stroke(0);
    buf.background(255);
    buf.noFill();
    buf.strokeWeight(1);
    buf.beginShape();
    for (int i=0; i<age; i++)
    {
      buf.vertex(genome.shape.get(i).x, genome.shape.get(i).y);
    }
    buf.vertex(genome.shape.get(0).x, genome.shape.get(0).y);
    buf.endShape();
    buf.endDraw();
    
    // check for vertical symetry
    int verDiff = 0;    
    for (int y=0; y<SIZE/2; y++)
    {
      for (int x=0; x<SIZE; x++)
      {
        int c1 = buf.get(x, y);
        int c2 = buf.get(x, SIZE-y);
        verDiff += sqrt(pow(red(c1) - red(c2), 2) + pow(green(c1) - green(c2),2) + pow(blue(c1) - blue(c2), 2));
      }
    }
    
    // check for horizontal symetry
    int horDiff = 0;    
    for (int y=0; y<SIZE; y++)
    {
      for (int x=0; x<SIZE/2; x++)
      {
        int c1 = buf.get(x, y);
        int c2 = buf.get(SIZE-x, y);
        horDiff += sqrt(pow(red(c1) - red(c2), 2) + pow(green(c1) - green(c2),2) + pow(blue(c1) - blue(c2), 2));
      }
    }

    fitness = horDiff + verDiff;
  }
  
  public int getFitness()
  {
    return fitness;
  }

  public boolean isAlive()
  {
    if (age > MAX_AGE)
      return false;

    return true;
  }
  
  public Creature mate(Creature c)
  {
    Creature newC = new Creature(pos.x, pos.y);
    newC.genome = genome.crossover(c.genome);
    newC.genome.mutate(0);
    newC.calcFitness();
    return newC;
  }

  public Creature clone()
  {
    Creature c = new Creature(pos.x, pos.y);
    c.age = age;
    
    c.genome = genome.clone();
    c.calcFitness();
    
    return c;
  }
}

