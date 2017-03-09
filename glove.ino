// includes
#include <SoftwareSerial.h> // import the serial library

// constant values
const byte fabricPin = 2;     // the digital fabric pin
const byte rxPin = 0;        // the pin to which data is received
const byte txPin = 1;        // the pin on which data is transmitted

// variables
bool fabricState;       // the current state of the flex sensor

/*
 * This object isn't really necessary, but makes sure data is 
 * received/transmitted on the specified pins.
 */
SoftwareSerial BT(rxPin, txPin);

void setup() {
  // initialize pins and Bluetooth
  pinMode(13, OUTPUT);
  pinMode(fabricPin, INPUT);
  BT.begin(9600);
}

void loop() {
  // read the value from the fabric pin
  int fabricValue = digitalRead(fabricPin);
  if (!fabricState && fabricValue == HIGH) {
    fabricState = true;
    digitalWrite(13, true);
    BT.write((byte)1);
    delay(50);
  } else if (fabricState && fabricValue == LOW) {
    fabricState = false;
    digitalWrite(13, false);
    BT.write((byte)0);    
    delay(50); 
  }
}
