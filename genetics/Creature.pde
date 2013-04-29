int MAX_AGE = 16;
float SIZE = 50;

class Creature extends VerletParticle2D
{
//  public PVector pos;
  public float age;
  float rotation;
  public int fitness;
  
  Genome genome;
  ShapeMorpher morpher;
  Animator anim;
  
  int beatTime = 30;
  float t=0;
  
  boolean isRawType;
  int rawIndex;
  
  public Creature(float x, float y, ShapeMorpher m)
  {
    super(x, y);
    morpher = m;
    age = MAX_AGE;
    rotation = 0;
    isRawType = false;
    
    genome = new Genome();
    anim = new Animator();
  }
  
  public void initRandom()
  {
    genome.initRandom();
  }
  
  public void setToRaw()
  {
    isRawType = true;
    anim.init(0, 1, 20);
    anim.play();
  }
  
  public void setToCreature()
  {
    genome.initRandom();
    anim.init(1, 0, 10);
    anim.play();
    isRawType = false;
  }

  public void updateAnimation()
  {
    anim.update();
  }

  public void draw()
  {
    pushMatrix();
    translate(x, y);  
    g.rotate(rotation);
    
    noFill();
    stroke(colorScheme.getDark());
    strokeWeight(2);
    beginShape();
    for (int i=0; i<(int)age; i++)
    {
      PVector shapePoint = morpher.getPoint(i, 1, anim.getNextFrame(), genome.shape);
      PVector p = PVector.add(shapePoint, genome.distortion.get(i).get(frameCount%30));
      vertex(p.x, p.y);
    }

    PVector shapePoint = morpher.getPoint(0, 1, anim.getNextFrame(), genome.shape);
    vertex(shapePoint.x + genome.distortion.get(0).get(frameCount%30).x,
                shapePoint.y + genome.distortion.get(0).get(frameCount%30).y);
    endShape();

    popMatrix();
  }
  
  public PVector getPointPos(int index)
  {
      PVector shapePoint = morpher.getPoint(index, 1, anim.getNextFrame(), genome.shape);
      PVector p = PVector.add(shapePoint, genome.distortion.get(index).get(frameCount%30));
      return p;
  }
  
  public boolean pick(Vec2D p)
  {
    if (distanceTo(p) < SIZE-10) {
      return true;
    }
    
    return false;
  }
  
  public void animateToCircle(float amount, int frames)
  {
    if (isRawType)
      return;
      
    anim.init(0, amount, frames);
    anim.play();
  }
  
  public void animateToOrig(float fromAmount, int frames)
  {
    if (isRawType)
      return;
      
    anim.init(fromAmount, 0, frames);
    anim.play();
  }
  
  public Creature mate(Creature c)
  {
    Creature newC = new Creature(x, y, morpher);
    newC.genome = genome.crossover(c.genome);
    newC.genome.mutate(0);

    return newC;
  }
  
//  public void setPosition(PVector p)
//  {
//    pos = p;
//  }

  public Creature clone()
  {
    Creature c = new Creature(x, y, morpher);
    c.age = age;
    
    c.genome = genome.clone();
    
    return c;
  }
}

