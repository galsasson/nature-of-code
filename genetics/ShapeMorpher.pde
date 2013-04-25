
class ShapeMorpher
{
  public ArrayList<PVector> circle;
  public ArrayList<PVector> point;
  
  public ShapeMorpher()
  {
    initCircle();
    initPoint();
  }
  
  private void initCircle()
  {    
    circle = new ArrayList<PVector>();
    
    PVector origin = new PVector(0, SIZE/2);
    
    float angInc = ((PI*2) / MAX_AGE);
    for (int i=0; i<MAX_AGE; i++)
    {
      origin.rotate(angInc);
      circle.add(origin.get());
    }
  }
  
  private void initPoint()
  {
    point = new ArrayList<PVector>();
    
    for (int i=0; i<MAX_AGE; i++)
      point.add(new PVector(0, 0));
  }
  
  public PVector getPoint(int index, int type, float amount, ArrayList<PVector> shape)
  {
    amount = constrain(amount, 0, 1);
    
    if (type == 0)
    {
      PVector diff = PVector.sub(point.get(index), shape.get(index));
      return PVector.add(shape.get(index), PVector.mult(diff, amount));
    }
    else if (type == 1)
    {
      PVector diff = PVector.sub(circle.get(index), shape.get(index));
      return PVector.add(shape.get(index), PVector.mult(diff, amount));
    }
    
    return shape.get(index);
  }
  
}
