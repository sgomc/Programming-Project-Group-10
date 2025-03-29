class City {
  float x, y;  // Coordinates for the city
  float radius = 20;  // Radius of the circle
  String label;  // Optional label for the city
  boolean isHovered = false;  // Whether the mouse is hovering over the city
  boolean wasClicked = false;  // Whether the city has been clicked

  // Constructor for creating city with coordinates and an optional label
  City(float x, float y, String label) {
    this.x = x * width;
    this.y = y * height;
    this.label = label;
  }

  // Draw the city as a circle
  void draw() {
    pushStyle();

    // Set the color based on hover and active states
    if (isHovered) {
      fill(0, 200, 255);  // Blue when hovered
    } else {
      fill(0);  // Default black color
    }

    noStroke();
    circle(x, y, radius);

    popStyle();
  }

  // Check if the mouse is over the city
  boolean isMouseOver(int mx, int my) {
    float distance = dist(mx, my, x, y);
    return distance <= radius;  // Check if the mouse is within the radius of the city
  }

  // Check for hover event
  void checkHover(int mx, int my) {
    isHovered = isMouseOver(mx, my);
  }

  // Check for click event
  boolean checkClick(int mx, int my) {
    if (isMouseOver(mx, my) && mousePressed && !wasClicked) {
      wasClicked = true;
      println(label + " City Clicked");
      return true;
    }
    return false;
  }

  // Run method to handle drawing and interactions
  void run() {
    draw();  // Always draw the city
  }
}
