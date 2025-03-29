String getStateName(State state) //Converts enum into string, replacing "_" with " " and capitalising first words
{
  String enumName = state.toString();
  String returnString = "";
  for (int i=0; i<enumName.length(); i++)
  {
    if (enumName.charAt(i)=='_')
    {
      returnString += " ";
    } else
    {
      if (returnString.length() == 0 || returnString.charAt(i-1) == ' ')
      {
        returnString += enumName.charAt(i);
      } else
      {
        returnString += Character.toLowerCase(enumName.charAt(i));
      }
    }
  }
  return returnString;
}

float getStateX(State state)
{
  switch(state)
  {
  case ALABAMA:
    return 0.713;
  case ALASKA:
    return 0.11;
  case ARIZONA:
    return 0.24;
  case ARKANSAS:
    return 0.5975;
  case CALIFORNIA:
    return 0.105;
  case COLORADO:
    return 0.356;
  case CONNECTICUT:
    return 0.9145;
  case DELAWARE:
    return 0.884;
  case FLORIDA:
    return 0.825;
  case GEORGIA:
    return 0.780;
  case HAWAII:
    return 0.06;
  case IDAHO:
    return 0.2265;
  case ILLINOIS:
    return 0.6485;
  case INDIANA:
    return 0.7025;
  case IOWA:
    return 0.5655;
  case KANSAS:
    return 0.4785;
  case KENTUCKY:
    return 0.72;
  case LOUISIANA:
    return 0.615;
  case MAINE:
    return 0.942;
  case MARYLAND:
    return 0.864;
  case MASSACHUSETTS:
    return 0.915;
  case MICHIGAN:
    return 0.716;
  case MINNESOTA:
    return 0.543;
  case MISSISSIPI:
    return 0.656;
  case MISSOURI:
    return 0.595;
  case MONTANA:
    return 0.315;
  case NEBRASKA:
    return 0.466;
  case NEVADA:
    return 0.17;
  case NEW_HAMPSHIRE:
    return 0.917;
  case NEW_JERSEY:
    return 0.896;
  case NEW_MEXICO:
    return 0.342;
  case NEW_YORK:
    return 0.840;
  case NORTH_CAROLINA:
    return 0.835;
  case NORTH_DAKOTA:
    return 0.455;
  case OHIO:
    return 0.755;
  case OKLAHOMA:
    return 0.510;
  case OREGON:
    return 0.115;
  case PENNSYLVANIA:
    return 0.836;
  case RHODE_ISLAND:
    return 0.935;
  case SOUTH_CAROLINA:
    return 0.817;
  case SOUTH_DAKOTA:
    return 0.447;
  case TENNESEE:
    return 0.7;
  case TEXAS:
    return 0.4825;
  case UTAH:
    return 0.2495;
  case VERMONT:
    return 0.895;
  case VIRGINIA:
    return 0.84;
  case WASHINGTON:
    return 0.1465;
  case WEST_VIRGINIA:
    return 0.7915;
  case WISCONSIN:
    return 0.620;
  case WYOMING:
    return 0.334;
  case PUERTO_RICO:
    return 0.282;
  case GUAM:
    return 0.315;
  case SAMOA:
    return 0.36;
  case SAIPAN:
    return 0.26;
  case VIRGIN_ISLANDS:
    return 0.41;

  default:
    return 0;
  }
}
float getStateY(State state)
{
  switch(state)
  {
  case ALABAMA:
    return 0.665;
  case ALASKA:
    return 0.77;
  case ARIZONA:
    return 0.631;
  case ARKANSAS:
    return 0.627;
  case CALIFORNIA:
    return 0.514;
  case COLORADO:
    return 0.487;
  case CONNECTICUT:
    return 0.282;
  case DELAWARE:
    return 0.383;
  case FLORIDA:
    return 0.795;
  case GEORGIA:
    return 0.66;
  case HAWAII:
    return 0.95;
  case IDAHO:
    return 0.323;
  case ILLINOIS:
    return 0.441;
  case INDIANA:
    return 0.445;
  case IOWA:
    return 0.3955;
  case KANSAS:
    return 0.516;
  case KENTUCKY:
    return 0.515;
  case LOUISIANA:
    return 0.767;
  case MAINE:
    return 0.12;
  case MARYLAND:
    return 0.395;
  case MASSACHUSETTS:
    return 0.252;
  case MICHIGAN:
    return 0.319;
  case MINNESOTA:
    return 0.2622;
  case MISSISSIPI:
    return 0.681;
  case MISSOURI:
    return 0.515;
  case MONTANA:
    return 0.221;
  case NEBRASKA:
    return 0.42;
  case NEVADA:
    return 0.445;
  case NEW_HAMPSHIRE:
    return 0.207;
  case NEW_JERSEY:
    return 0.347;
  case NEW_MEXICO:
    return 0.643;
  case NEW_YORK:
    return 0.282;
  case NORTH_CAROLINA:
    return 0.533;
  case NORTH_DAKOTA:
    return 0.212;
  case OHIO:
    return 0.408;
  case OKLAHOMA:
    return 0.608;
  case OREGON:
    return 0.266;
  case PENNSYLVANIA:
    return 0.35;
  case RHODE_ISLAND:
    return 0.268;
  case SOUTH_CAROLINA:
    return 0.585;
  case SOUTH_DAKOTA:
    return 0.322;
  case TENNESEE:
    return 0.575;
  case TEXAS:
    return 0.757;
  case UTAH:
    return 0.48;
  case VERMONT:
    return 0.192;
  case VIRGINIA:
    return 0.467;
  case WASHINGTON:
    return 0.16;
  case WEST_VIRGINIA:
    return 0.446;
  case WISCONSIN:
    return 0.287;
  case WYOMING:
    return 0.342;
  case PUERTO_RICO:
    return 0.96;
  case GUAM:
    return 0.89;
  case SAMOA:
    return 0.9465;
  case SAIPAN:
    return 0.86;
  case VIRGIN_ISLANDS:
    return 0.936;
  default:
    return 0;
  }
}

String getStateAbbreviation(String name) {
    switch (name) {
        case "Alabama": return "AL";
        case "Alaska": return "AK";
        case "Arizona": return "AZ";
        case "Arkansas": return "AR";
        case "California": return "CA";
        case "Colorado": return "CO";
        case "Connecticut": return "CT";
        case "Delaware": return "DE";
        case "Florida": return "FL";
        case "Georgia": return "GA";
        case "Hawaii": return "HI";
        case "Idaho": return "ID";
        case "Illinois": return "IL";
        case "Indiana": return "IN";
        case "Iowa": return "IA";
        case "Kansas": return "KS";
        case "Kentucky": return "KY";
        case "Louisiana": return "LA";
        case "Maine": return "ME";
        case "Maryland": return "MD";
        case "Massachusetts": return "MA";
        case "Michigan": return "MI";
        case "Minnesota": return "MN";
        case "Mississipi": return "MS";
        case "Missouri": return "MO";
        case "Montana": return "MT";
        case "Nebraska": return "NE";
        case "Nevada": return "NV";
        case "New Hampshire": return "NH";
        case "New Jersey": return "NJ";
        case "New Mexico": return "NM";
        case "New York": return "NY";
        case "North Carolina": return "NC";
        case "North Dakota": return "ND";
        case "Ohio": return "OH";
        case "Oklahoma": return "OK";
        case "Oregon": return "OR";
        case "Pennsylvania": return "PA";
        case "Puerto Rico": return "PR";
        case "Rhode Island": return "RI";
        case "South Carolina": return "SC";
        case "South Dakota": return "SD";
        case "Tennesee": return "TN";
        case "Texas": return "TX";
        case "Utah": return "UT";
        case "Virginia": return "VA";
        case "Virgin Islands": return "VI";
        case "Washington": return "WA";
        case "West Virginia": return "WV";
        case "Wisconsin": return "WI";
        case "Wyoming": return "WY";
        case "Guam": return "TT";
        case "Samoa": return "TT";
        case "Saipan": return "TT";
        case "Vermont": return "VT";
        default: return "";
    }
}
