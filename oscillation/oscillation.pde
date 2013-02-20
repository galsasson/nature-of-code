
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
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  frameRate(40);
  
  ocean = new Ocean();
  
  fish = new ArrayList();
  
  for (int i=0; i<FISH_NUM; i++)
  {
    float x = random(width*2) - width;
    float y = random(height*2) - height;
    float size = random(2, 16);
    int legs = (int)random(5, 20);
    fish.add(new SineFish(new PVector(x, y), size, legs, color(random(150)+140, 57, 100)));
  }
  
  myFish = new SineFish(new PVector(0, 0), 5, 10, color(56, 91, 100));
    
  
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
    
    f.applyDrag(LIQUID_DRAG);
    
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
  
  myFish.applyDrag(LIQUID_DRAG);
  
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
