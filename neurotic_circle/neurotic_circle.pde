
NeuroticCircle nc;

void setup()
{
  size(550, 250);
  smooth();
  frameRate(40);
  noStroke();
  
  nc = new NeuroticCircle();  
}

void draw()
{
  background(nc.getAngerLevel()*50, 0, 0);
  
  nc.move();
  nc.draw();
}
