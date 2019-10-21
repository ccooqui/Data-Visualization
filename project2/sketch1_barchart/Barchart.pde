import java.util.*;

class Barchart extends Frame {

  Table data;
  String useColumn;
  
  
  // Constants, referenced from processing website for linear gradient
  int Y_AXIS = 1;
  int X_AXIS = 2;
  
  //========================================
  //Colors for bar graphs dependent on party
  //========================================
  color repTop = #B20455;
  color repBot = #FB3C4F;
  color demTop = #493CD3;
  color demBot = #28A2E8;

  Barchart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  void draw() { 
    smooth();
    int rows = data.getRowCount();
    
    //widths for graph frame
    float beginWidth = width*0.15;
    float endWidth = width*0.95;
    
    //heights for graph frame
    float beginHeight = height*0.15;
    float endHeight = height*0.85;
    
    //Calculations for length of horizontal and vertical graph lines
    float frameWidth = endWidth - beginWidth;
    float frameHeight = endHeight - beginHeight;
    
    //Scale value for data
    float scale = frameHeight/100;
    
    //Sets size of text to fit size of canvas
    textSize(((width+height)/2)*0.025);
    fill(30);
    
    //Calculates space for data items
    float space = (frameWidth)/(rows);
    float p = beginWidth;
    float range = endHeight;
    line(endWidth, range, beginWidth, range);
    range = range - (endHeight*0.25);
    
    //Draws values for vertical data range and lines
    int verRange = nearestHundred("VALUE1");
    int i = 0;
    float verSpace = endHeight;
    while (i <= verRange) {
      textAlign(RIGHT);
      text(i, beginWidth*0.80, verSpace+7);
      stroke(205);
      line(endWidth, verSpace, beginWidth, verSpace);
      i += verRange*0.25;
      verSpace -= frameHeight*0.25;

    }
    
    //Legends for bar colors
    setGradient(width-(endWidth/2.7), height*0.038, width*0.033, height*0.033, demTop, demBot, Y_AXIS);
    text("DEM", width-(endWidth/2.7) + width*0.1, height*0.070);
    
    setGradient(width-beginWidth*1.3, height*0.038, width*0.033, height*0.033, repTop, repBot, Y_AXIS);
    text("REP", width-beginWidth*1.3 + width*0.090, height*0.070);

    textAlign(LEFT);
    //=======================================
    // Iterate through table and display data
    //=======================================
    for (TableRow row : data.rows()) {
      text(row.getString("YEAR"), p+25, endHeight + 25);
      noStroke();
      if ("DEM".equals(row.getString("PARTY"))){
            setGradient(p+15, endHeight - row.getFloat("VALUE1")*scale, (width/rows)*.65, row.getFloat("VALUE1")*scale, demTop, demBot, Y_AXIS);
      }
      else {
            setGradient(p+15, endHeight - row.getFloat("VALUE1")*scale, (width/rows)*.65, row.getFloat("VALUE1")*scale, repTop, repBot, Y_AXIS);
      }
      p += space;
      stroke(90);
    }
    
    //===================================
    //prints labels of data
    //===================================
    //calculate dynamic size of labels
    textSize(((width+height)/2)*0.029);
    
    text("Years", endWidth/1.9, endHeight*1.11);
    
    //rotate vertical label yeet
    translate(width/2, height/2);
    rotate(-HALF_PI);
    text("Value1", -28, -height*0.44);

    noLoop();
  }
  
  //Referenced from the processing website :)
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
  
  //Finds the nearest hundredeth from the data values to create a range for the graph :D
  int nearestHundred(String rowName){
    ArrayList<Integer> value0List = new ArrayList<Integer>();
    for (TableRow row : data.rows()) {
      value0List.add(row.getInt(rowName));
    }
  
    return ((Collections.max(value0List) + 99)/100)*100;
  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
