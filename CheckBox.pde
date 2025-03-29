class CheckBox {
  float x, y, width, height;
  String label;
  boolean isChecked;

  CheckBox(float x, float y, float width, float height, String label) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.isChecked = false;
  }

  // Draw the checkbox
  void draw() {
    fill(255);
    stroke(0);
    
    rect(x, y, width, height);  // Draw checkbox outline
    if (isChecked) {
      strokeWeight(2);
      line(x, y, x + width, y + height);  // Draw check mark (diagonal line)
      line(x, y + height, x + width, y);  // Draw check mark (diagonal line)
    }
    fill(0);
    strokeWeight(1);
    textAlign(LEFT, CENTER);
    text(label,  x + width + 10, y + width/2);  // Draw the label
  }

  // Check if the checkbox is clicked
  boolean checkClick(float mx, float my) {
    if (mx > x && mx < x + width && my > y && my < y + height) {
      isChecked = !isChecked;
      return true;
    }
    return false;
  }
}
