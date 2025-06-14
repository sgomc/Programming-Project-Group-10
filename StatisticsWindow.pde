//class StatisticsWindow done by Maccollins Obijiaku

class StatisticsWindow extends Window {
  StatisticsWindow(int x, int y, int w, int h) {
    super(x, y, w, h);
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
    Statistics stats = new Statistics(x+150,y+100,w-200,h-200,2);
    String depOrArr = "Departures and arrivals: ";
    TableRow row = table.findRow(searchedFlightNumber,"MKT_CARRIER_FL_NUM");
    if(row != null){
      if(departuresTab.isSelected)
      {
        stats.plot("BAR","DEP_TIME",row.getString("DEST_STATE_ABR"),"DEST_STATE_ABR",color(150, 175, 255),1,"Hours","Freq");
        stats.plot("LINE","DEP_TIME",row.getString("DEST_STATE_ABR"),"DEST_STATE_ABR",color(40, 95, 255),2,"Hours","Freq");
        depOrArr = "Departures: ";
      }else if(arrivalsTab.isSelected){
        stats.plot("BAR","ARR_TIME",row.getString("ORIGIN_STATE_ABR"),"ORIGIN_STATE_ABR",color(150, 175, 255),1,"Hours","Freq");
        stats.plot("LINE","ARR_TIME",row.getString("ORIGIN_STATE_ABR"),"ORIGIN_STATE_ABR",color(40, 95, 255),2,"Hours","Freq");
        depOrArr = "Arrivals: ";
      }
    }else{
        stats.plot("BAR","FL_DATE",".*","ORIGIN_CITY_NAME",color(150, 175, 255),1,"Days","Freq");
        stats.plot("BAR","FL_DATE",".*","DEST_CITY_NAME",color(40, 95, 255),2,"Days","Freq");
    }
    strokeWeight(1);
    textSize(18);
    textAlign(LEFT, TOP);
    text(depOrArr+"State flights frequency "+((row != null) ? ("by the hour for "+row.getString("ORIGIN_CITY_NAME")):"by the day for all states.") , 20, 50);
    closeButton.display();
    popMatrix();
  }
}
