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
  //image = loadImage("united-states-of-america-map-free-vector.jpg");
  image = loadImage("UsaMapGrey.png"); //This map is still a placeholder, but more appropriate for now.
  
  image.resize(2000,900);
  image(image,0,0);
  washington.draw();
  alabama.run();
  arizona.run();
  
  mouseReleased();
}
void mouseReleased()
{
  println(mouseX+ " "+mouseY);
}
