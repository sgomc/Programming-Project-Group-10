class AboutWindow extends Window {
  color themeBgColor = color(240, 236, 255);   
  color themeTextColor = color(0, 5, 24);         
  color themeTitleColor = color(40, 95, 255);     
  color themeNameColor = color(40, 95, 255);    
  color themeAccentColor = color(40, 95, 255);   

  color bgColor = themeBgColor;
  color textColor = themeTextColor;
  color titleColor = themeTitleColor;
  color nameColor = themeNameColor;
  color separatorColor = themeAccentColor; 

  String projectIntroText; 
  String teamSectionTitle = "OUR TEAM";

  PImage[] devImages;
  String[] devNames = {
    "Maccolins Obijiaku",
    "Veronika Zavatska",
    "Amy Murray",
    "Stephen Conboy",
    "Thomas Kennedy"
  };
  String[] devRoles = {
    "",
    "(Project Manager)",
    "",
    "",
    ""
  };
  String[] devDescriptions = {
    "Developed data visualization (histograms) for the statistics page and created the project's introduction section.",
    "Led overall project direction and core development: flight menu system, airport displays, UI enhancements, data optimization.",
    "Implemented filtering, scrolling features, UI improvements, and the delayed/on time/early flights tracking option.",
    "Contributed geographical elements: U.S. map integration, airport location data, and the flight path simulation feature.",
    "Created state selection buttons, the flexible date search, performed optimizations, and managed this about page."
  };
  String[] devImageFiles = {
    "images/Mac.jpg", "images/Veronika.jpg", "images/Amy.jpg", "images/Stephen.jpg", "images/Tommy.jpg"
  };

  float defaultImgSize = 140; 
  float minImgSize = 90;    
  float minHorizontalPadding = 25; 
  float verticalPadding = 25;  
  float textPaddingBelowImage = 8;  
  float textPaddingBelowName = 4;
  float estimatedTextBlockHeight = 115;


  float calculatedImgWidth = defaultImgSize;
  float calculatedImgHeight = defaultImgSize;
  float calculatedPaddingH = minHorizontalPadding; 
  float topRowStartX = 0; 
  float bottomRowStartX = 0; 

  AboutWindow(int x, int y, int w, int h) {
    super(x, y, w, h); 
  }

  void loadIntroText() { 
    try {
      String[] aboutFileLines = loadStrings("ABOUT.txt");
      projectIntroText = "";
      for (String s : aboutFileLines) {
        if (s.trim().equalsIgnoreCase(teamSectionTitle)) {
          break;
        }
        projectIntroText += s + "\n";
      }
    } catch (Exception e) {
      println("Error loading or parsing ABOUT.txt: " + e.getMessage());
      projectIntroText = "Could not load project description."; //<>//
    }
  }

  void loadImages() { 
    devImages = new PImage[devNames.length];
    for (int i = 0; i < devImageFiles.length; i++) {
      devImages[i] = loadImage(devImageFiles[i]);
      if (devImages[i] == null) {
        println("Error loading image: " + devImageFiles[i]);
        devImages[i] = createPlaceholderImage(int(defaultImgSize));
      }
    }
  }

  PImage createPlaceholderImage(int size) { 
     PImage placeholder = createImage(size, size, RGB);
     placeholder.loadPixels();
     for (int p = 0; p < placeholder.pixels.length; p++) {
       placeholder.pixels[p] = color(150); 
     }
     placeholder.updatePixels();
     return placeholder;
  }

  void display() {
    if (!isVisible) return;

    pushMatrix();
    translate(x, y);

    fill(bgColor);
    stroke(0);
    strokeWeight(1);
    rect(0, 0, w, h); 

    float margin = 75; 
    float availableWidth = w - (2 * margin);
    int numDevs = devNames.length;
    int numTopRow = 3;
    int numBottomRow = numDevs - numTopRow;

    int numGapsTop = numTopRow - 1;
    calculatedImgWidth = (availableWidth - (numGapsTop * minHorizontalPadding)) / numTopRow;

    calculatedImgWidth = constrain(calculatedImgWidth, minImgSize, 300);

    calculatedImgHeight = calculatedImgWidth;

    float totalImageWidthTop = numTopRow * calculatedImgWidth;
    float totalPaddingSpaceTop = availableWidth - totalImageWidthTop;
    if (numGapsTop > 0) {
        calculatedPaddingH = max(minHorizontalPadding, totalPaddingSpaceTop / numGapsTop);
    } else {
        calculatedPaddingH = 0; 
    }

    float topRowTotalWidth = totalImageWidthTop + (numGapsTop * calculatedPaddingH);
    topRowStartX = (w - topRowTotalWidth) / 2;

    int numGapsBottom = numBottomRow - 1;
    float bottomRowTotalWidth = numBottomRow * calculatedImgWidth + (numGapsBottom * calculatedPaddingH);
    bottomRowStartX = (w - bottomRowTotalWidth) / 2;
    
    float currentY = margin; 

    fill(titleColor);
    textSize(26); 
    textAlign(CENTER, TOP);
    text("VAST Map Project - About", w / 2, currentY);
    currentY += textAscent() + textDescent() + 20; 

    stroke(separatorColor); 
    strokeWeight(2);
    line(margin, currentY, w - margin, currentY);
    currentY += 20;
    noStroke();

    fill(textColor);
    textSize(20); 
    textAlign(LEFT, TOP);
    float introTextHeightEst = 90; 
    text(projectIntroText, margin, currentY, availableWidth, introTextHeightEst * 2);
    currentY += introTextHeightEst + verticalPadding; 

    fill(titleColor);
    textSize(24); 
    textAlign(CENTER, TOP);
    text(teamSectionTitle, w / 2, currentY);
    currentY += textAscent() + textDescent() + verticalPadding; 

    // Draw Top Row (3 Developers)
    float cursorX = topRowStartX;
    for (int i = 0; i < numTopRow; i++) {
      drawDeveloper(i, cursorX, currentY, calculatedImgWidth, calculatedImgHeight);
      cursorX += calculatedImgWidth + calculatedPaddingH; 
    }
    currentY += calculatedImgHeight + estimatedTextBlockHeight + verticalPadding - 160;

    // Draw Bottom Row (2 Developers)
    cursorX = bottomRowStartX;
    for (int i = numTopRow; i < numDevs; i++) {
       drawDeveloper(i, cursorX, currentY, calculatedImgWidth, calculatedImgHeight);
       cursorX += calculatedImgWidth + calculatedPaddingH; 
    }
    closeButton.display();
    popMatrix();
  }

  void drawDeveloper(int index, float xPos, float yPos, float imgW, float imgH) {
    if (devImages[index] != null) {
      image(devImages[index], xPos, yPos, imgW, imgH);
    }

    float currentTextY = yPos + imgH + textPaddingBelowImage;
    fill(nameColor); 
    textSize(23); 
    textAlign(CENTER, TOP);
    text(devNames[index], xPos + imgW / 2, currentTextY);
    currentTextY += textAscent() + textDescent() + textPaddingBelowName;

    if (devRoles[index] != null && !devRoles[index].isEmpty()) {
        fill(titleColor); 
        textSize(20);
        textAlign(CENTER, TOP);
        text(devRoles[index], xPos + imgW / 2, currentTextY);
        currentTextY += textAscent() + textDescent() + textPaddingBelowName + 15;
    } else if (index == 0) {
         currentTextY += (textAscent() + textDescent() + textPaddingBelowName + 15) * 0.5; // Add some space
    }

    fill(textColor);
    textSize(18); 
    textAlign(CENTER, TOP);
    text(devDescriptions[index], xPos + (imgW * 0.05f), currentTextY, imgW * 0.9f, 120);
  }
}
