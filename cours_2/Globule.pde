class Globule {
  
  int x, y, r, db;
  int xvalue, yvalue;
  color gColor;
  int vitesse = 5; 
  boolean hasTouchedSomething = false;
  PImage imgGlobule;
  
  Globule (int newX, int newY, int newRadius, color newColor) {
    
    x = newX;
    y = newY;
    r = newRadius;
    db = r*2;
    gColor = newColor; 
    imgGlobule = loadImage("data/globule.png");
    imgGlobule.resize(db,db);
  }
  
  void move() {
  //  x= x + xvalue;
  //  y = y + yvalue;
    x = mouseX;
    y = mouseY;
    
  } 
  
  
  void display() {
    fill(#FFFFFF, 0);
    noStroke();
    ellipse(x, y, db, db);
    imageMode(CENTER);
    image(imgGlobule,x,y);
    stroke(0);
  }
  
  void testOOB() {
    
     if (x > (width - r )) {
       
       x = x - r ;
     }
     
     if (y > ( height - r )) {
       
       y =  y - r;
     }
     if (x < r) {
       
       x = x + r ;
     }
     
     if (y < r){
       
       y =  y + r;
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
