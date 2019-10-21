
Table myTable = null;
Frame myFrame = null;

void setup(){
  size(800,600);  
  selectInput("Select a file to process:", "fileSelected");
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    myTable = loadTable( selection.getAbsolutePath(), "header" );
    // TODO: create object
    myFrame = new Splom(myTable, 200.0, 500.0); //<>//
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;

  if( myFrame != null){
    myFrame.setData("ACT", "GPA"); 
    myFrame.setPosition( 0, 0, width, height);
    myFrame.draw();
  }
  noLoop();
}

void mousePressed(){
  myFrame.mousePressed();
}


void mouseReleased(){
  myFrame.mouseReleased();
}



abstract class Frame {
  
  int u0,v0,w,h;
  int clickBuffer = 2;
  String colName;
  String rowName;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  void setData(String _colName, String _rowName){
    colName = _colName;
    rowName = _rowName;
  }
  
  abstract void draw();
  void mousePressed(){ }
  void mouseReleased(){ }
  
  
  boolean mouseInside(){
     return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
  }
  
  
}
