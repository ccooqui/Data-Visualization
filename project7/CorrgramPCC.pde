import java.lang.Math;

//Referenced http://www.ablongman.com/graziano6e/text_site/MATERIAL/statconcepts/relationship.htm
//for Persson equation

class CorrgramPPC extends Frame { 

  ArrayList<String> headers = new ArrayList();
  String rowName;
  String colName;
  int currentCol = 0;
  HashMap<Float, Integer> dataMap = new HashMap<Float, Integer>();
  HashMap<Integer, ArrayList<Float>> colDataMap = new HashMap<Integer, ArrayList<Float>>();
  
  HashMap<Integer, Float> meanMap = new HashMap<Integer, Float>();

  Table data;
  Float h1;
  Float w1;
  Float spaceX, spaceY;
  
  
  CorrgramPPC(Table _data) { 
    data = _data;
    
    for (int i = 0; i < data.getColumnCount(); i++){
      headers.add(data.getColumnTitle(i));
    }
    for (int i = 0; i < headers.size(); i++){
      ArrayList<Float> tableData = new ArrayList<Float>();
      for (TableRow row: data.rows()){ 
        tableData.add(row.getFloat(data.getColumnTitle(i)));
      }
      colDataMap.put(i, tableData);
      meanMap.put(i, calculateMean(tableData)); 
    }
  }
  
  void draw(){
    float size = 80;
    float placeX = 720;
    float placeY = 345;
    Float topEqSum, topX, topY, botEqSumY, botEqSumX;
    topEqSum = botEqSumY = botEqSumX = topX = topY = 0.0;
    
    int N = data.getRowCount();
    for (int i = 0; i < headers.size(); i++){
      placeX = 720;
      for (int j = 0; j < headers.size(); j++){
          ArrayList<Float> tableDataX = new ArrayList<Float>();
          ArrayList<Float> tableDataY = new ArrayList<Float>();
          if (i != j) {
          for (TableRow row: data.rows()){ 
            tableDataX.add(row.getFloat(data.getColumnTitle(i)));
            tableDataY.add(row.getFloat(data.getColumnTitle(j)));
            
            topX += row.getFloat(data.getColumnTitle(i));
            topY += row.getFloat(data.getColumnTitle(j));
            topEqSum += (row.getFloat(data.getColumnTitle(i))*row.getFloat(data.getColumnTitle(j)));
            
            botEqSumX += (row.getFloat(data.getColumnTitle(i)))*(row.getFloat(data.getColumnTitle(i)));
            botEqSumY += (row.getFloat(data.getColumnTitle(j)))*(row.getFloat(data.getColumnTitle(j)));
          }
          float botSqrY = topY*topY;
          float botSqrX = topX*topX;
          float p = (N*topEqSum - (topX*topY))/(sqrt(((N*botEqSumX)-botSqrX)*((N*botEqSumY)-botSqrY)));
          float opp = calcOppacity(p);    
          if (p < 0.475) {
            fill(#b250e0, opp);
            rect(placeX, placeY, size, size);
          }
          else if (p <= 0.525 && p >= .475){
            fill(#9e9e9e, opp);
            rect(placeX, placeY, size, size);
          }
          else if (p > 0.525) {
            fill(#ff9811, opp);
            rect(placeX, placeY, size, size);
          }
            fill(#FFFFFF);
            textSize(15);
            text(p, placeX+13, placeY+45); 
          } else { 
            fill(#000000);
            textSize(15);
            text(data.getColumnTitle(i), placeX+25, placeY+45); 
          }
          
          placeX = placeX + size;
          println(placeX);
        
        }
         placeY = placeY + size;
         println(placeY);
    }

  }
  
    float calcOppacity(float p) {
    int opp = 0;
    if(p > .75 ){ opp = 255; }
    else if(p > .60 && p <= .75){ opp = 200; }
    else if(p <= .55 && p > .45){ opp = 125; }
    else if(p <= .45 && p > .35){ opp = 150; }
    else if(p <= .35 && p >= .25){ opp = 200; }
    else if(p < .25){ opp = 255; }
    return opp;
  }
  
  float calculateMean(ArrayList<Float> nums) {
    float mean = 0;
    float sum = 0;
    for (Float num : nums) {
      sum += num;
    }
    mean = sum/nums.size();
    return mean;
  }
  
  float hSpaceCalc(){
    return h1/data.getColumnCount();
  }
  float wSpaceCalc(){
    return w1/data.getRowCount();
  }

  void mousePressed() { 
  
  }

  void mouseReleased() {   }


}
