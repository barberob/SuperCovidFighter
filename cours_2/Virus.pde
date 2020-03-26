class Virus {
  
  int x, y, r,d;
  int xvalue, yvalue;
  color vcolor;
  PImage imgVirus;
  
  Virus (int newX, int newY, int newRadius, color newColor) {
    x = newX;
    y = newY;
    r = newRadius;
    d = r*2;
    vcolor = newColor;
    imgVirus = loadImage("data/virus.png");
    imgVirus.resize(d,d);
  }
  
  void move(int xdirection, int ydirection) {
    
    x = x + xdirection;
    y = y + ydirection;
  }
  
  void display() {
    fill(vcolor,0);
    noStroke();
    ellipse(x, y, r, r);
    stroke(0);
    imageMode(CENTER);
    image(imgVirus,x,y);
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
