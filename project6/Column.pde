import java.util.*;

class Column {
  Boolean selectedForSwap = false;
  //never changes
  int colIndex;
  int currentCol;
  float currentX, topY, botY;
  List<Float> rangeList = new ArrayList<Float>();
  
  Column(int _colIndex, int _currentCol, List<Float> _rangeList) {
    colIndex = _colIndex;
    currentCol = _currentCol;
    rangeList = _rangeList;
  }
  
  int getColIndex() {
    return colIndex;
  }
  
  int getCurrentCol() {
    return currentCol;
  }
  
  float getCurrentX() {
     return currentX;
  }
  
  void setColIndex(int _colIndex) {
    colIndex = _colIndex;
  }
  
  void setCurrentCol(int _currentCol) {
    currentCol = _currentCol;
  }
  
  void setCurrentX(float _currentX) {
     currentX = _currentX;
  }

  void setY(float _topY, float _botY) {
     topY = _topY;
     botY = _botY;
  }
}
