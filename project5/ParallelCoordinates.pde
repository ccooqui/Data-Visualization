import java.util.*;

class ParallelCoordinates extends Frame { 
  
  Table data;
  String useColumn;
  int axisTotal;
  int rowTotal;
  Boolean belowAvg = false;
  Boolean avg = false;
  Boolean aboveAvg = false;
  HashMap<Integer, List<Float>> studentMap = new HashMap<Integer, List<Float>>();
  HashMap<Integer, List<Float>> rangeMap = new HashMap<Integer, List<Float>>();
  ArrayList<Column> columns = new ArrayList<Column>();
  ArrayList<Column> selectedColumns = new ArrayList<Column>();
  
  ParallelCoordinates(Table _data) {
    data = _data;
    
    axisTotal = data.getColumnCount();
    rowTotal = data.getRowCount();
    mapStudents(data);
    mapRanges(data);
    setUpParallelCoord();
  }
  
  void draw() {
    smooth();

    //** Draw all axis lines and labels for each one
    textSize(w*0.015);
    strokeWeight(w*0.0045);
    text("Click the screen to sort by above average scores", w/3, h*0.97);
    int space = 0;
    for (int i = 0; i < axisTotal; i++) {
      columns.get(i).setCurrentX(w*0.14+space);
      columns.get(i).setY(h*0.13, h*0.87);
      
      fill(0);
      if (columns.get(i).selectedForSwap == true) {
        fill(0, 97, 255);
      }
      text(data.getColumnTitles()[columns.get(i).currentCol], columns.get(i).currentX-(w*0.015), columns.get(i).topY-(w*0.04));
      fill(#777777);
      text(rangeMap.get(columns.get(i).currentCol).get(1), columns.get(i).currentX-(w*0.02), columns.get(i).topY-(w*0.015));
      text(rangeMap.get(columns.get(i).currentCol).get(0), columns.get(i).currentX-(w*0.02), columns.get(i).botY+(w*0.023));
      //if two columns have been selected 
      if (selectedColumns.size() == 2){
          swapColumns();
      }
      stroke(200);
      line(w*0.14+space, h*0.13, w*0.14+space, h*0.87);
      space += (w*0.99)/axisTotal;
    }
    //**************************************************
    
    //** Loop for all students and draw all lines
    for (int j = 0; j < rowTotal; j++) {
      stroke(0);
      if (aboveAvg == true){
        int aboveAvgCount = 0;
        int avgCount = 0;
        int belowAvgCount = 0;
        for (int i = 0; i < axisTotal; i++) {
          if (studentMap.get(j).get(i) > (rangeMap.get(i).get(0) + rangeMap.get(i).get(1))/2){
            aboveAvgCount++;
          }
          if (studentMap.get(j).get(i) == (rangeMap.get(i).get(0) + rangeMap.get(i).get(1))/2){
            avgCount++;
          }
          if (studentMap.get(j).get(i) > (rangeMap.get(i).get(0) + rangeMap.get(i).get(1))/2){
            belowAvgCount++;
          }
        }
        if (aboveAvgCount == axisTotal){
           stroke(#00FF00);
        }
        if (belowAvgCount == axisTotal){
           stroke(#009e73);
        } else {
           stroke(146, 0, 0);
        }
      } else { stroke(0); }
      
      for (int i = 1; i < axisTotal; i++) {
        strokeWeight(w*0.002);
        int col1, col2;
        col1 = columns.get(i-1).getCurrentCol();
        col2 = columns.get(i).getCurrentCol();
        
        line(columns.get(i-1).getCurrentX(), 
        map(studentMap.get(j).get(col1), rangeMap.get(col1).get(0), rangeMap.get(col1).get(1), columns.get(i-1).botY, columns.get(i-1).topY), 
        columns.get(i).getCurrentX(), 
        map(studentMap.get(j).get(col2), rangeMap.get(col2).get(0), rangeMap.get(col2).get(1), columns.get(i-1).botY, columns.get(i-1).topY));
      }
    }
    //**************************************************
    stroke(0);
    textSize(((w+h)/2)*0.025);
  }
  //**************************************************
  
  //***********************************************
  // Initialize columns
  //***********************************************
  void swapColumns() {
    int col1Index = selectedColumns.get(0).colIndex;
    int col2Index = selectedColumns.get(1).colIndex;
    
    int tempCol = selectedColumns.get(0).currentCol;
    columns.get(col1Index).currentCol = selectedColumns.get(1).currentCol;
    columns.get(col2Index).currentCol = tempCol;
    
    //** clear out selectedColumn list
    for (int i = 0; i < columns.size(); i++){
        columns.get(i).selectedForSwap = false;
    }
    selectedColumns.clear();
  }
  
  //***********************************************
  // Initialize columns
  //***********************************************
  void setUpParallelCoord(){
    for (int i = 0; i < axisTotal; i++){
      Column col = new Column(i, i, rangeMap.get(i));
      columns.add(col);
    }
  }
  //***********************************************
  
  //***********************************************
  // Data Structure for data
  //***********************************************
  void mapStudents(Table data) {
    
    //for every student
    for (int i = 0; i < rowTotal; i++) {

      //for every column
      for (int j = 0; j < axisTotal; j++){
        if(studentMap.get(i) != null){
          List<Float> list = studentMap.get(i);
          list.add(data.getFloat(i, j));
        } else {
          List<Float> list = new ArrayList<Float>();
          list.add(data.getFloat(i, j));
          studentMap.put(i, list);
        }
      }    
    }
  }
  //***********************************************
  
  //***********************************************
  // Data Structure for min and max of each column
  //***********************************************
  void mapRanges(Table data) {
    float rmin, rmax;
    String attr;
    float [] datas;
    
    //for every column
    for (int i = 0; i < axisTotal; i++) {
        attr = data.getColumnTitles()[i];
        datas = data.getFloatColumn(attr);
        if(rangeMap.get(i) != null){
          List<Float> list = rangeMap.get(i);
          rmin = min(datas);
          rmax = max(datas);
          list.add(rmin);
          list.add(rmax);
        } else {
          List<Float> list = new ArrayList<Float>();
          rmin = min(datas);
          rmax = max(datas);
          list.add(rmin);
          list.add(rmax);
          rangeMap.put(i, list);
        }  
    }
  }
  //***********************************************
  
  void keyPressed() {
  }

  void mousePressed() { 
    for (int i = 0; i < columns.size(); i++){
        if (mouseX >= (columns.get(i).currentX - 10) && mouseX <= (columns.get(i).currentX + 10)){
          columns.get(i).selectedForSwap = true;
          selectedColumns.add(columns.get(i));
        }
        else {
          if (aboveAvg == true) {
            aboveAvg = false;
          }
          if (aboveAvg == false) {
            aboveAvg = true;
          }
        }
    }
  }

  void mouseReleased() {   }
}
