// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// PBox2D example

// Simple Toxiclibs Spring

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics world
VerletPhysics2D physics;

Particle p;
boolean locked;

ArrayList<WalkingBuilding> movers = new ArrayList<WalkingBuilding>();

void setup() {
  size(1000,700);
  smooth();
  frameRate(30);

  // Initialize the physics
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.5)));

  // Set the world's bounding box
  //physics.setWorldBounds(new Rect(0,0,width,height));
  
  //movers.add(new WalkingBuilding(physics, new PVector(200, height-10), new PVector(10, 17), new PVector(200, 400)));
  
  for (int i=0; i<18; i++)
  {
    movers.add(new WalkingBuilding(null, physics, new Vec2D(random(0,600), height-10), 
                                  new Vec2D((int)random(4, 7), (int)random(6, 10)), new Vec2D((int)random(150, 230), (int)random(400, 600))));
  }
//  for (int i=0; i<1; i++)
//  {
//    movers.add(new WalkingBuilding(physics, new PVector(100, height-10), new PVector(2, 8)));
//  }
//  
//    movers.add(new WalkingBuilding(physics, new PVector(10, height-10), new PVector(20, 25)));
}

void draw() {

  // Update the physics world
  physics.update();

  background(255);

  for (int i=0; i<movers.size(); i++)
    movers.get(i).display();

  if (p!= null)
  {
    p.setWorldPosition(new Vec2D(mouseX, mouseY));
  }
}

void mousePressed()
{
  p=null;
  
  for (int i=0; i<movers.size() && p==null; i++)
    p = movers.get(i).pick(new Vec2D(mouseX, mouseY));
    
  if (p != null)
  {
    locked = p.isLocked();
    p.lock();
  }
  
}

void mouseReleased()
{
  if (p!=null)
  {
    if (!locked)
      p.unlock();
  }
  
  p = null;
}



