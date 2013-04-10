
class Particle extends VerletParticle2D implements SceneNode {
  
  SceneNode parent;
  ArrayList<VerletSpring2D> springs;
  float t;
  
  ArrayList<PVector> offsets;
  int frame;
  int direction;
  
  Particle(SceneNode parent, Vec2D loc) {
    super(loc);
    
    this.parent = parent;
    
    springs = new ArrayList<VerletSpring2D>();
    
    t = random(0, 10);
  }

  public void addMotion()
  {
    offsets = new ArrayList<PVector>();
    
    offsets.add(new PVector(3, -4));
    offsets.add(new PVector(2, -4));
    offsets.add(new PVector(2, -2.3));
    offsets.add(new PVector(1, -1.7));
    offsets.add(new PVector(1, 0));
    offsets.add(new PVector(1, 6));
    offsets.add(new PVector(0, 6));
    for (int i=0; i<60; i++)
      offsets.add(new PVector(0, 0));
      
    frame = (int)random(10, offsets.size());
    direction = 1;
    
  }
  
  public void tick()
  {
    if (offsets != null)
    {
      x += offsets.get(frame%offsets.size()).x * direction;
      y += offsets.get(frame%offsets.size()).y;
      
      if (x>width-20)
        direction = -1;
    }
    
    frame++;
  }

  void display(boolean spring) {
    fill(0, 50);
    stroke(0, 50);
    strokeWeight(2);
    ellipse(x,y,5,5);
    
    if (spring)
    {
      for (int i=0; i<springs.size(); i++)
      {
        strokeWeight(1);
        stroke(0, 50);
        line(springs.get(i).a.x, springs.get(i).a.y, springs.get(i).b.x, springs.get(i).b.y);
      }
    }
  }
  
  public void connectWith(VerletPhysics2D physics, Particle p)
  {
    VerletSpring2D s;
    
    s = new VerletSpring2D(this,p,getLength(this, p),0.6);
    springs.add(s);
    physics.addSpring(s);
  }
  
  private float getLength(Particle p1, Particle p2)
  {
    return sqrt(pow(p1.x-p2.x, 2) + pow(p1.y - p2.y, 2));
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
