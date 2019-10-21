import java.util.*;

//draw() is your view
//should only reference the model, aka the data from the table

//CONTROLLER
//mouse functions
//keyboard functions

//VARS
//falls under model, can grab from view

class Barchart extends Frame {

  Table data;
  String useColumn;
  ArrayList<String> headers = new ArrayList();
  String rowName;
  String colName;
  int currentCol = 0;
  HashMap<Float, Integer> dataMap = new HashMap<Float, Integer>();
  
  
  
  // Constants, referenced from processing website for linear gradient
  int Y_AXIS = 1;
  int X_AXIS = 2;
  
  //========================================
  //Colors for bar graphs dependent on party
  //========================================
  color colorTop = #092f60;
  color colorBot = #a5efd8;  
  color colorTopAlt = #820028;
  color colorBotAlt = #ffdd9e; 

  Barchart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  void draw() { 
    fill(0);
    stroke(0);
    int startX = 450;
    int startY = 20;
    int xSpace = 330;
    int ySpace = 320;
    
    for (int i = 0; i < data.getColumnCount(); i++){
      headers.add(data.getColumnTitle(i));
    }
    colName = headers.get(currentCol);
    setData(colName, colName);
    smooth();
    int rows = data.getRowCount();
    dataMap = getUniqueItemsFreq(colName);

    
    float sizeOfGraph = 400;
    
    //widths for graph frame
    float beginWidth = startX;
    float endWidth = startX+xSpace;
    
    //heights for graph frame
    float beginHeight = startY;
    float endHeight = startY+ySpace;

    //Calculations for length of horizontal and vertical graph lines
    float frameWidth = endWidth - beginWidth;
    float frameHeight = endHeight - beginHeight; 
    
    //Scale value for data
    float scale = frameHeight/100;
    
    //Sets size of text to fit size of canvas
    textSize(2);
    fill(30);
    
    float rowStartRange = Collections.min(dataMap.values());
    float rowEndRange = Collections.max(dataMap.values())*1.20;
    
    float colStartRange = findStartRange(colName);
    float colEndRange = findEndRange(colName);
    
    //Calculates space for data items
    float space = (frameWidth)/(rows);
    float p = beginWidth;
    float range = endHeight;
    line(endWidth, range, beginWidth, range);
    range = range - (endHeight*0.25);
    
    drawHorLines(beginWidth, endWidth, beginHeight, endHeight);
    drawVerLines(beginWidth, endWidth, beginHeight, endHeight);
    text((int)colStartRange, beginWidth*.90, endHeight*1.06);
    text((int)colEndRange, endWidth*.98, endHeight*1.06);
    
    text((int)rowEndRange, beginWidth*.90, beginHeight*1.06);
    text((int)rowStartRange, beginWidth*.98, endHeight*1.06);

    textAlign(LEFT);
    //=======================================
    // Iterate through data map and display data
    //=======================================
    for (Float key : dataMap.keySet()){
      noStroke();
      //start x, start y, width, height, color, color, type
      if (mouseX >= map(key, colStartRange, colEndRange, beginWidth, endWidth) && mouseX <= map(key, colStartRange, colEndRange, beginWidth, endWidth)+sizeOfGraph*0.007){
        setGradient(map(key, colStartRange, colEndRange, beginWidth, endWidth), endHeight - map(dataMap.get(key), rowStartRange, rowEndRange, beginHeight, endHeight), sizeOfGraph*0.01, map(dataMap.get(key), rowStartRange, rowEndRange, beginHeight, endHeight), colorTopAlt, colorBotAlt, Y_AXIS);
        println("Value: " + key + "Frequency: " + dataMap.get(key)); 
        text("Value: " + key + " Frequency: " + dataMap.get(key), endWidth/2-20, 35);
      } else {
        setGradient(map(key, colStartRange, colEndRange, beginWidth, endWidth), endHeight - map(dataMap.get(key), rowStartRange, rowEndRange, beginHeight, endHeight), sizeOfGraph*0.01, map(dataMap.get(key), rowStartRange, rowEndRange, beginHeight, endHeight), colorTop, colorBot, Y_AXIS);
      }
      stroke(90);
    }
    /*
    for (TableRow row: data.rows()) {
      noStroke();
      setGradient(map(row.getFloat(colName), colStartRange, colEndRange, beginWidth, endWidth), endHeight - map(row.getFloat(rowName), rowStartRange, rowEndRange, endHeight, beginHeight), sizeOfGraph*0.007, map(row.getFloat(rowName), rowStartRange, rowEndRange, endHeight, beginHeight), colorTop, colorBot, Y_AXIS);
      stroke(90);
    }*/
    
    
    //===================================
    //prints labels of data
    //===================================
    //calculate dynamic size of labels
    textSize(20);
    
    //rotate vertical label yeet
    //translate(width/2, height/2);
    //rotate(-HALF_PI);
    //text("Value1", -28, -height*0.44);
    stroke(0);
    fill(0);
  }
  
  
  
  HashMap<Float, Integer> getUniqueItemsFreq(String dataName) {
    ArrayList<Float> tableData = new ArrayList<Float>();
    for (TableRow row: data.rows()){ 
      tableData.add(row.getFloat(dataName));
    }
    HashSet<Float> noDupSet = new HashSet<Float>();
    for (TableRow row: data.rows()) {
      noDupSet.add(row.getFloat(dataName));
    }
    HashMap<Float, Integer> hmap = new HashMap<Float,Integer>();
    for (Float num : noDupSet) {
      hmap.put(num, Collections.frequency(tableData, num));
    }
    return hmap;
  }
  
  
  
  float findStartRange(String dataName){
    ArrayList<Float> valueList = new ArrayList<Float>();
    for (TableRow row : data.rows()) {
      valueList.add(row.getFloat(dataName));
    }
    float min = Collections.min(valueList);
    if (min > 100) {
      min -= min%100;
    }
    if (min > 10 && min < 100) {
      min -= min%10;
    }
    if (min > 0 && min < 10) {
      min = 0;
    }
    return min;
  }
  
  float findEndRange(String dataName){
    ArrayList<Float> valueList = new ArrayList<Float>();
    for (TableRow row : data.rows()) {
      valueList.add(row.getFloat(dataName));
    }
    float max = Collections.max(valueList);
    if (max > 100) {
      max += 10;
      //max += 100 - (max%100);
    }
    if (max > 10 && max < 100) {
      max += 5;
      //max += 10 - (max%10);
    }
    if (max > 0 && max < 10) {
      max += 0.10;
      //max += 10 - (max%10);
    }
    return max;
  }
  
  void drawHorLines(float beginWidth, float endWidth, float beginHeight, float endHeight) {
    stroke(210);
    float i = beginHeight;
    float rowInc = (endHeight - beginHeight)/4;
    while (i <= endHeight) {
      line(beginWidth, i, endWidth, i);
      i += rowInc;
    }
    stroke(0);
  }
  
  void setGradient(float x, float y, float w, float h, color c1, color c2, int axis ) {

    noFill();
  
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (float i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (float i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
  
  void drawVerLines(float beginWidth, float endWidth, float beginHeight, float endHeight) {
    stroke(210);
    
    float i = beginWidth;
    float rowInc = (endWidth - beginWidth)/4;
    while (i <= endWidth) {
      line(i, beginHeight, i, endHeight);
      i += rowInc;
    }
    stroke(0);
  }
  
  void setData(String _colName, String _rowName){
    colName = _colName;
    rowName = _rowName;
  }
  
  void keyPressed() {
  }

  void mousePressed() { 
        currentCol = (currentCol+1)%(data.getColumnCount());
  }

  void mouseReleased() {   }
  
}
