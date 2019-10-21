import java.util.*;

class Linechart extends Frame {

  Table data;
  String useColumn;

  Linechart( Table _data, String _useColumn ) {
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
    float lineSpace = ((frameWidth)/(rows))*0.60;
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
    
    textAlign(LEFT);
    //=======================================
    // Iterate through table and collect data
    //=======================================
    ArrayList<Float> dataList = new ArrayList<Float>();
    ArrayList<Float> dataPosList = new ArrayList<Float>();
    for (TableRow row : data.rows()) {
      dataList.add(row.getFloat("VALUE1"));
      dataPosList.add(p+lineSpace);
      text(row.getString("YEAR"), p+25, endHeight + 25);
      noStroke();
      p += space;
      stroke(90);
    }

    //Creates lines from data collected
    for (int iter = 1; iter < dataList.size(); iter++){
        stroke(#4286f4);
        fill(#4286f4);
        strokeWeight((height+width/2)*0.0048);
        line(dataPosList.get(iter-1), endHeight - dataList.get(iter-1)*scale, dataPosList.get(iter), endHeight - dataList.get(iter)*scale);

    }
    //Creates ellipse from data collected
    for (int iter = 0; iter < dataList.size(); iter++){
        strokeWeight((height+width/2)*0.0043);
        stroke(#add4ff);
        noFill();
        ellipse(dataPosList.get(iter), endHeight - dataList.get(iter)*scale, height*0.017, width*0.017);
    }
    
    //===================================
    //prints labels of data
    //===================================
    //calculate dynamic size of labels
    fill(30);
    textSize(((width+height)/2)*0.029);
    
    text("Years", endWidth/1.9, endHeight*1.11);
    
    //rotate vertical label yeet
    translate(width/2, height/2);
    rotate(-HALF_PI);
    text("Value0", -28, -height*0.44);

    noLoop();
  
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
