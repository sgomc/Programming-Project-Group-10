class AboutWindow extends Window {
  String aboutWindowText;
  
  AboutWindow(int x, int y, int w, int h) {
    super(x, y, w, h);
    String[] aboutWindowString = loadStrings("ABOUT.txt");
    aboutWindowText = "";
    for(String s : aboutWindowString)
    {
      aboutWindowText += s;
      aboutWindowText += "\n";
    }
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
    text(aboutWindowText, 20, 50);
    closeButton.display();
    popMatrix();
  }
}
