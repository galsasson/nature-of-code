
import themidibus.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

MidiBus myBus;
VerletPhysics2D physics;

ArrayList<Creature> creatures;
Creature mouseCreature = null;

ArrayList<Player> players;

RawPortal rawPortal;

ShapeMorpher morpher;

int beatCounter;
boolean systemReady = false;
PFont font;


ColorScheme colorScheme;

void setup()
{
  size(1280, 800);
  background(255);  
  stroke(0);
  smooth();
  frameRate(60);
  
  font = loadFont("ShareTech-Regular-16.vlw");
  
  myBus = new MidiBus(this, 0, 0);
  physics = new VerletPhysics2D();
  
  physics.setWorldBounds(new Rect(0,0,width,height));

  creatures = new ArrayList<Creature>();
  morpher = new ShapeMorpher();
  
  colorScheme = new ColorScheme();
  rawPortal = new RawPortal(new PVector(80, height-110));
  beatCounter = 0;
  
  players = new ArrayList<Player>();
  
  players.add(new Player(new PVector(width-300, 650), "Pad-Fat", -1));
  players.add(new Player(new PVector(width-200, 550), "Pad-Fat", 0));

  players.add(new Player(new PVector(width-300, 450), "Guitar-Balladeer", -1));
  players.add(new Player(new PVector(width-200, 350), "Guitar-Balladeer", 0));
  
  players.add(new Player(new PVector(width-300, 250), "Guitar-Reg", 0));
  players.add(new Player(new PVector(width-200, 150), "Guitar-Reg", 1));
  players.add(new Player(new PVector(width-300, 50), "Guitar-Reg-Fast", 1));
  
  for (int i=0; i<20; i++)
  {
    Creature c = new Creature(width/2 - 12*60/2 + (i%10)*60, height-80 - 2*60/2 + (i/10)*60, morpher);
    c.initRandom();
    addCreature(c);
  }
  
  /* Add the "GOGOAM" logo */
  String logo = "GOGOAM";
  for (int i=0; i<logo.length(); i++)
  {
    Creature c = new Creature(50+i*40, 50, morpher);
    c.initAsLetter(logo.charAt(i));
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
  background(colorScheme.getLight());
  
  physics.update();
  colorScheme.update();

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
  
  strokeWeight(3);
  stroke(colorScheme.getDark());
  line(width-20, 50, width-20, height-50);
  line(width-20, height-50, 0, height-50);
  
  rawPortal.draw();
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
      if (c.isRawType)
        c.setToCreature();
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
      
      // transition from white to black
//      doTransitions();
    }
  }
  
  if (rawPortal.pick(new PVector(mouseX, mouseY)))
  {
    mouseCreature.set(rawPortal.pos.x, rawPortal.pos.y);
    mouseCreature.setToRaw();
  }
  
  mouseCreature = null;
}

void rawMidi(byte[] data) {
  if (!systemReady)
    return;
    
  /* start beat message */
  if (data[0] == (byte)0xfa) {
    for (Player p : players)
    {
      p.setBeat();
    }
    beatCounter = 0;
  }
  
   /* clock message */
  if (data[0] == (byte)0xf8) {
    beatCounter++;
    if (beatCounter==24*4) {
      beatCounter = 0;
    }
    
    /* beat animation */
    if (beatCounter == 24*4-20)
    {
      for (Creature c : creatures)
      {
        c.animateToCircle(0.3, 20);
      }
    }
    else if (beatCounter == 24*4-1)
    {
      for (Creature c : creatures)
      {
        c.animateToOrig(0.3, 4);
      }
    }
    
    /* off beat animation */
    if (beatCounter == 24*2-10)
    {
      for (Creature c : creatures)
      {
        c.animateToCircle(0.2, 20);
      }
    }
    else if (beatCounter == 24*2-3)
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

public void doTransitions()
{
  int activePlayers = 0;
  for (Player p : players)
  {
    if (p.getCreature() != null)
      activePlayers++;
  }
  
  if (activePlayers >= 5)
    colorScheme.startFlip(20);
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

