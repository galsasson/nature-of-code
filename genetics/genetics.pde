
import themidibus.*;

MidiBus myBus;

ArrayList<Creature> creatures;
Creature mouseCreature = null;

ArrayList<Player> players;

ShapeMorpher morpher;

int[] orientalPitches = {36, 37, 40, 41, 42, 45, 46, 48};
int[] orientalScale = {0, 1, 4, 5, 6, 9, 10};

void setup()
{
  size(620, 600);
  background(255);  
  stroke(0);
  smooth();
  frameRate(60);
  
  myBus = new MidiBus(this, 0, 0);

  creatures = new ArrayList<Creature>();
  morpher = new ShapeMorpher();
  
  players = new ArrayList<Player>();
  players.add(new Player(new PVector(width/2-100, height-70)));
  players.add(new Player(new PVector(width/2, height-70)));
  players.add(new Player(new PVector(width/2+100, height-70)));

  for (int i=0; i<30; i++)
  {
    Creature c = new Creature(40 + i%10*60, 40 + i/10*60, morpher);
    c.initRandom();
    creatures.add(c);
  }
}

void draw()
{
  background(255);

  for (Creature c : creatures)
  {
    c.update();
    c.draw();
  }
  
  for (Player p : players)
  {
    p.update();
    p.draw();
  }
}

void mousePressed()
{
  for (Creature c : creatures)
  {
    if (c.pick(new PVector(mouseX, mouseY)))
    {
      c.animateToCircle();
      mouseCreature = c;      
      c.setPosition(new PVector(mouseX, mouseY));
      
      /* check if grabbed a creature from a player */
      for (Player p : players)
      {
        if (p.getCreature() == mouseCreature)
        {
          p.empty();
          mouseCreature.angle = 0;
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
    
  mouseCreature.setPosition(new PVector(mouseX, mouseY));
}

void mouseReleased()
{
  if (mouseCreature == null)
    return;
    
  Creature newc = null;
  
  mouseCreature.animateToOrig();
  
  for (Creature c : creatures)
  {
    if (c != mouseCreature && c.pick(new PVector(mouseX, mouseY)))
    {
      newc = mouseCreature.mate(c);
      newc.pos = new PVector(c.pos.x, c.pos.y+60);
      mouseCreature.pos.x -= 40;
      c.pos.x += 40;
    }
  }
  
  if (newc != null) 
    creatures.add(newc);

  for (Player p : players)
  {
    if (p.pick(new PVector(mouseX, mouseY)))
    {
      p.setCreature(mouseCreature);
    }
  }
  
  mouseCreature = null;
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

