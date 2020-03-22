class Globule
{
  int x,y,r;
  int xvalue,yvalue;
  color couleur;
  int db =20;
  int vitesse = 5; 
  boolean hasTouchedSomething = false;
  
  
  
  Globule (int newX, int newY, int newRayon, color newCouleur)
  {
    x = newX;
    y = newY;
    r = newRayon;
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
     if (x > (width - db /2 ) || x < 0) {
       x = x - xvalue; 
     }
     
     if (y > ( height - db /2 ) || y < 0) {
       y = y - yvalue; 
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
