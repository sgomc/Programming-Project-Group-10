PImage image; //<>//
PImage[] intro = new PImage[3];
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
boolean loading = true;
int[] introVar = new int[4];
String s = ".";
void setup() {
  //size(1600, 900);
  fullScreen(); // Main screen size
  background(0);
  
  image = loadImage("USA_map3.png");
  image.resize(width, height);

  for (State s : State.values())
  {
    if (getStateName(s).equals("Vermont") || getStateName(s).equals("New Hampshire") || getStateName(s).equals("Massachussets") || getStateName(s).equals("Rhode Island")
      || getStateName(s).equals("Conneticut") || getStateName(s).equals("New Jersey") || getStateName(s).equals("Delaware") || getStateName(s).equals("Maryland")
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
  statisticsTab = new Tab(4, 0, 100, 40, "Statistics", false);
  aboutTab = new Tab(104, 0, 100, 40, "About", false);
  statisticsWindow = new StatisticsWindow(4, 50, width - 8, height - 54);
  statisticsWindow.isVisible = false;
  aboutWindow = new AboutWindow(4, 50, width - 8, height - 54);
  aboutWindow.isVisible = false;

  closeButton = new Button(width - 50, 5, 40, 40, "X");
  closeButton.hasBackground = false; // No background when not hovered
  closeButton.hoverColor = color(255, 0, 0); // Red when hovered
  closeButton.textColor = color(0); // Black X
  closeButton.hoverTextColor = color(255); // White X when hovered
}

void draw() {
  background(200);
  if(loading)
  {
    loadingScreen();
  }else{
  image(image, 0, 0);

  
  for (City city : cities) {
    city.checkHover(mouseX, mouseY);
    city.draw();
  }

  //washington.draw();
  for (Button b : stateButtons) {
    b.display2();  // First, draw the buttons
  }

  for (Button b : stateButtons) {
    b.mouseWithinHitbox();
  }

  fill(255);
  noStroke();
  rect(4, 0, width - 8, 40);

  statisticsTab.draw();
  aboutTab.draw();

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


  if (topWindow.equals("Statistics") && statisticsWindow.isVisible) {
    statisticsWindow.display();
    statisticsWindow.checkHover(mouseX, mouseY);
  }

  if (topWindow.equals("About") && aboutWindow.isVisible) {
    aboutWindow.display(); //<>//
    aboutWindow.checkHover(mouseX, mouseY);
  }
  closeButton.display();
  closeButton.checkHover(mouseX, mouseY);
  }
}


void mousePressed() {

  boolean stateButtonClicked = false;

  // Check if any state button was clicked
  for (Button stateButton : stateButtons) {
    if (stateButton.checkClickStates()) {
      println("State button clicked: " + stateButton.label);

      // Open the menu for the selected state
      mainMenu.openForState(stateButton.state);  // Set the current state
      stateButtonClicked = true;
      break;
    }
  }
  for (City city : cities) {
    if (city.checkClick(mouseX, mouseY)) {
      println("City clicked: " + city.label);
      String formattedCityName = city.label.replace(" ", "_").toUpperCase();
      mainMenu.openForState(State.valueOf(formattedCityName));  // Set the current state for the city
      break;
    }
  }

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
  departuresArrivals.mousePressed(mouseX, mouseY);

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
}

void loadData() {
  String[] lines = loadStrings("flights_full.csv");
  if (lines == null) {
    println("Error: File not found!");
    return;
  }

  for (int i = 1; i < lines.length; i++) {
    String line = lines[i];
    String[] parts = line.split(",");
    if (parts.length >= 5) {
      //mapping the data columns to flight fields
      String flightNumber = parts[2];
      String departureTime = parts[11];
      String arrivalTime = parts[13];
      String destination = parts[7];
      String date = parts[0];

      dataList.add(new Flight(flightNumber, departureTime, arrivalTime, destination, date));
    }
  }
}

void displaySearchBar() {
  fill(255);
  rect(50, 20, 200, 30);  //search box
  fill(0);
  textSize(16);
  text(searchBar, 60, 40);  //display user input
}


void printData() {
  textAlign(CENTER);
  int y = height / 2;

  fill(50);
  textSize(18);
  for (Flight flight : dataList) {
    text(flight.toString(), width / 2, y);
    y += 30;  //space out lines
  }
}


void keyPressed() {
  if (departuresArrivals.isVisible) {
    println("Key pressed: " + key);
    departuresArrivals.keyPressed(); //forwarding key events to DeparturesArrivals v of keyPressed()
  }
}

void mouseWheel(MouseEvent event) {
  if (departuresArrivals.isVisible) {
    departuresArrivals.mouseWheel(event);
  }
}

void mouseDragged() {
  departuresArrivals.mouseDragged(mouseY);
}
