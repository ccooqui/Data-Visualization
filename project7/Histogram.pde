import java.util.*;
//Referenced https://statistics.laerd.com/statistical-guides/spearmans-rank-order-correlation-statistical-guide.php
//for spearman equation

class Histogram extends Frame {

  Table data;
  String useColumn;
  ArrayList<String> headers = new ArrayList();
  String rowName;
  String colName;
  int currentCol = 0;
  HashMap<Float, Integer> dataMap = new HashMap<Float, Integer>();
  ArrayList<Float> tableData = new ArrayList<Float>();
  
  
  // Constants, referenced from processing website for linear gradient
  int Y_AXIS = 1;
  int X_AXIS = 2;
  
  //========================================
  //Colors for bar graphs dependent on party
  //========================================
  color colorTop = #6e48aa;
  color colorBot = #9d50bb;  
  color colorTopAlt = #fc9516;
  color colorBotAlt = #efc221; 
  
  int startX;
  int startY;
  int xSpace;
  int ySpace;

  Histogram( Table _data, String _useColumn, int _startX, int _startY, int _xSpace, int _ySpace) {
    data = _data;
    useColumn = _useColumn;
    startX = _startX;
    startY = _startY;
    xSpace = _xSpace;
    ySpace = _ySpace;

    for (TableRow row: data.rows()){ 
      tableData.add(row.getFloat(useColumn));
    }
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  void draw() { 
    fill(0);
    stroke(0);
    for (int i = 0; i < data.getColumnCount(); i++){
      headers.add(data.getColumnTitle(i));
    }
    colName = useColumn;
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
    
    float rowStartRange = 0;
    float rowEndRange = findMaxRange(Collections.max(dataMap.values()));
    
    float colStartRange = 0;
    float colEndRange = findMaxRange(Collections.max(dataMap.values()));
    
    textSize(14);
    fill(#000000);
    text(useColumn, (endWidth+beginWidth)/2.05, 14);
    textSize(10);
    text((int)findMinRange(Collections.min(tableData)), startX, endHeight+20);
    text((int)findMaxRange(Collections.max(tableData)), endWidth-20, endHeight+20);
    
    //Calculates space for data items
    float space = (frameWidth)/(rows);
    float p = beginWidth;
    float range = endHeight;
    line(endWidth, range, beginWidth, range);
    range = range - (endHeight*0.25);
    
    drawHorLines(beginWidth, endWidth, beginHeight, endHeight);
    drawVerLines(beginWidth, endWidth, beginHeight, endHeight);

    textAlign(LEFT);
    //=======================================
    // Iterate through data map and display data
    //=======================================
    int bars = dataMap.size();
    float barSize = frameWidth/bars;
    float barSpace = beginWidth+(barSize/3.5);
    for (Float key : dataMap.keySet()){
       if (mouseX >= barSpace && mouseX <= barSpace+barSize){
        setGradient(barSpace, endHeight - map(dataMap.get(key), rowStartRange, rowEndRange+barSize, beginHeight, endHeight), 10, map(dataMap.get(key), rowStartRange, rowEndRange+barSize, beginHeight, endHeight), colorTopAlt, colorBotAlt, Y_AXIS);
        textSize(14);
        text("Frequency: " + dataMap.get(key), startX+90, endHeight+20);
      } else {
        setGradient(barSpace, endHeight - map(dataMap.get(key), rowStartRange, rowEndRange+barSize, beginHeight, endHeight), 10, map(dataMap.get(key), rowStartRange, rowEndRange+barSize, beginHeight, endHeight), colorTop, colorBot, Y_AXIS);
      }
      stroke(90);
      barSpace = barSpace + barSize;
    }

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
    float minVal = Collections.min(tableData);
    float maxVal = Collections.max(tableData);
    minVal = findMinRange(minVal);

    maxVal = findMaxRange(maxVal);

    float diff = maxVal - minVal;

    HashSet<Float> noDupSet = new HashSet<Float>();
    for (TableRow row: data.rows()) { 
      noDupSet.add(row.getFloat(dataName));
    }
    int buckets = ceil(sqrt(tableData.size()));
    //get min value
    //get max value
    //get size of noDupSet which will be K
    // create another hashset to find all buckets
    //use table data and formula to then create histogram
    HashMap<Float, Integer> hmap = new HashMap<Float,Integer>();
    for (int i = 0; i < tableData.size(); i++) {
      float bucketCalc = floor(buckets*(tableData.get(i) - minVal)/diff);
      if (hmap.containsKey(bucketCalc)) {
            hmap.put(bucketCalc, hmap.get(bucketCalc)+1);
      } else { hmap.put(bucketCalc, 1); }
    }
    return hmap;
  }
  
  
  
  float findMinRange(float min){
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
  
  float findMaxRange(float max){
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
  
  void keyPressed() {
  }

  void mousePressed() { 
        currentCol = (currentCol+1)%(data.getColumnCount());
  }

  void mouseReleased() {   }
}
