import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioOutput out;

SignalGenerator gen;

void setup()
{
  size(400, 400);
  smooth();
  
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO, 2048);
  
  gen = new SignalGenerator();  
  out.addSignal(gen);
}

void draw()
{
  background(0);
  
  gen.setVal((int)map(mouseY, 0, height, 256, 4));
}

void stop()
{
  out.close();
  minim.stop();
  
  super.stop();
}


