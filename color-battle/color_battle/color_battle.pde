import processing.serial.*;

Serial port;
String arduinovalue;
String[] separatedvalues;
int score;
int proportion = 40;
int newlinecode = 10;
Boolean isgamerunning = true;
int[] istimetorestart = {0, 0};

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
  if (isgamerunning) {
    background(89, 171, 227);
    rect(0, 0, score*(width/proportion), height);  
  }
  else {
    background(0, 0, 0);
  }
  
  while (port.available() > 0) {
    arduinovalue = port.readStringUntil(newlinecode);     
       
    if (arduinovalue != null) {      
      separatedvalues = split(arduinovalue.trim(), ",");
      
      if (isgamerunning) {
        runGame(separatedvalues);
        //println(isgamerunning);
        //println(score);
      }
      else {
        gameOver(separatedvalues);
      }
    }
  }
}

void runGame (String[] separatedvalues) {
  if (int(separatedvalues[0]) == 1 && int(separatedvalues[1]) == 0) {
    score = score + 1;           
  }
  else if (int(separatedvalues[0]) == 0 && int(separatedvalues[1]) == 1) {
    score = score - 1;
  }
  
  if (score == 0 || score == 40) {
    isgamerunning = false;
  }
}

void gameOver(String[] separatedvalues) {
  if (int(separatedvalues[0]) == 1 && istimetorestart[0] != 1) {
    istimetorestart[0] = 1;
  }
  if (int(separatedvalues[1]) == 1 && istimetorestart[1] != 1) {
    istimetorestart[1] = 1;
  }
  
  //print(istimetorestart[0] == 1 ? "APERTOU e " : "não e ");
  //print(istimetorestart[1] == 1 ? "APERTOU" : "não");
  
  if (istimetorestart[0] == 1 && istimetorestart[1] == 1) {
    score = 20;
    istimetorestart[0] = 0; 
    istimetorestart[1] = 0;
    isgamerunning = true; 
  }
}