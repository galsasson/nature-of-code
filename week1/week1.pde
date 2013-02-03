
Walker w;

void setup()
{
  size(800, 400);
  smooth();
  frameRate(60);
  w = new Walker();
  noStroke();
}

void draw()
{
  background(0);
  w.tick();
  w.draw();
}




