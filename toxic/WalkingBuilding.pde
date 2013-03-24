

class WalkingBuilding
{
  PVector pos;
  PVector elements;
  PVector size;
  PVector rectSize;
  
  color c;
  
  ArrayList<Particle> particles;
  
  public WalkingBuilding(VerletPhysics2D physics, PVector pos, PVector elements, PVector size)
  {
    this.pos = pos;
    this.elements = elements;
    this.size = size;
    
    rectSize = PVector.div(size, elements);
    
    pos.y -= size.y;
    
    c = color(random(100));
    
    initGrid(physics);
  }
  
  private void initGrid(VerletPhysics2D physics)
  {
    particles = new ArrayList<Particle>();
   
    for (int y=0; y<elements.y; y++)
    {
      for (int x=0; x<elements.x; x++)
      {
        Particle p = new Particle(new Vec2D(pos.x+x*rectSize.x, pos.y+y*rectSize.y));
        particles.add(p);
        physics.addParticle(p);
        
        if (y==elements.y-1)
        {
          p.addMotion();
          p.lock();
        }
      }
    }
    
    // connect with horizontal lines
    for (int y=0; y<elements.y-1; y++)
    {
      for (int x=0; x<elements.x-1; x++)
      {
        particles.get((int)(y*elements.x+x)).connectWith(physics, particles.get((int)(y*elements.x+(x+1))));
      }
    }
    
    // connect with vertical lines
    for (int x=0; x<elements.x; x++)
    {
      for (int y=0; y<elements.y-1; y++)
      {
        particles.get((int)(y*elements.x+x)).connectWith(physics, particles.get((int)((y+1)*elements.x+x)));

      }
    }
    
    // connect with orizontal lines
    for (int y=0; y<elements.y-1; y++)
    {
      for (int x=0; x<elements.x-1; x++)
      {
        particles.get((int)(y*elements.x+x)).connectWith(physics, 
          particles.get((int)((y+1)*elements.x+(x+1))));
        particles.get((int)(y*elements.x+(x+1))).connectWith(physics, 
          particles.get((int)((y+1)*elements.x+x)));
      }
    }

  }
  
  public void display()
  {
    fill(c);
    noStroke();
    
    
    // draw building shape
    beginShape();
    for (int i=0; i<elements.x; i++)
      vertex(particles.get(i).x, particles.get(i).y);
    for (int i=0; i<elements.y; i++)
      vertex(particles.get((int)(i*elements.x + elements.x-1)).x, particles.get((int)(i*elements.x + elements.x-1)).y);
    for (int i=(int)(elements.x-1); i>=0 ; i--)
      vertex(particles.get((int)((elements.y-1)*elements.x + i)).x, particles.get((int)((elements.y-1)*elements.x + i)).y);
    for (int i=(int)(elements.y-1); i>=0 ; i--)
      vertex(particles.get((int)(i*elements.x)).x, particles.get((int)(i*elements.x)).y);    
    endShape();
    
    // draw some windows
    noStroke();
    for (int y=0; y<elements.y-3; y++)
      for (int x=0; x<elements.x-1; x++)
      {
    if (random(2) > 1)
      fill(255, 255, 0);
    else
      fill(50, 50, 0);
        Particle p = particles.get((int)(y*elements.x + x));
        rect(p.x+rectSize.x/4, p.y+rectSize.y/4, rectSize.x/2, rectSize.y/2);
      }
    
    for (int i=0; i<particles.size(); i++)
    {
      particles.get(i).tick();
      //particles.get(i).display(true);
    }
  }
  
  public Particle pick(PVector p)
  {
    for (int i=0; i<particles.size(); i++)
    {
      if (getLength(particles.get(i), p) < 10)
        return particles.get(i);
    }
    
    return null;
  }
  
  private float getLength(Particle p1, PVector p2)
  {
    return sqrt(pow(p1.x-p2.x, 2) + pow(p1.y - p2.y, 2));
  }
  
  
  
  
  
  
}
