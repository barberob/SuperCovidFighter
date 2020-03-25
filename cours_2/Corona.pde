class Corona {
  
    int x, y, r , i;
    int xSpeed, ySpeed;
    color cColor;
    int db;
    boolean isDead = false;
    PImage imgCorona;
    float angle = 0.0;
    float angleVelocity = random(-0.1,0.1);
 
 
   Corona(int newX, int newY, int newRadius, color newColor) {
     
    x = newX;
    y = newY;
    r = newRadius;
    db = r*2;
    cColor = newColor;
    xSpeed = int(random(1, 5));
    ySpeed = int(random(1, 5));
    imgCorona = loadImage("data/corona.png");
    imgCorona.resize(db,db);
    
    
   
  }
  
  void move() {
    
    x = x + xSpeed;
    y = y + ySpeed;
  } 
  
  
  void display() {
   
    fill(#FFFFFF,0);
    noStroke();
    ellipse(x, y, db, db);
    imageMode(CENTER);
   
   
    pushMatrix();
    translate(x,y);
    rotate(angle);
    image(imgCorona,0,0);

    popMatrix();
    stroke(0);
    angle+=angleVelocity;
    
   
  }
  
  void testOOB() {
    
     if (x > (width - r) || x < r) {
      
       xSpeed = - xSpeed;
     }
     
     if (y > (height - r) || y < r) {
       
       ySpeed = - ySpeed;
     }
  }  
}
