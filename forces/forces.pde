
ArrayList<Particle> particles = new ArrayList();
ArrayList<Emitter> emitters = new ArrayList();
ArrayList<BlowerForce> blowers = new ArrayList();

PVector gravity = new PVector(0, 0.5);

String drawMode = "emitter";
PVector click1, click2;
boolean drag = false;

PFont font = createFont("Monospaced-12.vlw", 12);

PGraphics buf;
PImage img;

void setup()
{
  colorMode(HSB, 360, 100, 100, 255);
  size(600, 400);
  smooth();
  
  buf = createGraphics(width, height);
  clearTrails();
  
  background(0);
  frameRate(30);
}

void clearTrails()
{
  buf.beginDraw();
  buf.smooth();
  buf.background(0);
  buf.strokeWeight(1);
  buf.stroke(255, 255, 255, 10);
  buf.textFont(font);
  buf.text("'e' - draw emitter mode (click&drag to draw)", 10, 20);
  buf.text("'w' - draw wind mode (click&drag to draw)", 10, 32);
  buf.text("'c' - clear forces", 10, 44);
  buf.text("'q' - clear particle trails", 10, 56);
  buf.endDraw();
}

void draw()
{
  /* draw the particles paths image */
  image(buf, 0, 0);

  /* draw the emitters and make them emit particles */
  for (int i=0; i<emitters.size(); i++)
  {
    Emitter e = emitters.get(i);
    e.draw();
    
    /* emit particle */
    Particle p = e.emit();
    if (p != null)
      particles.add(p);
  }
  
  /* draw the blowers */
  for (int i=0; i<blowers.size(); i++)
  {
    BlowerForce bf = blowers.get(i);
    bf.draw();
  }
  
  /* update and draw particles */
  int i=0;
  while (i<particles.size())
  {
    Particle p = particles.get(i);
    
    /* apply gravity force on the particle */
    p.applyForce(PVector.mult(gravity, p.mass));
    
    /* apply blower forces on the particle */
    for (int j=0; j<blowers.size(); j++)
    {
      BlowerForce bf = blowers.get(j);
      p.applyForce(bf.getForce(p.pos));
    }
    
    /* update the particle position */
    p.update();
    
    /* draw the particle on screen and its path on the off-screen buffer */
    buf.beginDraw();
    p.draw(buf);
    buf.endDraw();
    
    /* if the particle is off screen remove it from the list */
    if (!p.isAlive())
          particles.remove(i);
    else
          i++;
  }

  /* draw drag line */  
  if (drag)
  {
    strokeWeight(1);
    
    if (drawMode == "emitter")
          stroke(255, 255, 255, 255);
    if (drawMode == "wind") {
          stroke(200, 100, 80, 255);
          noFill();
          float size = sqrt(pow(mouseX-click1.x, 2) + pow(mouseY-click1.y, 2));
          ellipse(click1.x, click1.y, size*2, size*2);
    }
    
    line(click1.x, click1.y, mouseX, mouseY);
  }

}


void keyPressed()
{
  if (key == 'e')
        drawMode = "emitter";
  else if (key == 'w')
        drawMode = "wind";
  else if (key == 'c')
  {
        blowers.clear();
        emitters.clear();
  }
  else if (key == 'q')
  {
    clearTrails();
  }
}

void mousePressed()
{
  click1 = new PVector(mouseX, mouseY);
  drag = true;
}

void mouseReleased()
{
  if (drag)
  {
    click2 = new PVector(mouseX, mouseY);
    drag = false;
    
    if (drawMode == "emitter")
          emitters.add(new Emitter(click1.get(), PVector.sub(click2, click1)));
    else if (drawMode == "wind")
          blowers.add(new BlowerForce(click1.get(), PVector.sub(click2, click1)));
  }
}
