
Ocean ocean;
FastFish myFish;
ArrayList<SineFish> fish;


final int FISH_NUM = 20;
final float LIQUID_DRAG = 0.5;

boolean keyUp = false;
boolean keyRight = false;
boolean keyDown = false;
boolean keyLeft = false;

ChatWindow chat;
WordSpace wordSpace;

void setup()
{
  size(600, 400);
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  frameRate(40);
  
  ocean = new Ocean();
  chat = new ChatWindow();
  wordSpace = new WordSpace(loadFont("Osaka-16.vlw"));
  
  /* init words with environment strings */
  int t=0;
  for (int y=-200; y<200; y++)
  {
    for (int x=-200; x<200; x++)
    {
      wordSpace.addWord(new ChunkOfWords(new PVector(x*50+(noise((t+=0.2))-0.5)*5, y*50+(noise((t+=0.2))-0.5)*5), new String("h"), -1));
    }
    
  }
  
  fish = new ArrayList();
  
  for (int i=0; i<FISH_NUM; i++)
  {
    float x = random(width*2) - width;
    float y = random(height*2) - height;
    float size = random(2, 16);
    int legs = (int)random(5, 20);
    fish.add(new SineFish(new PVector(x, y), size, legs, color(random(150)+140, 57, 100)));
  }
  
  myFish = new FastFish(new PVector(0, 0), 5);

  background(0);
}

void initWorld()
{
}

void draw()
{
  pushMatrix();
  
  PVector pos = myFish.pos.get();
  translate(-myFish.pos.x+width/2, -myFish.pos.y+height/2);
  ocean.draw();
  
  wordSpace.display(myFish.pos, 400);
  
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
  
  myFish.flapSpeed = 0.02;
  
  if (keyLeft)
    myFish.turnLeft();
  if (keyUp)
    myFish.forward(4);
  if (keyRight)
    myFish.turnRight();
  
  myFish.applyDrag(LIQUID_DRAG);
  
  myFish.update();
  
  myFish.draw();
  
  chat.update();
  chat.display(pos.x-width/2, pos.y+height/2);
  popMatrix();
  
}

void sendText()
{
  String str = new String(chat.getString());
  chat.emptyString();
  
  wordSpace.addWord(new ChunkOfWords(new PVector(myFish.pos.x, myFish.pos.y), str, -1));
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
    
    if (keyCode == ENTER)
    {
      sendText();
    }
    else chat.handleChar(key);
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
