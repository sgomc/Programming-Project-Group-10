class DeparturesArrivals extends Window {
  String selectedTab = "Departures";
  Tab departuresTab, arrivalsTab;
  String selectedDate= "";
  ArrayList<Flight> flights = new ArrayList<Flight>(); // Use Flight instead of DataPoint
  ArrayList<Flight> allFlights = new ArrayList<Flight>();
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

  DeparturesArrivals(int x, int y, int w, int h) {
    super(x, y, w, h);
    departuresTab = new Tab(x + 20, y + 10, 150, 40, "Departures", selectedTab.equals("Departures"));
    arrivalsTab = new Tab(x + 180, y + 10, 150, 40, "Arrivals", selectedTab.equals("Arrivals"));
    loadFlights();
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

    fill(0);
    textFont(boldFont);
    textSize(20);
    
    textAlign(LEFT, TOP);  // Ensures text is aligned properly
    
    int headerY = 140;
    text(selectedTab + " List:", 20, headerY);

    // Display column headers
    int tableY = headerY + 30;
    text("Flight #", 20, tableY);
    text("Departure", 120, tableY);
    text("Arrival", 250, tableY);
    text("Destination", 350, tableY);
    text("Date", 480, tableY);

    // Draw a line under the headers
    stroke(0);
    line(20, tableY + 31, 520, tableY + 31);
    noStroke();

    tableBodyY = tableY + 40;
    tableBodyHeight = height - tableBodyY - 120 ;

    //This updates maxScrollY based on number of flights
    maxScrollY = Math.max(0, flights.size() * rowHeight - tableBodyHeight);


    //set a range for srcollY
    scrollY = constrain(scrollY, 0, maxScrollY);
    float scrollOffset = scrollY % rowHeight;

    // Display flights or a message if none
    if (flights.isEmpty()) {
      for (Searchbar s : searchbars)
      {
        if (s.getSearchbarType()==SearchbarType.SEARCHBAR_FLIGHT_NUMBER && s.isEmpty()) text("Enter a flight number to search.", 20, tableBodyY + 10);
      }
    } else if (flights.isEmpty()) {
      text("No flights found matching your search.", 20, tableBodyY + 10);
    } else {
      // scroll bar if needed- COME BACK TO!!!
      if (flights.size() > flightsPerPage) {

        // scroll thumb - COME BACK TO!!
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
        text(flight.departureTime, 120, yPos);
        text(flight.arrivalTime, 250, yPos);
        text(flight.destination, 350, yPos);
        text(flight.date, 480, yPos);

        // Draw a light separator line between flights
        stroke(200);
        line(20, yPos + rowHeight- 18, 2 * width / 3 - 220, yPos + rowHeight -18);
        noStroke();
      }

      popMatrix();
      noClip();
    }
    closeButton.display();

    popMatrix();
    for (Searchbar s : searchbars)
    {
      s.display();
    }
    // scroll bar
    if (!flights.isEmpty() && flights.size() > flightsPerPage) {
      int scrollBarX = 2 * width / 3 - 130;
      int scrollTrackY = tableBodyY;

      fill(180);
      stroke(0);
      rect(scrollBarX, scrollTrackY, SCROLLBAR_WIDTH, tableBodyHeight);
      noStroke();

      fill(100);
      rect(scrollBarX, thumbY, SCROLLBAR_WIDTH, thumbHeight);
    }
    textFont(boldFont);
    departuresTab.draw();
    arrivalsTab.draw();
  }


  void checkTabClick(int mx, int my) {
    if (!isVisible) return;

    if (departuresTab.isClicked(mx, my)) {
      selectedTab = "Departures";
    } else if (arrivalsTab.isClicked(mx, my)) {
      selectedTab = "Arrivals";
    }

    // Update selected tab's state
    departuresTab.isSelected = selectedTab.equals("Departures");
    arrivalsTab.isSelected = selectedTab.equals("Arrivals");
    filterFlights();
    scrollY = 0; // -> reset scroll position when changing tabs
  }
  
  void loadFlights() {
    String[] lines = loadStrings("flights_full.csv");
    if (lines == null) {
      println("Error: File not found!");
      return;
    }
    allFlights.clear();

    for (int i = 1; i < lines.length; i++) { // Skip header row
      String line = lines[i];
      String[] parts = line.split(",");
      if (parts.length >= 14) {
        // Create a Flight with correct parameter order:
        Flight newFlight = new Flight(
          parts[2], // flightNumber (MKT_CARRIER_FL_NUM)
          parts[11], // departureTime (CRS_DEP_TIME)
          parts[13], // arrivalTime (CRS_ARR_TIME)
          parts[7], // destination (DEST)
          parts[0]   // date (FL_DATE)
          );
          Airport newAirport = new Airport (
          parts[3],
          parts[4].replace("\"", "").split(",")[0].trim(),
          parts[5].replace("\"", "").replace(" ", "")
          );

        allFlights.add(newFlight);
        airports.add(newAirport);
      }
    }
    println("Total flights loaded: " + allFlights.size());
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
    // Only filter if we have a search term
    for (Flight flight : allFlights) {
      boolean matchesSearch = false;
      boolean matchesDate = false;
      for (Searchbar s : searchbars)
      {
        if (s.getSearchbarType() == SearchbarType.SEARCHBAR_FLIGHT_NUMBER) matchesSearch = flight.flightNumber.toLowerCase().contains(s.getText());
        if (s.getSearchbarType() == SearchbarType.SEARCHBAR_DATE) matchesDate = s.isEmpty() || flight.date.toLowerCase().contains(s.getText());
      }

      boolean matchesTab = (selectedTab.equals("Departures") && flight.departureTime != null) ||
        (selectedTab.equals("Arrivals") && flight.arrivalTime != null);

      if (matchesSearch && matchesDate && matchesTab) {
        filtered.add(flight);
      }
    }
    flights = filtered;
    scrollY = 0; // Reset scroll position when filtering
  }
  
  void mouseWheel(MouseEvent event) {
    if (isVisible && isMouseOver()) {
      float e = event.getCount();
      scrollY += e * rowHeight;
    }
  }

  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }

  void mousePressed(int mx, int my) {
    if (!isVisible) return;

    int scrollBarX = 2 * width / 3 - 130;
    int scrollTrackY = tableBodyY;

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

      if (my >= thumbY && my <= thumbY + thumbHeight) {
        isDraggingThumb = true;
        lastMouseY = my;
        offsetY = my - thumbY;

        // Immediately update thumbY to the click position
        float newThumbY = my - offsetY;
        float clickPos = (newThumbY - tableBodyY) / (float) tableBodyHeight;
        scrollY = (int) (clickPos * maxScrollY);
        scrollY = constrain(scrollY, 0, maxScrollY);
      } else {
        // Clicked on track but not on thumb - jump to that position
        float clickPos = (my - scrollTrackY) / (float) tableBodyHeight;
        scrollY = (int) (clickPos * maxScrollY);
        scrollY = constrain(scrollY, 0, maxScrollY);
      }
    }
  }

  void mouseDragged(int my) {
    if (isDraggingThumb) {
      float newThumbY = my - offsetY;
      float clickPos = (newThumbY - tableBodyY) / (float) tableBodyHeight;
      scrollY = (int) (clickPos * maxScrollY);
      scrollY = constrain(scrollY, 0, maxScrollY);
      lastMouseY = my;
    }
  }

  void mouseReleased() {
    isDraggingThumb = false;
  }
}
