  class DeparturesArrivals extends Window {
    String selectedTab = "Departures";
    Tab departuresTab, arrivalsTab;
  
    DeparturesArrivals(int x, int y, int w, int h) {
      super(x, y, w, h);
      departuresTab = new Tab(x + 20, y + 10, 150, 40, "Departures", selectedTab.equals("Departures"));
      arrivalsTab = new Tab(x + 180, y + 10, 150, 40, "Arrivals", selectedTab.equals("Arrivals"));
    }
  
    void display() {
      if (!isVisible) return;
      super.display();
      departuresTab.draw();
      arrivalsTab.draw();
      
      pushMatrix();
      translate(x, y);  // Move the coordinate system to the window's position
      
      // Draw Tabs
      
    
      // Display Content
      fill(0);
      textSize(18);
      textAlign(LEFT, TOP);  // Ensures text is aligned properly
      
      if (selectedTab.equals("Departures")) {
        text("Departures:", 20, 70);  // Now relative to the window
        text("Flight 1 - 12:30 PM", 20, 100);
        text("Flight 2 - 3:45 PM", 20, 130);
      } else {
        text("Arrivals:", 20, 70);
        text("Flight A - 11:15 AM", 20, 100);
        text("Flight B - 2:50 PM", 20, 130);
      }
    
      popMatrix();  // Restore original coordinates
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
    }
  }
