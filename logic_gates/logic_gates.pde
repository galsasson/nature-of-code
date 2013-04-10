Wire wire;
Wire wire2;

void setup()
{
  size(640, 960);
  frameRate(60);
  smooth();
  
  wire = new Wire(new PVector(20, 30), new PVector(1, 0), 400);
  wire2 = new Wire(new PVector(420, 30), new PVector(0, 1), 400);
}

void draw()
{
  background(0);
  
  stroke(255);
  strokeWeight(1);
  
  wire.draw();
  wire2.draw();
}
