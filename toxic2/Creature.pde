
class Creature
{
  Vec2D pos;
  ArrayList<VerletSpring2D> springs;
  ArrayList<VerletParticle2D> particles;
  
  VerletPhysics2D physics;
  
  int[] move = {2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int moveCounter;
  
  public Creature(VerletPhysics2D phys, Vec2D p)
  {
    physics = phys;
    pos = p;
    
    initShape();
    
    moveCounter = (int)random(move.length);
  }
  
  private void initShape()
  {
    particles = new ArrayList<VerletParticle2D>();
    springs = new ArrayList<VerletSpring2D>();
    
    particles.add(new VerletParticle2D(new Vec2D(0, 0)));
    particles.add(new VerletParticle2D(new Vec2D(-10, 0)));
    particles.add(new VerletParticle2D(new Vec2D(10, 0)));
    particles.add(new VerletParticle2D(new Vec2D(0, -10)));
    particles.add(new VerletParticle2D(new Vec2D(0, 10)));
    
    springs.add(new VerletSpring2D(particles.get(0), particles.get(1), 10, 0.2));
    springs.add(new VerletSpring2D(particles.get(0), particles.get(2), 10, 0.2));
    springs.add(new VerletSpring2D(particles.get(0), particles.get(3), 10, 0.2));
    springs.add(new VerletSpring2D(particles.get(0), particles.get(4), 10, 0.2));
    springs.add(new VerletSpring2D(particles.get(1), particles.get(3), 13, 0.2));
    springs.add(new VerletSpring2D(particles.get(3), particles.get(2), 13, 0.2));
    springs.add(new VerletSpring2D(particles.get(2), particles.get(4), 13, 0.2));
    springs.add(new VerletSpring2D(particles.get(4), particles.get(1), 13, 0.2));
    
    for (int i=0; i<particles.size(); i++)
      physics.addParticle(particles.get(i));
    
    for (int i=0; i<springs.size(); i++)
      physics.addSpring(springs.get(i));
  }
  
  public void update()
  {
    if (move[moveCounter] > 0)
    {
      VerletParticle2D p = particles.get(0);
      p.lock();
      p.set(p.x + move[moveCounter], p.y);
      p.unlock();
    }
    
    moveCounter = ++moveCounter % move.length;
    
    /* apply friction */
    for (VerletParticle2D p : particles)
    {
      p.scaleVelocity(0.9);
    }
    
  }
  
  public void draw()
  {
    noStroke();
    fill(80);
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    for (int i=0; i<particles.size(); i++)
    {
      ellipse(particles.get(i).x, particles.get(i).y, 3, 3);
    }
    
    popMatrix();
  }
}
