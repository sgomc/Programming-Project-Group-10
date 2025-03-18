  class MainMenu extends Window {
    ArrayList<Button> buttons;
    MainMenu(int x, int y, int w, int h) {
      super(x, y, w, h);
      buttons = new ArrayList<Button>();
      
      // Add "Departures/Arrivals" button to the menu
      // Position it within the menu window (using relative coordinates)
      buttons.add(new Button(30, 110, 200, 40, "Departures/Arrivals"));
    }
  
    void display() {
      if (!isVisible) return;
      super.display();
      
      pushMatrix();
      translate(x, y);  // Move the coordinate system to the menu's position
      
      fill(0);
      textSize(18);
      textAlign(LEFT, TOP);
      text("Main Menu", 20, 60);  // Now relative to the menu window
      
      for (Button btn : buttons) {
        btn.display();  // Buttons are also drawn relative to the translated coordinate system
      }
      
      popMatrix();  // Restore original coordinates
   }

    
    void checkButtonClick(int mx, int my) {
      if (!isVisible) return;
      
      // Adjust mouse coordinates to be relative to the menu
      int relativeX = mx - x;
      int relativeY = my - y;
      
      for (Button btn : buttons) {
        if (btn.checkClick(relativeX, relativeY)) {
          // If Departures/Arrivals button is clicked, open that window
          if (btn.label.equals("Departures/Arrivals")) {
            departuresArrivals.open();
          }
          return;
        }
      }
    }
    void checkButtonHover(int mx, int my) {
      if (!isVisible) return;
      
      // Adjust mouse coordinates to be relative to the menu
      int relativeX = mx - x;
      int relativeY = my - y;
      
      for (Button btn : buttons) {
        btn.checkHover(relativeX, relativeY);
      }
    }
  }
