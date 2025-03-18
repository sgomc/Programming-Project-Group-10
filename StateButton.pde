class Button
{
  float x, y;
  float xSize, ySize;
  String text;
  color textColor;
  State state;
  
  Button(State state)
  {
    this.state = state;
    x = getStateX(state);
    y = getStateY(state);
    text = getStateName(state);
    xSize = BUTTON_TEXT_SIZE*text.length()/1.8;
    ySize = BUTTON_TEXT_SIZE;
    textColor = DEFAULT_TEXT_COLOR;
  }
  
  
  void run()
  {
    display();
    mouseCollisionHighlight();
    mouseCollisionPress();
    
  }
  
  void display()
  { 
    textSize(BUTTON_TEXT_SIZE);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    fill(textColor);
    text(text, x, y, xSize, ySize);
    
    
  }
  
  void changeTextColor(color c)
  {
    textColor = c;
  }
  
  void mouseCollisionHighlight()
  {
    changeTextColor(mouseWithinHitbox()? HIGHLIGHTED_TEXT_COLOR :DEFAULT_TEXT_COLOR);
  }
  
  void mouseCollisionPress()
  {
    if(mouseWithinHitbox() && mousePressed)
    {
      println("Menu Opened"); //Add whatever here to open up the state menu
    }
  }
  
  boolean mouseWithinHitbox()
  {
    if(mouseX>x-xSize/2 && mouseX<x+xSize/2 && mouseY>y-ySize/2 && mouseY<y+ySize/2) //Rectangular collision box
    {
      return true;
    }
    else return false;
  }
  
  
}
