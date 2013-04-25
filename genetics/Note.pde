class Note extends Thread
{
  int noteVal;
  int volume;
  int channel;
  int timeMs;
  
  public Note(int val, int vol, int chan, int t)
  {
    noteVal = val;
    volume = vol;
    channel = chan;
    timeMs = t;
  }
  
  public void run()
  {
    playNote();
    
    try {
    Thread.sleep(timeMs);
    }
    catch (Exception e){
    }
    
    stopNote();
  }
  
  private void play()
  {
    start();
  }
  
  private void playNote()
  {
    myBus.sendNoteOn(channel, noteVal, volume);
  }
  
  private void stopNote()
  {
    myBus.sendNoteOff(channel, noteVal, volume);
  }
  
  
  
}

