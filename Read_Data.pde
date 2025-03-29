//ArrayList<DataPoint> dataList = new ArrayList<DataPoint>();

//void setup() {
//  size(600, 400);
//  loadData();
//}

//void draw() {
//  background(240);
//  printData();
//}

//void loadData() {
//  String[] lines = loadStrings("flights_full.csv");  // Corrected file extension
//  if (lines == null) {
//    println("Error: File not found!");
//    return;
//  }
  
//  for (String line : lines) {
//    println(line);  // Print each line for verification
//    dataList.add(new DataPoint(line));  // Store in ArrayList
//  }
//}

//void printData() {
//  int y = 50;
//  textSize(18);
//  fill(50);

//  for (DataPoint dp : dataList) {
//    text(dp.toString(), 50, y);  // Display on screen
//    y += 30;  // Space out lines
//  }
//}

//class DataPoint {
//  String value;

//  DataPoint(String value) {
//    this.value = value;
//  }

//  public String toString() {
//    return value;
//  }
//}
