
class FastFish
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float angAcc;
  float angVel;
  float ang;
  
  float size;
  float mass;
  
  float t;
  float flapSpeed;
  
  ArrayList<Bubble> bubbles;
  
  public FastFish(PVector pos, float initSize)
  {
    this.pos = pos;
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    
    size = initSize;
    mass = size*2;
    
    ang = 0;
    angVel = 0;
    angAcc = 0;
    
    bubbles = new ArrayList<Bubble>();
    
    flapSpeed = 0.1;
    t=0;
  }
  
  public void applyDrag(float c)
  {
    float speed = vel.mag();
    float dragMag = c * speed * speed;
    
    PVector drag = vel.get();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMag);
    applyForce(drag);
  }
  
  public void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  public void update()
  {
    vel.add(acc);
    pos.add(vel);
    
    acc.mult(0);
    t+=flapSpeed;
    
    angVel += angAcc;
    ang += angVel;
    if (ang > PI*2)
          ang -= PI*2;
    angAcc = 0;
    
    // like friction for angular motion
    angVel *= 0.9;
    
    for (int i=bubbles.size()-1; i>=0; i--)
    {
      Bubble b = (Bubble)bubbles.get(i);
      if (!b.isAlive())
      {
        bubbles.remove(i);
        continue;
      }
      
      b.applyForce(new PVector(0, -0.03));
      b.update();
    }
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(ang);
    
    
    // draw head
    float yOffset = -23;

    fill(50, 100, 100, 100);
    noStroke();
    ellipse(-10, yOffset, 5, 5);
    ellipse(10, yOffset, 5, 5);

    fill(0, 0, 100, 20);
    stroke(0, 0, 100, 20);
    beginShape();
    curveVertex(5, yOffset-4);
    curveVertex(15, yOffset-8);
    curveVertex(15, yOffset+8);
    curveVertex(5, yOffset+4);
    curveVertex(-5, yOffset+4);
    curveVertex(-15, yOffset+8);
    curveVertex(-15, yOffset-8);
    curveVertex(-5, yOffset-4);
    curveVertex(5, yOffset-4);
    curveVertex(15, yOffset-8);
    curveVertex(15, yOffset+8);
    endShape();
    
    yOffset = -10;
    float x=0, y=0;
    for (int i=0; i<9; i++)
    {
      x = sin(t-i)*i;
      y = yOffset;
      ellipse(x, y, 15-i*2, (10-i));
      ellipse(x, y, 3, 3);
      yOffset += (12-i);
    }
    
    popMatrix();
    
    for (int i=0; i<bubbles.size(); i++)
    {
      ((Bubble)bubbles.get(i)).draw();
    }
    
  }
  
  public void forward(float speed)
  {
    flapSpeed = 0.8;
    applyForce(PVector.mult(PVector.fromAngle(ang-PI/2),speed));
  }
  
  public void turnRight()
  {
    PVector s = new PVector(-17, -22);
    s.rotate(ang);
    PVector initSpeed = PVector.mult(PVector.fromAngle(ang+PI), random(2,4));
    angAcc = PI/200;
    bubbles.add(new Bubble(PVector.add(pos, s), initSpeed, random(2, 8)));
  }
  
  public void turnLeft()
  {
    PVector s = new PVector(17, -22);
    s.rotate(ang);
    PVector initSpeed = PVector.mult(PVector.fromAngle(ang), random(2,4));
    angAcc = -PI/200;
    bubbles.add(new Bubble(PVector.add(pos, s), initSpeed, random(2, 8)));
  }
}
