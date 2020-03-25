class Corona {
  
    int x, y, r;
    int xSpeed, ySpeed;
    color cColor;
    int db;
    boolean isDead = false;
 
   Corona(int newX, int newY, int newRadius, color newColor) {
     
    x = newX;
    y = newY;
    r = newRadius;
    db = r*2;
    cColor = newColor;
    xSpeed = int(random(1, 5));
    ySpeed = int(random(1, 5));
    
  }
  
  void move() {
    x = x + xSpeed;
    y = y + ySpeed;
  } 
  
  
  void display() {
    
    fill(cColor);
    ellipseMode(CENTER);
    ellipse(x, y, db, db);
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
