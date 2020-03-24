class Virus {
  
  int x, y, r;
  int xvalue, yvalue;
  color vcolor;
  
  Virus (int newX, int newY, int newRadius, color newColor) {
    x = newX;
    y = newY;
    r = newRadius;
    vcolor = newColor;
  }
  
  void move(int xdirection, int ydirection) {
    x = x + xdirection;
    y = y + ydirection;
  }
  
  void display() {
    fill(vcolor);
    ellipse(x, y, r, r);
  }
  
  boolean testOOB() {
    
     boolean oob;
     
     if (x > (width + 500 - r) || x < 0) {
       oob = true;
     } else if (y > (height + 500 - r) || y < 0) {
       oob = true;
     } else {
       oob = false;
     }
     
     return oob;
  }
  
}
