import processing.serial.*;
//import ddf.minim.*;

Serial port;
PImage fond, ball;
float xvalue = 0;
float yvalue = 0;
int AngleVision = 90;
int buttonValue;
int background = 0;
int dB = 20; 
boolean hasTouched = false;
Corona[] coronas;
Virus[] viruses;
int last = 0;
int n = 0;
int numOfCoronas = 1;
int numOfViruses = 0;
int xdirection, ydirection;
int time;
boolean intersecting;
boolean hasLost = false;
PFont f;
int timeOfGame = 0;
int spawnVirusesTimer = 0;

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
    
    initCoronas(); 
}

void draw() 
{
    
    if (hasLost == false) {
        play();
    } else {
       loseScreen();
    }
}



//__________________________________________________________________________________________________________________________________________________________________________________________________________//



void serialEvent(Serial port) {
    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    if( values.length == 4 ) {
          
    }
}

//float calculate( int returnValue, int baseValue ) 
//{
//    int diff = returnValue - baseValue ;
//    float angle = AngleVision * (diff/70.0);
//    return angle * PI /180 ;  
//}


int calculate (int baseValue, int returnValue ) {
  int dif = returnValue - baseValue;
  return round(dif/5);
}




//_______________________________________________________________________________________________KEY EVENTS____________________________________________________________________________________________________________//

void keyPressed() {
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
  if (hasLost == true) {
    hasLost = false;
    numOfCoronas = 1;
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


void initCoronas(){
  
    coronas = new Corona[30];
    for (int i=0 ; i < 30 ; i++) {
      
       int x = int(random(0, 800)); 
       int y = int(random(0, 800)); 
       int size = int(random(7, 25));
       
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
       
        coronas[i] = new Corona(x, y, size, color(255, 0, 0));
    } 
}


/////////////////////////////////////////////


void moveCoronas() {   
    for (int i =0 ; i < numOfCoronas ; i++) {
        coronas[i].move();
        coronas[i].testOOB();
        coronas[i].display();
    } 
}


/////////////////////////////////////////////

void initViruses() {
  viruses = new Virus[10];
  
  int SpawnPoint = int(random(1, 5));
  
  int xlocate = 0;
  int ylocate = 0;
  
  xdirection = 0;
  ydirection = 0;
  
  if (SpawnPoint == 1) {
    ylocate = int(random(0, 800));
    xdirection = 5;
  } else if (SpawnPoint == 2) {
    xlocate = 800;
    ylocate = int(random(0, 800));
    xdirection = -5;
  } else if (SpawnPoint == 3) {
    ylocate = 800;
    xlocate = int(random(0, 800));
    ydirection = -5;
  } else if (SpawnPoint == 4) {
    xlocate = int(random(0, 800));
    ydirection = 5;
  }
  
  for (int i = 0 ; i < 10 ; i++) {
    
    int x = 0, y = 0;
    
    if (SpawnPoint == 1 || SpawnPoint == 2) {
      x =  int(10 * i + random(xlocate, xlocate + 20));
      y =  ylocate;
    } else if (SpawnPoint == 3 || SpawnPoint == 4) {
      x =  xlocate;
      y =  int(10 * i + random(ylocate, ylocate + 20));
    }
    
     int size = int(random(15, 20));
  
    viruses[i] = new Virus(x, y, size, color(0, 255, 255));
  } 
  
}

/////////////////////////////////////////////

void moveViruses() {
    if (viruses == null) return;
    for (int i = 0; i < viruses.length; i++) {
      viruses[i].move(xdirection, ydirection);
      viruses[i].display();
    }   
    
    if (viruses[viruses.length - 1].testOOB()) {
      initViruses();
    }
}

/////////////////////////////////////////////

void play() {
  time = millis()/1000 - timeOfGame;
    
  background(background);
  image(fond, 0, 0);
  
  myGlobule.move();
  myGlobule.testOOB();
  myGlobule.display();

  moveCoronas();
  moveViruses();
  
  if (testCollisionCoronas()) {
    hasLost = true;
  }
  
  if(viruses != null) {
    if (testCollisionViruses()) {
      hasLost = true;
    }
  }
  
  if (millis() > last + 5000) {
      last = millis();
      if (numOfCoronas < 30) {
        numOfCoronas++;
      }
      
      if (numOfCoronas == 5 && viruses == null){
        initViruses();
      }
      
  }
  
  text(time + "s" , 50, 50);
}

/////////////////////////////////////////////

void loseScreen() {
  
  timeOfGame = millis()/1000;
  fill(50);
  rect(0, 0, 800, 800);
  fill(255);
  textAlign(CENTER, CENTER);
  
  
  if (time < 60) { 
    text("Tu as tenu "+ time +" secondes, quel Mickey...", 400, 400);
  } else if (time < 120) {
    text("Tu as tenu "+ time +" secondes, pas mal pour une baltringue...", 400, 400);
  } else {
    text("Tu as tenu "+ time +" secondes, c'est un peu ridicule quand même...", 400, 400);
  }
  
}

/////////////////////////////////////////////

boolean testCollisionCoronas() {
   intersecting = false;
   for (int i = 0; i < numOfCoronas; i++) {
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

boolean testCollisionViruses() {
   intersecting = false;
   for (int i = 0; i < viruses.length; i++) {
        if(myGlobule.intersect(viruses[i])) {
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
