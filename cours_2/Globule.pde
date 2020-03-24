class Globule {
  int x, y, r;
  int xvalue, yvalue;
  color gcolor;
  int db = 20;
  int vitesse = 5; 
  boolean hasTouchedSomething = false;
  
  
  
  Globule (int newX, int newY, int newRadius, color newColor) {
    x = newX;
    y = newY;
    r = newRadius;
    gcolor = newColor;
    
  }
  
  void move() {
  //  x= x + xvalue;
  //  y = y + yvalue;
    x = mouseX;
    y = mouseY;
    
  } 
  
  
  void display() {
    fill(gcolor);
    ellipse(x, y, db, db);
  }
  
  void testOOB() {
     if (x > (width - db / 2) || x < 0) {
       x = x - xvalue; 
     }
     
     if (y > (height - db / 2) || y < 0) {
       y = y - yvalue; 
     }
  }
  
  
  boolean intersect(Corona c) {
      float distance = dist(x, y, c.x, c.y);
  
      if (distance < r + c.r) 
      {
        return true;
      }
      else 
      {
        return false;
      }
  }
  
  boolean intersect(Virus v) {
      float distance = dist(x, y, v.x, v.y);
  
      if (distance < r + v.r) 
      {
        return true;
      }
      else 
      {
        return false;
      }
  }

  
}
