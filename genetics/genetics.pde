
ArrayList<Creature> creatures;

void setup()
{
  size(1100, 600);
  background(255);  
  stroke(0);
  smooth();
  frameRate(30);

  creatures = new ArrayList<Creature>();
  
  for (int i=0; i<500; i++)
  {
    Creature c = new Creature(40 + i%18*60, 40 + i/18*60);
    c.initRandom();
    creatures.add(c);
  }
/*
  for (int i=0; i<14; i++)
  {
    for (int j=0; j<16; j++)
    {
      Creature c = creatures.get(i).clone();
      c.age += j+1;
      c.pos.y = 90+j*40;
      creatures.add(c);
    }
  }
*/
}

void draw()
{
  background(255);

  ArrayList<Creature> deadOnes = new ArrayList<Creature>();

  int totalFit = 0;
  
  for (Creature c : creatures)
  {
    c.update(0);
    if (!c.isAlive()) {
      deadOnes.add(c);
      continue;
    }
    c.draw();
    
    totalFit += c.getFitness();
  }
  
  // remove dead creatures
  for (Creature d : deadOnes)
  {
    creatures.remove(d);
  }
  
      
    fill(0);
    text(totalFit, 10, height-20);
}

void mousePressed()
{
//  for (int i=0; i<100; i++)
    nextGen();
}

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


