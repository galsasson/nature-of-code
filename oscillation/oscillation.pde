
Ocean ocean;
SineFish myFish;
ArrayList<SineFish> fish;

final int FISH_NUM = 10;
final float LIQUID_DRAG = 0.5;

boolean keyUp = false;
boolean keyRight = false;
boolean keyDown = false;
boolean keyLeft = false;

void setup()
{
  size(600, 400);
  smooth();
  frameRate(40);
  
  ocean = new Ocean();
  
  fish = new ArrayList();
  
  for (int i=0; i<FISH_NUM; i++)
  {
    float x = random(width);
    float y = random(height);
    float size = random(2, 16);
    int legs = (int)random(5, 20);
    fish.add(new SineFish(new PVector(x, y), size, legs));
  }
  
  myFish = new SineFish(new PVector(width/2, height/2), 5, 10);
    
  
  background(0);
}

void draw()
{
  pushMatrix();
  
  translate(-myFish.pos.x+width/2, -myFish.pos.y+height/2);
  ocean.draw();
  
  for (int i=0; i<fish.size(); i++)
  {
    SineFish f = fish.get(i);
    
    f.setAllArmsSpeed(0.02);
    if (f.pos.dist(myFish.pos) < 50)
    {
      f.move(PVector.sub(f.pos,myFish.pos));
    }
    f.drag(LIQUID_DRAG);
    
    f.update();
    f.draw();
  }  
  
  myFish.setAllArmsSpeed(0.04);
  
  if (keyLeft)
    myFish.move(new PVector(-1, 0));
  if (keyUp)
    myFish.move(new PVector(0, -1));
  if (keyRight)
    myFish.move(new PVector(1, 0));
  if (keyDown)
    myFish.move(new PVector(0, 1));
    
  myFish.drag(LIQUID_DRAG);
  
  myFish.update();
  
  myFish.draw();
  
  popMatrix();
  
}

void keyPressed()
{
  if (keyCode == UP)
    keyUp = true;
  else if (keyCode == RIGHT)
    keyRight = true;
  else if (keyCode == DOWN)
    keyDown = true;
  else if (keyCode == LEFT)
    keyLeft = true;
}

void keyReleased()
{
  if (keyCode == UP)
    keyUp = false;
  else if (keyCode == RIGHT)
    keyRight = false;
  else if (keyCode == DOWN)
    keyDown = false;
  else if (keyCode == LEFT)
    keyLeft = false;
}
