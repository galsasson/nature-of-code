import processing.opengl.*;

ArrayList<Block> blocks;
Camera cam;

void setup()
{
  size(600, 600, OPENGL);
  frameRate(30);

  cam = new Camera(1000, 1000, 200, 0, 0, 0);  
  blocks = new ArrayList<Block>();
  
  for (int i=0; i<10; i++)
  {
    for (int j=0; j<10; j++)
    {
      for (int k=0; k<10; k++)
      {
        blocks.add(new Block(k*10, j*10, i*10)); 
      }
    }
  }
}



void draw()
{
  background(255);
  fill(255);
  
  cam.pos.x = ((float)mouseX/width)*2000;
  cam.pos.y = ((float)mouseY/height)*2000;
//  cam.pos.x -= 5;
  cam.draw();
  
  strokeWeight(1);
  stroke(0);
  for (int i=0; i<blocks.size(); i++)
  {
    blocks.get(i).update();
    blocks.get(i).draw();
  }
  
  
  drawAxis();
}

void drawAxis()
{
  // x - red
  // y - gree
  // z - blue
  strokeWeight(3);
  stroke(255, 0, 0);
  line(-500, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -500, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -500, 0, 0, 1000); 
}
