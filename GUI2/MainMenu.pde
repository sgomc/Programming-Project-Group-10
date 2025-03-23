class MainMenu extends Window {
  ArrayList<Button> buttons;
  State currentState;
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
    translate(x, y);

    fill(0);
    textSize(24);
    textAlign(LEFT, TOP);

    // Don't add x and y again - we've already translated
    if (currentState != null) {
      text("Main Menu - " + getStateName(currentState), 20, 40);
    } else {
      text("Main Menu", 20, 40);
    }

    for (Button btn : buttons) {
      btn.display();  // Buttons are also drawn relative to the translated coordinate system
    } //<>//

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
          departuresArrivals.isVisible = false;
          departuresArrivals.open();
          btn.wasClicked = false;
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

  void openForState(State state) {
    this.currentState = state;
    this.isVisible = true;

    // Reset all buttons' active state
    for (Button stateButton : stateButtons) {
      stateButton.setActive(false);  // Disable active state for all buttons
    }

    // Now, set the active state for the current state
    for (Button stateButton : stateButtons) {
      if (stateButton.state == currentState) {
        stateButton.setActive(true);  // Set the active button for the current state
      }
    }
    println("Main menu opened for state: " + getStateName(state));
  }
}
