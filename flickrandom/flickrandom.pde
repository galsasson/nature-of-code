Walker[] w;

String[] searchFor = {"tree", "sand", "car", "smoke", "road"};

void setup()
{
  size(800, 320);
  smooth();
  background(0);
  frameRate(30);

  w = new Walker[searchFor.length];
  for (int i=0; i<w.length; i++)
  {
    w[i] = new Walker(searchFor[i%searchFor.length], 20+i*20);
  }
}

void draw()
{
  background(0);
  
  for (int i=0; i<w.length; i++)
  {  
    w[i].tick();
    w[i].draw();
  }  
}

