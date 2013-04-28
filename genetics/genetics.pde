
import themidibus.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

MidiBus myBus;
VerletPhysics2D physics;

ArrayList<Creature> creatures;
Creature mouseCreature = null;

ArrayList<Player> players;

ShapeMorpher morpher;

boolean systemReady = false;

PImage speakerImg;

void setup()
{
  size(1280, 800);
  background(255);  
  stroke(0);
  smooth();
  frameRate(60);
  
  myBus = new MidiBus(this, 0, 0);
  physics = new VerletPhysics2D();
  
  physics.setWorldBounds(new Rect(0,0,width,height));

  creatures = new ArrayList<Creature>();
  morpher = new ShapeMorpher();
  
  // load resources
  speakerImg = loadImage("img/speaker_new.jpg");
  
  players = new ArrayList<Player>();
  players.add(new Player(new PVector(width/4-100, height-160), "Guitar-Balladeer", -1));
  players.add(new Player(new PVector(width/4, height-160), "Guitar-Balladeer", 0));
  
  players.add(new Player(new PVector(width/2-50, height-160), "Pad-Fat", -1));
  players.add(new Player(new PVector(width/2+50, height-160), "Pad-Fat", 0));
  
  players.add(new Player(new PVector(width*3/4, height-160), "Guitar-Reg", 0));
  players.add(new Player(new PVector(width*3/4+100, height-160), "Guitar-Reg", 1));

  for (int i=0; i<100; i++)
  {
    Creature c = new Creature(40 + i%20*60, 40 + i/20*60, morpher);
    c.initRandom();
    addCreature(c);
  }
  
  systemReady = true;
}

void addCreature(Creature c)
{
    physics.addParticle(c);
    c.lock();
//    c.addBehavior(new AttractionBehavior(c, SIZE, -0.3));
//    physics.addBehavior(new AttractionBehavior(c, SIZE, -0.3));
    creatures.add(c);
}

void draw()
{
  background(255);
  
  physics.update();

  for (Creature c : creatures)
  {
    c.updateAnimation();
    c.draw();
  }
  
  for (Player p : players)
  {
    //p.update();
    p.draw();
  }
}

void mousePressed()
{
  for (Creature c : creatures)
  {
    if (c.pick(new Vec2D(mouseX, mouseY)))
    {
      //c.animateToCircle();
      mouseCreature = c;
      c.lock();     
      c.set(mouseX, mouseY);
//      c.removeAllBehaviors();
      
      /* check if grabbed a creature from a player */
      for (Player p : players)
      {
        if (p.getCreature() == mouseCreature)
        {
          p.empty();
          mouseCreature.rotation = 0;
        }
      }
      
      return;
    }
  }
}

void mouseDragged()
{
  if (mouseCreature == null)
    return;
    
  mouseCreature.set(mouseX, mouseY);
}

void mouseReleased()
{
  if (mouseCreature == null)
    return;
    
  //mouseCreature.animateToOrig();
  //mouseCreature.unlock();
  
  for (int i=0; i<creatures.size(); i++)
  {
    if (creatures.get(i) != mouseCreature && creatures.get(i).pick(new Vec2D(mouseX, mouseY)))
    {
      Creature newc = mouseCreature.mate(creatures.get(i));
      newc.set(creatures.get(i).add(0, 60));
      mouseCreature.subSelf(40, 0);
      creatures.get(i).addSelf(40, 0);
      addCreature(newc);
    }
  }
  
  for (Player p : players)
  {
    if (p.pick(new PVector(mouseX, mouseY)))
    {
//      mouseCreature.lock();
      p.setCreature(mouseCreature);
    }
  }
  
  mouseCreature = null;
}

int counter=0;

void rawMidi(byte[] data) {
  if (!systemReady)
    return;
    
  /* start beat message */
  if (data[0] == (byte)0xfa) {
    for (Player p : players)
    {
      p.setBeat();
    }
    counter = 0;
  }
  
   /* clock message */
  if (data[0] == (byte)0xf8) {
    counter++;
    if (counter==24*4) {
      counter = 0;
    }
    
    /* beat animation */
    if (counter == 24*4-20)
    {
      for (Creature c : creatures)
      {
        c.animateToCircle(0.3, 20);
      }
    }
    else if (counter == 24*4-1)
    {
      for (Creature c : creatures)
      {
        c.animateToOrig(0.3, 4);
      }
    }
    
    /* off beat animation */
    if (counter == 24*2-10)
    {
      for (Creature c : creatures)
      {
        c.animateToCircle(0.2, 20);
      }
    }
    else if (counter == 24*2-3)
    {
      for (Creature c : creatures)
      {
        c.animateToOrig(0.2, 4);
      }
    }

    
    for (Player p : players)
    {
      p.beat();
    }

  }
}

/*
void nextGen()
{
  ArrayList<Creature> selectedOnes = new ArrayList<Creature>();
  float averageFit = 0;
  for (Creature c : creatures)
  {
    averageFit += c.getFitness();
  }
  averageFit /= creatures.size();
  
  for (Creature c :creatures)
  {
    if (c.getFitness() < averageFit)
      selectedOnes.add(c);
  }
  
  
  ArrayList<Creature> newGen = new ArrayList<Creature>();
  for (int i=0 ;i<500; i++)
  {
    Creature newC = selectedOnes.get(int(random(selectedOnes.size()))).mate(selectedOnes.get(int(random(selectedOnes.size()))));
    newC.pos = new PVector(40 + newGen.size()%18*60, 40 + newGen.size()/18*60);
    newGen.add(newC);
  }
  
  creatures = newGen;
}
*/

