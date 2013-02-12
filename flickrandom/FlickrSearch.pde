/**********************/
/* FlickrSearch class */
/**********************/

class FlickrSearch
{
  String searchStr;
  XML response;
  XML[] photo;
  
  public FlickrSearch(String search)
  {
    searchStr = search;
    
  }
  
  public boolean execute()
  {
    response = loadXML("http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=0e4c79df3bf440a41ce99f74c51f77c6&text="+searchStr);
    //print(response);
    
    /* check response status */
    String status = response.getString("stat");
    if (!status.equals("ok"))
        return false;
        
    XML photos = response.getChild("photos");
    if (photos == null)
        return false;
        
    photo = photos.getChildren("photo"); 

    return true; 
  }
  
  PImage getImage(int index)
  {
    if (index > photo.length)
        return null;
    
    String farm = photo[index].getString("farm");
    String server = photo[index].getString("server");
    String id = photo[index].getString("id");
    String secret = photo[index].getString("secret");
    
    PImage image = loadImage("http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg");
    
    return image;
  }
  
  
}
