class City {
  float x, y;  // Coordinates for the city
  float radius = 20;  // Radius of the circle
  String label;  // Optional label for the city
  boolean isHovered = false;  // Whether the mouse is hovering over the city
  boolean wasClicked = false;  // Whether the city has been clicked
  color hoverColor = color(175, 235, 245);  // Light blue for hover effect
  color defaultColor = color(0, 51, 102);  // Dark blue by default
  color currentColor = defaultColor;  // Current color of the city

  // Constructor for creating city with coordinates and an optional label
  City(float x, float y, String label) {
    this.x = x * width;
    this.y = y * height;
    this.label = label;
  }

  // Draw the city as a circle
  void draw() {
    pushStyle();

    // Draw the city circle first (background layer)
    if (isHovered) {
      fill(40, 95, 255);  // Light Purple when hovered
    } else {
      fill(0, 51, 102);  // Dark Blue by default
    }
    
    noStroke();
    circle(x, y, radius);

    popStyle(); // End of city drawing
  }

  // Function to draw the label with background (on top of the city)
  void drawLabel() {
    float labelX = x;  // Center the label horizontally over the city
    float labelY = y - radius - 10;  // Position label above the city
    float rectWidth = textWidth(label) * 1.5;  // Rounded rectangle width based on label length
    float rectHeight = 25;  // Height of the rounded rectangle

    // Draw the rounded rectangle for the label background
    fill(255, 255, 255);  // Semi-transparent white for the background
    noStroke();
    rect(labelX - rectWidth / 2, labelY - rectHeight / 2, rectWidth, rectHeight, 10);  // Rounded corners

    // Draw the label text
    fill(0);
    textSize(23);
    textAlign(CENTER, CENTER);
    text(label, labelX, labelY);
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
