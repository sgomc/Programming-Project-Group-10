//#Done by Maccollins Obijiaku
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.Comparator;
import java.util.Collections;
class Statistics
{
  Axis Axis;
  int currentPlot;
  int windowWidth = 0;
  int windowHeight = 0;
  public Statistics(int x,int y, int windowWidth, int windowHeight ,int num)
  {
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    
    Axis = new Axis(num,x,y);
  }

  void plot(String type, String header, String cityPattern, String pattern, color barColor, int plot, String xLabel, String yLabel)
  {
    currentPlot = plot;
    HashMap<String, Integer> map = new HashMap<>();
    for (TableRow item : table.matchRows(cityPattern, pattern))
    {
      String myString = item.getString(header);

      if (myString.split("/").length > 1) {
        myString = myString.split("/")[1];
        
      }
      if (myString.length() > 0) {
        if ((header == "DEP_TIME" || header == "ARR_TIME" || header == "CRS_DEP_TIME")) {
          myString =((Integer.valueOf(myString)-Integer.valueOf(myString)%100)%2400)/100+"";
        }
        map.put(myString, map.getOrDefault(myString, 0)+1);
      }
    }
    
    float histMax = 0;
    float histMin = Float.MAX_VALUE;
    for (Integer item : map.values())
    {
      int value = Integer.valueOf(item);
      if (histMax < value) histMax = value;
      if (histMin > value) histMin = value;
    }
    Axis.XYaxis(histMax,histMin,xLabel,yLabel);
    switch(type.toUpperCase())
    {
      case "BAR":
        barChart(map,barColor,plot,histMax);
        break;
      case "LINE":
        lineGraph(map,barColor,plot,histMax);
        break;
      default:
        println("not a graph!!");
    }

  }
  void lineGraph(HashMap<String, Integer> map,color pointColor, int plot,float histMax)
  {
    int counter = 1;
    int strokeWeight = (plot == 1) ?(Axis.Xend-Axis.Xstart)/(map.size()) :(Axis.X1end-Axis.X1start)/(map.size());
    if (strokeWeight > 20) strokeWeight = 20;
    
    SortedSet<String> set = new TreeSet<>(   Comparator.comparingInt((String s) -> s.matches("\\d+") ? Integer.parseInt(s) : Integer.MAX_VALUE).thenComparing(String::compareTo));
    set.addAll(map.keySet());
    textSize(10);
    strokeCap(SQUARE);
    stroke(pointColor);
    fill(0);
    textSize(strokeWeight/1.5);
    float range = ((Axis.Ystart-Axis.Yend))/histMax;
    noFill();
    beginShape();
    for (String item : set)
    {

      //println(list.get(counter));
      int position = ((plot == 1)? Axis.Xstart:Axis.X1start)+counter++*strokeWeight;
      int y = int( (Integer.valueOf(map.get(item))-0)*range);
      vertex(position, Axis.Ystart - y);
      text(item, -strokeWeight/5+position, Axis.Ystart+30);
    }
    endShape();
  }
  void barChart(HashMap<String, Integer> map,color pointColor, int plot, float histMax)
  {
    int counter = 1;

    SortedSet<String> set = new TreeSet<>(   Comparator.comparingInt((String s) -> s.matches("\\d+") ? Integer.parseInt(s) : Integer.MAX_VALUE).thenComparing(String::compareTo));
    set.addAll(map.keySet());
    int strokeWeight = (plot == 1) ?(Axis.Xend-Axis.Xstart)/(map.size()) :(Axis.X1end-Axis.X1start)/(map.size());

    if (strokeWeight > 20) strokeWeight = 20;

    
    strokeCap(SQUARE);
    stroke(pointColor);
    strokeWeight(strokeWeight/1.1);
    fill(0);
    
    float range = ((Axis.Ystart-Axis.Yend))/histMax;
    textSize(strokeWeight/1.5);
    for (String item : set)
    {
      int position = ((plot == 1)? Axis.Xstart:Axis.X1start)+counter++*strokeWeight;
      int y = int( (Integer.valueOf(map.get(item))-0)*range);
      line(position, Axis.Ystart, position, Axis.Ystart-y);
      text(item, -strokeWeight/5+position, Axis.Ystart+30);
    }

  }
  
  //might not even be neccessary but just for clarity
  private class Axis
  {
    int Xstart, Xend, Ystart,Yend, X1start, X1end, num;

    public Axis(int toPlot, int x,int y)
    {
      num = toPlot;
      Xstart = x;
      Yend = y;
      switch(toPlot)
      {
      case 1:
        
        Xend = windowWidth-100;
        Ystart = windowHeight-100;
        break;
      case 2:
        
        Xend = windowWidth/2-100+x;
        Ystart = (windowHeight-100)+y;
        X1start = (windowWidth/2+100)+x;
        X1end = windowWidth+x;
      }
    }

    void XYaxis(float max,float min,String xLabel,String yLabel)
    {

      stroke(0);
      strokeWeight(1);
      strokeJoin(ROUND);
      strokeCap(SQUARE);
      int y;
      switch(num)
      {
      case 1:
        //println(Ystart);
        line(Xstart, Ystart, Xstart, Yend);
        line(Xstart, Ystart, Xend, Ystart);
        y = Ystart-int( (Ystart -(((Ystart-Yend)/4)*3)));
        line(Xstart-5, Ystart-y, Xend, Ystart-y);
        text((max/4),Xstart-100, Ystart-y);
        y = Ystart-int( (Ystart -((Ystart-Yend)/4)*2));
        line(Xstart-5, Ystart-y, Xend, Ystart-y);
        text((max/4)*2,Xstart-100, Ystart-y);
        y = Ystart-int( (Ystart -((Ystart-Yend)/4)));
        line(Xstart-5, Ystart-y, Xend, Ystart-y);
        text((max/4)*3,Xstart-100, Ystart-y);
        break;
      case 2:
        switch(currentPlot)
        {
        case 1:
          background(255);
          line(Xstart, Ystart, Xstart, Yend);
          line(Xstart, Ystart, Xend, Ystart);
          line(Xend, Ystart, Xend-5, Ystart-5);
          line(Xend, Ystart, Xend-5, Ystart+5);
          y = Ystart-int( (Ystart-((Ystart-Yend)/4)*3));
          line(Xstart-5, Ystart-y, Xend, Ystart-y);
          text((max/4)*3,Xstart-100, Ystart-y);
          y = Ystart-int( (Ystart -((Ystart-Yend)/4)*2));
          line(Xstart-5, Ystart-y, Xend, Ystart-y);
          text((max/4)*2,Xstart-100, Ystart-y);
          y = Ystart-int( (Ystart -((Ystart-Yend)/4)));
          line(Xstart-5, Ystart-y, Xend, Ystart-y);
          text((max/4),Xstart-100, Ystart-y);

          break;
        case 2:

          line(X1start, Ystart, X1start, Yend);
          line(X1start, Ystart, X1end, Ystart);
          line(X1end, Ystart, X1end-5, Ystart-5);
          line(X1end, Ystart, X1end-5, Ystart+5);
          y = Ystart-int( (Ystart -((Ystart-Yend)/4)*3));
          line(X1start-5,Ystart -y, X1end,Ystart -y);
          text((max/4)*3, X1start-100, Ystart-y);
          y = Ystart-int( (Ystart -((Ystart-Yend)/4)*2));
          line(X1start-5,Ystart -y, X1end,Ystart -y);
          text((max/4)*2, X1start-100, Ystart-y);
          y = Ystart-int( (Ystart -((Ystart-Yend)/4)));
          line(X1start-5,Ystart -y, X1end,Ystart -y);
          text((max/4), X1start-100, Ystart-y);

          break;
        }

        break;
      }
    textSize(windowHeight/66.66);
    text(xLabel, ((currentPlot == 1) ? (Axis.Xstart +(Axis.Xend-Axis.Xstart)/2):(Axis.X1start +(Axis.X1end-Axis.X1start)/2)), Axis.Ystart+60);
    text("Max\n"+yLabel+ ": " +max+ "\n\nMin\n"+yLabel+ ": " +min, (currentPlot == 1) ? Axis.Xstart-100:Axis.X1start-100, Axis.Yend+100);
    }


  }
}
