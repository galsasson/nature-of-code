
Walker w;

void setup()
{
  size(800, 400);
  smooth();
  frameRate(60);
  noStroke();
  
  w = new Walker();  
}

void draw()
{
  background(0);
  w.tick();
  w.draw();
}
