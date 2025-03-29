class Button {
  float x, y, w, h;
  String label;
  boolean isHovered = false;
  boolean isHoveredStates = false;
  boolean hasBackground = true; // Whether to show background when not hovered
  color bgColor = color(200, 220, 255); // Default background color
  color hoverColor = color(175, 235, 245); // Default hover color
  color textColorStates = color(0, 5, 24); // Default text color
  color hoverTextColor, textColor = color(0); // Default hover text color
  color hoverTextColorStates = color(40, 95, 255); // Default hover text color
  boolean wasClicked = false;
  boolean isActive = false;
  State state;

  Button(int x, int y, int w, int h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  Button(State state) {
    this.state = state;
    this.x = getStateX(state) * width;
    this.y = getStateY(state) * height;
    this.label = getStateName(state);
    this.w = BUTTON_TEXT_SIZE * label.length() / 1.8;
    this.h = BUTTON_TEXT_SIZE;
  }

  void setActive(boolean active) {
    this.isActive = active;
  }

  void display() {

    pushStyle();

    // Button background
    if (isHovered) {
      fill(hoverColor);
    } else if (hasBackground) {
      fill(bgColor);
    } else {
      noFill();
    }

    // No stroke for the close button
    if (label.equals("X")) {
      noStroke();
    } else {
      stroke(0);
    }

    rect(x, y, w, h);

    // Special handling for close button "X"
    if (label.equals("X")) {
      // Draw X lines instead of text
      strokeWeight(1);
      if (isHovered) {
        stroke(hoverTextColor);
      } else {
        stroke(textColor);
      }

      int xCenter = (int)(x + w/2);
      int yCenter = (int) (y + h/2);
      int offset = 7;

      line(xCenter - offset, yCenter - offset, xCenter + offset, yCenter + offset);
      line(xCenter + offset, yCenter - offset, xCenter - offset, yCenter + offset);
    } else {
      // Normal button text
      if (isHovered) {
        fill(hoverTextColor);
      } else {
        fill(textColor);
      }
      textAlign(CENTER, CENTER);
      textSize(16);
      text(label, x + w/2, y + h/2);
    }

    popStyle();
  }

  void display2()
  {
    pushStyle();
    textSize(BUTTON_TEXT_SIZE);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);

    textFont(boldFont);

    // Only change the text color when hovering
    if (isHoveredStates) {
      fill(hoverTextColorStates); // Change text color on hover
    } else {
      fill(textColorStates); // Default text color
    }

    // No background fill, just show the button boundary lightly
    noFill();

    if (isActive) {
      strokeWeight(2);
      stroke(hoverTextColorStates);  // Apply stroke for the active button
    } else {
      noStroke();  // No stroke for other buttons
    }

    rect(x, y, w, h); // Show button boundary lightly

    // Draw the button text
    text(label, x, y, w, h);

    popStyle();
  }

  boolean isMouseOver(int mx, int my) {
    return (mx >= x && mx <= x + w && my >= y && my <= y + h);
  }

  void checkHover(int mx, int my) {
    isHovered = isMouseOver(mx, my);
  }

  boolean checkClick(int mx, int my) {
    if (isMouseOver(mx, my) && mousePressed && !wasClicked) {
      println(label + " Button Clicked");
      wasClicked = true;
      return true;
    }
    return false;
  }

  void changeTextColor(color c) {
    textColor = c;
  }

  void mouseCollisionHighlight() {
    changeTextColor(isHoveredStates ? HIGHLIGHTED_TEXT_COLOR : DEFAULT_TEXT_COLOR);
  }

  void run() {
    if (isHoveredStates || wasClicked) {
      display();  // Use full rendering if interacted with
    } else {
      display2(); // Otherwise, just show text
    }
    mouseCollisionHighlight();
  }

  void mouseWithinHitbox()
  {
    isHoveredStates = mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2; //Rectangular collision box
  }

  boolean checkClickStates() {
    if (isHoveredStates && mousePressed && !wasClicked) {
      println(label + " Button Clicked");
      wasClicked = true;
      return true;
    }
    return false;
  }
}
