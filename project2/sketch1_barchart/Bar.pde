

class Bar{
  
  // Constants, referenced from processing website for linear gradient
  int Y_AXIS = 1;
  int X_AXIS = 2;
 
  color top, bot;
  
  public Bar(float start, float end, float barWidth, float scale, color top, color bot){
    
  
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
}
