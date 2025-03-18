  class Tab {
    int x, y, w, h;
    String label;
    boolean isSelected;
  
    Tab(int x, int y, int w, int h, String label, boolean isSelected) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.label = label;
      this.isSelected = isSelected;
    }
  
    void draw() {
      fill(isSelected ? 200 : 220);
      rect(x, y, w, h);
      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);  
      text(label, x + w / 2, y + h / 2);
    }
  
    boolean isClicked(int mx, int my) {
      return mx >= x && mx <= x + w && my >= y && my <= y + h;
    }
  }
