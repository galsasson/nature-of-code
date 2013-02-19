
ArrayList<SineFish> fish; 

void setup()
{
  size(400, 400);
  smooth();
  frameRate(40);
  
  fish = new ArrayList();
  
  for (int i=0; i<50; i++)
  {
    float x = random(width);
    float y = random(height);
    float size = random(2, 6);
    int legs = (int)random(5, 20);
    fish.add(new SineFish(new PVector(x, y), size, legs));
  }
    
  
  background(0);
}

void draw()
{
  background(0);
  
  for (int i=0; i<fish.size(); i++)
  {
    fish.get(i).update();
    fish.get(i).draw();
  }  
  
}
