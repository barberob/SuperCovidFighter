class Attack
{
    int x,y,r;
    int xvalue,yvalue;
    color couleur;
    int db =20;
    boolean hasTouchedSomething = false;
    //int maxRange = 75;
  
    Attack (int newX, int newY, int newRayon, color newCouleur)
    {
      x = newX;
      y = newY;
      r = newRayon;
      couleur = newCouleur;
      
    }
    
    void display() 
    {
      fill(couleur);
      ellipseMode(CENTER);
      ellipse(x,y,75,75);
     
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
