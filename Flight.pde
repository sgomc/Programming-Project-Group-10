class Flight {
  String flightNumber, departureTime, arrivalTime, destination, date;
  String originState, destState, originCity, destCity;
  String CRS_DEP_TIME, DEP_TIME, CRS_ARR_TIME, ARR_TIME;

  Flight(String flightNumber, String departureTime, String arrivalTime,
    String destination, String date, String originState, String destState,
    String originCity, String destCity) {
    this.flightNumber = flightNumber;
    this.departureTime = formatTime(departureTime);
    this.arrivalTime = formatTime(arrivalTime);
    this.destination = destination;
    this.date = formatDate(date);
    this.originState = originState;
    this.destState = destState;
    this.originCity = originCity;
    this.destCity = destCity;

    //I stored the raw times for delay calculation
    this.CRS_DEP_TIME = departureTime.replaceAll("[^0-9]", "");
    this.DEP_TIME = departureTime.replaceAll("[^0-9]", "");
    this.CRS_ARR_TIME = arrivalTime.replaceAll("[^0-9]", "");
    this.ARR_TIME = arrivalTime.replaceAll("[^0-9]", "");
  }

  // Helper method to format time
  public String formatTime(String time) {
    // Remove all non-digit characters
    time = time.replaceAll("[^0-9]", "");

    // If empty, return unknown
    if (time.isEmpty()) return "??:??";

    // Pad with leading zeros if needed
    while (time.length() < 4) {
      time = "0" + time;
    }

    try {
      int timeInt = Integer.parseInt(time.substring(0, 4));
      int hours = timeInt / 100;
      int minutes = timeInt % 100;

      // Validate time
      if (hours >= 24 || minutes >= 60) {
        return "??:??";
      }

      // Convert to 12-hour format
      String amPm = (hours >= 12) ? "PM" : "AM";
      hours = hours % 12;
      if (hours == 0) hours = 12;

      return String.format("%d:%02d %s", hours, minutes, amPm);
    }
    catch (NumberFormatException e) {
      return "??:??";
    }
  }

  // Helper method to format date
  private String formatDate(String date) {
    // Remove time portion and trim
    date = date.split(" ")[0].trim();

    // Split date parts
    String[] dateParts = date.split("/");
    if (dateParts.length >= 3) {
      // Ensure two-digit month and day
      String month = dateParts[0].length() == 1 ? "0" + dateParts[0] : dateParts[0];
      String day = dateParts[1].length() == 1 ? "0" + dateParts[1] : dateParts[1];
      return month + "/" + day + "/" + dateParts[2];
    }

    return date;
  }

  public String toString() {
    return flightNumber + " | " +
      originCity + ", " + originState + " -> " +
      destCity + ", " + destState + " | " +
      "Dep: " + departureTime;
  }
}
