import processing.serial.*;
//import ddf.minim.*;

Serial port;
PImage fond,ball;
float xvalue = 0;
float yvalue = 0;
int AngleVision = 90;
int buttonValue;
int background = 0;
int dB = 20; 
boolean hasTouched = false;
Corona[] coronas;
int last = 0;
int m = 0;
int numOfBombs = 1;
int time;
boolean intersecting;
boolean hasLoosed = false;
PFont f;
int timeOfGame = 0;

//Minim minim;
//AudioPlayer musiqueFond;

Globule myGlobule = new Globule ( 250, 250, 15, color(255));


void setup() 
{
     
    //minim = new Minim(this);
    //musiqueFond = minimum.loadFile(".....mp3");
    f = createFont("Arial",26,true);
    textFont(f);
    smooth();
    size(800, 800);
    //port = new Serial(this, "COM5", 9600);
    //port.bufferUntil('\n');
    background(background);
    fond = loadImage("data/trump.jpg");
    fond.resize(800,800);
    
    initBombs();
    
}

void draw() 
{
    
    if (hasLoosed == false) 
    {
        play();
    }
    
    else
    {
       looseScreen();
    }
}



//__________________________________________________________________________________________________________________________________________________________________________________________________________//



void serialEvent(Serial port) 
{
    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    if( values.length == 4 ) 
    {
          
    }
}

//float calculate( int returnValue, int baseValue ) 
//{
//    int diff = returnValue - baseValue ;
//    float angle = AngleVision * (diff/70.0);
//    return angle * PI /180 ;  
//}


int calculate (int baseValue, int returnValue )
{
  int dif = returnValue - baseValue;
  return round(dif/5);
}




//_______________________________________________________________________________________________KEY EVENTS____________________________________________________________________________________________________________//

void keyPressed()
{
  if (key == CODED ) {
     if(keyCode == UP) if (myGlobule.yvalue>-5) {
       myGlobule.yvalue -= 2; 
     }
     if(keyCode == LEFT) if (myGlobule.xvalue>-5) {
       myGlobule.xvalue -= 2;
     }
     if(keyCode == RIGHT) if(myGlobule.xvalue<5) {
       myGlobule.xvalue += 2;
     }
     if(keyCode == DOWN) if(myGlobule.yvalue<5) {
       myGlobule.yvalue += 2;  
     }
  }
}

void mousePressed() {
  if (hasLoosed == true) {
    hasLoosed = false;
    numOfBombs = 1;
    println("ooooooke");
  } 
}

//void keyReleased()
//{
//  if (key == CODED ) {
//   if(keyCode == UP) maBalle.y = 0;
//   if(keyCode == LEFT) maBalle.x = 0;
//   if(keyCode == RIGHT) maBalle.x = 0;
//   if(keyCode == DOWN) maBalle.y = 0;
//  }
    
//}


//_______________________________________________________________________________________________FUNCTIONS____________________________________________________________________________________________________________//


void initBombs(){
  
    coronas = new Corona[30];
    for (int i=0 ; i<30 ; i++) {
      
       int x = int(random(0,800)); 
       int y = int(random(0,800)); 
       int size = int(random(15,50));
       
       if (x <= 400) {
         x = 1 + size;
       } else {
         x = 799 - size;
       }
       
       if (y <= 400) {
         y = 1 + size;
       } else {
         y = 799 - size;
       }
       
        coronas[i] = new Corona( x, y, size, color(255, 0, 0));
    } 
}


/////////////////////////////////////////////


void moveBombs()
{
    
    for (int i =0 ; i<numOfBombs ; i++) {
        coronas[i].move();
        coronas[i].testOOB();
        coronas[i].display();
    } 
}


/////////////////////////////////////////////

void play() {
 time = millis()/1000 - timeOfGame;
    
  background(background);
  image(fond,0,0);
  
  myGlobule.move();
  myGlobule.testOOB();
  myGlobule.display();

  moveBombs();
       
  if (testCollisionBombs()) {
    hasLoosed = true;
  }
  
  m = millis() - last;
  if (millis() > last+5000) {
      last = millis();
      if (numOfBombs < 30) {
        numOfBombs++;
      }
      
  }
  
  text(time + "s" ,50,50);
}

/////////////////////////////////////////////

void looseScreen() {
  
  timeOfGame = millis()/1000;
  fill(50);
  rect(0,0,800,800);
  fill(255);
  textAlign(CENTER,CENTER);
  
  
  if (time<60) { 
   text("Tu as tenu "+time +" secondes, quel Mickey...",400,400);
  } else if (time < 120) {
     text("Tu as tenu "+time +" secondes, pas mal pour une baltringue...",400,400);
  } else {
     text("Tu as tenu "+time +" secondes, c'est un peu ridicule quand même...",400,400);
  }
  
}


/////////////////////////////////////////////

boolean testCollisionBombs() {
   intersecting = false;
   for (int i=0 ; i<numOfBombs ; i++) {
        if(myGlobule.intersect(coronas[i])) {
            intersecting = true;
            break;
        } else {
            intersecting = false;
        }
   }   

    if(intersecting == true) {
        return true;
    } else {
        return false;
    }
    
}

//////////////////////////////////////////////
