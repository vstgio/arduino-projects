import processing.serial.*;

Serial port;
color color01 = color(142, 68, 173);   //player 01 color antiga: 242, 121, 53
color color02 = color(38, 166, 91);   //player 02 color antiga: 89, 171, 227
color color03 = color(0, 0, 0);        //game over background
color color04 = color(255, 255, 255);  //game over text color
color winnercolor;
String arduinovalue;
String[] separatedvalues;
int score;
int proportion = 40;
int newlinecode = 10;
Boolean isgamerunning = true;
int winner = 0;
int[] istimetorestart = {0, 0};
PFont font;

void setup() {
  size(1000,600);
  score = proportion/2;
  
  noStroke();
  background(color02);
  fill(color01);
  rect(0, 0, score*(width/proportion), height);
  
  font = createFont("Press Start 2P Regular", 32);
  
  port = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
  port.clear();
  arduinovalue = port.readStringUntil(newlinecode);
  arduinovalue = null;  
}

void draw() {
  if (isgamerunning) {
    background(color02);
    fill(color01);
    rect(0, 0, score*(width/proportion), height);  
  }
  else {
    background(color03);
    drawGameOverTexts();
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
        runGameOver(separatedvalues);
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
    if (score == 40) {
      winner = 1;
      winnercolor = color01;
    }
    else {
      winner = 2;
      winnercolor = color02;
    }
  }
}

void runGameOver(String[] separatedvalues) {
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
    winner = 0;
    istimetorestart[0] = 0; 
    istimetorestart[1] = 0;
    isgamerunning = true; 
  }
}

void drawGameOverTexts() {
    textFont(font);
    textSize(55);
    textAlign(CENTER, CENTER);
    fill(color04);
    String text01 = "FIM DE JOGO";
    text(text01, width/2, (height/2)-120);
    
    textSize(30);
    fill(winnercolor);
    String text02 = "VITÓRIA DO JOGADOR 0" + winner + "!";
    text(text02, width/2, (height/2)-60);
    
    textSize(16);
    fill(color04);
    String text03 = "CLIQUE NOS BOTÕES DE CADA CONTROLE";
    text(text03, width/2, (height/2)+120);
    
    String text04 = "PARA COMEÇAR UMA NOVA PARTIDA";
    text(text04, width/2, (height/2)+150);
    
    textSize(20);
    String icon01 = istimetorestart[0] == 0 ? "X" : "OK";
    text(icon01, (width/2)-80, (height/2)+200);
    
    String icon02 = istimetorestart[1] == 0 ? "X" : "OK";
    text(icon02, (width/2)+80, (height/2)+200);
    
    String icon03 = "|";
    text(icon03, width/2, (height/2)+200);
}