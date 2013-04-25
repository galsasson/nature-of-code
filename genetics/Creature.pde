int MAX_AGE = 16;
float SIZE = 50;

class Creature
{
  public PVector pos;
  public float age;
  float angle;
  public int fitness;
  
  Genome genome;
  ShapeMorpher morpher;
  Animator anim;
  
  int beatTime = 30;
  float t=0;
  
  public Creature(float x, float y, ShapeMorpher m)
  {
    pos = new PVector(x, y);
    morpher = m;
    age = MAX_AGE;
    angle = 0;
    
    genome = new Genome();
    anim = new Animator();
  }
  
  public void initRandom()
  {
    genome.initRandom();
  }

  public void update()
  {
    anim.update();
  }

  public void draw()
  {
    strokeWeight(1);
    stroke(50);
    fill(0);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    
    
    beginShape();
    for (int i=0; i<(int)age; i++)
    {
      PVector shapePoint = morpher.getPoint(i, 0, anim.getNextFrame(), genome.shape);
      PVector p = PVector.add(shapePoint, genome.distortion.get(i).get(frameCount%30));
      vertex(p.x, p.y);
    }

    PVector shapePoint = morpher.getPoint(0, 0, anim.getNextFrame(), genome.shape);
    vertex(shapePoint.x + genome.distortion.get(0).get(frameCount%30).x,
                shapePoint.y + genome.distortion.get(0).get(frameCount%30).y);
    noFill();
    endShape();

    popMatrix();
  }
  
  public boolean pick(PVector p)
  {
    if (PVector.dist(p, pos) < SIZE-10) {
      return true;
    }
    
    return false;
  }
  
  public void animateToCircle()
  {
    anim.init(0, 1, 7);
    anim.play();
  }
  
  public void animateToOrig()
  {
    anim.init(1, 0, 3);
    anim.play();
  }
  
  public Creature mate(Creature c)
  {
    Creature newC = new Creature(pos.x, pos.y, morpher);
    newC.genome = genome.crossover(c.genome);
    newC.genome.mutate(0.1);

    return newC;
  }
  
  public void setPosition(PVector p)
  {
    pos = p;
  }

  public Creature clone()
  {
    Creature c = new Creature(pos.x, pos.y, morpher);
    c.age = age;
    
    c.genome = genome.clone();
    
    return c;
  }
}

