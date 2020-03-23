class Corona {
  int x, y, r;
  int xSpeed, ySpeed;
  color ccolor;
  int db;
  
  
   Corona(int newX, int newY, int newRadius, color newColor) {
    x = newX;
    y = newY;
    r = newRadius;
    ccolor = newColor;
    xSpeed = int(random(0,10));
    ySpeed = int(random(0,10));
    
  }
  
  void move() {
    x = x + xSpeed;
    y = y + ySpeed;
  } 
  
  
  void display() {
    fill(ccolor);
    ellipse(x, y, r*2, r*2);
  }
  
  void testOOB() {
     if (x > (width - r) || x < 0) {
      // x = - x; 
       xSpeed = - xSpeed;
     }
     
     if (y > (height - r) || y < 0) {
       //y = - y; 
       ySpeed = - ySpeed;
     }
  }  
}
