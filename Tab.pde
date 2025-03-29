class Tab {
  int x, y, w, h;
  String label;
  boolean isSelected;
  boolean isHovered = false;

  Tab(int x, int y, int w, int h, String label, boolean isSelected) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.isSelected = isSelected;
  }

  void draw() {

    if (this.label.equals("Arrivals") || this.label.equals("Departures")) {
      if (isSelected) {
        fill(150, 175, 255); // Selected color
      } else if (isHovered) {
        fill(175, 235, 245); // Hover color
      } else {
        fill(200, 220, 255); // Default color
      }
    } else {
      if (isSelected) {
        fill(150, 175, 255); // Selected color
      } else if (isHovered) {
        fill(201, 211, 245); // Hover color
      } else {
        fill(237, 240, 255); // Default color
      }
    }

    rect(x, y, w, h, 15);
    fill(0, 5, 24);
    textFont(boldFont);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);
  }

  boolean isClicked(int mx, int my) {
    return mx >= x && mx <= x + w && my >= y && my <= y + h;
  }
  void checkHover(int mx, int my) {
    isHovered = mx >= x && mx <= x + w && my >= y && my <= y + h;
  }
}
