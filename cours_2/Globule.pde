class Globule
{
  int x,y;
  int xvalue,yvalue;
  color couleur;
  int db =20;
  int r =db/2;
  int vitesse = 5; 
  boolean hasTouchedSomething = false;
  
  
  
  Globule (int newX, int newY, int newRayon, color newCouleur)
  {
    x = newX;
    y = newY;
    r = newRayon;
    db = r*2;
    couleur = newCouleur;
    
  }
  
 // void move()
 //{
 // //  x= x + xvalue;
 // //  y = y + yvalue;
 //   x = mouseX;
 //   y = mouseY;
    
 // } 
  
  
  void display() 
  {
    fill(couleur);
    ellipse(x,y,db,db);
  }
  
  void testOOB()
  {
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
  
  
  boolean intersect(Corona b) 
  {
      float distance = dist(x, y, b.x, b.y);
  
      if (distance < r + b.r) 
      {
        return true;
      }
      else 
      {
        return false;
      }
  }

  
}
