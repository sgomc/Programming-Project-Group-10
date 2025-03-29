class AboutWindow extends Window {
    AboutWindow(int x, int y, int w, int h) {
      super(x, y, w, h);
    }
  
    void display() {
      if (!isVisible) return;
      super.display();
      
      pushMatrix();
      translate(x, y);  // Move the coordinate system to the window's position
    
      // Display Content
      fill(0);
      textSize(18);
      textAlign(LEFT, TOP);
      text("About Content", 20, 50);
      popMatrix();
      
    }
  }
