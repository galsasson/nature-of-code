class Walker
{
  PVector pos;
  float tVer, tHor, tShape;
  float pissedOff;
  
  public Walker()
  {
    pos = new PVector(width/2, height/2);
    pissedOff = 0;
    
    tVer = 0;
    tHor = 10000;
    tShape = 20000;
  }
  
  public void tick()
  {
    PVector evade = new PVector(pos.x-mouseX, pos.y-mouseY);
    float distance = evade.mag();
    if (distance<1)
          distance=1;
          
    if (distance < pissedOff+50)
    {
      // If we are really pissed off, chase the mouse
      if (pissedOff>130)
            evade.mult(-1);
            
      evade.normalize();
      pos.add(PVector.mult(evade, 50/distance));
      
      if (pissedOff < 200)
            pissedOff += 1;
    }
    else {
      if (pissedOff > 0)
            pissedOff -= 1;
    }

    /* add random noise to movement based on 
     * "danger" from the sides
     */
    PVector danger = new PVector(noise(tVer)-0.48, 
                                  noise(tHor)-0.48); 
    danger.mult(2);
    
    pos.add(danger);    
        
    tVer += 0.2;
    tHor += 0.2;
    
    //pissedOff = noise(tAnger)*150;
    //tAnger += 0.005;
  }
  
  public void draw()
  {
    fill(100 + pissedOff, 100, 100);
    
    for (float i=0; i<PI*2; i+=0.1)
    {
      ellipse(pos.x + sin(i)*(20+noise(tShape)*5), 
              pos.y + cos(i)*(20+noise(tShape)*5), 3, 3);
      tShape += 0.2;
//      point(pos.x + sin(i)*20, pos.y + cos(i)*20);
    }
    
    //ellipse(pos.x, pos.y, 20, 20);
  }
}
