

class WalkingBuilding extends VerletParticle2D implements SceneNode
{
  SceneNode parent;
  
  Vec2D elements;
  Vec2D size;
  Vec2D rectSize;
  
  color c;
  
  ArrayList<Particle> particles;
  
  public WalkingBuilding(SceneNode parent, VerletPhysics2D physics, Vec2D pos, Vec2D elements, Vec2D size)
  {
    super(pos);
    this.parent = parent;
    
    this.elements = elements;
    this.size = size;
    
    rectSize = size.scale(new Vec2D(1/elements.x, 1/elements.y));
    
    y -= size.y;
    
    c = color(random(100));
    
    initGrid(physics);
  }
  
  private void initGrid(VerletPhysics2D physics)
  {
    particles = new ArrayList<Particle>();
   
    for (int yy=0; yy<elements.y; yy++)
    {
      for (int xx=0; xx<elements.x; xx++)
      {
        Particle p = new Particle(this, new Vec2D(xx*rectSize.x, yy*rectSize.y));
        particles.add(p);
        physics.addParticle(p);
        
        if (yy==elements.y-1)
        {
          p.addMotion();
          p.lock();
        }
      }
    }
    
    // connect with horizontal lines
    for (int yy=0; yy<elements.y-1; yy++)
    {
      for (int xx=0; xx<elements.x-1; xx++)
      {
        particles.get((int)(yy*elements.x+xx)).connectWith(physics, particles.get((int)(yy*elements.x+(xx+1))));
      }
    }
    
    // connect with vertical lines
    for (int xx=0; xx<elements.x; xx++)
    {
      for (int yy=0; yy<elements.y-1; yy++)
      {
        particles.get((int)(yy*elements.x+xx)).connectWith(physics, particles.get((int)((yy+1)*elements.x+xx)));

      }
    }
    
    // connect with orizontal lines
    for (int yy=0; yy<elements.y-1; yy++)
    {
      for (int xx=0; xx<elements.x-1; xx++)
      {
        particles.get((int)(yy*elements.x+xx)).connectWith(physics, 
          particles.get((int)((yy+1)*elements.x+(xx+1))));
        particles.get((int)(yy*elements.x+(xx+1))).connectWith(physics, 
          particles.get((int)((yy+1)*elements.x+xx)));
      }
    }

  }
  
  public void display()
  {
    pushMatrix();
    translate(x, y);
    
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
    /*
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
    */
    for (int i=0; i<particles.size(); i++)
    {
      particles.get(i).tick();
      particles.get(i).display(true);
    }
    
    popMatrix();
  }
  
  public Particle pick(Vec2D p)
  {
    for (int i=0; i<particles.size(); i++)
    {
      if (getLength(particles.get(i), p) < 10)
        return particles.get(i);
    }
    
    return null;
  }
  
  public void moveParticleTo(Particle p, Vec2D target)
  {
    target.subSelf(this);
    p.set(target);
  }
  
  
  private float getLength(SceneNode node1, Vec2D vec)
  {
    return node1.getWorldPosition().distanceTo(vec);
    //return sqrt(pow(pos.x+p1.x-p2.x, 2) + pow(pos.y+p1.y - p2.y, 2));
  }
  
  public void setWorldPosition(Vec2D vec)
  {
    if (parent != null)
    {
      vec.subSelf(parent.getWorldPosition());
    }
    
    set(vec);
  }
  
  public Vec2D getWorldPosition()
  {
    Vec2D pos = copy();
    
    if (parent != null)
      pos.addSelf(parent.getWorldPosition());
    
    return pos;
  }
  
  
  
  
  
  
}
