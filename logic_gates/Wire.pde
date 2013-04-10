

class Wire
{
  PLine line;
  PVector pos;
  PVector dir;
  PVector per;
  
  Deformation deform;
  
  int frame;
  
  public Wire(PVector start, PVector direction, float length)
  {
    pos = start;
    dir = direction;
    dir.normalize();
    
    line = new PLine();
    
    float t=20;
    PVector p = new PVector();
    while(p.mag() < length)
    {
      PVector nextJump = PVector.mult(new PVector(20-sqrt(10*t), 20-sqrt(10*t)), dir);
      p.add(nextJump);
      line.addPoint(p.get());
        
      if (t<30) t+=1;
    }
    
    deform = new Deformation(dir);
    
    frame = 0;
  }
  
  float t = 1;
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noFill();

    stroke(8, 10, 26);
    strokeWeight(12);
    beginShape();
    for (int i=0; i<line.size(); i++)
    {
      PVector start = PVector.add(line.getPoint(i), deform.getFrame((deform.size()-frame+i)%deform.size()));
      if (i>line.size()-5)
        start.y *= (float)(line.size()-i) / 5;
      
      vertex(start.x, start.y);
    }
    endShape();

    stroke(37, 48, 155);
    strokeWeight(6);
    beginShape();
    for (int i=0; i<line.size(); i++)
    {
      PVector start = PVector.add(line.getPoint(i), deform.getFrame((deform.size()-frame+i)%deform.size()));
      if (i>line.size()-5)
        start.y *= (float)(line.size()-i) / 5;

      vertex(start.x, start.y);
    }
    endShape();

    stroke(255);
    strokeWeight(2);
    beginShape();
    for (int i=0; i<line.size(); i++)
    {
      PVector start = PVector.add(line.getPoint(i), deform.getFrame((deform.size()-frame+i)%deform.size()));
      if (i>line.size()-5)
        start.y *= (float)(line.size()-i) / 5;

      vertex(start.x, start.y);
    }
    endShape();
 
    // draw start point
    fill(200);
    noStroke();
    PVector p = PVector.add(line.getPoint(0), deform.getFrame((deform.size()-frame)%deform.size()));
    rect(p.x-10, p.y-10, 5, 20);
    rect(p.x-5, p.y-2, 5, 4);
    ellipse(line.getPoint(line.size()-1).x, line.getPoint(line.size()-1).y, 5, 5);

    frame += 1;//(int)t;
    frame %= deform.size();
      
    //t+=2;
    
    popMatrix();
  }
  
  
  
}
