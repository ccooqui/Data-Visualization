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
    Barchart barchart = new Barchart(data, data.getColumnTitles()[0]);
    barchart.draw();
    
    Splom splom = new Splom(data, 0.0, 0.0);
    splom.draw();
    
    linechart linechart = new linechart(data, data.getColumnTitles()[0]);
    linechart.draw();
    
    ParallelCoordinates parallelCoordinates = new ParallelCoordinates(data);
    parallelCoordinates.draw();
    
   Scatterplot n = new Scatterplot(data, headers.get(1), headers.get(0), 850.0, 370.0, 320);
   n.draw();
  }
  
  void mousePressed() { }

  void mouseReleased() {}

}
