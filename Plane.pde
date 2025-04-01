/*
To go in Main
import processing.sound.*;
import java.util.Map;

PImage plane;
final int framerate=60;
Plane boeing;
SoundFile planeFly;

  plane = loadImage("Plane.png");
  plane.resize(height/15, height/15);
  boeing = new Plane(width/2,height/2,100,100);
  planeFly = new SoundFile(this, "airplane-lift-off-01.mp3");
  
  if(boeing.isVisible){
    boeing.fly();
    boeing.draw();
  }


*/


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
  //String[] results = text.split("(?<=\\G.{" + 4 + "})");   //allegedly splits string every 4 chars
  
  /*
  Plane(int originX, int originY, int destX, int destY){
    
    this.loadData();
    isVisible=true;
    this.originX = originX;
    this.originY = originY;
    //this.destX = destX;
    //this.destY = destY;
    this.x = 0;
    this.y = 0;
    timer=0;
    angle=atan2(-originY+destY,-originX+destX)+HALF_PI;
    distance=sqrt((destX-originX)*(destX-originX) + (destY-originY)*(destY-originY));
  
  }
  */
  
  
  
  Plane(){
    
    this.loadData(); 
    isVisible=false;

    this.x = 0;
    this.y = 0;
    
    timer=200;
  }
  
  void fly(){
    if (timer==0){
      planeFly.play(3.5); //rate, pos, amp, add, cue
      planeFly.amp(.2); //volume
      
    }
  
     if (timer < framerate*travelTime) {
       //x = originX + ((timer/(framerate*4)) * (destX - originX));
       //y = originY + ((timer/(framerate*4)) * (destY - originY));
       //println(x + " " + y);
       //x+=(destX - originX)/(framerate*travelTime);
       y-=distance/(framerate*travelTime);
       
     }
    
    if(timer > framerate*(travelTime+1)){
      isVisible=false;
    
    }
  
    timer++;
  }
  
  void draw(){
    
    println("angle " + angle);
    
    pushMatrix();
    translate(originX, originY);
    rotate(angle);
    image(plane, x, y);
    popMatrix();

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
    
    angle=atan2(-this.originY+this.destY,-this.originX+this.destX)+HALF_PI;
    distance=sqrt((this.destX-this.originX)*(this.destX-this.originX) + (this.destY-this.originY)*(this.destY-this.originY));
  
  
  }
  
  
}
