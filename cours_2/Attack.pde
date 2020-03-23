class Attack
{
    int x,y,r,db;
    int xvalue,yvalue;
    color couleur;
    boolean hasTouchedSomething = false;
    int maxRange = 100;
  
    Attack (int newX, int newY, color newCouleur)
    {
      x = newX;
      y = newY;
      db = maxRange;
      r = db/2;
      couleur = newCouleur;
      
    }
    
    void display() 
    {
      fill(couleur);
      ellipseMode(CENTER);
      ellipse(x,y,db,db);
     
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
