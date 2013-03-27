class ChatWindow
{
  String currentText;
  PFont font;
  
  float tw;
  int cursorCounter = 0;
  
  public ChatWindow()
  {
    currentText = "";
    font = loadFont("Osaka-18.vlw");
    textFont(font, 18);
    cursorCounter = 0;
    tw = 0;
  }
  
  public void handleChar(char c)
  {
    if ((c >= 32 && key <= 126))
      addChar(c);
    else if (keyCode == BACKSPACE)
      deleteChar();
  }
  
  public String getString()
  {
    return currentText;
  }
  
  public void emptyString()
  {
    currentText = "";
    tw = textWidth(currentText);
  }
  
  public void addChar(char c)
  {
    currentText = currentText + c;
    tw = textWidth(currentText);
  }
  
  public void deleteChar()
  {
    if (currentText.length() > 0)
      currentText = currentText.substring(0, currentText.length()-1);
    tw = textWidth(currentText);
  }
  
  public void update()
  {
    cursorCounter++;
    
    if (cursorCounter > 60)
      cursorCounter = 0;
  }
  
  public void display(float x, float y)
  {
    
    pushMatrix();
    translate(x, y);
    
    textFont(font, 18);
    strokeWeight(2);
    stroke(0, 0, 100, 80);
    fill(0, 0, 100, 20);
    
    rect(0, -25, width, 23, 5, 5, 5, 5);
    fill(250);
    text(currentText, 5, -7);
    
    /* draw cursor */
    if (cursorCounter < 30)
      line (tw+7, -20, tw+7, -6);
      
    popMatrix();
  }
}
