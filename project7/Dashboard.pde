import java.util.*;

class Dashboard extends Frame {
  
  Table data;
  PVector selected;
  ArrayList<String> headers = new ArrayList();
  
  Dashboard (Table _data) {
    data = _data;
    
    for (int i = 0; i < data.getColumnCount(); i++){
      headers.add(data.getColumnTitle(i));
    }
  }

  void draw() {
    Histogram hist1 = new Histogram(data, data.getColumnTitles()[0], 610, 20, 280, 280);
    hist1.draw();
    Histogram hist2 = new Histogram(data, data.getColumnTitles()[1], 910, 20, 280, 280);
    hist2.draw();
    Histogram hist3 = new Histogram(data, data.getColumnTitles()[2], 10, 20, 280, 280);
    hist3.draw();
    Histogram hist4 = new Histogram(data, data.getColumnTitles()[3], 310, 20, 280, 280);
    hist4.draw();
    
    Corrgram corr = new Corrgram(data);
    corr.draw();
    
    CorrgramPPC corr1 = new CorrgramPPC(data);
    corr1.draw();
    
  }
  
  void mousePressed() { }

  void mouseReleased() {}

}
