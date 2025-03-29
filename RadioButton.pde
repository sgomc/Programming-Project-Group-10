class RadioButton {
  int x, y, w, h;
  String label;
  boolean isSelected;

  RadioButton(int x, int y, int w, int h, String label, boolean isSelected) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.isSelected = isSelected;
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    // Draw circle
    stroke(0);
    fill(255);
    ellipse(10, h/2, 16, 16);

    // Draw dot if selected
    if (isSelected) {
      fill(0);
      ellipse(10, h/2, 8, 8);
    }

    // Draw label
    fill(0);
    textAlign(LEFT, CENTER);
    text(label, 25, h/2);

    popMatrix();
  }

  boolean isClicked(int mx, int my) {
    return mx >= x && mx <= x + w && my >= y && my <= y + h;
  }
}
