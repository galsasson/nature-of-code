
class SineFish
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float angAcc;
  float angVel;
  float ang;
  
  float initialSize;
  float size;
  float mass;
  
  color tipColor;
  
  float t;
  
  ArrayList<SineArm> arms;
  
  public SineFish(PVector pos, float initSize, int numOfLegs, color tipColor)
  {
    this.pos = pos;
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    
    initialSize = initSize;
    size = initialSize;
    mass = size*2;
    
    this.tipColor = tipColor;
    
    ang = 0;
    angVel = 0;
    angAcc = 0;
    
    arms = new ArrayList<SineArm>();
    
    for (float i=0; i<PI*2-0.01; i+=(PI*2)/numOfLegs)
    {
      arms.add(new SineArm(i, tipColor));
    }
    
    t=0;
  }
  
  public void setArmsSpeed(float angle, float speed)
  {
    for (int i=0; i<arms.size(); i++)
    {
      float angleDiff = abs(angle - (ang+arms.get(i).rot));
      if (angleDiff > PI*2)
            angleDiff -= PI*2;
            
      if (angleDiff < PI/3 || angleDiff > 2*PI-(PI/3))
            arms.get(i).setSpeed(speed);
    }
  }
  
  public void setAllArmsSpeed(float speed)
  {
    for (int i=0; i<arms.size(); i++)
    {
      arms.get(i).setSpeed(speed);
    }    
  }
  
  public void drag(float c)
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
    t+=0.01;
    
    angVel += angAcc;
    ang += angVel;
    if (ang > PI*2)
          ang -= PI*2;
    angAcc = 0;
    
    // like friction for angular motion
    angVel *= 0.9;
          
    size = initialSize+noise(t)*3;
    
    for (int i=0; i<arms.size(); i++)
          arms.get(i).update(size);
    
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(ang);
    
    fill(0, 0, 100, 20);
    noStroke();
    ellipse(0, 0, size*2, size*2);
    
    for (int i=0; i<arms.size(); i++)
          arms.get(i).draw();
    
    popMatrix();

  }
  
  public void move(PVector d)
  {
    d.normalize();
    applyForce(d);
    d.mult(-1);
    setArmsSpeed(d.heading(), 0.3);
    //println(d.heading());
    if (d.heading()>1)
      angAcc = -0.002;
    else
      angAcc = 0.002;    
  }
}
