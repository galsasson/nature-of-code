import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics world
VerletPhysics2D physics;
ArrayList<Creature> cs;

void setup()
{
  size(800, 500);
  smooth();
  
  cs = new ArrayList<Creature>();

  physics=new VerletPhysics2D();
  for (int i=0; i<200; i++)
  {
    cs.add(new Creature(physics, new Vec2D(random(width), random(height))));
  }  
  
}

void draw()
{
  background(0);
  
  physics.update();
  
  for (Creature c : cs)
  {
    c.update();
    c.draw();
  }
  
  println(frameRate);
}
