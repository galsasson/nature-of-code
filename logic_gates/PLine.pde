
class PLine
{
  ArrayList<PVector> points;
  
  public PLine()
  {
    points = new ArrayList<PVector>();
  }
  
  public void addPoint(PVector p)
  {
    points.add(p);
  }
  
  public PVector getPoint(int index)
  {
    return points.get(index);
  }
  
  public int size()
  {
    return points.size();
  }
}
