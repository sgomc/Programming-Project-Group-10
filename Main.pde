import java.util.HashSet; //<>// //<>//
import java.util.HashMap;
import processing.sound.*;

PImage image, icon;
PImage[] intro = new PImage[3];
PFont boldFont, font;
ArrayList<Button> stateButtons = new ArrayList<Button>();
ArrayList<Flight> dataList = new ArrayList<Flight>();
ArrayList<Flight> filteredList = new ArrayList<Flight>();
MainMenu mainMenu;
DeparturesArrivals departuresArrivals;
Tab statisticsTab, aboutTab;
StatisticsWindow statisticsWindow;
AboutWindow aboutWindow;
Button closeButton;
String topWindow = "";
String searchBar = "";
ArrayList<City> cities = new ArrayList<City>();
boolean isDraggingScroll = false;
float scrollThumbY = 0;
boolean blockInteractions = false;
ArrayList<Searchbar> searchbars = new ArrayList<Searchbar>();
ArrayList<Airport> airports = new ArrayList<Airport>();
CheckBox sortCitiesCheckBox;
RadioButton allFlightsRadio, delayedFlightsRadio, onTimeFlightsRadio;
HashMap<String, ArrayList<Flight>> departuresByState = new HashMap<>();
HashMap<String, ArrayList<Flight>> arrivalsByState = new HashMap<>();
ArrayList<Flight> flights = new ArrayList<Flight>(); // Use Flight instead of DataPoint
ArrayList<Flight> allFlights = new ArrayList<Flight>();
boolean loading = true;
int[] introVar = new int[4];
String dotsIntro = "";
Table table;
PImage plane;
final int framerate=60;
Plane boeing;
SoundFile planeFly;
String selectedTab = "Departures";
Tab departuresTab, arrivalsTab;
String selectedDate= "";
State currentState;

void setup() {
  fullScreen(); // Main screen size

  boldFont = createFont("text/cambriab.ttf", 23.5);
  font = createFont("text/cambria.ttf", 23.5);

  image = loadImage("images/Map.png");
  image.resize(width, height);
  icon = loadImage("images/airplane.png");
  icon.resize(50, 50);
  
  plane = loadImage("Plane.png");
  plane.resize(height/15, height/15);
  boeing = new Plane();
  planeFly = new SoundFile(this, "airplane-lift-off-01.mp3");

  for (State s : State.values())
  {
    if (getStateName(s).equals("Vermont") || getStateName(s).equals("New Hampshire") || getStateName(s).equals("Massachusetts") || getStateName(s).equals("Rhode Island")
      || getStateName(s).equals("Connecticut") || getStateName(s).equals("New Jersey") || getStateName(s).equals("Delaware") || getStateName(s).equals("Maryland")
      || getStateName(s).equals("West Virginia") || getStateName(s).equals("Hawaii") || getStateName(s).equals("Guam") || getStateName(s).equals("Samoa")
      || getStateName(s).equals("Saipan") || getStateName(s).equals("Virgin Islands")) {
      City city = new City(getStateX(s), getStateY(s), getStateName(s));
      cities.add(city);
    } else {
      stateButtons.add(new Button(s));
    }
  }

  int menuWidth = width / 3;
  int contentWidth = (width / 3) * 2;

  // Initialize windows
  mainMenu = new MainMenu(2 * width / 3, 50, menuWidth - 4, height-54);
  mainMenu.isVisible = false;
  departuresArrivals = new DeparturesArrivals(100, 100, contentWidth - 200, height - 200);
  departuresArrivals.isVisible = false;

  // Initialize Tabs
  statisticsTab = new Tab(69, 0, 100, 45, "Statistics", false);
  aboutTab = new Tab(179, 0, 100, 45, "About", false);
  statisticsWindow = new StatisticsWindow(4, 50, width - 8, height - 54);
  statisticsWindow.isVisible = false;
  aboutWindow = new AboutWindow(4, 50, width - 8, height - 54);
  aboutWindow.isVisible = false;

  closeButton = new Button(width - 50, 5, 40, 40, "X");
  closeButton.hasBackground = false; // No background when not hovered
  closeButton.hoverColor = color(255, 0, 0); // Red when hovered
  closeButton.textColor = color(0); // Black X
  closeButton.hoverTextColor = color(255); // White X when hovered

  sortCitiesCheckBox = new CheckBox(280, 90, 20, 20, "Sort Cities Alphabetically");
  thread("loadFlightsThread");
}

void loadFlightsThread() {
  loadFlights();  // Load flight data
  preprocessFlightsByState(); // Process data
}

void preprocessFlightsByState() {
  // Initialize maps
  departuresByState.clear();
  arrivalsByState.clear();

  // Get all state abbreviations
  HashSet<String> stateAbbrs = new HashSet<>();
  for (Flight flight : allFlights) {
    stateAbbrs.add(flight.originState);
    stateAbbrs.add(flight.destState);
  }

  // Populate maps for each state
  for (String stateAbbr : stateAbbrs) {
    ArrayList<Flight> departures = new ArrayList<>();
    ArrayList<Flight> arrivals = new ArrayList<>();

    for (Flight flight : allFlights) {
      if (flight.originState.equals(stateAbbr)) {
        departures.add(flight);
      }
      if (flight.destState.equals(stateAbbr)) {
        arrivals.add(flight);
      }
    }

    departuresByState.put(stateAbbr, departures);
    arrivalsByState.put(stateAbbr, arrivals);
  }

  println("Preprocessed flights for " + stateAbbrs.size() + " states");
}

void draw() {
  if (loading)
  {
    loadingScreen();
  } else {

    image(image, 0, 0);
    for (City city : cities) {
      if (!blockInteractions)
        city.checkHover(mouseX, mouseY);
      city.run();
    }
    for (Button b : stateButtons) {
      if (!blockInteractions)
        b.mouseWithinHitbox();
      b.display2();
    }
    for (City city : cities) {
      if (city.isHovered) {
        city.drawLabel();  // Draw label only if the city is hovered
      }
    }

    fill(181, 233, 238);
    noStroke();
    rect(4, 0, width - 8, 40);

    statisticsTab.draw();
    aboutTab.draw();
    image(icon, 10, 3);

    if (statisticsWindow.isVisible) {
      statisticsWindow.display();
      statisticsWindow.checkHover(mouseX, mouseY);
    }

    if (aboutWindow.isVisible) {
      aboutWindow.display();
      aboutWindow.checkHover(mouseX, mouseY);
    }

    if (mainMenu.isVisible) {
      mainMenu.checkHover(mouseX, mouseY);
      mainMenu.checkButtonHover(mouseX, mouseY);
      mainMenu.display();
    }


    if (departuresArrivals.isVisible) {
      departuresArrivals.checkHover(mouseX, mouseY);
      departuresArrivals.display();
    }

    statisticsTab.checkHover(mouseX, mouseY);
    aboutTab.checkHover(mouseX, mouseY);

    if (topWindow.equals("Statistics") && statisticsWindow.isVisible) {
      statisticsWindow.display();
      statisticsWindow.checkHover(mouseX, mouseY);
    }

    if (topWindow.equals("About") && aboutWindow.isVisible) {
      aboutWindow.display();
      aboutWindow.checkHover(mouseX, mouseY);
    }
    closeButton.display();
    closeButton.checkHover(mouseX, mouseY);
  }
  
  
  //draw plane animation over everything else
  if(boeing.isVisible){
    image(image, 0, 0);
    for (City city : cities) {
      city.run();
    }
    for (Button b : stateButtons) {
      b.display2();
    }
    boeing.fly();
    boeing.draw();
  }
}


void mousePressed() {

  blockInteractions = departuresArrivals.isVisible || statisticsWindow.isVisible || aboutWindow.isVisible;

  boolean stateButtonClicked = false;

  //Only check other buttons if no state button was clicked
  if (!stateButtonClicked) {
    if (closeButton.checkClick(mouseX, mouseY)) {
      println("Program closed");
      exit();
    }
    if (mainMenu.isVisible) {
      mainMenu.checkClose(mouseX, mouseY);
      mainMenu.checkButtonClick(mouseX, mouseY);
    }
  }
  mainMenu.mousePressed(mouseX, mouseY);
  departuresArrivals.mousePressed(mouseX, mouseY);
  if (departuresArrivals.isVisible)
  {
    departuresArrivals.checkClose(mouseX, mouseY);
    departuresArrivals.checkTabClick(mouseX, mouseY);
  }

  if (statisticsTab.isClicked(mouseX, mouseY)) {
    statisticsTab.isSelected = true;
    aboutTab.isSelected = false;
    statisticsWindow.isVisible = true;
    aboutWindow.isVisible = false;
    topWindow = "Statistics"; // Open the Statistics Window when tab is clicked
  } else if (aboutTab.isClicked(mouseX, mouseY)) {
    aboutTab.isSelected = true;
    statisticsTab.isSelected = false;
    statisticsWindow.isVisible = false;
    aboutWindow.isVisible = true;
    topWindow = "About";
  }
  statisticsWindow.checkClose(mouseX, mouseY);
  aboutWindow.checkClose(mouseX, mouseY);

  // If window is now closed, unselect the corresponding tab
  if (!statisticsWindow.isVisible) {
    statisticsTab.isSelected = false;
    if (topWindow.equals("Statistics"))
      topWindow = "";
  }
  if (!aboutWindow.isVisible) {
    aboutTab.isSelected = false;
    if (topWindow.equals("About"))
      topWindow = "";
  }


  if (!departuresArrivals.isVisible && !statisticsWindow.isVisible && !aboutWindow.isVisible)
    blockInteractions = false;

  if (blockInteractions) return;

  // Check if any state button was clicked
  for (Button stateButton : stateButtons) {
    if (stateButton.checkClickStates()) {
      println("State button clicked: " + stateButton.label);

      // Open the menu for the selected state
      mainMenu.openForState(stateButton.state);  // Set the current state
      departuresArrivals.currentState = mainMenu.currentState;
      mainMenu.getAirportsForCurrentState();
      stateButtonClicked = true;
      break;
    }
  }
  for (City city : cities) {
    if (city.checkClick(mouseX, mouseY)) {
      println("City clicked: " + city.label);
      String formattedCityName = city.label.replace(" ", "_").toUpperCase();
      mainMenu.openForState(State.valueOf(formattedCityName));  // Set the current state for the city
      departuresArrivals.currentState = mainMenu.currentState;
      mainMenu.getAirportsForCurrentState();
      break;
    }
  }
}
void mouseReleased() {
  for (Button b : stateButtons) {
    b.wasClicked = false;
  }
  departuresArrivals.closeButton.wasClicked = false;

  for (City city : cities) {
    city.wasClicked = false;
  }
  departuresArrivals.mouseReleased();
  mainMenu.mouseReleased();
}

void displaySearchBar() {
  fill(255);
  rect(50, 20, 200, 30);  //search box
  fill(0);
  textSize(16);
  text(searchBar, 60, 40);  //display user input
}

void keyPressed() {
  if (departuresArrivals.isVisible) {
    println("Key pressed: " + key);
    departuresArrivals.keyPressed(); //forwarding key events to DeparturesArrivals v of keyPressed()
  }
  
  /*testing
  if (key == '#'){
    boeing.reset("SPN","JFK");
  }
  */
}

void mouseWheel(MouseEvent event) {
  if (departuresArrivals.isVisible) {
    departuresArrivals.mouseWheel(event);
  }
  if (mainMenu.isVisible) {
    mainMenu.mouseWheel(event);
  }
}

void mouseDragged() {
  departuresArrivals.mouseDragged(mouseY);
  mainMenu.mouseDragged(mouseY);
}

void loadFlights() {
  table = loadTable("flights_full.csv", "header");
  String[] lines = loadStrings("flights_full.csv");
  if (lines == null) {
    println("Error: File not found!");
    return;
  }
  allFlights.clear();
  allFlights = new ArrayList<Flight>(lines.length);

  for (int i = 1; i < lines.length; i++) { // Skip header row
    String line = lines[i];
    // Handle potential CSV complexities
    String[] parts = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");

    if (parts.length >= 15) {
      String date = parts[0].replaceAll("\"", "").trim();
      String flightNumber = parts[2].replaceAll("\"", "").trim();

      String origin = parts[3].replaceAll("\"", "").trim();
      String originCity = parts[4].replaceAll("\"", "").trim();
      String originState = cleanStateAbbreviation(parts[5]);

      String destination = parts[7].replaceAll("\"", "").trim();
      String destCity = parts[8].replaceAll("\"", "").trim();
      String destState = cleanStateAbbreviation(parts[9]);

      // Scheduled departure and arrival times
      String crsDepTime = parts[11].replaceAll("\"", "").trim();
      String crsArrTime = parts[13].replaceAll("\"", "").trim();

      String depTime = parts[12].replaceAll("\"", "").trim(); // ACTUAL DEP_TIME
      String arrTime = parts[14].replaceAll("\"", "").trim();  // ACTUAL ARR_TIME

      Flight newFlight = new Flight(
        flightNumber,
        crsDepTime,
        crsArrTime,
        destination,
        origin,
        date,
        originState,
        destState,
        originCity,
        destCity
        );

      newFlight.DEP_TIME = depTime.replaceAll("[^0-9]", "");
      newFlight.ARR_TIME = arrTime.replaceAll("[^0-9]", "");

      allFlights.add(newFlight);

      Airport newAirport = new Airport (
        origin,
        originCity.split(",")[0],
        originState
        );

      airports.add(newAirport);
    }
  }
  println("Total flights loaded: " + allFlights.size());
}
