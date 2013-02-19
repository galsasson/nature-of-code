SineFish fish;

void setup()
{
  size(400, 400);
  smooth();
  frameRate(40);
  
  fish = new SineFish(new PVector(width/2, height/2));
  
  background(0);
}

void draw()
{
  background(0);
  
  fish.update();
  fish.draw();
}
