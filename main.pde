PImage image;
City washington = new City(1,2);
void setup()
{
  size(2000,1000);
  
  
}

void draw()
{
  image = loadImage("united-states-of-america-map-free-vector.jpg");
  
  image.resize(2000,1000);
  image(image,0,0);
  washington.draw();
  
  mouseReleased();
}
void mouseReleased()
{
  println(mouseX+ " "+mouseY);
}
