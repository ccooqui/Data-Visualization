
class Splom extends Frame { 
  Table data;
  Float h1;
  Float w1;
  Float spaceX, spaceY;
  ArrayList<String> headers = new ArrayList();
  
  Splom(Table _data, Float _h1, Float _w1) { 
    data = _data;
    h1 = _h1;
    w1 = _w1;
    
    for (int i = 0; i < data.getColumnCount(); i++){
      headers.add(data.getColumnTitle(i));
    }
  }
  
  void draw(){
    Float wSpace = 500.0;
    Float hSpace = 850.0;
    Float space = 80.0;
    
    for (int i = 0; i < headers.size(); i++){
      wSpace = 20.0;
      for (int j = 0; j < headers.size(); j++){
         Scatterplot s = new Scatterplot(data, headers.get(i), headers.get(j),(w1/3)+hSpace, (h1/3)+wSpace, 80);
         s.draw();
         if ((mouseX >= wSpace+space && mouseX <= wSpace+space+80) && (mouseY >= hSpace && mouseY <= hSpace+space)){
           println(headers.get(i) + " " + headers.get(j));
         }
         wSpace+=space;
      }
      hSpace+=space;
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
