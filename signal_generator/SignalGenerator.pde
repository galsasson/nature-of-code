
class SignalGenerator implements AudioSignal
{
  int val;
  int counter;
  
  public SignalGenerator()
  {
    val = 64;
    counter = 0;
  }

  void setVal(int v)
  {
    val = v;
    counter=0;
  }
  
  void generate(float[] samp)
  {
    float t=random(100000);
    for (int i=0; i<samp.length; i++)
    {
      samp[i] = ((counter/val)%2 == 0) ? 0.4 : -0.4 + (noise(t)-0.5)*0.7;
      counter++;
      t+=0.1;
    }
  }

  // this is a stricly mono signal
  void generate(float[] left, float[] right)
  {
    generate(left);
    generate(right);
  }
}
