class Virus {
  
  int x,y,r;
  color vcolor;
  
  Virus (int newX, int newY, int newRadius, color newColor) {
    x = newX;
    y = newY;
    r = newRadius;
    vcolor = newColor;
  }
  
  void move(int direction) {
    x = x + direction;
  }
  
  void display() {
    fill(vcolor);
    ellipse(x,y, r, r);
  }
  
}
