
class Ocean
{
  ArrayList<PVector> points;
  
  public Ocean()
  {
    points = new ArrayList();
    
    for (int i=0; i<500; i++)
    {
      points.add(new PVector(random(2000)-1000, random(2000)-1000));
    }
  }
  
  public void draw()
  {
    background(231, 100, 20);
    fill(0, 0, 100, 20);
    
    for (int i=0; i<points.size(); i++)
    {
      ellipse(points.get(i).x, points.get(i).y, 2, 2);
    }
  }
  
}

