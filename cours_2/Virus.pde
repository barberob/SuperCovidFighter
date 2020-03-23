class Virus {
  
  int x,y,r;
  color vcolor;
  
  Virus (int newX, int newY, int newRadius, color newColor) {
    x = newX;
    y = newY;
    r = newRadius;
    vcolor = newColor;
  }
  
  void move() {
    x = x + 2;
  }
  
  void display() {
    fill(vcolor);
    ellipse(x,y, r, r);
  }
  
}
