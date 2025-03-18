PImage image;
City washington = new City();
Button alabama, arizona;
void setup()
{
  size(2000,900);
  alabama = new Button(State.ALABAMA);
  arizona = new Button(State.ARIZONA);
  
}

void draw()
{
  background(50);
  //image = loadImage("united-states-of-america-map-free-vector.jpg");
  image = loadImage("UsaMapGrey.png"); //This map is still a placeholder, but more appropriate for now.
  
  image.resize(2000,900);
  image(image,0,0);
  washington.draw();
  alabama.run();
  arizona.run();

  //DEBUG ONLY - DON'T DISPLAY IN ACTUAL PROJECT
  displayCoords();
  
  mouseReleased();
}
void mouseReleased()
{
  println(mouseX+ " "+mouseY);
}
