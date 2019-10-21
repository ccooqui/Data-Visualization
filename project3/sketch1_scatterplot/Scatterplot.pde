import java.util.*;

class Scatterplot extends Frame {
  Table data;
  String useColumn; 
  
  Scatterplot( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }
  

  void draw() {
    smooth();
    
    println(rowName);
    println(colName);
    int rows = data.getRowCount();
    
    float sizeOfGraph = (h+w)/2;
    
    //widths for graph frame
    float beginWidth = sizeOfGraph*0.20;
    float endWidth = sizeOfGraph;
    
    //heights for graph frame
    float beginHeight = sizeOfGraph*0.10;
    float endHeight = sizeOfGraph*0.75;

    //Calculations for length of horizontal and vertical graph lines
    float frameWidth = endWidth - beginWidth;
    float frameHeight = endHeight - beginHeight; 
    
    //Sets size of text to fit size of canvas
    textSize(((w+h)/2)*0.025);
    fill(30);
    
    float rowStartRange = findStartRange(rowName);
    float rowEndRange = findEndRange(rowName);
    
    float colStartRange = findStartRange(colName);
    float colEndRange = findEndRange(colName);
    println(colEndRange);
    
    drawHorLines(beginWidth, endWidth, beginHeight, endHeight);
    drawVerLines(beginWidth, endWidth, beginHeight, endHeight);
    
    drawVerLabels(rowStartRange, rowEndRange, beginWidth, endWidth, beginHeight, endHeight);
    
    ArrayList<Float> data1List = new ArrayList<Float>();
    ArrayList<Float> data2List = new ArrayList<Float>();
    
    for (TableRow row : data.rows()) {
       data1List.add(row.getFloat(colName));
       data2List.add(row.getFloat(rowName));
       ellipse(map(row.getFloat(colName), colStartRange, colEndRange, beginWidth, endWidth), map(row.getFloat(rowName), rowStartRange, rowEndRange, endHeight, beginHeight), 10, 10);

    }
    
    //noLoop();
  
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
    if (min > 1 && min < 10) {
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
  
  void drawVerLabels(float startRange, float endRange, float beginWidth, float endWidth, float beginHeight, float endHeight) {
    stroke(180);
    float i = beginHeight;
    float j = startRange;
    float rowInc = (endWidth - beginWidth)/5;
    float numInc = (endWidth - beginWidth)/5;
    while (i <= endHeight) {
      text((int)j, beginWidth*0.50, i);
      j += numInc;
      i += rowInc;
    }
    stroke(0);
  }
  
  void drawVerLines() {
  
  }
  
  void mousePressed() {  }

  void mouseReleased() {   }
}
