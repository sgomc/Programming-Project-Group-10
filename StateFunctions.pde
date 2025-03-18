
String getStateName(State state) //Converts enum into string, replacing "_" with " " and capitalising first words
{
  String enumName = state.toString();
  String returnString = "";
  for(int i=0; i<enumName.length(); i++)
  {
    if(enumName.charAt(i)=='_')
    {
      returnString += " ";
    }
    else
    {
      if(returnString.length() == 0 || returnString.charAt(i-1) == ' ')
      {
        returnString += enumName.charAt(i);
      }
      else
      {
        returnString += Character.toLowerCase(enumName.charAt(i));
      }
    }
  }
  return returnString;
}



int getStateX(State state)
{
  switch(state)
  {
    case ALABAMA:
      return 1375;
    case ALASKA:
      return 0;
     case ARIZONA:
      return 460;
    default:
      return 0;
  }
 
 
}
int getStateY(State state)
{
  switch(state)
  {
    case ALABAMA:
      return 650;
    case ALASKA:
      return 0;
    case ARIZONA:
      return 580;
    default:
      return 0;
  }
 
}
