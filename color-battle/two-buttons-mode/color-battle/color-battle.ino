int player01_state = 0;
int player02_state = 0;
int player03_state = 0;
int player04_state = 0;
int player01_last_state = 0;
int player02_last_state = 0;
int player03_last_state = 0;
int player04_last_state = 0;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
}

void loop() {
  //player 01, botão 01
  if (digitalRead(2) != player01_last_state) {
    if (digitalRead(2) == true) {
      player01_last_state = true;
      player01_state = true;
    }
    
    else {
      player01_last_state = false;
      player01_state = false;
    }
  }
  
  else {
      player01_state = false;
  }

  //player 01, botão 02
  if (digitalRead(3) != player02_last_state) {
    if (digitalRead(3) == true) {
      player02_last_state = true;
      player02_state = true;
    }
  
    else {
      player02_last_state = false;
      player02_state = false;
    }
  }
  
  else {
      player02_state = false;
  }

  //player 02, botão 02
  if (digitalRead(4) != player03_last_state) {
    if (digitalRead(4) == true) {
      player03_last_state = true;
      player03_state = true;
    }
  
    else {
      player03_last_state = false;
      player03_state = false;
    }
  }
  
  else {
      player03_state = false;
  }

  //player 02, botão 02
  if (digitalRead(5) != player04_last_state) {
    if (digitalRead(5) == true) {
      player04_last_state = true;
      player04_state = true;
    }
  
    else {
      player04_last_state = false;
      player04_state = false;
    }
  }
  
  else {
      player04_state = false;
  }
  
  Serial.println(String(player01_state) + "," + String(player02_state) + "," + String(player03_state) + "," + String(player04_state));
  delay(20);
}
