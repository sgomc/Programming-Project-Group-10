    MainMenu mainMenu;
    Button menuButton;
    DeparturesArrivals departuresArrivals;
    Tab statisticsTab, aboutTab;
    StatisticsWindow statisticsWindow;
    AboutWindow aboutWindow;
    String topWindow = "";
    
    void setup() {
      size(1600, 900); // Main screen size
    
      int menuWidth = width / 3;
      int contentWidth = (width / 3) * 2;
    
      // Initialize windows
      mainMenu = new MainMenu(2 * width / 3, 40, menuWidth, height-40);
      mainMenu.isVisible = false;
      departuresArrivals = new DeparturesArrivals(100, 100, contentWidth - 200, height - 200);
      departuresArrivals.isVisible = false;
      menuButton = new Button(width/2 - 75, height/2 - 20, 150, 40, "Open Main Menu");
      
      // Initialize Tabs 
      statisticsTab = new Tab(0, 0, 100, 40, "Statistics", false);
      aboutTab = new Tab(100, 0, 100, 40, "About", false);
      statisticsWindow = new StatisticsWindow(0, 40, width, height - 40);
      statisticsWindow.isVisible = false;
      aboutWindow = new AboutWindow(0, 40, width, height - 40);
      aboutWindow.isVisible = false;
    }
    
    void draw() {
      background(200);
      fill(255);
      noStroke();
      rect(0,0, width, 40);
      
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
      
      menuButton.display();
      menuButton.checkHover(mouseX, mouseY);
      
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
        aboutWindow.display();
        aboutWindow.checkHover(mouseX, mouseY);
      }
      
    }
    
    
    void mousePressed() {
      if (menuButton.checkClick(mouseX, mouseY)) {
        mainMenu.open(); // Open the window when button is clicked
      }
      if (mainMenu.isVisible) {
        mainMenu.checkClose(mouseX, mouseY);
        mainMenu.checkButtonClick(mouseX, mouseY);
      }
      departuresArrivals.checkClose(mouseX, mouseY);
      departuresArrivals.checkTabClick(mouseX, mouseY);
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
    }
