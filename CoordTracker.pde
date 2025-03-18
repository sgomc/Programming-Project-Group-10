void displayCoords() //Coord tracker shouldn't be displayed in the real project, it's for debug purposes only.
{
  textSize(50);
  float x = (float)mouseX/width;
  float y = (float)mouseY/height;
  textAlign(RIGHT, CENTER);
  text("x: "+x+" y: "+y, 500, height-100, 500, 100);
  
  
}
