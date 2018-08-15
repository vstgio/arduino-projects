import processing.serial.*;

Serial port;
String arduinovalue;
String[] separatedvalues;
int score;
int proportion = 40;
int newlinecode = 10;

void setup() {
  fullScreen();
  score = 20;
  
  noStroke();
  background(89, 171, 227);
  fill(242, 121, 53);
  rect(0, 0, score*(width/proportion), height);
  
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
      separatedvalues = split(arduinovalue.trim(), ",");
      
      if (int(separatedvalues[0]) == 1 && int(separatedvalues[1]) == 0) {
        score = score + 1;           
      }
      else if (int(separatedvalues[0]) == 0 && int(separatedvalues[1]) == 1) {
        score = score - 1;
      }
      rect(0, 0, score*(width/proportion), height);
    }
  }
}