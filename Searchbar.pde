class Searchbar
{
  int x, y, w, h;
  SearchbarType searchbarType;
  String searchbarText = "";
  boolean active = false;
  color clickedColor = color(200, 220, 255); // Color when clicked
  color defaultColor = color(255);
  int textSize = 20;
  DeparturesArrivals departuresArrivals;

  Searchbar(int x, int y, int w, int h, SearchbarType searchbarType, DeparturesArrivals departuresArrivals)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.searchbarType = searchbarType;
    this.departuresArrivals = departuresArrivals;
  }

  String getPreText()
  {
    switch(searchbarType)
    {
    case SEARCHBAR_FLIGHT_NUMBER:
      return "Search Flight:";
    case SEARCHBAR_DATE:
      return "Select Date:";
    default:
      return "Type:";
    }
  }

  void display()
  {
    fill(0);
    textAlign(LEFT, TOP);
    textSize(textSize);
    text(getPreText(), x-132, y+5);
    stroke(0);
    fill(active? clickedColor : defaultColor);
    rect(x, y, 200, 25);
    fill(0);
    text(searchbarText, x, y+5);
  }

  void setActive(boolean active)
  {
    this.active = active;
  }

  boolean getActive()
  {
    return active;
  }

  boolean mouseWithinHitbox()
  {
    return (mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h) ? true : false;
  }

  void addCharacter(char c)
  {
    if (checkCharLegal(c)) searchbarText += c;
    doStringConversions();
  }
  boolean checkCharLegal(char c)
  {
    if (searchbarText.length()*textSize > w*1.8) return false;
    switch(searchbarType)
    {
    case SEARCHBAR_FLIGHT_NUMBER:
      if (!Character.isDigit(c)) return false;
      break;
    case SEARCHBAR_DATE:
      break;
    }
    return true;
  }

  void deleteLastCharacter()
  {
    if (searchbarText.length() == 0) return;
    searchbarText = searchbarText.substring(0, searchbarText.length() - 1);
  }

  SearchbarType getSearchbarType()
  {
    return searchbarType;
  }

  boolean isEmpty()
  {
    return searchbarText.length()==0 ? true : false;
  }

  String getText()
  {
    return searchbarText;
  }

  void doStringConversions()
  {
    switch(searchbarType)
    {
    case SEARCHBAR_FLIGHT_NUMBER:
      break;
    case SEARCHBAR_DATE:
      searchbarText = searchbarText.replace(" ", "/");
      searchbarText = searchbarText.replace("jan", "1");
      searchbarText = searchbarText.replace("feb", "2");
      searchbarText = searchbarText.replace("mar", "3");
      searchbarText = searchbarText.replace("apr", "4");
      searchbarText = searchbarText.replace("may", "5");
      searchbarText = searchbarText.replace("jun", "6");
      searchbarText = searchbarText.replace("jul", "7");
      searchbarText = searchbarText.replace("aug", "8");
      searchbarText = searchbarText.replace("sep", "9");
      searchbarText = searchbarText.replace("oct", "10");
      searchbarText = searchbarText.replace("nov", "11");
      searchbarText = searchbarText.replace("dec", "12");
      searchbarText = searchbarText.replace("Jan", "1");
      searchbarText = searchbarText.replace("Feb", "2");
      searchbarText = searchbarText.replace("Mar", "3");
      searchbarText = searchbarText.replace("Apr", "4");
      searchbarText = searchbarText.replace("May", "5");
      searchbarText = searchbarText.replace("Jun", "6");
      searchbarText = searchbarText.replace("Jul", "7");
      searchbarText = searchbarText.replace("Aug", "8");
      searchbarText = searchbarText.replace("Sep", "9");
      searchbarText = searchbarText.replace("Oct", "10");
      searchbarText = searchbarText.replace("Nov", "11");
      searchbarText = searchbarText.replace("Dec", "12");
      break;
    }
  }
}
