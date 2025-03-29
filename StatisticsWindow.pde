class StatisticsWindow extends Window {
  StatisticsWindow(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  void display() {
    if (!isVisible) return;
    super.display();

    pushMatrix();
    translate(x, y);  // Move the coordinate system to the window's position
    fill(240, 236, 255);
    rect(0, 0, w, h);

    // Display Content
    fill(0);
    textSize(18);
    textAlign(LEFT, TOP);
    text("Statistics Content", 20, 50);
    closeButton.display();
    popMatrix();
  }
}
