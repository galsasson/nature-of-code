
Foot foot;

void setup()
{
  size(600, 400);
  smooth();
  strokeWeight(1);
  
  foot = new Foot(new PVector(50, height-30),
                  new PVector(40, 0));
}

void draw()
{
  background(0);
  
  /* draw ground */
  line(0, height-20, width, height-20);
 
  foot.update(); 
  foot.draw();
}


