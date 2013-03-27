
class WordSpace
{
  ArrayList<ChunkOfWords> words;
  PFont font;
 
  public WordSpace(PFont f)
  {
    font = f;
    words = new ArrayList<ChunkOfWords>();
  }
  
  public void addWord(ChunkOfWords word)
  {
    words.add(word);
  }
  
  public void display(PVector p, float radius)
  {
    textFont(font, 16);

    for (int i=0; i<words.size(); i++)
    {
      ChunkOfWords chunk = (ChunkOfWords)words.get(i);
      if (chunk.pos.dist(p) < radius)
        words.get(i).display();
    }
  }
}

