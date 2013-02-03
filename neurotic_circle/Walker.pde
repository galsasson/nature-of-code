class Walker
{
  final float CHASE_THRESHOLD = 0.6;
  final float SHAKE_THRESHOLD = 0.95;
  PVector pos;
  float tVer, tHor, tShape, tShake, tChase;
  float pissedOff;
  
  public Walker()
  {
    pos = new PVector(width/2, height/2);
    pissedOff = 0;
    
    tVer = 0;
    tHor = 10000;
    tShape = 20000;
    tShake = 30000;
    tChase = 40000;
  }
  
  public void tick()
  {
    PVector evade = new PVector(pos.x-mouseX, pos.y-mouseY);
    float distance = evade.mag();
    if (distance<1)
          distance=1;
          
    if (distance < 50+(pissedOff*100))
    {
      // If we are really pissed off, chase the mouse
      if (pissedOff > SHAKE_THRESHOLD ||
            (pissedOff > CHASE_THRESHOLD &&
            noise(tChase) > 0.5)) 
      {
            evade.mult(-1);
            evade.normalize();
            pos.add(PVector.mult(evade, distance/5));
      }
      else 
      {     
            evade.normalize();
            pos.add(PVector.mult(evade, 50/distance));
      }
      
      if (pissedOff < 1)
            pissedOff += 0.002;
    }
    else {
      if (pissedOff > 0)
            pissedOff -= 0.01;
    }
    
    /* if we are in chase mode make 
     * side to side movement
     */
    
    if (pissedOff > CHASE_THRESHOLD) {
      tShake += 1;
      pos.x += sin(tShake)*(((pissedOff-CHASE_THRESHOLD)/0.35)*10);
    }
    

    /* add random noise (neuroza) to movement */
    PVector neuroza = new PVector(noise(tVer)-0.48, 
                                  noise(tHor)-0.48); 
    neuroza.mult(5+pissedOff*5);
    
    pos.add(neuroza);    
        
    tVer += 0.2;
    tHor += 0.2;
    tChase += 0.1;
    
    /* keep the circle inside the screen */
    if (pos.x < 20)
          pos.x = 20;
    else if (pos.x > width-20)
          pos.x = width-20;
    
    if (pos.y < 20)
          pos.y = 20;
    else if (pos.y > height-20)
          pos.y = height-20;
  }
  
  public void draw()
  {
    fill(80 + (pissedOff*175), 80, 80, 255);
    
    for (float i=0; i<PI*2; i+=0.05)
    {
      ellipse(pos.x + sin(i)*(20+noise(tShape)*(5+(pissedOff*8))), 
              pos.y + cos(i)*(20+noise(tShape)*(5+(pissedOff*8))), 2, 2);
              
      tShape += 0.2;
    }
  }
}
