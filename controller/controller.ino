
int buttonValue;

int pinX = A4;
int pinY = A5;

int button = 7;

int calX, calY, calSW, rawX, rawY;


void setup() {
  // put your setup code here, to run once:
  pinMode(pinX,INPUT);
  pinMode(pinY,INPUT);
  pinMode(button,INPUT); 
  
  calX = analogRead(pinX);
  calY = analogRead(pinY);

  Serial.begin(9600);

}

void loop() {
  // put your main code here, to run repeatedly:

 rawX = analogRead(pinX)- calX;
 rawY = analogRead(pinY)- calY;
 
 buttonValue = digitalRead(button);

 Serial.print((int)(rawX));
 Serial.print(',');
 Serial.print((int)(rawY));
 Serial.print(',');
 Serial.println(buttonValue);
 delay(10);
 
}
