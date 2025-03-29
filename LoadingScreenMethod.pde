
void loadingScreen()
{
  //introVar 0 is for the planet 1 is for the stars background 2 duration count 3 tint changing  

  fill(0, 408, 612, 816);
 
  textFont(createFont("text/PressStart2P-Regular.ttf", 32));
  textSize(128);
  
  int duration = 7*60;
  if(introVar[2] >= duration/2){
    background(image);
  }else{
    
    background(0);
  }
  if(introVar[2] <= 50)
  {
    
    introVar[3] += 5;
    tint(introVar[3],introVar[3]);
  }
  if(introVar[2]++ <= duration)
  {
    if(introVar[1] < 10  && frameCount %2 !=0 && frameCount %3 !=0) intro[0] = loadImage("stars/frame_0"+introVar[1]+++"_delay-0.09s.gif");
    if(introVar[1] >=10 &&frameCount %2 !=0 && frameCount %3 !=0) intro[0] = loadImage("stars/frame_"+introVar[1]+++"_delay-0.09s.gif");
    if(introVar[1] > 39 ) introVar[1] = 0;
    
    if(introVar[0] < 10  && frameCount %2 !=0 && frameCount %3 !=0) intro[1] = loadImage("earth/frame_0"+introVar[0]+++"_delay-0.17s.gif");
    if(introVar[0] >=10 &&frameCount %2 !=0 && frameCount %3 !=0) intro[1] = loadImage("earth/frame_"+introVar[0]+++"_delay-0.17s.gif");
    if(introVar[0] > 59 ) introVar[0] = 0;
    intro[0].resize(width,height);
    image(intro[0],0,0);
    intro[1].resize(400,400);
    image(intro[1],width/2 -200,height/2-200);
    if(introVar[2] >= 56){
    text("VAST MAP", width/2-500, height/2+400);  
    }
    if(introVar[2] > duration/2 )
    {
      
      
      intro[1].filter(BLUR, (introVar[2]/60)-5);
      textSize(64);
      
      if(introVar[2]%20 == 0)
      {
        dotsIntro += ".";
        if(dotsIntro.length() > 3) dotsIntro = "";
      }
      text("loading"+dotsIntro, width/2-300, height/2+500);
      if(introVar[2] >= duration-56)
      {
        introVar[3] -= 5;
        tint(introVar[3],introVar[3]);
      }
    
    }
   
  }else{
    
    noTint();
    loading = false;
  }
 
  textFont(loadFont("text/ArialMT-48.vlw"));
  
  
}
