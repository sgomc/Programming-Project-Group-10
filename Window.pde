class Window {
  int x, y, w, h;
  boolean isVisible = true;
  Button closeButton;
  State currentState;

  Window(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    // Create a close button at the top-right corner of the window
    closeButton = new Button(w - 35, 5, 30, 30, "X");

    // Custom styling for close button
    closeButton.hasBackground = false; // No background when not hovered
    closeButton.hoverColor = color(255, 0, 0); // Red when hovered
    closeButton.textColor = color(0); // Black X
    closeButton.hoverTextColor = color(255); // White X when hovered
  }

  void display() {
    if (!isVisible) return;

    fill(240);
    stroke(0);
    rect(x, y, w, h);

    // Draw the close button relative to the window
    pushMatrix();
    translate(x, y);
    closeButton.display();
    popMatrix();
  }

  void checkClose(int mx, int my) {
    if (!isVisible) return;

    // Adjust mouse coordinates to be relative to the window
    int relativeX = mx - x;
    int relativeY = my - y;

    if (closeButton.checkClick(relativeX, relativeY)) {
      isVisible = false;
      sortCitiesCheckBox.isChecked = false;
      closeButton.wasClicked = false;
      for (Button stateButton : stateButtons) {
        stateButton.setActive(false);  // Set the active button for the current state
      }
      for (Searchbar s : searchbars) {
        s.setActive(false);
        s.searchbarText = ""; // Clear the search text
      }
    }
  }

  void checkHover(int mx, int my) {
    if (!isVisible) return;

    int relativeX = mx - x;
    int relativeY = my - y;

    closeButton.checkHover(relativeX, relativeY);
  }

  void open() {
    isVisible = true;
    closeButton.wasClicked = false;
  }
}
