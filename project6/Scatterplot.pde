import java.util.*;

class Scatterplot extends Frame {
  Table data;
  String useColumn; 
  Float h1, w1;
  String dataVal1, dataVal2;
  int size;

  Scatterplot( Table _data, String _dataVal1, String _dataVal2, Float _w1, Float  _h1, int _size) {
    data = _data;
    dataVal1 = _dataVal1;
    dataVal2 = _dataVal2;
    w1 = _w1;
    h1 = _h1;
    size = _size;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }
  

  void draw() {
    smooth();
    noFill();
    stroke(0.2);
   
    
    //widths for graph frame
    float beginWidth = w1;
    float endWidth = w1+size;

    
    //heights for graph frame
    float beginHeight = h1;
    float endHeight = h1+size;
    fill(30);
    
    float rowStartRange = findStartRange(dataVal1);
    float rowEndRange = findEndRange(dataVal1);
    
    float colStartRange = findStartRange(dataVal2);
    float colEndRange = findEndRange(dataVal2);
    
    //drawHorLines(beginWidth, endWidth, beginHeight, endHeight);
    //drawVerLines(beginWidth, endWidth, beginHeight, endHeight);
    
    //drawVerLabels(rowStartRange, rowEndRange, beginWidth, endWidth, beginHeight, endHeight);
    
    ArrayList<Float> data1List = new ArrayList<Float>();
    ArrayList<Float> data2List = new ArrayList<Float>();
    
    for (TableRow row : data.rows()) {
       data1List.add(row.getFloat(dataVal2));
       data2List.add(row.getFloat(dataVal1));
       ellipse(map(row.getFloat(dataVal2), colStartRange, colEndRange, beginWidth, endWidth), map(row.getFloat(dataVal1), rowStartRange, rowEndRange, endHeight, beginHeight), size*0.02, size*0.02);
       //println(scaleH);
       //println(row.getFloat("SATM")/scaleH);
       //ellipse(endWidth - row.getFloat("SATM")/scaleW, beginHeight+row.getFloat("SATV")/scaleH, height*0.017, width*0.017);
    }
    
    //ellipse(map(data1List.get(0), 0, 800, beginWidth, endWidth), map(data2List.get(0), 0, 800, endHeight, beginHeight), 10, 10);
    
    line(beginWidth, beginHeight, endWidth, beginHeight);
    line(beginWidth, beginHeight, beginWidth, endHeight);  
    line(endWidth, beginHeight, endWidth, endHeight);
    line(beginWidth, endHeight, endWidth, endHeight);  
  
  
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
  
  /*void drawVerLabels(float startRange, float endRange, float beginWidth, float endWidth, float beginHeight, float endHeight) {
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
  }*/
  
  void drawVerLines() {
  
  }
  
  void mousePressed() {  }

  void mouseReleased() {   }
}
