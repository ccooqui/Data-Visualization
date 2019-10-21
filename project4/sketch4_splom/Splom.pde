import java.util.*;

class Splom extends Frame { 
  Table data;
  Float h1;
  Float w1;
  Float spaceX, spaceY;
  ArrayList<String> dataList = new ArrayList<String>(Arrays.asList("SATV", "SATM", "ACT", "GPA"));
  
  Splom(Table _data, Float _h1, Float _w1) { 
    data = _data;
    h1 = _h1;
    w1 = _w1;
  }
  
  void draw(){
    Float wSpace = 0.0;
    Float hSpace = 0.0;
    
    for (int i = 0; i < 4; i++){
      wSpace = 0.0;
      for (int j = 0; j < 4; j++){
         Scatterplot s = new Scatterplot(data, dataList.get(i), dataList.get(j),(w1/3)+hSpace, (h1/3)+wSpace, 120);
         s.draw();
         if ((mouseX >= wSpace+120 && mouseX <= wSpace+240) && (mouseY >= hSpace && mouseY <= hSpace+120)){
           println(dataList.get(i) + " " + dataList.get(j));
           Scatterplot n = new Scatterplot(data, dataList.get(i), dataList.get(j), width*.70, height*.35, 220);
           n.draw();
         }
         wSpace+=120;
      }
      hSpace+=120;
    }
    
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
