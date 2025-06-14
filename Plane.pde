class Plane{
  
  final int travelTime=2;
  private float originX;   //origin city coords
  private float originY;
  private float destX;     //destination city coords
  private float destY;
  private float x;         //current position
  private float y;
  private int timer;
  private float angle;
  private float distance;
  public boolean isVisible;
  
  HashMap<String,String> airportCoords = new HashMap<String,String>();
  
  
  //Hashmap airport signifier string to coordinates in a string
  void loadData() {
    String[] lines = loadStrings("airport_coords.csv");
    if (lines == null) {
      println("Error: airport_coords.csv not found!");
      return;
    }
  
    for (int i = 1; i < lines.length; i++) {
      String line = lines[i];
      String[] parts = line.split(",");
      airportCoords.put(parts[0],parts[1]+parts[2]);
    }
  }
  
  Plane(){
    
    this.loadData(); 
    isVisible=false;

    this.x = 0;
    this.y = 0;
    
    timer=200;
  }
  
  void fly(){
  
     if (timer < framerate*travelTime) {
       //x = originX + ((timer/(framerate*4)) * (destX - originX));
       //y = originY + ((timer/(framerate*4)) * (destY - originY));
       //println(x + " " + y);
       //x+=(destX - originX)/(framerate*travelTime);
       y-=distance/(framerate*travelTime);              //when the plane has been rotated the direction to the destination airport is just -y
       
     }
     
    // disappear after traveltime + x seconds
    if(timer > framerate*(travelTime+1)){
      isVisible=false;
    
    }
  
    timer++;
  }
  
  void draw(){
    
    //println("angle " + angle); //testing
    //line(originX, originY, destX, destY);
    imageMode(CENTER);
    pushMatrix();
    translate(originX, originY);
    rotate(angle);
    image(plane, x, y);
    popMatrix();
    imageMode(CORNER);

  }
  
  void reset(String origin, String dest){
  
    isVisible=true;
    
    String[] originTemp = airportCoords.get(origin).split("(?<=\\G.{" + 4 + "})");    //split coordinate string into x and y components
    String[] destTemp = airportCoords.get(dest).split("(?<=\\G.{" + 4 + "})");
    
    int originTempX = Integer.parseInt(originTemp[0]);                                //convert String coordinates to int values
    int originTempY = Integer.parseInt(originTemp[1]);
    int destTempX = Integer.parseInt(destTemp[0]);
    int destTempY = Integer.parseInt(destTemp[1]);
    
    this.originX = map(originTempX,0,1313,0,width);                                   //remap coords from original 1313x900 image to fullscreen size
    this.originY = map(originTempY,0,900,0,height);
    this.destX = map(destTempX,0,1313,0,width);
    this.destY = map(destTempY,0,900,0,height);
    
    this.x = 0;
    this.y = 0;
    
    timer=0;
    
    angle=atan2(-this.originY+this.destY,-this.originX+this.destX)+HALF_PI;         // calculate angle between origin and dest airports                                             
    distance=sqrt((this.destX-this.originX)*(this.destX-this.originX) +             // pythagoras to get the absolute distance between the airports
    (this.destY-this.originY)*(this.destY-this.originY));
    
    //audio
    planeFly.play(3.5); //rate, pos, amp, add, cue
    planeFly.amp(.1); //volume
  }  
}
