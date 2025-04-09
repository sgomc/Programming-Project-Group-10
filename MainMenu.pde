class MainMenu extends Window { 
  Button button;
  State currentState;
  int tableBodyY = 180;
  int rowHeight = 50;
  int count = 0;
  int scrollY = 0;
  int maxScrollY = 0;
  int tableStartY = 0;
  float thumbHeight = 0;
  float thumbY = 0;
  int tableBodyHeight = 0;
  final int SCROLLBAR_WIDTH = 20;
  boolean isDraggingThumb = false;
  float lastMouseY = 0;
  float offsetY = 0;
  ArrayList<Airport> stateAirports = new ArrayList<>();
  ArrayList<Airport> originalAirports = new ArrayList<Airport>();
  MainMenu(int x, int y, int w, int h) {
    super(x, y, w, h);
    button = new Button(20, 80, 240, 40, "See Departures/Arrivals");
  }

  void display() {
    if (!isVisible) return;
    super.display();

    pushMatrix();
    translate(x, y);

    fill(240, 236, 255);  // Background
    rect(0, 0, w, h);

    fill(0);
    textSize(24);
    textFont(boldFont);
    textAlign(LEFT, TOP);

    if (currentState != null) {
      text("Main Menu - " + getStateName(currentState), 20, 40);
    } else {
      text("Main Menu", 20, 40);
    }

    int headerY = 140;
    textSize(26);
    text("State airports:", w/2-80, headerY + 15);
    textSize(24);
    text("Airport", 70, headerY + 60);
    text("City", w/2 - 40, headerY + 60);
    stroke(0);
    line(20, headerY + 90, w - 50, headerY + 90);

    int tableY = headerY + 70;
    tableBodyY = tableY + 40;
    tableBodyHeight = height - tableBodyY - 60;  // Ensure space for scroll

    maxScrollY = Math.max(0, stateAirports.size() * rowHeight - tableBodyHeight);
    scrollY = constrain(scrollY, 0, maxScrollY);
    float scrollOffset = scrollY % rowHeight;
    int airportsPerPage = tableBodyHeight / rowHeight;

    if (stateAirports.isEmpty()) {
      text("No airports available for this state.", 20, tableBodyY + 10);
    } else {
      // Scrollbar calculations
      if (stateAirports.size() > airportsPerPage) {
        thumbHeight = max(10, (tableBodyHeight * 0.5f * tableBodyHeight) / (stateAirports.size() * rowHeight));  // Reduced height
        thumbHeight = min(thumbHeight, tableBodyHeight);
        thumbY = tableBodyY + (tableBodyHeight - thumbHeight) * (float) scrollY / maxScrollY;
      }

      // Clip the table drawing area
      pushMatrix();
      clip(20, tableBodyY - 10, w - 40, tableBodyHeight);
      translate(0, -scrollY + scrollOffset);

      int startIndex = scrollY / rowHeight;
      int endIndex = min(stateAirports.size(), startIndex + airportsPerPage);

      for (int i = startIndex; i < endIndex; i++) {
        Airport airport = stateAirports.get(i);
        int yPos = tableBodyY + (i * rowHeight + 8) - 10;

        fill(0);
        textSize(22);
        textFont(font);


        text(airport.name, 80, yPos);
        text(airport.city, w/2-40, yPos);

        stroke(200);
        line(20, yPos + rowHeight - 18, w - 40, yPos + rowHeight - 18);
        noStroke();
      }

      popMatrix();
      noClip();
    }

    // Draw the scrollbar
    if (!stateAirports.isEmpty() && stateAirports.size() > airportsPerPage && !getStateName(currentState).equals("New York")) {
      int scrollBarX = w - SCROLLBAR_WIDTH - 10;  // Positioned at the right edge
      tableBodyY -=20;
      thumbY -= 20;
      tableBodyHeight -= 16;
      thumbHeight -= 16;
      int scrollTrackY = tableBodyY;

      fill(180);
      stroke(0);
      rect(scrollBarX, scrollTrackY, SCROLLBAR_WIDTH, tableBodyHeight);
      noStroke();

      fill(100);
      rect(scrollBarX, thumbY, SCROLLBAR_WIDTH, thumbHeight);
    }

    textFont(boldFont);
    button.display();
    closeButton.display();
    sortCitiesCheckBox.draw();
    if (sortCitiesCheckBox.isChecked) {
      sortCitiesAlphabetically();
    }

    popMatrix();
  }


  void checkButtonClick(int mx, int my) {
    if (!isVisible) return;

    // Adjust mouse coordinates to be relative to the menu
    int relativeX = mx - x;
    int relativeY = my - y;

    if (button.checkClick(relativeX, relativeY)) {
      // If Departures/Arrivals button is clicked, open that window
      departuresArrivals.isVisible = false;
      departuresArrivals.open();
      blockInteractions = true;
      button.wasClicked = false;
    }
  }
  void checkButtonHover(int mx, int my) {
    if (!isVisible) return;

    // Adjust mouse coordinates to be relative to the menu
    int relativeX = mx - x;
    int relativeY = my - y;

    button.checkHover(relativeX, relativeY);
  }

  void openForState(State state) {
    // Ensure that a state isn't set if one is already active
    if (this.currentState != null && this.currentState.equals(state)) {
      return;
    }

    // Set the new state
    this.currentState = state;
    sortCitiesCheckBox.isChecked = false;
    scrollY = 0;

    this.isVisible = true;
    stateAirports.clear(); // Clear any existing airports data
    originalAirports.clear();
    allFlightsRadio.isSelected = true;
    delayedFlightsRadio.isSelected = false;
    onTimeFlightsRadio.isSelected = false;

    // Reset all buttons' active state
    updateButtonStates();

    println("Main menu opened for state: " + getStateName(state));
  }

  private void updateButtonStates() {
    for (Button stateButton : stateButtons) {
      stateButton.setActive(stateButton.state == currentState);
    }
  }

  ArrayList<Airport> getAirportsForCurrentState() {
    stateAirports.clear(); // Clear old data
    if (currentState != null) {
      String stateAbbreviation = getStateAbbreviation(currentState);
      for (Airport airport : airports) {
        if (airport.state.equals(stateAbbreviation) && !stateAirports.contains(airport)) {
          stateAirports.add(airport);
          count++;
        }
      }
    } else {
      println("Current state is null.");
    }
    println(count);
    return stateAirports;
  }

  // Handle mouse wheel to adjust scroll position
  void mouseWheel(MouseEvent event) {
    if (isVisible && isMouseOver()) {
      float e = event.getCount();
      scrollY = constrain(scrollY + (int)(e * rowHeight), 0, maxScrollY);
    }
  }

  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }


  void mousePressed(int mx, int my) {
    if (!isVisible) return;

    // Convert to coordinates relative to the menu
    int relativeX = mx - x;
    int relativeY = my - y;

    if (sortCitiesCheckBox.checkClick(relativeX, relativeY)) {
      println("Sort cities alphabetically: " + sortCitiesCheckBox.isChecked);
      sortCitiesAlphabetically();
    }

    int scrollBarX = w - SCROLLBAR_WIDTH - 10;

    if (relativeX >= scrollBarX && relativeX <= scrollBarX + SCROLLBAR_WIDTH &&
      relativeY >= tableBodyY && relativeY <= tableBodyY + tableBodyHeight) {

      // Calculate the current thumb position
      thumbY = tableBodyY + (tableBodyHeight - thumbHeight) * (float)scrollY / maxScrollY;

      if (relativeY >= thumbY && relativeY <= thumbY + thumbHeight) {
        isDraggingThumb = true;
        // Store the offset between mouse and top of thumb
        offsetY = relativeY - thumbY;
      } else {
        // Clicked on track but not on thumb - jump to that position
        float clickPos = (relativeY - tableBodyY) / (float)tableBodyHeight;
        scrollY = (int)(clickPos * maxScrollY);
        scrollY = constrain(scrollY, 0, maxScrollY);
      }
    }
  }

  void mouseDragged(int my) {
    if (isDraggingThumb) {
      // Adjust for menu position
      int relativeY = my - y;

      // Calculate new thumb position
      float newThumbY = relativeY - offsetY;

      // Calculate what percentage of the scrollbar we've moved
      float scrollPercentage = (newThumbY - tableBodyY) / (float)(tableBodyHeight - thumbHeight);

      // Update scroll position
      scrollY = (int)(scrollPercentage * maxScrollY);
      scrollY = constrain(scrollY, 0, maxScrollY);
    }
  }

  void mouseReleased() {
    isDraggingThumb = false;
  }


  // Modify your sortCitiesAlphabetically method to handle both sorting and restoring
  void sortCitiesAlphabetically() {
    if (sortCitiesCheckBox.isChecked) {
      // Save original order if we haven't already
      if (originalAirports.isEmpty()) {
        originalAirports.clear();
        originalAirports.addAll(stateAirports); // Store the current order
      }

      // Sort alphabetically by city
      stateAirports.sort((airport1, airport2) -> airport1.city.compareTo(airport2.city));
      println("Cities sorted alphabetically");
    } else {
      // Restore original order
      if (!originalAirports.isEmpty()) {
        stateAirports.clear();
        stateAirports.addAll(originalAirports);
        println("Original city order restored");
      }
    }
  }

void checkClose(int mx, int my) {
    if (!isVisible) return;

    // Adjust mouse coordinates to be relative to the window
    int relativeX = mx - x;
    int relativeY = my - y;

    if (closeButton.checkClick(relativeX, relativeY)) {
      isVisible = false;
      this.currentState = null;
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
}
