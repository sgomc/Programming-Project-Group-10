PImage image;
City washington = new City();
void setup()
{
  size(2000,900);
  
  
}

void draw()
{
  image = loadImage("united-states-of-america-map-free-vector.jpg");
  
  image.resize(2000,900);
  image(image,0,0);
  washington.draw();
  
  mouseReleased();
}
void mouseReleased()
{
  println(mouseX+ " "+mouseY);
}
