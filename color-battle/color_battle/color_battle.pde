import processing.serial.*;

Serial port;
String arduinovalue;
int newlinecode = 10;

void setup() {
  fullScreen();
  noStroke();
  background(89, 171, 227);
  fill(242, 121, 53);
  
  port = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
  port.clear();
  arduinovalue = port.readStringUntil(newlinecode);
  arduinovalue = null;
}

void draw() {
  while (port.available() > 0) {
    arduinovalue = port.readStringUntil(newlinecode);     
       
    if (arduinovalue != null) {
      background(89, 171, 227);
      rect(0, 0, int(arduinovalue.trim()), height);
    }
  }
}