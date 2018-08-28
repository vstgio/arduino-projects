int player01_01_state = 0;
int player01_02_state = 0;
int player02_01_state = 0;
int player02_02_state = 0;
int player01_01_last_state = 0;
int player01_02_last_state = 0;
int player02_01_last_state = 0;
int player02_02_last_state = 0;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
}

void loop() {
  //player 01, botão 01
  if (digitalRead(2) != player01_01_last_state) {
    if (digitalRead(2) == true) {
      player01_01_last_state = true;
      player01_01_state = true;
    }
    
    else {
      player01_01_last_state = false;
      player01_01_state = false;
    }
  }
  
  else {
      player01_01_state = false;
  }

  //player 01, botão 02
  if (digitalRead(3) != player01_02_last_state) {
    if (digitalRead(3) == true) {
      player01_02_last_state = true;
      player01_02_state = true;
    }
  
    else {
      player01_02_last_state = false;
      player01_02_state = false;
    }
  }
  
  else {
      player01_02_state = false;
  }

  //player 02, botão 02
  if (digitalRead(4) != player02_01_last_state) {
    if (digitalRead(4) == true) {
      player02_01_last_state = true;
      player02_01_state = true;
    }
  
    else {
      player02_01_last_state = false;
      player02_01_state = false;
    }
  }
  
  else {
      player02_01_state = false;
  }

  //player 02, botão 02
  if (digitalRead(5) != player02_02_last_state) {
    if (digitalRead(5) == true) {
      player02_02_last_state = true;
      player02_02_state = true;
    }
  
    else {
      player02_02_last_state = false;
      player02_02_state = false;
    }
  }
  
  else {
      player02_02_state = false;
  }
  String data = String(player01_01_state) + "," + String(player01_02_state) + "," + String(player02_01_state) + "," + String(player02_02_state);
  Serial.println(data);
  delay(20);
}
