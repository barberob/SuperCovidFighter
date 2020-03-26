import processing.serial.*;
import ddf.minim.*;

Serial myPort;
PImage fond, imgCorona, imgGlobule, imgMenu, imgMenuEmpty;
float xvalue = 0;
float yvalue = 0;
int buttonValue;
int background = 0;
int dB = 20;
int inc =0;
boolean hasTouched = false;
ArrayList<Corona> coronas = new ArrayList<Corona>();

Virus[] viruses;
Globule myGlobule;
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
boolean startMenu = true;

boolean canAttack = false;
boolean firstAttack = true;
boolean isAttacking = false;
boolean attackInProgress = false;
int attackDuration = 750; //ms
int attackCooldown = 12000; //ms
int lastAttack = 0;
int timeOfAttack = 0;
PFont font;
int numOfGames= 0;
PrintWriter output = createWriter("data/scores.txt");;
BufferedReader input =  createReader("data/scores.txt");
String score;
Minim minim;
AudioPlayer music, attackSound;

Attack myAttack = new Attack(250, 250, #3AF051);

void setup() 
{
     initGlobule();
    minim = new Minim(this);
    music = minim.loadFile("data/main_music.mp3");
    attackSound = minim.loadFile("data/cell_attack.mp3");
    music.setGain(-25);
    

    font = loadFont("CenturyGothic-Bold-30.vlw");
    textFont(font);
    
    smooth();
    size(1000, 1000);
    myPort = new Serial(this, "COM5", 9600);
    myPort.bufferUntil('\n');
    
    imgMenu = loadImage("data/menu.png");
    imgMenu.resize(1100,1100);
    fond = loadImage("data/fond.jpg");
    fond.resize(1000,1000);
    imgMenuEmpty = loadImage("data/menu_empty.png");
    imgMenuEmpty.resize(1100,1100);
    //initCoronas(); 
  
}

void draw() 
{
    
 
    if (startMenu == true) {
      
        fill(#25F025);
        background(background);
        rect(500,500,0,0);
        imageMode(CENTER);
        image(imgMenu, width/2,height/2);
        imageMode(CORNER);
        //text("Appuyez longuement pour lancer le jeu", width/2, height/2);
        
    } else {
      
      if (hasLost == false) {
          music.play();
          play();
          
      } else {
         music.pause();
         music.rewind(); 
         numOfGames++;
         loseScreen();
      }
    }
    
    fill(0);
    
    
    
}

//__________________________________________________________________________________________________________________________________________________________________________________________________________//

void serialEvent(Serial myPort) 
{
    
    String serialStr = myPort.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    if( values.length == 3 ) {
      
      
      if(values[2]==1) {
        
        if (inc < 51) {
          inc++;
        }
        
        if(canAttack == true) {
          
           isAttacking  = true; 
        }
        
        if(inc == 50) {
          
           lastAttack = millis();
           startMenu = false;
           timeOfGame = millis();
           
        }
        
        if(hasLost == true && inc == 51) {
 
            refreshGame();
        }

      } else {
        
        if(startMenu == true) {
          
          inc =0 ;
        }
        
        isAttacking = false;
      }
      
      int newX = int(map(values[0], -509, 514, -5, 5));
      int newY = int(map(values[1], -507, 516, -5, 5));
      
      myAttack.x = myGlobule.x;
      myAttack.y = myGlobule.y;
      myGlobule.x += newX;
      myGlobule.y += newY;
      //println(inc);
      
    }
}

//_______________________________________________________________________________________________KEY EVENTS____________________________________________________________________________________________________________//

//void mousePressed() { 
  
//  if (hasLost == true) {
    
//      hasLost = false;
//      numOfCoronas = 0;
//  } 
//}

//_______________________________________________________________________________________________FUNCTIONS____________________________________________________________________________________________________________//


void play() {
  
  initCoronas();
  time = millis()/1000 - timeOfGame/1000;
    
  imageMode(CORNER);
  image(fond, 0, 0);
  
  testAttack();
  //myGlobule.move();
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
  
  if (millis() > last + 2000) {
    
      last = millis();
      
        numOfCoronas++;
     
      if (numOfCoronas == 5 && viruses == null) {
        
        initViruses();
      }  
  }
   
  fill(255);
  text(time + "s" , 50, 50);
  
  displayCoolDown();
}

//_________________________________________________________________________________________________________________________________________________________________________

void refreshGame() {
  
    startMenu = true ;
    hasLost = false;
    inc = 0;
    coronas.clear();
    numOfCoronas = 0;
    myGlobule.x = width/2;
    myGlobule.y = height/2;
    canAttack = false;
    viruses = null ; 
}

void initGlobule() {
    
    myGlobule = new Globule ( width/2, height/2, 30, color(255));
}

/////////////////////////////////

void initCoronas() {
  
       int x = int(random(0, 1000)); 
       int y = int(random(0, 1000)); 
       int size = int(random(25, 50));
       
       if (x <= 500) {
         
         x = 1 + size;
       } else {
         
         x = 1000 - size;
       }
       
       if (y <= 500) {
         
         y = 1 + size;
       } else {
         
         y = 1000 - size;
       }
       
      if(numOfCoronas > 0 && numOfCoronas > coronas.size()) {
        coronas.add( new Corona(x, y, size, color(255, 0, 0)));
      }
      
     // println(coronas.size());
}

/////////////////////////////////////////////

void moveCoronas() {
    
    for (int i =0 ; i<numOfCoronas ; i++) {
      
        if(coronas.get(i).isDead == false) {
        
          coronas.get(i).move();
          coronas.get(i).testOOB();
          coronas.get(i).display();
        } else {
          
          coronas.get(i).x = 1600;
          coronas.get(i).y = 1600;
        }
    } 
}

/////////////////////////////////////////////

void initViruses() {
  int totalViruses = 30;
  viruses = new Virus[totalViruses];
  
  int SpawnPoint = int(random(1, 5));
  
  int xlocate = -1000;
  int ylocate = -1000;
  
  xdirection = 0;
  ydirection = 0;
  
  if (SpawnPoint == 1) {
    ylocate = int(random(0, 1000));
    xdirection = 5;
  } else if (SpawnPoint == 2) {
    xlocate = 1000;
    ylocate = int(random(0, 1000));
    xdirection = -5;
  } else if (SpawnPoint == 3) {
    ylocate = 1000;
    xlocate = int(random(0, 1000));
    ydirection = -5;
  } else if (SpawnPoint == 4) {
    xlocate = int(random(0, 1000));
    ydirection = 5;
  }
  
  for (int i = 0 ; i < totalViruses ; i++) {
    
    int x = 0, y = 0;
    
    if (SpawnPoint == 1 || SpawnPoint == 2) {
      
      x =  int(20 * i + random(xlocate, xlocate + 20));
      y =  ylocate;
    } else if (SpawnPoint == 3 || SpawnPoint == 4) {
      x =  xlocate;
      y =  int(20 * i + random(ylocate, ylocate + 20));
    }
    
     int size = int(random(25, 40));
  
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
    
    if (viruses[viruses.length - 1].testOOB() && viruses[1].testOOB()) {
      
      initViruses();
    }
}

/////////////////////////////////////////////

/////////////////////////////////////////////

void loseScreen() {
  
  timeOfGame = millis();
  
  
  fill(255);
  rect(0,0,width,height); 
  image(imgMenuEmpty,width/2,height/2);
  
  textAlign(CENTER, CENTER);
  

  if (time < 60) { 
    
    text("Tu as tenu "+ time +" secondes, quel Mickey...", width/2, height/2);
    
  } else if (time < 120) {
    
    text("Tu as tenu "+ time +" secondes, pas mal pour une baltringue...", width/2, height/2);
  } else {
    
    text("Tu as tenu "+ time +" secondes, c'est un peu ridicule quand même...", width/2, height/2);
    
  }
  String[] lastScore = loadStrings("data/scores.txt"); 
       
   String score = str(time) ;
   
   if ( parseInt(lastScore[0]) > parseInt(score) )
   {
   } else {
      fill(255);
      text("Nouveau record !",150,500);
      String[] splittedScore = split(score, ' ');
      saveStrings("data/scores.txt", splittedScore);
   }
   
  
  
   

}

/////////////////////////////////////////////

boolean testCollisionCoronas() {
  
   intersecting = false;
   for (int i = 0; i < numOfCoronas; i++) {
     
        if(myGlobule.intersect(coronas.get(i))) {
          
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



/////////////////////////////////////////////

void testAttack()
{
    
    if(millis() > lastAttack + attackCooldown) {
    
      lastAttack = millis();
      canAttack = true; 
    } 
  
    if(canAttack == true && isAttacking == true) {
      
       canAttack = false;
       lastAttack = millis();
       attackInProgress = true;
    }
    
    if(millis() > lastAttack + attackDuration) {
          
       attackInProgress = false;
    }
    
    if(millis() < lastAttack + attackDuration && attackInProgress == true) {
          
       int timeWhileAttacking = millis() - lastAttack ;
       int attackWidth = int(map(timeWhileAttacking,0,attackDuration,myGlobule.db,(myAttack.maxRange*2)));
       
       if (attackWidth > myAttack.maxRange) {
         
         attackWidth = myAttack.maxRange ; 
       }
       myAttack.display(attackWidth);
       myAttack.testDestroyBombs(attackWidth);
    }
}


void displayCoolDown() {
  
  if(canAttack == false) {
      
      int cD = millis() - lastAttack;
      int cDBarWidth = int(map(cD,0,attackCooldown,0,150));
      fill(245);
      rect((width/2-75), 50, 150, 20, 3);
      fill(#4858EB);
      rect((width/2-75), 50, cDBarWidth, 20, 3);
      
    } else {
      
      fill(#26EB4A);
      rect((width/2-75), 50, 150, 20, 3);
    }
}
