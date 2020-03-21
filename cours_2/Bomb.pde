class Bomb
{
  int x,y,r;
  int xSpeed,ySpeed;
  color couleur;
  int db;
  
  
   Bomb(int newX, int newY, int newRayon, color newCouleur)
  {
    x = newX;
    y = newY;
    r = newRayon;
    couleur = newCouleur;
    xSpeed = int(random(0,10));
    ySpeed = int(random(0,10));
    
  }
  
  void move()
  {
    x= x + xSpeed;
    y = y + ySpeed;
  } 
  
  
  void display() 
  {
    fill(couleur);
    ellipse(x,y,r,r);
  }
  
  void testOOB()
  {
     if (x > (width - r /2 ) || x < 0) {
      // x = - x; 
       xSpeed = - xSpeed;
     }
     
     if (y > ( height - r /2 ) || y < 0) {
       //y = - y; 
       ySpeed = - ySpeed;
     }
  }
  
  
  
  
  
  
  
  
}
