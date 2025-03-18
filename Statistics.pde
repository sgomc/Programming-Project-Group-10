class Statistics
{
  Axis Axis;
  PImage image = loadImage("playstation-x-button-ezgif.com-resize.gif");
  public Statistics(int num)
  {
    image.resize(75,75);
    Axis = new Axis(num);
    
  }
  void barChart(String pattern, String header,color barColor,int plot)
  {
    if(plot == 1) background(255);
    HashMap<String,Integer> map = new HashMap<>();
    for(TableRow item:table.matchRows(pattern, header))
    {
       String myString = item.getString(header);
       map.put(myString,map.getOrDefault(myString,0)+1);
    }
    
   
    int counter = 0;
    float histMax = 0;
    float histMin = Float.MAX_VALUE;
    for(Integer item: map.values())
    {
      int value = Integer.valueOf(item);
      if(histMax < value) histMax = value;
      if(histMin > value) histMin = value;
      
      
    }
    counter = 1;
    
    
    int strokeWeight = (plot == 1) ?(Axis.Xend-Axis.Xstart)/(map.size()) :(Axis.X1end-Axis.X1start)/(map.size());
    if(strokeWeight > 20) strokeWeight = 20;
    Axis.XYaxis(histMax);
    strokeCap(SQUARE);
    stroke(barColor);
    strokeWeight(strokeWeight/1.1);
    fill(0);
    float range = (Axis.Ystart-100)/histMax;
    textSize(strokeWeight/1.5);
    for(String item: map.keySet())
    {
      
      
      
      int position = ((plot == 1)? Axis.Xstart:Axis.X1start)+counter*strokeWeight;
      int y = int( (Integer.valueOf(map.get(item))-0)*range);
      line(position, Axis.Ystart,position, Axis.Ystart-y);
      text(item,-strokeWeight/5+position, Axis.Ystart+30);
      counter++;
    }
    
    textSize(15);
    text("Hours",((plot == 1) ? (Axis.Xstart +(Axis.Xend-Axis.Xstart)/2):(Axis.X1start +(Axis.X1end-Axis.X1start)/2)) ,Axis.Ystart+60);
    text("Scaled y axis \n["+histMax+((("["+histMax+", "+histMin+"]").length() > 14) ? "\n ":"")+","+histMin+"]",(plot == 1) ? Axis.Xstart-100:Axis.X1start-100,Axis.Ystart/2);
    
  }
  void scatterPlot(String header,color pointColor,int plot)
  {
    
    int modulo = 30;
    HashMap<Integer,Integer> map = new HashMap<>();
    for(TableRow item:table.matchRows(".*", header))
    {
      int value = (item.getInt(header)-item.getInt(header)%modulo)%2400;
      map.put(value,map.getOrDefault(value,0)+1);
    }
    
    drawScatterPlot(map,modulo,pointColor,plot);
    
  }
  void scatterPlot(String header ,String city,String citiesHeader,color pointColor,int plot)
  {
    if(plot == 1) background(255);
    int modulo = 100;
    HashMap<Integer,Integer> map = new HashMap<>();
    for(TableRow item:table.matchRows(".*", header))
    {
      
      if(item.getString(citiesHeader).equals(city))
      {
        int value = (item.getInt(header)-item.getInt(header)%modulo)%2400;
        map.put(value,map.getOrDefault(value,0)+1);
      }
    }
    
    drawScatterPlot(map,modulo,pointColor,plot);
    
  }
  void drawScatterPlot(HashMap<Integer,Integer> map,int modulo,color pointColor,int plot)
  {
    
    int counter = 1;
    float histMax = 0;
    float histMin = Float.MAX_VALUE;
    for(Integer item: map.values())
    {
      int value = Integer.valueOf(item);
      if(histMax < value) histMax = value;
      if(histMin > value) histMin = value;
      
    }
    
    
    
    int strokeWeight = (plot == 1) ?(Axis.Xend-Axis.Xstart)/(map.size()) :(Axis.X1end-Axis.X1start)/(map.size());
    SortedSet<Integer> set = new TreeSet<>(map.keySet());
    Axis.XYaxis(histMax);
    textSize(10);
    strokeCap(SQUARE);
    stroke(pointColor);
    fill(0);
    float range = (Axis.Ystart-100)/histMax;
    
    for(Integer item: set)
    {
      
      
      int position = ((plot == 1)? Axis.Xstart:Axis.X1start)+counter++*strokeWeight;
      int y = int( (Integer.valueOf(map.get(item))-0)*range);
      circle(position,Axis.Ystart - y,10);
      text((double)(item-item%modulo)/100 + "",-strokeWeight/10+position, Axis.Ystart+30);
      
    }
    textSize(15);
    text("Hours",((plot == 1) ? (Axis.Xstart +(Axis.Xend-Axis.Xstart)/2):(Axis.X1start +(Axis.X1end-Axis.X1start)/2)) ,Axis.Ystart+60);
    text("Scaled y axis \n["+histMax+", "+histMin+"]",(plot == 1) ? Axis.Xstart-100:Axis.X1start-100,Axis.Ystart/2);
    
  }
  boolean closeButton()
  {
    
    image(image,width-150, 0);
    if(mouseX > width-150 && mouseY<150 && mousePressed && (mouseButton == LEFT))
    {
      return true;
    } 
    return false;
  }
  //might not even be neccessary but just for clarity
  private class Axis
  {
    int Xstart,Xend,Ystart,X1start,X1end,num;
    
    public Axis(int plot)
    {
      num = plot;
      
      switch(plot)
      {
        case 1:
        Xstart = 100;
        Xend = width-100;
        Ystart = height-100;
        break;
        case 2:
        Xstart = 100;
        Xend = width/2-100;
        Ystart = height-100;
        X1start = width/2;
        X1end = width -100;
      }
      
    }
    
    void XYaxis(float max)
    {
      
      stroke(0);
      strokeWeight(1);
      strokeJoin(ROUND);
      strokeCap(SQUARE);
      float range = (Axis.Ystart-100)/max;
      switch(num)
      {
        case 1:
        //println(Ystart);
        line(100,Ystart,100,0);
        line(100,Ystart,Xend,Ystart);
        line(100,Ystart-int( ((max/4)*3)*range),Xend,Ystart-int( (Integer.valueOf(map.get(item))-0)*range));
        break;
        case 2:
        line(100,Ystart,100,0);
        line(100,Ystart,Xend,Ystart);
        line(Xend,Ystart,Xend-5,Ystart-5);
        line(Xend,Ystart,Xend-5,Ystart+5);
        line(X1start,Ystart,X1start,0);
        line(X1start,Ystart,X1end,Ystart);
        line(X1end,Ystart,X1end-5,Ystart-5);
        line(X1end,Ystart,X1end-5,Ystart+5);
        break;
      }
      
      
    }
    
    
    
  }
}
