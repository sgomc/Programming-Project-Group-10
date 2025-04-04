class DeparturesArrivals extends Window {
  String selectedTab = "Departures";
  Tab departuresTab, arrivalsTab;
  String selectedDate= "";

  State currentState;
  String delayFilter = "All"; // "All", "Delayed", "OnTime"

  int scrollY = 0;
  int maxScrollY = 0;
  int rowHeight = 50;
  int flightsPerPage = 0;
  int tableStartY = 170;
  float thumbHeight = 0;
  float thumbY = 0;
  int tableBodyHeight = 0;
  int tableBodyY = 0;
  final int SCROLLBAR_WIDTH = 20;
  boolean isDraggingThumb = false;
  float lastMouseY = 0;
  float offsetY = 0;
  String searchbar = "";

  final int TIME_COLUMN_X = 690;
  final int TIME_SPACING = 30;
  final int MAX_TIME_WIDTH = 80;

  final int DATE_COLUMN_X_NORMAL = 820; // Normal position
  final int DATE_COLUMN_X_DELAYED = 910; // Position when showing delayed flights

  DeparturesArrivals(int x, int y, int w, int h) {
    super(x, y, w, h);
    departuresTab = new Tab(x + 20, y + 10, 150, 40, "Departures", selectedTab.equals("Departures"));
    arrivalsTab = new Tab(x + 180, y + 10, 150, 40, "Arrivals", selectedTab.equals("Arrivals"));

    allFlightsRadio = new RadioButton(x + 200, y + 130, 120, 20, "All Flights", delayFilter.equals("All"));
    delayedFlightsRadio = new RadioButton(x + 370, y + 130, 120, 20, "Delayed Only", delayFilter.equals("Delayed"));
    onTimeFlightsRadio = new RadioButton(x + 540, y + 130, 120, 20, "On Time Only", delayFilter.equals("OnTime"));

    flights.clear();
    flightsPerPage = (h - tableStartY - 30) / rowHeight;
    searchbars.add(new Searchbar(150+x, 65+y, 200, 25, SearchbarType.SEARCHBAR_FLIGHT_NUMBER, this));
    searchbars.add(new Searchbar(150+x, 95+y, 200, 25, SearchbarType.SEARCHBAR_DATE, this));
  }

  void display() {
    if (!isVisible) return;
    super.display();
    departuresTab.checkHover(mouseX, mouseY);
    arrivalsTab.checkHover(mouseX, mouseY);

    pushMatrix();
    translate(x, y);  // Move the coordinate system to the window's position


    fill(240, 236, 255);
    rect(0, 0, w, h);
    popMatrix();

    textSize(20);
    allFlightsRadio.draw();
    delayedFlightsRadio.draw();
    onTimeFlightsRadio.draw();

    pushMatrix();
    translate(x, y);

    fill(0);
    textFont(boldFont);
    textSize(20);

    textAlign(LEFT, TOP);  // Ensures text is aligned properly

    int headerY = 130;
    text(selectedTab + " List:", 20, headerY);

    // Display column headers
    int tableY = headerY + 30;
    text("Flight #", 20, tableY);
    if (selectedTab.equals("Departures")) {
      text("Destination", 120, tableY);
      text("Origin airport", 410, tableY);
      if (delayFilter.equals("Delayed")) {
        text("Scheduled → Actual", TIME_COLUMN_X, tableY);
      } else {
        text("Dep Time", TIME_COLUMN_X, tableY);
      }
    } else {
      text("Origin", 120, tableY);
      text("Arrival airport", 410, tableY);
      if (delayFilter.equals("Delayed")) {
        text("Scheduled → Actual", TIME_COLUMN_X, tableY);
      } else {
        text("Arrival Time", TIME_COLUMN_X, tableY);
      }
    }
    int dateColumnX = delayFilter.equals("Delayed") ? DATE_COLUMN_X_DELAYED : DATE_COLUMN_X_NORMAL;
    text("Date", dateColumnX, tableY);

    // Draw a line under the headers
    stroke(0);
    line(20, tableY + 31, 960, tableY + 31);
    noStroke();

    tableBodyY = tableY + 40;
    tableBodyHeight = flightsPerPage * rowHeight;

    //This updates maxScrollY based on number of flights
    maxScrollY = Math.max(0, flights.size() * rowHeight - tableBodyHeight);


    //set a range for srcollY
    scrollY = constrain(scrollY, 0, maxScrollY);
    float scrollOffset = scrollY % rowHeight;

    // Display flights or a message if none
    if (flights.isEmpty()) {
      boolean searchbarEmpty = true;
      boolean dateSearchUsed = false;

      for (Searchbar s : searchbars) {
        if (s.getSearchbarType() == SearchbarType.SEARCHBAR_FLIGHT_NUMBER && !s.isEmpty()) {
          searchbarEmpty = false; // Flight number entered
        }
        if (s.getSearchbarType() == SearchbarType.SEARCHBAR_DATE && !s.isEmpty()) {
          searchbarEmpty = false; // Date entered
          dateSearchUsed = true;
        }
      }

      if (searchbarEmpty) {
        text("Enter a flight number or date to search.", 20, tableBodyY + 10);
      } else if (dateSearchUsed) {
        text("No flights found for this date.", 20, tableBodyY + 10);
      } else {
        text("No flights found matching your search.", 20, tableBodyY + 10);
      }
    } else {
      if (flights.size() > flightsPerPage) {
        thumbHeight = tableBodyHeight * (float)tableBodyHeight / (flights.size() * rowHeight);
        thumbHeight = max(20, thumbHeight); //the min size for the thumb

        if (maxScrollY > 0) {  // Prevent division by zero
          thumbY = tableBodyY + (tableBodyHeight - thumbHeight) * ((float)scrollY / maxScrollY);
        } else {
          thumbY = tableBodyY;
        }
      }

      // Apply clipping to the table body area
      pushMatrix();
      clip(20, tableBodyY, width - 40, tableBodyHeight);
      translate(0, -(scrollY - scrollOffset)); // Apply scroll offset
      // Display flights with scrolling
      int startIndex = max(0, scrollY / rowHeight);
      int endIndex = min(flights.size(), startIndex + flightsPerPage);

      for (int i = startIndex; i < endIndex; i++) {
        Flight flight = flights.get(i);
        int yPos = tableBodyY + (i * rowHeight + 8);

        // Display each flight information in columns
        fill(0);
        textFont(font);
        textSize(18);

        text(flight.flightNumber, 20, yPos);
        String locationInfo;
        if (selectedTab.equals("Departures")) {
          locationInfo = flight.destCity ;
          text(flight.originCity, 410, yPos);
        } else {
          locationInfo = flight.originCity;
          text(flight.destCity, 410, yPos);
        }
        text(locationInfo, 120, yPos);

        // Time information
        if (delayFilter.equals("Delayed")) {
          // For delayed flights, show both scheduled and actual times
          String scheduledTime = selectedTab.equals("Departures") ?
            flight.formatTime(flight.CRS_DEP_TIME) :
            flight.formatTime(flight.CRS_ARR_TIME);
          String actualTime = selectedTab.equals("Departures") ?
            flight.formatTime(flight.DEP_TIME) :
            flight.formatTime(flight.ARR_TIME);

          float scheduledWidth = textWidth(scheduledTime);

          fill(150);
          text(scheduledTime, TIME_COLUMN_X, yPos);

          // Draw strikethrough line
          stroke(150);
          line(TIME_COLUMN_X, yPos + 5, TIME_COLUMN_X + scheduledWidth, yPos + 5);
          noStroke();

          // Show actual time in red
          fill(255, 0, 0);
          text(actualTime, TIME_COLUMN_X + scheduledWidth + TIME_SPACING, yPos);
          fill(0); // Reset to black
        } else {
          // Normal display - scheduled flights CRS
          String time = selectedTab.equals("Departures") ?
            flight.formatTime(selectedTab.equals("Departures") ? flight.CRS_DEP_TIME : flight.CRS_ARR_TIME) :
            flight.formatTime(selectedTab.equals("Arrivals") ? flight.CRS_ARR_TIME : flight.CRS_DEP_TIME);
          text(time, TIME_COLUMN_X, yPos);
        }

        // Date
        text(flight.date, dateColumnX, yPos);

        // Draw a light separator line between flights
        stroke(200);
        line(20, yPos + rowHeight- 18, 2 * width / 3 - 238, yPos + rowHeight - 18);
        noStroke();
      }

      popMatrix();
      noClip();
    }
    closeButton.display();

    popMatrix();
    for (Searchbar s : searchbars)
    {
      textFont(font);
      s.display();
    }
    // scroll bar
    if (!flights.isEmpty() && flights.size() > flightsPerPage) {
      int scrollBarX = 2 * width / 3 - 130;
      int scrollTrackY = tableBodyY;

      fill(180);
      stroke(0);
      rect(scrollBarX, scrollTrackY + 90, SCROLLBAR_WIDTH, tableBodyHeight);
      noStroke();

      fill(100);
      rect(scrollBarX, thumbY + 90, SCROLLBAR_WIDTH, thumbHeight);
    }
    textFont(boldFont);
    noStroke();
    departuresTab.draw();
    arrivalsTab.draw();
  }


  void checkTabClick(int mx, int my) {
    if (!isVisible) return;

    if (departuresTab.isClicked(mx, my)) {
      selectedTab = "Departures";
      delayFilter = "All"; // Reset filter to "All Flights"
      allFlightsRadio.isSelected = true;
      delayedFlightsRadio.isSelected = false;
      onTimeFlightsRadio.isSelected = false;
    } else if (arrivalsTab.isClicked(mx, my)) {
      selectedTab = "Arrivals";
      delayFilter = "All"; // Reset filter to "All Flights"
      allFlightsRadio.isSelected = true;
      delayedFlightsRadio.isSelected = false;
      onTimeFlightsRadio.isSelected = false;
    }

    // Update selected tab's state
    departuresTab.isSelected = selectedTab.equals("Departures");
    arrivalsTab.isSelected = selectedTab.equals("Arrivals");
    filterFlights();
    scrollY = 0; // -> reset scroll position when changing tabs
  }

  boolean isFlightDelayed(Flight flight) {
    try {
      if (selectedTab.equals("Departures")) {
        // For departures, compare scheduled vs actual departure time
        int scheduled = Integer.parseInt(flight.CRS_DEP_TIME);
        int actual = Integer.parseInt(flight.DEP_TIME);
        return actual > scheduled; // Delayed if actual > scheduled
      } else {
        // For arrivals, compare scheduled vs actual arrival time
        int scheduled = Integer.parseInt(flight.CRS_ARR_TIME);
        int actual = Integer.parseInt(flight.ARR_TIME);
        return actual > scheduled; // Delayed if actual > scheduled
      }
    }
    catch (NumberFormatException e) {
      return false;
    }
  }

  void checkRadioButtonClick(int mx, int my) {
    if (!isVisible) return;

    if (allFlightsRadio.isClicked(mx, my)) {
      delayFilter = "All";
      allFlightsRadio.isSelected = true;
      delayedFlightsRadio.isSelected = false;
      onTimeFlightsRadio.isSelected = false;
      filterFlights();
    } else if (delayedFlightsRadio.isClicked(mx, my)) {
      delayFilter = "Delayed";
      allFlightsRadio.isSelected = false;
      delayedFlightsRadio.isSelected = true;
      onTimeFlightsRadio.isSelected = false;
      filterFlights();
    } else if (onTimeFlightsRadio.isClicked(mx, my)) {
      delayFilter = "OnTime";
      allFlightsRadio.isSelected = false;
      delayedFlightsRadio.isSelected = false;
      onTimeFlightsRadio.isSelected = true;
      filterFlights();
    }
  }

  void keyPressed() {
    if (key == BACKSPACE) {
      for (Searchbar s : searchbars)
      {
        if (s.getActive())
        {
          s.deleteLastCharacter();
          filterFlights();
        }
      }
    } else if (key == ENTER) {
      filterFlights();
    } else if (key == CODED) {
      scrollY += rowHeight;
    } else if (key != CODED && key != BACKSPACE && key != ENTER) {

      for (Searchbar s : searchbars)
      {
        if (s.getActive())
        {
          s.addCharacter(key);
          filterFlights();
        }
      }
    }
  }

  void filterFlights()
  {
    ArrayList<Flight> filtered = new ArrayList<Flight>();
    ArrayList<Flight> stateFlights;
    // Only filter if we have a search term
    if (currentState == null) {
      println("No state selected. Cannot filter flights.");
      return;
    }
    if (selectedTab.equals("Departures")) {
      stateFlights = departuresByState.get(getStateAbbreviation(currentState));
    } else {
      stateFlights = arrivalsByState.get(getStateAbbreviation(currentState));
    }

    int totalFlights = stateFlights.size();
    int processedCount = 0;

    for (Flight flight : stateFlights) {
      processedCount++;
      if (processedCount % 1000 == 0) {
        println("Processed " + processedCount + " out of " + totalFlights + " flights");
      }

      boolean matchesSearch = false;
      boolean matchesDate = false;
      for (Searchbar s : searchbars) {
        if (s.getSearchbarType() == SearchbarType.SEARCHBAR_FLIGHT_NUMBER)
          matchesSearch = flight.flightNumber.toLowerCase().contains(s.getText().toLowerCase());
        if (s.getSearchbarType() == SearchbarType.SEARCHBAR_DATE)
          matchesDate = s.isEmpty() || flight.date.toLowerCase().contains(s.getText().toLowerCase());
      }

      boolean matchesDelayFilter = true;
      if (!delayFilter.equals("All")) {
        boolean isDelayed = isFlightDelayed(flight);
        if (delayFilter.equals("Delayed")) {
          matchesDelayFilter = isDelayed;
        } else if (delayFilter.equals("OnTime")) {
          matchesDelayFilter = !isDelayed;
        }
      }

      if (matchesSearch && matchesDate && matchesDelayFilter) {
        filtered.add(flight);
      }
    }
    flights = filtered;
    println("Filtered " + selectedTab + " count: " + flights.size());
    scrollY = 0; // Reset scroll position when filtering
  }

  void mouseWheel(MouseEvent event) {
    if (isVisible && isMouseOver()) {
      float e = event.getCount();
      scrollY += e * rowHeight;
      return;
    }
  }

  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }

  void mousePressed(int mx, int my) {
    if (!isVisible) return;
    checkRadioButtonClick(mx, my);

    int scrollBarX = 2 * width / 3 - 130;
    int scrollTrackY = tableBodyY + 90;

    //Check searchbar hitboxes.
    for (Searchbar s : searchbars)
    {
      if (s.mouseWithinHitbox())
      {
        s.setActive(!s.getActive());
        for (Searchbar s2 : searchbars)
        {
          if (s != s2) s2.setActive(false); // No more than one searchbar can be active at once.
        }
      }
    }

    if (mx >= scrollBarX && mx <= scrollBarX + SCROLLBAR_WIDTH &&
      my >= scrollTrackY && my <= scrollTrackY + tableBodyHeight) {

      // First update thumb position based on current scroll
      thumbY = (tableBodyHeight - thumbHeight) * ((float)scrollY / maxScrollY);

      // Check if clicked on thumb
      if (my >= scrollTrackY + thumbY && my <= scrollTrackY + thumbY + thumbHeight) {
        isDraggingThumb = true;
        // Store the offset between mouse and top of thumb
        offsetY = my - (scrollTrackY + thumbY);
      } else {
        // Clicked on track but not on thumb - jump to that position
        float clickPos = (my - (scrollTrackY + thumbY)) / (float)tableBodyHeight;
        scrollY = (int)(clickPos * maxScrollY);
        scrollY = constrain(scrollY, 0, maxScrollY);
        thumbY = (tableBodyHeight - thumbHeight) * ((float)scrollY / maxScrollY);
        isDraggingThumb = true;
        offsetY = my - (scrollTrackY + thumbY);
      }
    }
  }

  void mouseDragged(int my) {
    if (isDraggingThumb) {
      int scrollTrackY = tableBodyY + 90;

      // Calculate new relative position within scrollbar track
      float relativeY = my - scrollTrackY - offsetY;

      // Calculate what percentage of the scrollbar we've moved
      float scrollPercentage = relativeY / (float)(tableBodyHeight - thumbHeight);

      // Convert directly to scroll position
      scrollY = (int)(scrollPercentage * maxScrollY);
      scrollY = constrain(scrollY, 0, maxScrollY);
    }
  }


  void mouseReleased() {
    isDraggingThumb = false;
  }
}
