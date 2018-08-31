import processing.serial.*;

Serial port;
color color01 = color(162, 222, 208);  //player 01 color
color color02 = color(253, 227, 167);  //player 02 color
color color03 = color(0, 0, 0);        //game over background
color color04 = color(255, 255, 255);  //game over text color
int buttonwidth = 20;
color winnercolor;
String arduinovalue;
String[] separatedvalues;
int score;
int proportion = 40;
int newlinecode = 10;
Boolean isgamerunning = true;
int winner = 0;
int[] istimetorestart = {0, 0, 0, 0};
PFont font;

int now = -1;
int randomround;
int mode;
Animation button01;
Animation button02;
Animation button03;
Animation button04;

void setup() {
  fullScreen();
  score = proportion/2;
  
  noStroke();
  background(color02);
  fill(color01);
  rect(0, 0, score*(width/proportion), height);
  
  frameRate(16);
  button01 = new Animation("roxo-0", 3);
  button02 = new Animation("verde-0", 3);
  button03 = new Animation("roxo-0", 3);
  button04 = new Animation("verde-0", 3);
  
  font = createFont("Press Start 2P Regular", 32);
  
  port = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
  port.clear();
  arduinovalue = port.readStringUntil(newlinecode);
  arduinovalue = null;  
}

void draw() {
  calculateRandomRound();
  
  if (isgamerunning) {
    background(color02);
    fill(color01);
    rect(0, 0, score*(width/proportion), height);
    drawButtonColor();
  }
  else {
    background(color03);
    drawGameOverTexts();
  }
  
  while (port.available() > 0) {
    arduinovalue = port.readStringUntil(newlinecode);     
    
    if (arduinovalue != null) {
      //println(arduinovalue);
      separatedvalues = split(arduinovalue.trim(), ",");
      //println(separatedvalues);
      
      if (isgamerunning) {
        runGame(separatedvalues);
      }
      else {
        runGameOver(separatedvalues);
      }
    }
  }
}

void drawButtonColor() {
    if (mode == 1) {
      button01.display(30, 20);                             //botão roxo player 01
      button03.display((width-30)-button02.getWidth(), 20); //botão roxo player 02
    }
    else {
      button02.display(30, 20);                             //botão verde player 01
      button04.display((width-30)-button02.getWidth(), 20); //botão verde player 02
    }
}

void calculateRandomRound() {
  if (now == -1) {
      now = second();
      randomround = int(random(2, 9));
      mode = int(random(1, 3));
      println("Estamos no modo " + mode + " por " + randomround + " segundos!");
  }
  else {
    if (second() < now) {
      if (second()+(60-now) > randomround) {
        now = second();
        randomround = int(random(2, 9));
        mode = mode == 1 ? 2 : 1;
        println("Estamos no modo " + mode + " por " + randomround + " segundos!");
      }
     }
    else {
      if (second() == (now+randomround)){
        now = second();
        randomround = int(random(2, 9));
        mode = mode == 1 ? 2 : 1;
        println("Estamos no modo " + mode + " por " + randomround + " segundos!");
      }
    }
  }
}

void runGame (String[] separatedvalues) {
  if (mode == 1) {
    if (int(separatedvalues[0]) == 1 && int(separatedvalues[2]) == 0) {
      score = score + 1;
    }
    else if (int(separatedvalues[0]) == 0 && int(separatedvalues[2]) == 1) {
      score = score - 1;
    }
  }
  else {
    if (int(separatedvalues[1]) == 1 && int(separatedvalues[3]) == 0) {
      score = score + 1;
    }
    else if (int(separatedvalues[1]) == 0 && int(separatedvalues[3]) == 1) {
      score = score - 1;
    }
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
  if (int(separatedvalues[2]) == 1 && istimetorestart[2] != 1) {
    istimetorestart[2] = 1;
  }
  if (int(separatedvalues[3]) == 1 && istimetorestart[3] != 1) {
    istimetorestart[3] = 1;
  }
  
  if (istimetorestart[0] == 1 && istimetorestart[1] == 1 && istimetorestart[2] == 1 && istimetorestart[3] == 1) {
    score = 20;
    winner = 0;
    istimetorestart[0] = 0; 
    istimetorestart[1] = 0;
    istimetorestart[2] = 0; 
    istimetorestart[3] = 0;
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
    text(icon01, (width/2)-150, (height/2)+200);
    
    String icon02 = istimetorestart[1] == 0 ? "X" : "OK";
    text(icon02, (width/2)-80, (height/2)+200);
    
    String icon03 = istimetorestart[2] == 0 ? "X" : "OK";
    text(icon03, (width/2)+80, (height/2)+200);
    
    String icon04 = istimetorestart[3] == 0 ? "X" : "OK";
    text(icon04, (width/2)+150, (height/2)+200);
    
    String icon05 = "|";
    text(icon05, width/2, (height/2)+200);
}

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];
    
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + i + ".png";
      images[i] = loadImage(filename);
      images[i].resize(images[i].width/16, images[i].height/16);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  } 
}