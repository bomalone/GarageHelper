/*
  This is a simple garage parking helper.  It warns if the
  vehicle is not in far enough, up to a notification that
  the vehicle is in far enough for some spare room behind it.
  
  The default values for the constant integers should be modified
  for each instance usage of this code, depending on the depth of the garage
  and the length of the vehicles used in it.  All referenced pin numbers
  may be changed depending on the enclosure built for the unit.
 
  The referenced header file is an implementation for the
  HR-SC04, from iteadstudio.com.
*/

#include "Ultrasonic.h"

int greenpin = 3;
int redpin = 2;
int yellowpin = 4;
int redpin2 = 5;

/*These values (in inches) represent the four stages of proximity*/
const int FAR_AWAY = 36;      //green light
const int GETTING_CLOSE = 24; //yellow light
const int JUST_IN = 12;       //in enough for door closure
const int SPARE_ROOM = 0;     //in enough for room behind vehicle

Ultrasonic ultrasonic(12,13);

void setup()
{
  pinMode(greenpin,OUTPUT);
  pinMode(redpin, OUTPUT);
  pinMode(redpin2, OUTPUT);
  pinMode(yellowpin, OUTPUT);
  pinMode(11, OUTPUT);
  digitalWrite(11, HIGH);
  Serial.begin( 9600 );
}
void loop()
{
  //getting rangerfinder input (in cm) and converting it to inches
  float inches = ultrasonic.Ranging(CM)/2.54;
  
  if (inches > FAR_AWAY)
  {
     digitalWrite(greenpin,HIGH);
     delay(300);
     digitalWrite(greenpin,LOW);
  }
  else if (inches < FAR_AWAY && inches > GETTING_CLOSE)
  {
    digitalWrite(yellowpin,HIGH);
    delay(300);
    digitalWrite(yellowpin,LOW);
  }
  else if (inches < GETTING_CLOSE && inches > JUST_IN)
  {       
    digitalWrite(redpin,HIGH);
    delay(300);
    digitalWrite(redpin,LOW);
  }
  else
  {
    digitalWrite(redpin,HIGH);
    delay(300);
    digitalWrite(redpin,LOW);
    digitalWrite(redpin2,HIGH);
    delay(300);
    digitalWrite(redpin2,LOW); 
  }
} //end loop
