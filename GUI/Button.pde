  class Button {
    int x, y, w, h;
    String label;
    boolean isHovered = false;
    boolean hasBackground = true; // Whether to show background when not hovered
    color bgColor = color(220); // Default background color
    color hoverColor = color(200, 220, 255); // Default hover color
    color textColor = color(0); // Default text color
    color hoverTextColor = color(0); // Default hover text color
    
    Button(int x, int y, int w, int h, String label) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.label = label;
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
        
        int xCenter = x + w/2;
        int yCenter = y + h/2;
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
    
    boolean isMouseOver(int mx, int my) {
      return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
    
    void checkHover(int mx, int my) {
      isHovered = isMouseOver(mx, my);
    }
    
    boolean checkClick(int mx, int my) {
      return isMouseOver(mx, my);
    }
  }
